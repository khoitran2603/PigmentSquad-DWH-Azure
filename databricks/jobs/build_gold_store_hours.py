from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col, lit, abs, unix_timestamp, to_timestamp, concat_ws, expr,
    date_trunc, date_format, year, month, dayofmonth, sum as _sum, count, when, current_timestamp
)

# Set working catalog and schema
spark.sql("USE CATALOG pigments_cata")
spark.sql("USE SCHEMA gold")

spark = SparkSession.builder.getOrCreate()

# Define catalog and layer references
CATALOG = "pigments_cata"
SILVER = f"{CATALOG}.silver"
GOLD   = f"{CATALOG}.gold"

# Source sales data from Silver layer
SRC = f"{SILVER}.pos_prd_sales"

# Target Gold tables
T_REFUND_EVENTS = f"{GOLD}.refund_events_expanded"
T_FACT_FILTERED = f"{GOLD}.fact_sales_filtered"
T_STORE_HOURS   = f"{GOLD}.store_hours"  

# ----------------------------
# 1 Load + rename columns
# ----------------------------
df_fact_sales = spark.table(SRC)

# Align column names to analytics-friendly naming
rename_map = {
    "date_col": "transaction_date",
    "time_col": "transaction_time",
    "itemization_type": "product_type",
    "item_name": "product_name",
    "category": "product_category",
    "qty": "quantity",
    "net_sales": "sales_amount",
    "product_sales": "product_price",
    "discounts": "discount_amount"
}
for old, new in rename_map.items():
    if old in df_fact_sales.columns:
        df_fact_sales = df_fact_sales.withColumnRenamed(old, new)

# ------------------------------------------------
# 2. Identify refund events (sale + refund pairs)
# ------------------------------------------------
# Match positive and negative transactions for the same product
# occurring within a short time window
s1 = df_fact_sales.alias("s1")
s2 = df_fact_sales.alias("s2")

df_pairs = (
    s1.join(
        s2,
        on=(
            (col("s1.transaction_date") == col("s2.transaction_date")) &
            (col("s1.product_name")     == col("s2.product_name")) &
            (col("s1.quantity")         == lit(1)) &
            (col("s2.quantity")         == lit(-1)) &
            (abs(col("s1.sales_amount")) == abs(col("s2.sales_amount")))
        ),
        how="inner"
    )
    .where(col("s1.transaction_time") < col("s2.transaction_time"))
    .where(
        abs(
            unix_timestamp(col("s2.transaction_time"), "HH:mm:ss") -
            unix_timestamp(col("s1.transaction_time"), "HH:mm:ss")
        ).between(0, 300) # within 5 minutes
    )
    .select(
        col("s1.transaction_date").alias("transaction_date"),
        col("s1.product_name").alias("product_name"),
        col("s1.product_category").alias("product_category_1"),
        col("s2.product_category").alias("product_category_2"),
        col("s1.transaction_time").alias("time_1"),
        col("s2.transaction_time").alias("time_2"),
        col("s1.quantity").alias("qty_1"),
        col("s2.quantity").alias("qty_2"),
        col("s1.sales_amount").alias("amount_1"),
        col("s2.sales_amount").alias("amount_2"),
    )
)

# Expand both sides of the refund event for easier filtering
df_refund_events_expanded = (
    df_pairs.select(
        "transaction_date",
        col("time_1").alias("transaction_time"),
        col("product_category_1").alias("product_category"),
        "product_name",
        col("qty_1").alias("quantity"),
        col("amount_1").alias("sales_amount"),
    )
    .unionByName(
        df_pairs.select(
            "transaction_date",
            col("time_2").alias("transaction_time"),
            col("product_category_2").alias("product_category"),
            "product_name",
            col("qty_2").alias("quantity"),
            col("amount_2").alias("sales_amount"),
        )
    )
)

# ------------------------------------------------
# 3. Remove refund transactions from sales data
# ------------------------------------------------
# Exclude any transaction identified as part of a refund event
df_fact_sales_filtered = (
    df_fact_sales.alias("f")
    .join(
        df_refund_events_expanded.alias("r"),
        on=(
            (col("f.transaction_date") == col("r.transaction_date")) &
            (col("f.transaction_time") == col("r.transaction_time")) &
            (col("f.product_name")     == col("r.product_name")) &
            (col("f.product_category") == col("r.product_category")) &
            (col("f.quantity")         == col("r.quantity")) &
            (col("f.sales_amount")     == col("r.sales_amount"))
        ),
        how="left_anti"
    )
)

# ------------------------------------------------
# 4. Build store hours performance metrics
# ------------------------------------------------
# Prepare base dataset for hourly analysis
df_base = df_fact_sales_filtered.select(
        "transaction_date",
        "transaction_time",
        "product_type",
        "product_category",
        "product_name",
        "product_price",
        "discount_amount",
        "sales_amount",
        "quantity"
)

# Combine date and time into a single timestamp
df_base = df_base.withColumn(
    "txn_ts",
    to_timestamp(
        concat_ws(" ", col("transaction_date").cast("string"), col("transaction_time")),
        "yyyy-MM-dd HH:mm:ss"
    )
)

# Round transactions into hourly buckets
# Special handling for early morning edge case
df_base = df_base.withColumn(
    "bucket_ts",
    when(expr("hour(txn_ts)") == 10, expr("timestamp(transaction_date) + interval 11 hours"))
    .otherwise(date_trunc("hour", col("txn_ts")))
)

df_base = df_base.withColumn("transaction_time_bucket", date_format(col("bucket_ts"), "HH:mm"))

# Add calendar attributes and store opening hour
df_base = (
    df_base
    .withColumn("year_dp", year(col("transaction_date")))
    .withColumn("weekday_dn", date_format(col("transaction_date"), "EEEE"))
    .withColumn("month_dp", month(col("transaction_date")))
    .withColumn("week_of_month", expr("floor((dayofmonth(transaction_date)-1)/7) + 1"))
    .withColumn("opening_hour", lit("11:00"))
)

# Apply store closing hour rules (historical change included)
df_base = df_base.withColumn(
    "closing_hour",
    when(
        (year(col("transaction_date")) == 2024) & (month(col("transaction_date")) < 8),
        when(col("weekday_dn").isin("Friday", "Saturday"), lit("23:00")).otherwise(lit("22:00"))
    ).otherwise(
        when(col("weekday_dn").isin("Friday", "Saturday"), lit("22:00")).otherwise(lit("21:00"))
    )
)

# Aggregate sales metrics at hour level
df_agg = (
    df_base
    .groupBy(
        "transaction_date",
        col("transaction_time_bucket").alias("transaction_time"),
        "product_type",
        "product_category",
        "product_name",
        "year_dp",
        "weekday_dn",
        "month_dp",
        "week_of_month",
        "opening_hour",
        "closing_hour"
    )
    .agg(
        _sum("sales_amount").alias("total_sales"),
        _sum("quantity").alias("total_quantity"),
        count(lit(1)).alias("total_transactions")
    )
)

# Classify each hour as Day, Evening, or Outside Hours
df_agg = df_agg.withColumn(
    "time_of_day",
    when((col("transaction_time") >= lit("11:00")) & (col("transaction_time") < lit("16:00")), lit("Day"))
    .when((col("transaction_time") >= lit("16:00")) & (col("transaction_time") < col("closing_hour")), lit("Evening"))
    .otherwise(lit("Outside Hours"))
)

# Calculate derived metrics used in reporting
df_final = (
    df_agg
    .withColumn(
        "avg_order_revenue",
        when(col("total_transactions") == 0, lit(0.0))
        .otherwise(col("total_sales") / col("total_transactions"))
    )
    .withColumn(
        "hours_since_opening",
        when(
            col("time_of_day") == lit("Day"),
            expr("cast(substr(transaction_time,1,2) as int) - cast(substr(opening_hour,1,2) as int)")
        )
    )
    .withColumn(
        "hours_until_closing",
        when(
            col("time_of_day") == lit("Evening"),
            expr("cast(substr(closing_hour,1,2) as int) - cast(substr(transaction_time,1,2) as int)")
        )
    )
    .withColumn("updated_at", current_timestamp())
)

# Write final Store Hours table to Gold layer
(df_final.write
 .format("delta")
 .option("mergeSchema", "true")
 .mode("overwrite")
 .saveAsTable(T_STORE_HOURS))

# Optional: if you still want a view name "store_hours"
spark.sql(f"""
CREATE OR REPLACE VIEW {GOLD}.store_hours_view AS
SELECT * FROM {T_STORE_HOURS}
""")

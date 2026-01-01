from pyspark.sql import DataFrame
from pyspark.sql.functions import *

class name_changed:

    def fact_sales(self, df: DataFrame) -> DataFrame:
        return df.select(
            to_date(col("date_col")).alias("date"),
            trim(col("category")).alias("category"),
            trim(col("itemization_type")).alias("type"),
            trim(col("item_name")).alias("product_name"),
            col("transaction_id").alias("order_id"),
            col("time_col").alias("transaction_time"),
            col("qty").alias("quantity"),
            col("net_sales").alias("sales_amount"),
            col("product_sales").alias("product_price"),
            col("discounts").alias("discount_amount")
        )

    def dim(self, df: DataFrame, dim_cols: list[str]) -> DataFrame:
        df_std = self.fact_sales(df)
        return df_std.select(*dim_cols).dropDuplicates()
    

class table_key:

    def add_cat_id(self, df):
        return df.withColumn(
            "cat_id",
            concat(
                substring(upper(trim(col("category"))), 1, 2),
                substring(upper(trim(col("type"))), 1, 2)
            )
        )

    def add_product_id(self, df):
        return df.withColumn(
            "product_id",
            sha2(lower(trim(col("product_name"))), 256)
        )

    def add_date_key(self, df):
        return df.withColumn(
            "date_key",
            date_format(col("date"), "yyyyMMdd").cast("int")
        )

    def add_stream_id(self, df):
        return df.withColumn(
            "stream_id",
            sha2(
                concat_ws(
                    "||",
                    col("order_id"),
                    col("product_id"),
                    col("cat_id"),
                    col("date_key").cast("string"),
                    col("transaction_time").cast("string"),
                    col("quantity").cast("string"),
                    col("sales_amount").cast("string"),
                    col("product_price").cast("string"),
                    col("discount_amount").cast("string"),
                ),
                256
            )
        )

    def apply_all(self, df):
        df = self.add_cat_id(df)
        df = self.add_product_id(df)
        df = self.add_date_key(df)
        df = self.add_stream_id(df)
        return df

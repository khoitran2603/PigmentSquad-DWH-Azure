from pyspark import pipelines as dp
import dlt

# Basic data quality rule: category must have a valid ID
expectations = {
  "rule_1": "product_id IS NOT NULL"
}

# Create a staging table from the Silver layer
# This acts as the clean input source for the Gold dimension
@dlt.table()
@dlt.expect_all_or_drop(expectations)

def dimproduct_stg():
        df = spark.readStream.table("pigments_cata.silver.dimproduct")
        return df
    
# Define the Gold dimension table
# Only records passing data quality checks are kept
dlt.create_streaming_table(
  name = "dimproduct",
  expect_all_or_drop= expectations
)

# Apply incremental updates to the dimension table
# Changes are tracked over time based on update timestamp
dp.create_auto_cdc_flow(
  target = "dimproduct",
  source = "dimproduct_stg",
  keys = ["product_id"],
  sequence_by = "updated_at",
  stored_as_scd_type = 2,
  track_history_except_column_list = None,
  name = None,
  once = False
)
from pyspark import pipelines as dp
import dlt

# Basic data quality rule: category must have a valid ID
expectations = {
  "rule_1": "date_key IS NOT NULL"
}

# Create a staging table from the Silver layer
# This acts as the clean input source for the Gold dimension
@dlt.table()
@dlt.expect_all_or_drop(expectations)

def dimdate_stg():
        df = spark.readStream.table("pigments_cata.silver.dimdate")
        return df
    
# Define the Gold dimension table
# Only records passing data quality checks are kept
dlt.create_streaming_table(
  name = "dimdate",
  expect_all_or_drop= expectations
)

# Apply incremental updates to the dimension table
# Changes are tracked over time based on update timestamp
dp.create_auto_cdc_flow(
  target = "dimdate",
  source = "dimdate_stg",
  keys = ["date_key"],
  sequence_by = "updated_at",
  stored_as_scd_type = 2,
  track_history_except_column_list = None,
  name = None,
  once = False
)
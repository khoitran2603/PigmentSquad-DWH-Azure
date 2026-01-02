# Databricks Layer — Silver & Gold Warehouse Processing

This folder contains all Databricks notebooks, pipelines, and jobs used to
transform raw POS data from the Bronze layer into a **modelled, analytics-ready
cloud data warehouse**.

Databricks is the primary engine for **Silver and Gold layers**, handling
data cleaning, modelling, incremental updates, and analytics feature builds.

---

## Purpose

- Clean and standardise raw POS data from the Bronze layer.
- Build reusable Silver dimension and fact tables.
- Maintain Gold warehouse tables incrementally.
- Produce analytics-ready data products built on top of the warehouse.

---

## Structure

- `notebooks/`  
  Silver-layer transformations that clean, standardise, and split raw data
  into dimension and fact tables.

- `pipelines/`  
  Incremental pipelines that maintain Gold dimension and fact tables,
  including change tracking where applicable.

- `jobs/`  
  Batch analytics jobs that generate warehouse features such as
  store hours performance metrics.

- `utils/`  
  Shared transformation utilities reused across Silver notebooks
  and Gold pipelines to ensure consistency.

---

## Design Principles

- Databricks owns Silver and Gold warehouse processing.
- Shared logic is centralised and reused across layers.
- Core warehouse tables are built independently of any single use case.
- Analytics features are implemented as downstream jobs, not embedded
  in the core model.

---

## Notes

Store hours analytics is one example of a downstream feature built on
top of the warehouse. The structure allows additional analytics use cases
to be added without changing the underlying data model.


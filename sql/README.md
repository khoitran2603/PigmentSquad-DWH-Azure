# SQL Layer — Bronze Warehouse Setup

This folder contains SQL scripts used to establish the **Bronze layer**
of the cloud-based data warehouse.

The SQL layer focuses on **initial setup and raw data ingestion** from
Azure Blob Storage, forming the foundation for downstream processing
in Databricks.

---

## Purpose

- Set up secure access between Azure SQL and Azure Blob Storage.
- Define raw landing tables that mirror source POS data.
- Support one-time historical loads and ongoing incremental ingestion.

---

## Structure

- `bronze/`  
  One-time setup scripts, table definitions, and initial import logic
  for raw POS datasets.

---

## Design Principles

- SQL is used for warehouse setup and ingestion, not transformations.
- Bronze tables closely reflect source data with minimal modification.
- Business logic and analytics are intentionally handled in Databricks.

---

## Notes

This SQL layer is intentionally lightweight.
All cleaning, modelling, and analytics logic are implemented in Databricks
to keep responsibilities clearly separated.

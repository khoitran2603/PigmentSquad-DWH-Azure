# SQL Layer — Cloud Data Warehouse

This folder contains all SQL scripts used to establish and manage the
cloud-based analytical warehouse.

The SQL layer defines the **structure and meaning of the data**,
from raw ingestion through to analytics-ready datasets.

---

## Purpose

- Establish the physical warehouse foundation.
- Define schemas, tables, and views used across the project.
- Centralise business rules that should remain stable and reusable.

---

## Structure

- `bronze/`  
  One-time setup and raw landing tables that closely mirror source POS data.


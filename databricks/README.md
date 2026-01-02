# Databricks Layer — Silver & Gold Processing

This folder contains all Databricks notebooks, pipelines, and jobs used to
transform raw POS data into **modelled and analytics-ready datasets**.

Databricks is responsible for **all Silver and Gold layers** in this project.

---

## Responsibilities

- Clean and standardise raw POS data (Silver)
- Build reusable dimension and fact tables
- Maintain Gold tables incrementally
- Generate analytics features from the warehouse

---

## Folder Structure

- `notebooks/`  
  Silver-layer transformations and core data modelling.

- `pipelines/`  
  Incremental pipelines that maintain Gold dimensions and facts.

- `jobs/`  
  Batch analytics jobs that produce specific data products
  (e.g. store hours performance).

- `utils/`  
  Shared transformation utilities reused across notebooks and pipelines.

---

## Key Principle

The **warehouse model comes first**.  
Analytics features are built on top of it, not embedded inside it.


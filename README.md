# Cloud-Based POS Data Warehouse (Azure & Databricks)

This project demonstrates how raw POS data can be transformed into a
**cloud-based analytical warehouse** using Azure and Databricks.

The primary goal is to establish a **reusable data foundation** that supports
ongoing business analytics.  
**Store hours analysis** is implemented as one example feature built on top of
the warehouse.

---

## What This Project Shows

- How to ingest POS data into a cloud warehouse
- How to separate ingestion, modelling, and analytics responsibilities
- How to build analytics features without embedding logic in dashboards
- How a warehouse can support operational decision-making

---

## In One Sentence

Raw POS data → structured cloud warehouse → analytics-ready data products.

---

## Repository Structure
```
PigmentSquad-DWH-Azure/
│
├─ databricks/
│  ├─ notebooks/        # Silver-layer cleaning and modelling
│  ├─ pipelines/        # Gold incremental dimension & fact pipelines
│  ├─ jobs/             # Analytics jobs (e.g. store hours feature)
│  ├─ utils/            # Shared transformation utilities
│  └─ README.md
│
├─ sql/
│  ├─ bronze/           # Warehouse setup and raw ingestion (Azure SQL)
│  └─ README.md
│
├─ factory/             # Azure Data Factory (ADF) definitions
│
├─ source/
│  ├─ datasets/         # Raw POS data files 
│  ├─ cdc.json          # Incremental ingestion configuration
│  └─ empty.json        # Placeholder for schema alignment
│
├─ docs/
│  ├─ architecture.md   # Warehouse-focused architecture overview
│  ├─ business-context.md
│  └─ screenshots/      # UI screenshots (ADF, Databricks, results)
│
└─ README.md            # Project overview (entry point)
```
- The sql/ folder shows how the warehouse is established at the Bronze layer.
- The databricks/ folder contains all Silver and Gold processing logic.
- The docs/ folder provides architectural context and assumptions.
---

## Branching Strategy

- `main`: Stable, portfolio-ready version of the project.
- `kuro`: Development and Azure Data Factory collaboration branch used to build
  and test incremental pipelines.
- `adf_publish`: Reserved for Azure Data Factory publish artifacts.
  Intentionally kept empty for this portfolio project.

---

## Notes

This project is designed as a **warehouse-first system**.
Analytics features are downstream use cases, not the core deliverable.

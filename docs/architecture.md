# Architecture Overview

This project focuses on establishing a **cloud-based analytical warehouse**
from raw POS data, designed to support repeatable, reliable business analytics.

The architecture enables raw transactional data to be ingested, cleaned,
modelled, and served in a structured way, with **store hours analytics implemented
as one downstream use case** of the warehouse.

The design follows a **Bronze → Silver → Gold** layering approach, with each
cloud service used for a clear and limited responsibility.

---

## High-Level Flow

Azure Blob Storage  
→ Azure SQL (Bronze Warehouse)  
→ Azure Data Factory (Incremental Ingestion)  
→ Databricks (Silver Modelling)  
→ Databricks (Gold Data Products)  
→ Power BI

---

## Component Responsibilities

### 1. Source Layer — Azure Blob Storage
- Stores raw POS datasets uploaded from the source system.
- Files are organised by dataset and naming is consistent with Bronze tables.
- Acts as the immutable input layer for the warehouse.

---

### 2. Bronze Layer — Azure SQL
- Establishes the physical foundation of the warehouse.
- Defines raw landing tables aligned with source structure.
- Supports both one-time historical loads and ongoing incremental ingestion.

Key characteristics:
- Minimal transformation
- Schema-focused
- Re-runnable setup and import scripts

---

### 3. Orchestration — Azure Data Factory
- Manages incremental data ingestion into the Bronze layer.
- Controls scheduling and dependency order.
- Separates orchestration from transformation and analytics logic.

ADF is intentionally limited to orchestration responsibilities only.

---

### 4. Silver Layer — Databricks
- Cleans and standardises POS data.
- Applies shared transformation utilities for consistent naming and keys.
- Produces clean, join-ready dimension and fact tables.

The Silver layer acts as the **modelled core of the warehouse**, independent
of any single reporting use case.

---

### 5. Gold Layer — Databricks
The Gold layer serves **analytics-ready data products** derived from the
core warehouse model.

It includes:
- Incrementally maintained dimension and fact tables
- Batch or streaming jobs for specific analytical needs

One such data product is **store hours performance**, built on top of the
core fact and dimension tables.

---

## Design Principles

- The warehouse is the primary asset; analytics are downstream features.
- Business logic is embedded in the data layer, not dashboards.
- Each cloud service has a single, well-defined role.
- The design prioritises repeatability and clarity over complexity.

---

## Outcome

This architecture converts raw POS data into a structured cloud warehouse
that supports multiple analytical use cases, with store hours analysis
demonstrating how the warehouse can be extended to answer operational
business questions.


# SQL Layer — Bronze Setup Only

This folder contains SQL scripts used **only for the Bronze layer**
of the cloud data warehouse.

SQL is intentionally limited to **initial setup and raw data ingestion**.
All cleaning, modelling, and analytics logic is handled in Databricks.

---

## What Lives Here

- Database setup scripts
- External data source configuration
- Bronze table definitions
- One-time historical imports

---

## What Does NOT Live Here

- Data transformations
- Business logic
- Analytics calculations

---

## Intentional Design Choice

Keeping SQL limited to Bronze ensures:
- Clear separation of responsibilities
- A lightweight, stable ingestion layer
- Flexibility to evolve Silver and Gold logic independently

This folder exists to support the warehouse foundation — nothing more.

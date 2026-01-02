# Key Assumptions & Business Rules

This document outlines assumptions applied across the cloud-based warehouse.
These rules ensure consistent interpretation of POS data as it moves from
raw ingestion to analytics-ready outputs.

Store hours analytics inherits these assumptions as a downstream use case.

---

## Source Data Assumptions

- POS files represent completed transactions at product level.
- Each row corresponds to a single product within a transaction.
- File names in Azure Blob Storage match Bronze table names.
- Incremental files contain only new or updated records.

---

## Warehouse Modelling Assumptions

- Bronze tables closely reflect source structure.
- Silver tables represent cleaned and standardised entities suitable for reuse.
- Dimension and fact tables are designed to support multiple analytics use cases.
- Surrogate keys are generated centrally to ensure consistent joins.

---

## Refund Handling (Warehouse-Level)

- Refunds are not always explicitly flagged in source data.
- Refund events are inferred based on matching transaction patterns:
  - Same date
  - Same product
  - Opposite quantities (+1 / -1)
  - Matching absolute sales values
  - Occurring within a short time window (≤ 5 minutes)
- Identified refund records are excluded from analytics-facing fact tables.

This logic applies globally to the warehouse, not only store hours reporting.

---

## Time & Calendar Assumptions

- Transaction date and time are treated as separate attributes in source data.
- Hour-level bucketing is applied consistently across analytical outputs.
- Calendar attributes (weekday, month, week of month) are derived centrally.

---

## Store Hours Rules (Use-Case Specific)

The following assumptions apply only to the **store hours analytics feature**:

- Store opening time is assumed to be **11:00**.
- Closing hours vary by:
  - Day of week
  - Historical period (before vs after Aug 2024)

Closing hour rules:
- Before Aug 2024:
  - Fri–Sat: 23:00
  - Other days: 22:00
- From Aug 2024 onwards:
  - Fri–Sat: 22:00
  - Other days: 21:00

---

## Metric Interpretation

- `total_transactions` counts transaction events, not items.
- `total_sales` reflects net sales after refund exclusion.
- Derived metrics are calculated only when base values are valid.

---

## Scope & Limitations

- The warehouse supports analytical use cases, not operational systems.
- Business rules reflect current understanding and may evolve.
- Store hours analytics is one example of how the warehouse can be extended.

---

## Notes

Assumptions are documented explicitly to ensure:
- Transparency in analytics outputs
- Reusability of the warehouse for future use cases
- Clear separation between core data modelling and feature-specific logic


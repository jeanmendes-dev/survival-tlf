# Survival TLF Engine  

[![R](https://img.shields.io/badge/R-≥4.0-276DC3?logo=r)](https://www.r-project.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GxP-inspired](https://img.shields.io/badge/Compliance-GxP--inspired-lightgrey)](#reproducibility--compliance)

> **Automated Tables, Listings, and Figures for Time-to-Event Endpoints in Clinical Trials**  
> Kaplan-Meier Curves • Log-Rank Test • Cox Proportional Hazards • Regulatory-Ready Outputs  

A lightweight, reproducible R toolkit for generating **statistical outputs aligned with clinical trial reporting standards** (e.g., ICH E9, CDISC). Designed for Phase II/III studies with time-to-event endpoints such as *overall survival (OS)*, *progression-free survival (PFS)*, or *disease-free survival (DFS)*.

---

## 🎯 Key Features

- ✅ **Kaplan-Meier survival curves** with confidence intervals & risk tables  
- ✅ **Log-Rank test** for group comparisons (e.g., treatment vs. control)  
- ✅ **Cox PH model** with multivariable adjustment & forest plots  
- ✅ **Assumption diagnostics** (proportional hazards via Schoenfeld residuals)  
- ✅ **Export-ready outputs**:  
  - Publication-quality plots (`ggplot2` + `survminer`)  
  - Summary tables in CSV/HTML (via `gt` or `flextable`)  
- ✅ **Template-driven**: easy to adapt to new studies or protocols  

---

## 🖼️ Example Output

### Kaplan-Meier Curves (Treatment Comparison)

![Figure 1 survival curves by treatment](img1.png)

> Simulated Phase III oncology trial (n=200). Log-Rank p = 0.021.

### Cox Model Forest Plot

![Gráficos de comparação entre grupos](comparacao_grupos.png)

Boxplots, bar charts, and density plots facilitate intuitive interpretation of between-group differences..

---

## 🧪 Reproducibility & Compliance

- ✅ **Version control (Git + GitHub)  
- ✅ **Explicit data provenance (input/output documentation) 
- ✅ **Parameterized scripts (no hard-coded paths/values)
- ✅ **Session info logged (sessionInfo() in output logs)
- ✅ **No hidden side effects (pure functions, no global assignments)

```text
---

## 🚀 How to Use

- R ≥ 4.0  
- Required packages: `survival`, `survminer`, `ggplot2`, `gt`, `broom`

```r
# Install dependencies
install.packages(c("survival", "survminer", "ggplot2", "gt", "broom"))



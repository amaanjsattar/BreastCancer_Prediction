# Breast Cancer Malignancy Prediction Using Logistic Regression

### Authors:

- Amanda Creech (David Geffen School of Medicine, UCLA)
- Amaan Jogia-Sattar (Fielding School of Public Health, UCLA; Department of Biostatistics, UCLA)
- Halle Villalobos (Fielding School of Public Health, UCLA; Department of Biostatistics, UCLA)
- Olivia Williams (Fielding School of Public Health, UCLA; Department of Biostatistics, UCLA)

---

## Project Overview:

This project investigates the role of nuclear features in predicting breast cancer malignancy using logistic regression. Fine Needle Aspirate (FNA) samples were utilized to assess the relationship between nuclear feature measurements and malignancy outcomes. The analysis emphasizes exploratory data analysis (EDA), model fitting, and statistical evaluation to develop predictive models.

---

## Key Objectives:

1. Conduct exploratory data analysis (EDA) for continuous variables.
2. Create correlation matrices to evaluate relationships between covariates.
3. Fit logistic regression models using:
   - Covariates in their original units.
   - Z-scored covariates for standardization.
   - A domain knowledge-based model with three covariates.
4. Generate key summary tables (Tables 1, 2, and 3) for inclusion in reports.

---

## Program Information:

**Main Script:** `TumorLogistic.sas`\
**Author:** Amaan Jogia-Sattar\
**Creation Date:** September 2024\
**Last Modified:** December 2024

**Description:**

- Preprocess the data and conduct exploratory data analysis.
- Develop and evaluate logistic regression models.
- Output key results in various formats for reporting.

**Input Files:**

- `Cancer_Data.csv` (raw data file containing nuclear features and malignancy labels)

**Output Files:**

- `breastcancersas.sas7bdat` (SAS dataset used for modeling)
- `tbloneoutput.csv` (CSV output from Table 1)
- `table_1.rtf` (RTF output for Table 1)
- `table_2.rtf` (RTF output for Table 2)
- `table_3.rtf` (RTF output for Table 3)

All RTF and CSV outputs can be recreated directly from the SAS code provided in this repository.

---

## Workflow Summary:

1. **Data Preparation:** Load and preprocess FNA data, ensuring proper handling of missing values and scaling when necessary.
2. **Exploratory Data Analysis:** Visualize and summarize the distribution of key features and their correlations.
3. **Logistic Regression Models:**
   - Fit models using both raw and standardized covariates.
   - Develop a domain knowledge-informed model focusing on three key predictors.
4. **Reporting:** Generate professional tables summarizing descriptive statistics, model coefficients, and predictive performance metrics.

---

## Modification History:

**Modification Number:** 6\
**Modified By:** Amaan Jogia-Sattar\
**Reason for Modification:** Added RTF output for tables in the report.

---

## Additional Notes:

- This project was originally developed as a collaborative effort for a graduate-level coursework project at UCLA.
- All scripts and documentation reflect the authors’ independent contributions and do not replicate or infringe on existing proprietary works.

---

## Copyright:

All rights reserved by the authors. Redistribution or modification of this project is prohibited without explicit permission.

---

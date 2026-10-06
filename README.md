# Loan Default Prediction – Big Data Analytics

## HCL GUVI × JAIN UNIVERSITY

A Big Data Analytics capstone project that analyzes loan/customer characteristics associated with loan default using **HDFS, Hive, Apache Spark/PySpark and Spark MLlib**.

---

## 1. Project Overview

Loan default prediction is an important financial analytics problem. Loan applications contain numerical and categorical information about borrowers, credit characteristics, loan details and property characteristics.

This project implements an end-to-end Big Data Analytics workflow:

```text
Loan_Default.csv
       ↓
      HDFS
       ↓
  ┌────┴────┐
 Hive     Spark/PySpark
  ↓           ↓
SQL       Cleaning
Analysis  Transformation
             ↓
       Machine Learning
             ↓
          Results
             ↓
            HDFS
```

The project follows the Big Data Analytics capstone structure recommended by HCL GUVI × Jain University.

---

## 2. Objectives

- Store and manage the loan dataset using HDFS.
- Create a Hive database and external table over HDFS data.
- Perform meaningful SQL-based analysis using Hive.
- Clean and transform the dataset using PySpark.
- Handle missing numerical and categorical values.
- Engineer machine-learning features.
- Train Logistic Regression and Random Forest models.
- Analyze default patterns by loan type, region and LTV.
- Store analytical outputs and model predictions in HDFS.

---

## 3. Dataset

**Dataset:** `Loan_Default.csv`

| Property | Value |
|---|---:|
| Records | 148,670 |
| Original columns | 34 |
| Non-default (Status = 0) | 112,031 |
| Default (Status = 1) | 36,639 |
| Overall default rate | 24.64% |

### Target Variable

`Status`

- `0` → Non-default
- `1` → Default

The original dataset is not included in this repository because the working CSV is approximately 28.5 MB. The project notebook expects the CSV to be available in HDFS.

---

## 4. Important Technologies

- **Docker** – classroom Big Data environment
- **HDFS** – distributed storage
- **Hive** – SQL-based data organization and analysis
- **Apache Spark / PySpark** – data processing and analytics
- **Spark MLlib** – machine learning
- **Jupyter** – interactive PySpark development
- **YARN** – resource management
- **Git/GitHub** – version control and reproducibility

---

## 5. HDFS Structure

```text
/data/loan_default/
├── raw/
│   └── Loan_Default.csv
├── processed/
└── results/
    ├── random_forest_predictions/
    ├── loan_type_analysis/
    ├── region_analysis/
    └── ltv_analysis/
```

### Raw Dataset

```text
hdfs://namenode:8020/data/loan_default/raw/Loan_Default.csv
```

---

## 6. Hive

### Database

```sql
loan_default_analytics
```

### Table

```sql
loan_default
```

The Hive table is an external table over the raw HDFS CSV.

Important Hive operations include:

```sql
SHOW DATABASES;

USE loan_default_analytics;

SHOW TABLES;

DESCRIBE loan_default;

SELECT COUNT(*) FROM loan_default;
```

The project also performs grouped default-rate analysis by loan type.

---

## 7. PySpark Data Processing

The PySpark workflow includes:

### Data Cleaning

- Blank categorical values are standardized as `Unknown`.
- Numerical missing values are handled using median imputation through Spark ML `Imputer`.

Numerical variables include:

```text
loan_amount
rate_of_interest
Interest_rate_spread
Upfront_charges
term
property_value
income
Credit_Score
LTV
dtir1
```

### Feature Engineering

Categorical variables are transformed using:

```text
StringIndexer
      ↓
OneHotEncoder
      ↓
VectorAssembler
```

The final feature vector contains **70 features**.

### Train/Test Split

```text
Training records: 119,149
Testing records:   29,521
```

Split ratio:

```text
80% training
20% testing
```

Random seed:

```text
42
```

---

## 8. Machine Learning Models

### Logistic Regression

Logistic Regression was used as a binary classification baseline.

Verified results:

| Metric | Result |
|---|---:|
| Accuracy | 87.21% |
| Weighted Precision | 87.93% |
| Weighted Recall | 87.21% |
| Weighted F1 | 85.86% |
| Default Precision | 92.93% |
| Default Recall | 52.41% |
| Default F1 | 67.02% |

### Random Forest

Configuration:

```text
numTrees = 100
maxDepth = 10
seed = 42
```

Verified test result:

```text
Accuracy = 100.00%
```

Test confusion matrix:

```text
True Negatives  = 22,200
False Positives = 0
False Negatives = 0
True Positives  = 7,321
```

Because the 100% result is unusually high, a diagnostic experiment was also performed.

### Random Forest Diagnostic

The three highest-importance numerical variables were removed:

```text
rate_of_interest
Interest_rate_spread
Upfront_charges
```

Random Forest accuracy after removing them:

```text
87.68%
```

This diagnostic indicates strong dependence of the observed model result on these variables. The result should therefore be interpreted cautiously and is not presented as proof of general real-world model performance.

---

## 9. Feature Importance

The most important Random Forest features included:

| Feature | Importance |
|---|---:|
| Upfront_charges_imputed | 0.2357 |
| Interest_rate_spread_imputed | 0.2345 |
| rate_of_interest_imputed | 0.1825 |
| credit_type encoded feature | 0.1571 |
| property_value_imputed | 0.0350 |
| LTV_imputed | 0.0315 |
| dtir1_imputed | 0.0280 |

Feature importance represents how the fitted model used variables and should not be interpreted as causal importance.

---

## 10. Business Analytics

### Loan Type

| Loan Type | Default Rate |
|---|---:|
| type1 | 22.77% |
| type2 | 34.54% |
| type3 | 25.06% |

### Region

| Region | Default Rate |
|---|---:|
| North-East | 30.45% |
| central | 27.54% |
| south | 26.63% |
| North | 22.51% |

### LTV

| LTV Category | Default Rate |
|---|---:|
| Below 60 | 13.92% |
| 60–69 | 12.50% |
| 70–79 | 13.23% |
| 80–89 | 18.44% |
| 90+ | 51.99% |

These are descriptive associations observed in this dataset and should not be interpreted as causal relationships.

---

## 11. HDFS Result Outputs

The project writes the following outputs to HDFS:

```text
/data/loan_default/results/random_forest_predictions
/data/loan_default/results/loan_type_analysis
/data/loan_default/results/region_analysis
/data/loan_default/results/ltv_analysis
```

The Random Forest prediction output contains **29,521 test predictions**.

---

## 12. Repository Structure

loan-default-prediction-big-data/
│
├── README.md
├── Loan_Default_Analysis.ipynb
├── Loan_Default_Prediction_Big_Data_Analytics_Report.docx
├── loan_default_queries.sql
├── model_metrics.csv
├── results_summary.csv
│
├── Screenshot 2026-08-09 182702.png
├── Screenshot 2026-10-04 011203.png
├── Screenshot 2026-10-04 011223.png
├── Screenshot 2026-10-04 011850.png
├── Screenshot 2026-10-04 011904.png
├── Screenshot 2026-10-04 011931.png
├── Screenshot 2026-10-04 012021.png
├── Screenshot 2026-10-04 012138.png
├── Screenshot 2026-10-04 012404.png
├── Screenshot 2026-10-04 012510.png
├── Screenshot 2026-10-04 012522.png
└── Screenshot 2026-10-04 012538.png

## 13. How to Run

### Start the Big Data stack

```cmd
cd C:ig_docker
docker-compose --profile full up -d
docker-compose ps
```

### HDFS

Verify the raw file:

```cmd
docker exec namenode hdfs dfs -ls -h /data/loan_default/raw
```

### Jupyter

Open:

```text
http://localhost:8888
```

### Spark

The notebook reads:

```text
hdfs://namenode:8020/data/loan_default/raw/Loan_Default.csv
```

Run the notebook cells in sequence after the classroom Docker stack is running and HDFS contains the dataset.

---

## 14. Project Outputs

The final project demonstrates:

- HDFS data ingestion
- Hive database and external table
- Hive SQL analysis
- PySpark data cleaning
- Missing-value treatment
- Feature engineering
- Machine learning
- Model evaluation
- Business-level default analysis
- HDFS result generation

---

## 15. Technical Evidence

The `screenshots/` directory contains technical evidence for:

1. Docker stack
2. HDFS raw dataset
3. HDFS directory structure
4. Hive database/table
5. Hive schema
6. Hive analytical query
7. Spark HDFS ingestion
8. Spark data cleaning
9. Feature engineering
10. Model evaluation
11. HDFS analytical results
12. Random Forest predictions

Additional screenshots may be retained as supporting evidence.

---

## 16. Future Scope

- Fit preprocessing parameters on training data only.
- Apply cross-validation and hyperparameter tuning.
- Investigate class imbalance and classification thresholds.
- Compare additional Spark ML classifiers.
- Validate the model on an independent dataset.
- Develop an interactive dashboard for loan-default analysis.
- Monitor model performance when new loan data becomes available.

---

## 17. Conclusion

This project implements an end-to-end Big Data Analytics pipeline for Loan Default Prediction using HDFS, Hive and Spark/PySpark.

The project analyzes 148,670 loan records, performs data preprocessing and feature engineering, trains classification models, evaluates their performance and produces business-level analytical outputs.

The observed overall default rate is 24.64%. The analysis identifies differences in default rates across loan types, regions and LTV categories. Logistic Regression achieved 87.21% accuracy, while the Random Forest experiment achieved 100% accuracy on the held-out test set. The additional diagnostic experiment reduced Random Forest accuracy to 87.68% after removing the three highest-importance numerical features, providing important context for interpreting the unusually high original result.

---

## By Team 5 - Section B
II MSc Data Science and Analytics  
Jain University, Bengaluru

---

## 19. Disclaimer

This repository contains project-specific analytical results generated from the Loan_Default.csv dataset used for the academic capstone. The model results are intended for academic analysis and should not be treated as production lending decisions or evidence of causal relationships.

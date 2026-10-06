-- Loan Default Prediction - Hive Queries
-- HCL GUVI × JAIN UNIVERSITY
-- Database: loan_default_analytics
-- Table: loan_default

CREATE DATABASE IF NOT EXISTS loan_default_analytics;
USE loan_default_analytics;

-- Check available tables
SHOW TABLES;

-- Check schema
DESCRIBE loan_default;

-- Total records
SELECT COUNT(*) AS total_records
FROM loan_default;

-- Target distribution
SELECT
    Status,
    COUNT(*) AS record_count
FROM loan_default
GROUP BY Status
ORDER BY Status;

-- Loan type analysis
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY loan_type
ORDER BY loan_type;

-- Region analysis
SELECT
    Region,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY Region
ORDER BY default_rate DESC;

-- LTV analysis
SELECT
    CASE
        WHEN LTV IS NULL THEN 'Unknown'
        WHEN LTV < 60 THEN 'Below 60'
        WHEN LTV < 70 THEN '60-69'
        WHEN LTV < 80 THEN '70-79'
        WHEN LTV < 90 THEN '80-89'
        ELSE '90+'
    END AS LTV_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY
    CASE
        WHEN LTV IS NULL THEN 'Unknown'
        WHEN LTV < 60 THEN 'Below 60'
        WHEN LTV < 70 THEN '60-69'
        WHEN LTV < 80 THEN '70-79'
        WHEN LTV < 90 THEN '80-89'
        ELSE '90+'
    END
ORDER BY default_rate DESC;

-- Credit score analysis
SELECT
    CASE
        WHEN Credit_Score IS NULL THEN 'Unknown'
        WHEN Credit_Score < 600 THEN 'Below 600'
        WHEN Credit_Score < 650 THEN '600-649'
        WHEN Credit_Score < 700 THEN '650-699'
        WHEN Credit_Score < 750 THEN '700-749'
        WHEN Credit_Score < 800 THEN '750-799'
        ELSE '800+'
    END AS credit_score_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY
    CASE
        WHEN Credit_Score IS NULL THEN 'Unknown'
        WHEN Credit_Score < 600 THEN 'Below 600'
        WHEN Credit_Score < 650 THEN '600-649'
        WHEN Credit_Score < 700 THEN '650-699'
        WHEN Credit_Score < 750 THEN '700-749'
        WHEN Credit_Score < 800 THEN '750-799'
        ELSE '800+'
    END
ORDER BY credit_score_group;

-- Income analysis
SELECT
    CASE
        WHEN income IS NULL THEN 'Unknown'
        WHEN income < 5000 THEN 'Below 5K'
        WHEN income < 10000 THEN '5K-10K'
        WHEN income < 20000 THEN '10K-20K'
        WHEN income < 30000 THEN '20K-30K'
        ELSE '30K+'
    END AS income_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY
    CASE
        WHEN income IS NULL THEN 'Unknown'
        WHEN income < 5000 THEN 'Below 5K'
        WHEN income < 10000 THEN '5K-10K'
        WHEN income < 20000 THEN '10K-20K'
        WHEN income < 30000 THEN '20K-30K'
        ELSE '30K+'
    END
ORDER BY default_rate DESC;

-- Loan amount analysis
SELECT
    CASE
        WHEN loan_amount < 200000 THEN 'Below 200K'
        WHEN loan_amount < 400000 THEN '200K-400K'
        WHEN loan_amount < 600000 THEN '400K-600K'
        WHEN loan_amount < 800000 THEN '600K-800K'
        ELSE '800K+'
    END AS loan_amount_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loan_default
GROUP BY
    CASE
        WHEN loan_amount < 200000 THEN 'Below 200K'
        WHEN loan_amount < 400000 THEN '200K-400K'
        WHEN loan_amount < 600000 THEN '400K-600K'
        WHEN loan_amount < 800000 THEN '600K-800K'
        ELSE '800K+'
    END
ORDER BY default_rate DESC;

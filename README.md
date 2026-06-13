# Bank Customer Retention & Churn Intelligence

## Project Overview

Customer retention is one of the most important challenges faced by banks and financial institutions. Acquiring new customers is significantly more expensive than retaining existing ones, making customer churn analysis a critical business function.

This project focuses on analyzing customer churn behaviour using SQL Server, Python, and Power BI to identify key factors influencing customer attrition and to provide actionable insights for improving customer retention strategies.

The project follows an end-to-end analytics workflow, including data exploration, customer segmentation, churn analysis, risk assessment, and business intelligence reporting.

---

## Dataset Description

The dataset contains information about 10,000 bank customers and their banking relationships. Each record represents a unique customer and includes demographic, financial, and account-related attributes.

### Key Features

* Customer ID
* Credit Score
* Geography
* Gender
* Age
* Tenure
* Account Balance
* Number of Products
* Credit Card Status
* Active Membership Status
* Estimated Salary
* Customer Churn Status (Exited)

### Business Objective

The primary objective of this project is to identify patterns and drivers of customer churn and answer key business questions such as:

* Which customers are most likely to leave the bank?
* Which customer segments have the highest churn rate?
* How much revenue is at risk due to customer attrition?
* What factors influence customer retention?
* Which customers should be targeted for retention campaigns?

---

## SQL Analysis Performed

- Data validation and exploration
- Customer churn rate analysis
- Geography-based churn analysis
- Gender-based churn analysis
- Age group segmentation
- Revenue at risk calculation
- Credit score segmentation
- Balance segmentation
- Customer risk segmentation
- High-value churned customer analysis

## Key Insights

- Customer churn varies across geographical regions.
- Inactive customers are more likely to churn.
- High-balance customers represent significant revenue risk.
- Customer age and account behaviour strongly influence retention.


## Python Analysis Performed

Python was used to clean, transform, and analyze the customer churn dataset using Visual Studio Code and Jupyter Notebook.

### Data Cleaning

- Loaded and validated customer data.
- Checked for missing values and duplicate records.
- Removed unnecessary columns.
- Created Age Group segmentation.
- Created Balance Segment categories.
- Exported a cleaned dataset for analysis.

### Exploratory Data Analysis (EDA)

- Customer Churn Distribution Analysis
- Geography-based Churn Analysis
- Gender-based Churn Analysis
- Age vs Churn Analysis
- Correlation Heatmap Analysis
- Churn Driver Analysis
- High-Risk Customer Identification

### Key Insights

- Older customers demonstrated higher churn rates.
- Inactive customers were more likely to leave the bank.
- High-balance customers represented significant revenue risk.
- Geography and customer activity status strongly influenced churn behaviour.
- Risk segmentation helped identify customers requiring proactive retention strategies.

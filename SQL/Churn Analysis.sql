
-- 1. View sample data
-- Purpose: Validate that the dataset was imported correctly.

SELECT TOP 10 *
FROM dbo.churn_data;


-- 2. Total customer count
-- Purpose: Understand the total customer base.

SELECT
    COUNT(*) AS TotalCustomers
FROM dbo.churn_data;


-- 3. Churned and active customers
-- Purpose: Compare customers who left the bank with customers who stayed.

SELECT
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS ActiveCustomers
FROM dbo.churn_data;


-- 4. Churn rate
-- Purpose: Calculate the percentage of customers who left the bank.

SELECT
    ROUND(
        100.0 * SUM(CAST(Exited AS INT)) / COUNT(*),
        2
    ) AS ChurnRatePercentage
FROM dbo.churn_data;


-- 5. Churn by geography
-- Purpose: Identify which country has the highest churn rate.

SELECT
    Geography,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY Geography
ORDER BY ChurnRatePercentage DESC;


-- 6. Churn by gender
-- Purpose: Compare churn behaviour between male and female customers.

SELECT
    Gender,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY Gender
ORDER BY ChurnRatePercentage DESC;


-- 7. Churn by age group
-- Purpose: Understand which age group is more likely to churn.

SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 49 THEN '30-49'
        ELSE '50+'
    END AS AgeGroup,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 49 THEN '30-49'
        ELSE '50+'
    END
ORDER BY ChurnRatePercentage DESC;


-- 8. Revenue at risk
-- Purpose: Calculate total customer balance linked to churned customers.
-- Business meaning: This estimates the financial value at risk due to churn.

SELECT
    SUM(Balance) AS RevenueAtRisk
FROM dbo.churn_data
WHERE Exited = 1;


-- 9. Churn by active membership
-- Purpose: Check whether inactive customers are more likely to leave.

SELECT
    IsActiveMember,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY IsActiveMember
ORDER BY ChurnRatePercentage DESC;


-- 10. Churn by number of products
-- Purpose: Understand how product ownership affects churn behaviour.

SELECT
    NumOfProducts,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY NumOfProducts
ORDER BY ChurnRatePercentage DESC;


-- 11. Credit score segment analysis
-- Purpose: Analyze churn based on customer credit score bands.

SELECT
    CASE
        WHEN CreditScore < 500 THEN 'Poor'
        WHEN CreditScore BETWEEN 500 AND 650 THEN 'Average'
        WHEN CreditScore BETWEEN 651 AND 750 THEN 'Good'
        ELSE 'Excellent'
    END AS CreditScoreSegment,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage
FROM dbo.churn_data
GROUP BY
    CASE
        WHEN CreditScore < 500 THEN 'Poor'
        WHEN CreditScore BETWEEN 500 AND 650 THEN 'Average'
        WHEN CreditScore BETWEEN 651 AND 750 THEN 'Good'
        ELSE 'Excellent'
    END
ORDER BY ChurnRatePercentage DESC;


-- 12. Balance segment analysis
-- Purpose: Identify whether high-balance customers are more likely to churn.

SELECT
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN 'Low Balance'
        WHEN Balance BETWEEN 50000 AND 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS BalanceSegment,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage,
    SUM(Balance) AS TotalBalance
FROM dbo.churn_data
GROUP BY
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN 'Low Balance'
        WHEN Balance BETWEEN 50000 AND 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END
ORDER BY ChurnRatePercentage DESC;


-- 13. Customer risk segmentation
-- Purpose: Create risk groups using age, balance, and activity status.
-- Business meaning: Helps identify customers who may need retention support.

SELECT
    CASE
        WHEN Age >= 50 AND Balance > 100000 AND IsActiveMember = 0 THEN 'High Risk'
        WHEN Age >= 40 AND Balance > 50000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS RiskSegment,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Exited AS INT)) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CAST(Exited AS INT)) / COUNT(*), 2) AS ChurnRatePercentage,
    SUM(Balance) AS TotalBalance
FROM dbo.churn_data
GROUP BY
    CASE
        WHEN Age >= 50 AND Balance > 100000 AND IsActiveMember = 0 THEN 'High Risk'
        WHEN Age >= 40 AND Balance > 50000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY ChurnRatePercentage DESC;


-- 14. Top 20 high-value churned customers
-- Purpose: Identify churned customers with the highest balances.
-- Business meaning: These customers represent priority cases for retention analysis.

SELECT TOP 20
    CustomerId,
    Surname,
    Geography,
    Gender,
    Age,
    CreditScore,
    Balance,
    NumOfProducts,
    IsActiveMember,
    EstimatedSalary,
    Exited
FROM dbo.churn_data
WHERE Exited = 1
ORDER BY Balance DESC;
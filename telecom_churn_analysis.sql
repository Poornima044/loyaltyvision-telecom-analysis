-- =========================================
-- LoyaltyVision Telecom Analysis
-- =========================================

-- 1. Database setup
CREATE DATABASE IF NOT EXISTS loyaltyvision;
USE loyaltyvision;

-- 2. Explore the dataset
-- View first 10 rows
SELECT * 
FROM telecom
LIMIT 10;

-- Total rows in dataset
SELECT COUNT(*) AS total_rows 
FROM telecom;

-- 3. Check for missing values
SELECT 
    SUM(CASE WHEN AccountID IS NULL THEN 1 ELSE 0 END) AS missing_AccountID,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS missing_Churn,
    SUM(CASE WHEN Tenure IS NULL THEN 1 ELSE 0 END) AS missing_Tenure,
    SUM(CASE WHEN City_Tier IS NULL THEN 1 ELSE 0 END) AS missing_City_Tier,
    SUM(CASE WHEN CC_Contacted_LY IS NULL THEN 1 ELSE 0 END) AS missing_CC_Contacted_LY,
    SUM(CASE WHEN Payment IS NULL THEN 1 ELSE 0 END) AS missing_Payment,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS missing_Gender,
    SUM(CASE WHEN Service_Score IS NULL THEN 1 ELSE 0 END) AS missing_Service_Score,
    SUM(CASE WHEN Account_user_count IS NULL THEN 1 ELSE 0 END) AS missing_Account_user_count,
    SUM(CASE WHEN account_segment IS NULL THEN 1 ELSE 0 END) AS missing_account_segment,
    SUM(CASE WHEN CC_Agent_Score IS NULL THEN 1 ELSE 0 END) AS missing_CC_Agent_Score,
    SUM(CASE WHEN Marital_Status IS NULL THEN 1 ELSE 0 END) AS missing_Marital_Status,
    SUM(CASE WHEN rev_per_month IS NULL THEN 1 ELSE 0 END) AS missing_rev_per_month,
    SUM(CASE WHEN Complain_ly IS NULL THEN 1 ELSE 0 END) AS missing_Complain_ly
FROM telecom;

-- 4. Summary statistics
SELECT 
    MIN(Tenure) AS min_tenure,
    MAX(Tenure) AS max_tenure, 
    ROUND(AVG(Tenure), 2) AS avg_tenure,
    MIN(rev_per_month) AS min_rev, 
    MAX(rev_per_month) AS max_rev, 
    ROUND(AVG(rev_per_month), 2) AS avg_rev
FROM telecom;

-- 5. Churn overview
SELECT 
    Churn, 
    COUNT(*) AS count, 
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM telecom), 2) AS percentage
FROM telecom
GROUP BY Churn;

-- 6. Gender distribution
SELECT Gender, COUNT(*) AS total_customers
FROM telecom
GROUP BY Gender;

-- 7. Payment method distribution
SELECT Payment, COUNT(*) AS total_customers
FROM telecom
GROUP BY Payment;

-- 8. Tenure buckets
SELECT 
    CASE 
        WHEN Tenure BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN Tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN Tenure BETWEEN 25 AND 36 THEN '25-36 months'
        ELSE '36+ months'
    END AS tenure_group,
    COUNT(*) AS customers
FROM telecom
GROUP BY tenure_group
ORDER BY tenure_group;

-- 9. Churn by demographic / segment
-- By Gender
SELECT 
    Gender, 
    Churn, 
    COUNT(*) AS customers
FROM telecom
GROUP BY Gender, Churn;

-- By Tenure Bucket
SELECT 
    CASE 
        WHEN Tenure BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN Tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN Tenure BETWEEN 25 AND 36 THEN '25-36 months'
        ELSE '36+ months'
    END AS tenure_group,
    Churn,
    COUNT(*) AS customers
FROM telecom
GROUP BY tenure_group, Churn;

-- By Payment Method
SELECT Payment, Churn, COUNT(*) AS customers
FROM telecom
GROUP BY Payment, Churn;

-- By City Tier
SELECT 
    City_Tier,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY City_Tier
ORDER BY churn_rate_percent DESC;

-- By Account Segment
SELECT 
    account_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY account_segment
ORDER BY churn_rate_percent DESC;

-- By Marital Status
SELECT 
    Marital_Status,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY Marital_Status
ORDER BY churn_rate_percent DESC;

-- 10. Revenue & Tenure comparison by churn
SELECT 
    Churn,
    ROUND(AVG(rev_per_month), 2) AS avg_monthly_revenue,
    ROUND(AVG(Tenure), 2) AS avg_tenure_months,
    ROUND(AVG(rev_growth_yoy), 2) AS avg_revenue_growth
FROM telecom
GROUP BY Churn;

-- 11. Rank customers by revenue within gender
SELECT 
    AccountID,
    Gender,
    rev_per_month,
    RANK() OVER (PARTITION BY Gender ORDER BY rev_per_month DESC) AS revenue_rank
FROM telecom;

-- 12. Cumulative churn over tenure
SELECT 
    Tenure,
    SUM(Churn) OVER (ORDER BY Tenure ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_churn
FROM telecom
ORDER BY Tenure;

-- 13. Identify at-risk customers (active but declining revenue, short tenure)
SELECT 
    AccountID, 
    rev_per_month, 
    rev_growth_yoy, 
    Tenure
FROM telecom
WHERE Churn = 0
  AND rev_growth_yoy < 0
  AND Tenure < 24
ORDER BY rev_growth_yoy ASC;

-- 14. Advanced segmentation (gender + marital status + city tier)
SELECT 
    Gender,
    Marital_Status,
    City_Tier,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY Gender, Marital_Status, City_Tier
ORDER BY churn_rate_percent DESC;

-- 15. Cohort / Tenure Group Analysis
SELECT 
    CASE 
        WHEN Tenure BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN Tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN Tenure BETWEEN 25 AND 36 THEN '25-36 months'
        WHEN Tenure BETWEEN 37 AND 48 THEN '37-48 months'
        WHEN Tenure BETWEEN 49 AND 60 THEN '49-60 months'
        ELSE '60+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;

-- 16. Revenue impact of churn
SELECT
    SUM(CASE WHEN Churn = 1 THEN rev_per_month ELSE 0 END) AS lost_monthly_revenue,
    SUM(CASE WHEN Churn = 0 THEN rev_per_month ELSE 0 END) AS retained_monthly_revenue,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN rev_per_month ELSE 0 END) /
          SUM(rev_per_month), 2) AS percent_revenue_lost
FROM telecom;

-- 17. Churn by Gender and Account User Count
SELECT 
    Gender,
    Account_user_count,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY Gender, Account_user_count
ORDER BY churn_rate_percent DESC;

-- 18. Payment Method vs Churn
SELECT 
    Payment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM telecom
GROUP BY Payment
ORDER BY churn_rate_percent DESC;

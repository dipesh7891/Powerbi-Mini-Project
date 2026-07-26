/*
====================================================
APPLE SALES DATA ANALYSIS
Database: apple_db
Questions: Q1 - Q5
====================================================
*/


-- ==================================================
-- Q1: NUMBER OF STORES PER COUNTRY
-- ==================================================

SELECT *
FROM stores;
SELECT DISTINCT country
FROM stores
ORDER BY country;
SELECT
    country,
    COUNT(store_id) AS total_stores
FROM stores
GROUP BY country;

-- ==================================================
-- Q2: TOTAL UNITS SOLD BY EACH STORE
-- ==================================================

SELECT
st.store_name,
SUM(s.quantity) AS total_units_sold
FROM sales s
INNER JOIN stores st
ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY total_units_sold DESC;

-- ==================================================
-- Q3: TOTAL TRANSACTIONS IN DECEMBER 2023
-- ==================================================

SELECT
COUNT(sale_id) AS total_sales
FROM sales
WHERE sale_date BETWEEN '2023-12-01' AND '2023-12-31';


-- ==================================================
-- Q4: STORES THAT NEVER RECIEVED A WARRANTY CLAIM
-- ==================================================

SELECT
COUNT(*) AS stores_with_no_claims
FROM stores
WHERE store_id NOT IN (
SELECT DISTINCT s.store_id
FROM warranty w
INNER JOIN sales s
ON w.sale_id = s.sale_id
WHERE s.store_id IS NOT NULL
);

-- ==================================================
-- Q5: PERCENTAGE OF CLAIMS MARKED AS WARRANTY VOIDS
-- ==================================================

SELECT
    ROUND(
        COUNT(
            CASE
                WHEN repair_status = 'Warranty Void' THEN 1
            END
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS void_percentage
FROM warranty;
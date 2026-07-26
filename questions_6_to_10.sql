-- ==================================================
-- Q6: STORE WITH HIGHEST SALES IN THE LAST YEAR
-- ==================================================

SELECT
    st.store_name,
    SUM(s.quantity) AS total_units
FROM sales s
INNER JOIN stores st
    ON s.store_id = st.store_id
WHERE s.sale_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY st.store_name
ORDER BY total_units DESC
LIMIT 1;

SELECT MIN(sale_date), MAX(sale_date)
FROM sales;

-- ==================================================
-- Q7: UNIQUE PRODUCTS SOLD IN THE LAST YEAR
-- ==================================================

SELECT
    COUNT(DISTINCT product_id) AS unique_skus_sold
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '1 year';

-- ==================================================
-- Q8: AVERAGE PRODUCT PRICE PER CATEGORY
-- ==================================================

SELECT
    c.category_name,
    ROUND(AVG(p.price), 2) AS avg_retail_price
FROM products p
INNER JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_retail_price DESC;

-- ==================================================
-- Q9: TOTAL WARRANTY CLAIMS FILED IN 2020
-- ==================================================

SELECT
    COUNT(claim_id) AS total_claims_2020
FROM warranty
WHERE EXTRACT(YEAR FROM claim_date) = 2020;

-- ==================================================
-- Q10: BEST-SELLING WEEKDAY PER STORE
-- ==================================================

WITH daily_sales AS (
    SELECT
        s.store_id,
        st.store_name,
        TRIM(TO_CHAR(s.sale_date, 'Day')) AS weekday,
        SUM(s.quantity) AS total_units,

        RANK() OVER (
            PARTITION BY s.store_id
            ORDER BY SUM(s.quantity) DESC
        ) AS sales_rank

    FROM sales s

    INNER JOIN stores st
        ON s.store_id = st.store_id

    GROUP BY
        s.store_id,
        st.store_name,
        TRIM(TO_CHAR(s.sale_date, 'Day'))
)

SELECT
    store_name,
    weekday AS best_selling_day,
    total_units
FROM daily_sales
WHERE sales_rank = 1
ORDER BY store_name;
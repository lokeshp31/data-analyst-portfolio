-- Retail Sales Analytics (SQLite)

-- 0) Inspect
SELECT COUNT(*) AS row_count, MIN(order_date) AS first_date, MAX(order_date) AS last_date FROM sales;

-- 1) Overall KPIs
SELECT ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit,
       ROUND(SUM(profit)/SUM(sales),4) AS profit_margin
FROM sales;

-- 2) Sales by Category/Subcategory
SELECT category, subcategory,
       ROUND(SUM(sales),2) AS sales,
       ROUND(SUM(profit),2) AS profit
FROM sales
GROUP BY category, subcategory
ORDER BY sales DESC;

-- 3) Sales by State (Top 5)
SELECT state,
       ROUND(SUM(sales),2) AS sales
FROM sales
GROUP BY state
ORDER BY sales DESC
LIMIT 5;

-- 4) Average Order Value (AOV)
WITH orders AS (
  SELECT order_id, SUM(sales) AS order_sales
  FROM sales
  GROUP BY order_id
)
SELECT ROUND(AVG(order_sales),2) AS avg_order_value FROM orders;

-- 5) Profit by Customer Segment
SELECT customer_segment,
       ROUND(SUM(profit),2) AS profit
FROM sales
GROUP BY customer_segment
ORDER BY profit DESC;

-- 6) Monthly Sales Trend
SELECT strftime('%Y-%m', order_date) AS ym,
       ROUND(SUM(sales),2) AS sales
FROM sales
GROUP BY ym
ORDER BY ym;

-- 7) Top 10 Orders by Sales
WITH orders AS (
  SELECT order_id, SUM(sales) AS order_sales, SUM(profit) AS order_profit
  FROM sales
  GROUP BY order_id
)
SELECT * FROM orders
ORDER BY order_sales DESC
LIMIT 10;

-- 8) Categories with Negative Profit Months
WITH monthly AS (
  SELECT category, strftime('%Y-%m', order_date) AS ym, SUM(profit) AS profit
  FROM sales
  GROUP BY category, ym
)
SELECT * FROM monthly WHERE profit < 0 ORDER BY category, ym;

-- 9) State Contribution to Total Sales (%)
WITH by_state AS (
  SELECT state, SUM(sales) AS sales
  FROM sales
  GROUP BY state
),
total AS (
  SELECT SUM(sales) AS total_sales FROM by_state
)
SELECT b.state,
       ROUND(100.0 * b.sales / t.total_sales, 2) AS pct_of_total
FROM by_state b, total t
ORDER BY pct_of_total DESC;

-- 10) Cumulative Sales Over Time (Window Function)
WITH daily AS (
  SELECT DATE(order_date) AS d, SUM(sales) AS sales
  FROM sales
  GROUP BY d
)
SELECT d,
       sales,
       ROUND(SUM(sales) OVER (ORDER BY d ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS cum_sales
FROM daily
ORDER BY d;

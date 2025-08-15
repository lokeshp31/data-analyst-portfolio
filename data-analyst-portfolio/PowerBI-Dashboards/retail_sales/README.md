# Retail Sales Dashboard (Power BI)

This folder contains a clean CSV (`sales.csv`) you can import into Power BI to build a dashboard that demonstrates core DA skills.

## Build Steps
1. Open **Power BI Desktop** → **Get Data** → **Text/CSV** → select `sales.csv`.
2. Verify data types:
   - `order_date`: Date
   - `sales`, `profit`: Decimal Number
   - `quantity`: Whole Number
3. Click **Load**.
4. Create a **Date table** (Modeling → New table) and mark it as a date table:
   ```DAX
   Date = CALENDAR(DATE(2024,1,1), DATE(2025,12,31))
   ```
5. Create relationships: `Date[Date]` → `sales[order_date]`.
6. Add the following measures:
   ```DAX
   Total Sales = SUM(sales[sales])
   Total Profit = SUM(sales[profit])
   Profit Margin % = DIVIDE([Total Profit], [Total Sales])
   Orders = DISTINCTCOUNT(sales[order_id])
   Avg Order Value = DIVIDE([Total Sales], [Orders])
   ```
7. Suggested visuals:
   - **Cards**: Total Sales, Total Profit, Profit Margin %, Orders
   - **Bar chart**: Sales by Category / Subcategory
   - **Line chart**: Sales over time (Date[Date] on axis, [Total Sales] as values)
   - **Map**: Sales by State
   - **Slicer**: Customer Segment

## Talking Points (for interviews / LinkedIn)
- Which categories drive the most sales and why?
- Which states are most profitable?
- Trend seasonality over the year.
- Profit margin vs. volume trade-offs.


# Retail Sales SQL Analysis (SQLite)

This project demonstrates practical SQL for analytics: joins, aggregations, window functions, and cohort-style analysis.

## How to Run
1. Ensure you have Python 3 and `pandas` installed.
2. Run the loader script to create `retail.db` from the CSV used in the Power BI project:
   ```bash
   python load_sales_to_sqlite.py
   ```
3. Execute the analysis queries (requires `sqlite3` CLI):
   ```bash
   sqlite3 retail.db < queries.sql
   ```
   Or open `retail.db` with your preferred SQLite client and run pieces of `queries.sql` interactively.

## Files
- `load_sales_to_sqlite.py` – creates a SQLite DB and loads `sales.csv` into a `sales` table
- `queries.sql` – 10+ analytics queries you can discuss in interviews
- `questions.md` – business questions the SQL answers

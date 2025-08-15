# Load sales.csv into SQLite as table `sales`
import sqlite3, pandas as pd, os
from pathlib import Path

root = Path(__file__).resolve().parent
csv_path = root.parent.parent / "PowerBI-Dashboards" / "retail_sales" / "sales.csv"
db_path = root / "retail.db"

df = pd.read_csv(csv_path, parse_dates=["order_date"])
con = sqlite3.connect(db_path)
df.to_sql("sales", con=con, if_exists="replace", index=False)
con.close()
print(f"Loaded {len(df)} rows into {db_path} as table 'sales'.")

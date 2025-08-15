import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

root = Path(__file__).resolve().parent
csv_path = root.parent.parent / "PowerBI-Dashboards" / "retail_sales" / "sales.csv"
out_dir = root / "outputs"
out_dir.mkdir(exist_ok=True, parents=True)

df = pd.read_csv(csv_path, parse_dates=["order_date"])

# Clean types (already good), derive month
df['month'] = df['order_date'].dt.to_period('M').dt.to_timestamp()

# KPIs
total_sales = df['sales'].sum()
total_profit = df['profit'].sum()
orders = df['order_id'].nunique()
aov = df.groupby('order_id')['sales'].sum().mean()
profit_margin = total_profit / total_sales if total_sales else 0

print('KPIs:')
print({'total_sales': round(total_sales, 2),
       'total_profit': round(total_profit, 2),
       'profit_margin': round(profit_margin, 4),
       'orders': int(orders),
       'avg_order_value': round(aov, 2)})

# Monthly sales plot
monthly = df.groupby('month', as_index=False)['sales'].sum()

plt.figure()
plt.plot(monthly['month'], monthly['sales'])
plt.title('Monthly Sales')
plt.xlabel('Month')
plt.ylabel('Sales')
plt.tight_layout()
plt.savefig(out_dir / 'monthly_sales.png', dpi=150)
print(f"Saved plot to {out_dir / 'monthly_sales.png'}")

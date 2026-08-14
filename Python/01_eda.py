import pandas as pd

customers = pd.read_csv("data/customers.csv")
categories = pd.read_csv("data/categories.csv")
products = pd.read_csv("data/products.csv")
orders = pd.read_csv("data/orders.csv")
shipments = pd.read_csv("data/shipments.csv")
promotions = pd.read_csv("data/promotions.csv")
suppliers = pd.read_csv("data/suppliers.csv")
payments = pd.read_csv("data/payments.csv")
order_items = pd.read_csv("data/order_items.csv")
employees = pd.read_csv("data/employees.csv")
stores = pd.read_csv("data/stores.csv")
returns = pd.read_csv("data/returns.csv")

datasets = {
    "customers": customers,
    "categories": categories,
    "products": products,
    "orders": orders,
    "shipments": shipments,
    "promotions": promotions,
    "suppliers": suppliers,
    "payments": payments,
    "order_items": order_items,
    "employees": employees,
    "stores": stores,
    "returns": returns
}

   # Step 20 - Convert date columns to datetime
customers["signup_date"] = pd.to_datetime(customers["signup_date"])
orders["order_date"] = pd.to_datetime(orders["order_date"])

# Display date ranges
print("\nCustomer signup date range:")
print(customers["signup_date"].min(), "to", customers["signup_date"].max())

print("\nOrder date range:")
print(orders["order_date"].min(), "to", orders["order_date"].max())

# Step 21 - Numerical distribution summary

print("\nProduct price statistics:")
print(products["price"].describe())

print("\nOrder item quantity statistics:")
print(order_items["qty"].describe())

print("\nOrder item price statistics:")
print(order_items["price"].describe())

print("\nPayment amount statistics:")
print(payments["amount"].describe())

print("\nEmployee salary statistics:")
print(employees["salary"].describe())

print("\nReturn refund statistics:")
print(returns["refund"].describe())

# Step 22 - Outlier detection using IQR

def check_outliers(df, column):
    Q1 = df[column].quantile(0.25)
    Q3 = df[column].quantile(0.75)
    IQR = Q3 - Q1

    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR

    outliers = df[
        (df[column] < lower_bound) |
        (df[column] > upper_bound)
    ]

    print(f"\n{column}")
    print("Lower bound:", lower_bound)
    print("Upper bound:", upper_bound)
    print("Outlier count:", len(outliers))


check_outliers(products, "price")
check_outliers(order_items, "qty")
check_outliers(order_items, "price")
check_outliers(payments, "amount")
check_outliers(employees, "salary")
check_outliers(returns, "refund")

# Step 23 - Order quantity distribution

quantity_distribution = order_items["qty"].value_counts().sort_index()

print("\nOrder quantity distribution:")
print(quantity_distribution)

print("\nOrder quantity percentage:")
print((quantity_distribution / len(order_items) * 100).round(2))

# Step 24 - Monthly order trend

orders["year_month"] = orders["order_date"].dt.to_period("M")

monthly_orders = orders.groupby("year_month").size()

print("\nMonthly order trend:")
print(monthly_orders)

# Step 25 - Yearly order trend

yearly_orders = orders.groupby(
    orders["order_date"].dt.year
).size()

print("\nYearly order trend:")
print(yearly_orders)

# Step 26 - Year-over-year order growth

complete_years = yearly_orders.loc[2020:2023]

yoy_change = complete_years.pct_change() * 100

print("\nYear-over-year order growth (%):")
print(yoy_change.round(2))

# Step 27 - Customer signup trend

customer_signup_yearly = customers.groupby(
    customers["signup_date"].dt.year
).size()

print("\nCustomer signup trend:")
print(customer_signup_yearly)

# Step 28 - Customer growth vs order growth

comparison = pd.DataFrame({
    "customers_signed_up": customer_signup_yearly.loc[2020:2023],
    "orders": yearly_orders.loc[2020:2023]
})

comparison["orders_per_new_customer"] = (
    comparison["orders"] / comparison["customers_signed_up"]
)

print("\nCustomer growth vs order volume:")
print(comparison.round(2))

# Step 29 - Payment value distribution

payment_bins = [0, 5000, 10000, 15000, 20000]
payment_labels = ["0-5K", "5K-10K", "10K-15K", "15K-20K"]

payments["amount_range"] = pd.cut(
    payments["amount"],
    bins=payment_bins,
    labels=payment_labels,
    include_lowest=True
)

payment_distribution = payments["amount_range"].value_counts().sort_index()

print("\nPayment value distribution:")
print(payment_distribution)

print("\nPayment value percentage:")
print(
    (payment_distribution / len(payments) * 100).round(2)
)

# Step 30 - Category product analysis

category_product_analysis = products.merge(
    categories,
    on="category_id",
    how="left"
)

category_summary = category_product_analysis.groupby(
    "category_name"
).agg(
    product_count=("product_id", "count"),
    average_price=("price", "mean"),
    minimum_price=("price", "min"),
    maximum_price=("price", "max")
).sort_values(
    "average_price",
    ascending=False
)

print("\nCategory product analysis:")
print(category_summary.round(2))

# Step 31 - Category sales performance

sales_data = order_items.merge(
    products[["product_id", "category_id"]],
    on="product_id",
    how="left"
)

sales_data = sales_data.merge(
    categories[["category_id", "category_name"]],
    on="category_id",
    how="left"
)

sales_data["revenue"] = sales_data["qty"] * sales_data["price"]

category_sales = sales_data.groupby(
    "category_name"
).agg(
    units_sold=("qty", "sum"),
    revenue=("revenue", "sum"),
    average_selling_price=("price", "mean")
).sort_values(
    "revenue",
    ascending=False
)

print("\nCategory sales performance:")
print(category_sales.round(2))


# Step 32 - Top-selling products

product_sales = order_items.groupby(
    "product_id"
).agg(
    units_sold=("qty", "sum"),
    revenue=("price", lambda x: (x * order_items.loc[x.index, "qty"]).sum())
).sort_values(
    "revenue",
    ascending=False
)

print("\nTop 10 products by revenue:")
print(product_sales.head(10).round(2))

# Step 33 - Top-selling products by units

top_units_products = product_sales.sort_values(
    "units_sold",
    ascending=False
).head(10)

print("\nTop 10 products by units sold:")
print(top_units_products)

# Step 34 - Revenue per unit for top-selling products

top_units_products = top_units_products.copy()

top_units_products["revenue_per_unit"] = (
    top_units_products["revenue"] /
    top_units_products["units_sold"]
)

print("\nTop products - revenue per unit:")
print(
    top_units_products[
        ["units_sold", "revenue", "revenue_per_unit"]
    ].round(2)
)

# Step 35 - Shipment status analysis

shipment_status = shipments["status"].value_counts()

print("\nShipment status count:")
print(shipment_status)

print("\nShipment status percentage:")
print(
    (shipment_status / len(shipments) * 100).round(2)
)

# Step 36 - Shipment status by year

shipment_analysis = shipments.merge(
    orders[["order_id", "order_date"]],
    on="order_id",
    how="left"
)

shipment_analysis["year"] = shipment_analysis["order_date"].dt.year

yearly_shipment_status = pd.crosstab(
    shipment_analysis["year"],
    shipment_analysis["status"]
)

print("\nShipment status by year:")
print(yearly_shipment_status)

# Step 37 - Late shipment rate by year

complete_shipment_years = yearly_shipment_status.loc[2020:2023]

late_shipment_rate = (
    complete_shipment_years["late"] /
    complete_shipment_years.sum(axis=1)
) * 100

print("\nLate shipment rate by year:")
print(late_shipment_rate.round(2))

# Step 38 - Returns and refund analysis

return_summary = {
    "total_returns": len(returns),
    "total_refund": returns["refund"].sum(),
    "average_refund": returns["refund"].mean(),
    "median_refund": returns["refund"].median()
}

print("\nReturns and refund summary:")
for metric, value in return_summary.items():
    print(f"{metric}: {value:.2f}")

    # Step 39 - Returns by category

return_sales = returns.merge(
    order_items[["order_item_id", "product_id"]],
    on="order_item_id",
    how="left"
)

return_sales = return_sales.merge(
    products[["product_id", "category_id"]],
    on="product_id",
    how="left"
)

return_sales = return_sales.merge(
    categories[["category_id", "category_name"]],
    on="category_id",
    how="left"
)

category_returns = return_sales.groupby(
    "category_name"
).agg(
    return_count=("return_id", "count"),
    total_refund=("refund", "sum"),
    average_refund=("refund", "mean")
).sort_values(
    "return_count",
    ascending=False
)

print("\nReturns by category:")
print(category_returns.round(2))

# Step 40 - Category return rate

category_return_rate = category_sales[
    ["units_sold"]
].join(
    category_returns[
        ["return_count", "total_refund"]
    ]
)

category_return_rate["return_rate"] = (
    category_return_rate["return_count"] /
    category_return_rate["units_sold"]
) * 100

category_return_rate = category_return_rate.sort_values(
    "return_rate",
    ascending=False
)

print("\nCategory return rate:")
print(category_return_rate.round(2))

# Step 41 - Store performance analysis

store_orders = orders.merge(
    stores[["store_id", "city"]],
    on="store_id",
    how="left"
)

store_orders = store_orders.merge(
    payments[["order_id", "amount"]],
    on="order_id",
    how="left"
)

store_summary = store_orders.groupby(
    ["store_id", "city"]
).agg(
    order_count=("order_id", "count"),
    total_revenue=("amount", "sum"),
    average_order_value=("amount", "mean")
).sort_values(
    "total_revenue",
    ascending=False
)

print("\nStore performance:")
print(store_summary.round(2))

# Step 42 - Top 10 stores by revenue

top_stores = store_summary.head(10)

print("\nTop 10 stores by revenue:")
print(top_stores.round(2))

# Step 43 - City performance analysis

city_summary = store_orders.groupby(
    "city"
).agg(
    order_count=("order_id", "count"),
    total_revenue=("amount", "sum"),
    average_order_value=("amount", "mean")
).sort_values(
    "total_revenue",
    ascending=False
)

print("\nCity performance:")
print(city_summary.round(2))

# Step 44 - City revenue contribution

city_summary["revenue_contribution"] = (
    city_summary["total_revenue"] /
    city_summary["total_revenue"].sum()
) * 100

print("\nCity revenue contribution:")
print(
    city_summary[
        ["order_count", "total_revenue", "revenue_contribution"]
    ].round(2)
)

# Step 45 - Employee cost by store

employee_store_summary = employees.merge(
    stores[["store_id", "city"]],
    on="store_id",
    how="left"
)

employee_store_summary = employee_store_summary.groupby(
    ["store_id", "city"]
).agg(
    employee_count=("employee_id", "count"),
    total_salary=("salary", "sum"),
    average_salary=("salary", "mean")
).sort_values(
    "total_salary",
    ascending=False
)

print("\nEmployee cost by store:")
print(employee_store_summary.round(2))

# Step 46 - Store revenue vs employee cost

store_business = store_summary[
    ["order_count", "total_revenue", "average_order_value"]
].join(
    employee_store_summary[
        ["employee_count", "total_salary"]
    ],
    how="left"
)

store_business["revenue_per_salary"] = (
    store_business["total_revenue"] /
    store_business["total_salary"]
)

store_business = store_business.sort_values(
    "revenue_per_salary",
    ascending=False
)

print("\nStore revenue vs employee cost:")
print(store_business.round(2))

# Step 47 - Most and least efficient stores

print("\nTop 5 stores by revenue-to-salary ratio:")
print(
    store_business[
        ["total_revenue", "total_salary", "revenue_per_salary"]
    ].head(5).round(2)
)

print("\nBottom 5 stores by revenue-to-salary ratio:")
print(
    store_business[
        ["total_revenue", "total_salary", "revenue_per_salary"]
    ].tail(5).round(2)
)

# Step 48 - Monthly order trend visualization

import matplotlib.pyplot as plt

monthly_orders = orders[
    orders["order_date"] < "2024-01-01"
].groupby(
    orders["order_date"].dt.to_period("M")
).size()

plt.figure(figsize=(12, 5))

plt.plot(
    monthly_orders.index.astype(str),
    monthly_orders.values
)

plt.title("Monthly Order Trend")
plt.xlabel("Month")
plt.ylabel("Number of Orders")

plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig("outputs/monthly_order_trend.png", dpi=300)

plt.show()

# Step 49 - Category revenue visualization

category_revenue = category_sales.sort_values(
    "revenue",
    ascending=True
)

plt.figure(figsize=(10, 8))

plt.barh(
    category_revenue.index,
    category_revenue["revenue"]
)

plt.title("Revenue by Category")
plt.xlabel("Revenue")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig("outputs/category_revenue.png", dpi=300)

plt.show()

# Step 49 - Category revenue visualization

category_revenue = category_sales.sort_values(
    "revenue",
    ascending=True
)

plt.figure(figsize=(10, 8))

plt.barh(
    category_revenue.index,
    category_revenue["revenue"]
)

plt.title("Revenue by Category")
plt.xlabel("Revenue")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig("outputs/category_revenue.png", dpi=300)

plt.show()

# Step 50 - Top 10 products by revenue visualization

top_10_revenue = product_sales.sort_values(
    "revenue",
    ascending=False
).head(10).sort_values(
    "revenue",
    ascending=True
)

plt.figure(figsize=(10, 6))

plt.barh(
    top_10_revenue.index.astype(str),
    top_10_revenue["revenue"]
)

plt.title("Top 10 Products by Revenue")
plt.xlabel("Revenue")
plt.ylabel("Product ID")

plt.tight_layout()

plt.savefig("outputs/top_10_products_revenue.png", dpi=300)

plt.show()

# Step 51 - Shipment status visualization

shipment_status = shipments["status"].value_counts()

plt.figure(figsize=(8, 6))

plt.bar(
    shipment_status.index,
    shipment_status.values
)

plt.title("Shipment Status Distribution")
plt.xlabel("Shipment Status")
plt.ylabel("Number of Shipments")

plt.tight_layout()

plt.savefig("outputs/shipment_status.png", dpi=300)

plt.show()

# Step 52 - Shipment status by year visualization

shipment_year = shipments.copy()

shipment_year["year"] = pd.to_datetime(
    orders["order_date"]
).dt.year.values

shipment_year_status = pd.crosstab(
    shipment_year["year"],
    shipment_year["status"]
)

shipment_year_status.plot(
    kind="bar",
    figsize=(10, 6)
)

plt.title("Shipment Status by Year")
plt.xlabel("Year")
plt.ylabel("Number of Shipments")
plt.xticks(rotation=0)

plt.tight_layout()

plt.savefig("outputs/shipment_status_by_year.png", dpi=300)

plt.show()

# Step 53 - Late shipment rate by year visualization

shipment_year = shipments.copy()

shipment_year["year"] = pd.to_datetime(
    orders["order_date"]
).dt.year.values

late_rate = (
    shipment_year.groupby("year")["status"]
    .apply(lambda x: (x == "late").mean() * 100)
)

# Exclude 2024 because it contains only partial-year data
late_rate = late_rate[late_rate.index < 2024]

plt.figure(figsize=(9, 6))

plt.plot(
    late_rate.index,
    late_rate.values,
    marker="o"
)

plt.title("Late Shipment Rate by Year")
plt.xlabel("Year")
plt.ylabel("Late Shipment Rate (%)")
plt.xticks(late_rate.index)

plt.tight_layout()

plt.savefig("outputs/late_shipment_rate_by_year.png", dpi=300)

plt.show()

# Step 54 - Returns by category visualization

returns_category_plot = category_returns.sort_values(
    "return_count",
    ascending=True
)

plt.figure(figsize=(10, 8))

plt.barh(
    returns_category_plot.index,
    returns_category_plot["return_count"]
)

plt.title("Returns by Category")
plt.xlabel("Number of Returns")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig("outputs/returns_by_category.png", dpi=300)

plt.show()

# Step 55 - Category return rate visualization

category_return_rate = category_returns.copy()

category_return_rate["return_rate"] = (
    category_return_rate["return_count"]
    / category_sales["units_sold"]
    * 100
)

category_return_rate = category_return_rate.sort_values(
    "return_rate",
    ascending=True
)

plt.figure(figsize=(10, 8))

plt.barh(
    category_return_rate.index,
    category_return_rate["return_rate"]
)

plt.title("Return Rate by Category")
plt.xlabel("Return Rate (%)")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig(
    "outputs/category_return_rate.png",
    dpi=300
)

plt.show()

# Step 56 - Top 10 stores by revenue visualization

store_revenue_plot = (
    orders.merge(
        payments[["order_id", "amount"]],
        on="order_id",
        how="left"
    )
    .merge(
        stores[["store_id", "city"]],
        on="store_id",
        how="left"
    )
    .groupby(["store_id", "city"])
    .agg(
        order_count=("order_id", "nunique"),
        total_revenue=("amount", "sum")
    )
    .sort_values("total_revenue", ascending=False)
    .head(10)
    .sort_values("total_revenue", ascending=True)
)

store_labels = (
    store_revenue_plot.index.get_level_values("store_id").astype(str)
    + " - "
    + store_revenue_plot.index.get_level_values("city")
)

plt.figure(figsize=(10, 7))

plt.barh(
    store_labels,
    store_revenue_plot["total_revenue"]
)

plt.title("Top 10 Stores by Revenue")
plt.xlabel("Total Revenue")
plt.ylabel("Store")

plt.tight_layout()

plt.savefig(
    "outputs/top_10_stores_revenue.png",
    dpi=300
)

plt.show()

# Step 57 - City revenue contribution visualization

city_revenue_plot = orders.merge(
    payments[["order_id", "amount"]],
    on="order_id",
    how="left"
).merge(
    stores[["store_id", "city"]],
    on="store_id",
    how="left"
).groupby("city")["amount"].sum()

city_revenue_plot = (
    city_revenue_plot
    / city_revenue_plot.sum()
    * 100
).sort_values(ascending=True)

plt.figure(figsize=(9, 6))

plt.barh(
    city_revenue_plot.index,
    city_revenue_plot.values
)

plt.title("City Revenue Contribution")
plt.xlabel("Revenue Contribution (%)")
plt.ylabel("City")

plt.tight_layout()

plt.savefig(
    "outputs/city_revenue_contribution.png",
    dpi=300
)

plt.show()

# Step 58 - Store revenue vs employee cost visualization

store_revenue = (
    orders.merge(
        payments[["order_id", "amount"]],
        on="order_id",
        how="left"
    )
    .groupby("store_id")["amount"]
    .sum()
)

store_salary = (
    employees.groupby("store_id")["salary"]
    .sum()
)

store_efficiency = pd.concat(
    [store_revenue, store_salary],
    axis=1
)

store_efficiency.columns = [
    "total_revenue",
    "total_salary"
]

plt.figure(figsize=(10, 7))

plt.scatter(
    store_efficiency["total_salary"],
    store_efficiency["total_revenue"]
)

plt.title("Store Revenue vs Employee Cost")
plt.xlabel("Total Employee Salary")
plt.ylabel("Total Revenue")

plt.tight_layout()

plt.savefig(
    "outputs/store_revenue_vs_employee_cost.png",
    dpi=300
)

plt.show()

# Step 59 - Store revenue-to-salary efficiency visualization

store_efficiency["revenue_per_salary"] = (
    store_efficiency["total_revenue"]
    / store_efficiency["total_salary"]
)

top_bottom_stores = pd.concat([
    store_efficiency.nlargest(5, "revenue_per_salary"),
    store_efficiency.nsmallest(5, "revenue_per_salary")
])

top_bottom_stores = top_bottom_stores.sort_values(
    "revenue_per_salary",
    ascending=True
)

store_labels = top_bottom_stores.index.astype(str)

plt.figure(figsize=(10, 7))

plt.barh(
    store_labels,
    top_bottom_stores["revenue_per_salary"]
)

plt.title("Top & Bottom Stores by Revenue-to-Salary Ratio")
plt.xlabel("Revenue per Salary")
plt.ylabel("Store ID")

plt.tight_layout()

plt.savefig(
    "outputs/store_revenue_salary_efficiency.png",
    dpi=300
)

plt.show()
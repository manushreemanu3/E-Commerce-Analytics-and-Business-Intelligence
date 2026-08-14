# E-Commerce Analytics and Business Intelligence

## Project Overview

This project is an end-to-end **E-Commerce Analytics and Business Intelligence solution** developed to analyze business performance across sales, customers, products, stores, employees, suppliers, shipments, promotions, payments, and returns.

The project combines **SQL, Python, and Power BI** to transform structured business data into meaningful analysis, visual insights, and an interactive business intelligence dashboard.

The objective is to understand key business performance indicators, identify high-performing areas, analyze operational performance, and present insights in a form that can support data-driven decision-making.

---

## Business Objectives

The project focuses on answering important business questions such as:

* What is the overall revenue and order performance?
* How many customers are contributing to the business?
* Which cities contribute the most to total revenue?
* Which stores generate the highest revenue?
* How does store revenue compare with employee salary costs?
* Which product categories have higher return rates?
* How does revenue change over time?
* What is the current shipment status distribution?
* Which stores have strong revenue-to-salary performance?
* What areas of the business may require further investigation?

---

## Key Performance Indicators

The Power BI dashboard provides an executive-level overview of the business using key metrics.

| KPI                     |       Value |
| ----------------------- | ----------: |
| **Total Revenue**       |     **4bn** |
| **Total Orders**        |    **300K** |
| **Total Customers**     |     **50K** |
| **Average Order Value** | **$12.76K** |

These KPIs provide a high-level view of the scale and performance of the e-commerce business.

---

## Tools & Technologies

| Technology       | Usage                                                               |
| ---------------- | ------------------------------------------------------------------- |
| **SQL**          | Data querying, aggregation, filtering, joins, and business analysis |
| **Python**       | Exploratory Data Analysis and visualization                         |
| **Pandas**       | Data manipulation and analysis                                      |
| **Matplotlib**   | Analytical visualizations                                           |
| **Power BI**     | Interactive Business Intelligence dashboard                         |
| **DAX**          | Measures and analytical calculations                                |
| **Power Query**  | Data preparation and transformation                                 |
| **Git & GitHub** | Version control and project documentation                           |
| **Git LFS**      | Storage of the large Power BI `.pbix` file                          |

---

## Project Workflow

The project follows an end-to-end data analytics workflow:

```text
Raw Data
   ↓
Data Preparation
   ↓
SQL Analysis
   ↓
Python Exploratory Data Analysis
   ↓
Business Insights
   ↓
Power BI Data Model
   ↓
DAX Measures
   ↓
Interactive Dashboard
```

## 1. Data

The project uses multiple interconnected datasets representing different aspects of an e-commerce business.

The datasets cover areas such as:

* Customers
* Orders
* Order Items
* Products
* Categories
* Stores
* Employees
* Suppliers
* Payments
* Promotions
* Shipments
* Returns

The data is organized into a relational structure and connected through appropriate keys and relationships.

---

## 2. SQL Analysis

SQL was used as one of the primary analytical tools in the project.

The SQL analysis includes:

* Data retrieval and filtering
* Table joins
* Aggregations
* `GROUP BY` analysis
* Revenue analysis
* Store-level analysis
* Customer analysis
* Product and category analysis
* Employee cost analysis
* Return analysis
* Business performance calculations

The SQL queries used in the project are available in the `SQL` folder.

---

## 3. Python Exploratory Data Analysis

Python was used to perform exploratory analysis and generate analytical visualizations.

The analysis uses **Pandas** for data manipulation and **Matplotlib** for visualization.

The Python analysis includes:

* Store revenue analysis
* Revenue-to-salary ratio analysis
* Store revenue vs employee cost analysis
* City-level revenue contribution
* Top-performing stores by revenue
* Category-level return rate analysis

The Python source code is available in the `python` folder.

Generated visualizations and outputs are available in the `outputs` folder.

---

## Python Analysis Highlights

### Top & Bottom Stores by Revenue-to-Salary Ratio

The analysis compares store revenue against employee salary costs to identify stores with stronger and weaker revenue-to-salary performance.

This provides an additional perspective on operational efficiency at the store level.

### Store Revenue vs Employee Cost

A scatter plot compares total store revenue against total employee salary costs.

This helps examine the relationship between employee expenditure and revenue generation across stores.

### City Revenue Contribution

Revenue contribution was analyzed across four major cities:

* Mumbai
* Pune
* Delhi
* Bangalore

The visualization provides a comparison of each city's contribution to overall revenue.

### Top 10 Stores by Revenue

The analysis identifies the highest-revenue stores and compares their total revenue performance.

### Return Rate by Category

Return rates were analyzed across product categories to identify categories with relatively higher return behaviour.

This can help businesses investigate potential product, quality, fulfilment, or customer-experience issues.

---

## Power BI Dashboard

The Power BI dashboard provides an interactive business intelligence view of the e-commerce data.

Users can explore the dashboard using filters such as:

* **Year**
* **City**

The dashboard includes key performance indicators and visualizations covering revenue, orders, customers, average order value, city performance, revenue trends, and shipment status.

---

## Dashboard Overview

The main dashboard provides the following visualizations:

### Revenue Share by City

A city-level revenue share visualization compares the contribution of Mumbai, Pune, Delhi, and Bangalore.

### Revenue Trend by Year

The revenue trend visualization shows the change in revenue across the years represented in the dataset.

### Shipment Status Overview

Shipment performance is presented across different shipment statuses, including:

* Shipped
* Delivered
* Late

This provides a high-level view of order fulfilment status.

---

## Dashboard Screenshots

### Page 1 — E-Commerce Analytics Dashboard

![E-Commerce Analytics Dashboard - Page 1](PowerBI_Screenshots/Page%201.jpg)

### Page 2 — E-Commerce Analytics Dashboard

![E-Commerce Analytics Dashboard - Page 2](PowerBI_Screenshots/Page%202.jpg)

### Page 3 — E-Commerce Analytics Dashboard

![E-Commerce Analytics Dashboard - Page 3](PowerBI_Screenshots/Page%203.jpg)

### Page 4 — E-Commerce Analytics Dashboard

![E-Commerce Analytics Dashboard - Page 4](PowerBI_Screenshots/Page%204.jpg)

### Page 5 — E-Commerce Analytics Dashboard

![E-Commerce Analytics Dashboard - Page 5](PowerBI_Screenshots/Page%205.jpg)

---

## Key Business Insights

The analysis provides several useful perspectives on the e-commerce business.

### 1. Overall Business Scale

The dashboard indicates approximately **4bn in total revenue**, **300K orders**, and **50K customers**, providing an overview of the overall scale of the business.

### 2. Average Order Value

The reported average order value is approximately **$12.76K**, providing an important metric for evaluating the value generated per order.

### 3. Geographic Revenue Distribution

Revenue is distributed across Mumbai, Pune, Delhi, and Bangalore, allowing the business to compare geographic performance and identify stronger revenue-contributing markets.

### 4. Revenue Trends

The yearly revenue visualization allows changes in revenue performance to be examined over time.

### 5. Shipment Performance

The shipment status visualization compares shipped, delivered, and late orders, providing an overview of fulfilment performance.

### 6. Store Performance

Store-level analysis identifies high-revenue stores and compares revenue generation across locations.

### 7. Employee Cost & Revenue

Comparing store revenue with employee salary costs provides a perspective on the relationship between operational expenditure and revenue generation.

### 8. Product Returns

Category-level return-rate analysis helps identify categories with comparatively higher return rates that may require further investigation.

---

## Power BI Data Model

The Power BI model contains interconnected business entities including:

```text
Customers
    │
    └── Orders
          │
          ├── Order Items ── Products ── Categories
          │                      │
          │                      └── Suppliers
          │
          ├── Payments
          ├── Shipments
          ├── Promotions
          └── Stores ── Employees

Order Items
    │
    └── Returns
```

The relational model allows analysis across different dimensions of the business while maintaining relationships between the underlying tables.

---

## Repository Structure

```text
E-Commerce-Analytics-and-Business-Intelligence/
│
├── SQL/
│   └── Project 2.sql
│
├── python/
│   └── 01_eda.py
│
├── outputs/
│   └── Python analysis outputs
│
├── powerbi/
│   └── Project_2_Ecommerce_Analytics.pbix
│
├── PowerBI_Screenshots/
│   ├── Page 1.jpg
│   ├── Page 2.jpg
│   ├── Page 3.jpg
│   ├── Page 4.jpg
│   └── Page 5.jpg
│
├── data/
│   └── Project datasets
│
└── .gitattributes
```

---

## Skills Demonstrated

This project demonstrates practical skills in:

* SQL
* Data Analysis
* Exploratory Data Analysis
* Python
* Pandas
* Matplotlib
* Power BI
* DAX
* Power Query
* Data Modeling
* Data Visualization
* Business Intelligence
* KPI Development
* Business Performance Analysis
* Analytical Problem Solving

---

## Project Outcome

This project demonstrates an end-to-end approach to **data-driven business analysis**, starting from raw relational data and progressing through SQL analysis, Python-based exploratory analysis, and Power BI dashboard development.

By combining these technologies, the project transforms raw business data into structured analysis and interactive visual insights that can help stakeholders understand **revenue performance, customer activity, geographic contribution, store performance, employee costs, shipment status, and product returns**.

---

## Author

**Manushree M**

**B.Tech — Computer Science and Engineering**

Aspiring **Data Analyst | SQL | Python | Power BI | Business Intelligence**

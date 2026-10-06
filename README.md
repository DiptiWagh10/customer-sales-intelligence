 Customer Sales Intelligence

End-to-End Data Analytics and Machine Learning Project

An end-to-end Data Analytics and Machine Learning project built using the Olist Brazilian E-Commerce Public Dataset. This project takes raw e-commerce data through data cleaning, transformation, SQL analysis, customer analytics, machine learning, and Power BI visualization to generate meaningful business insights.

Project Overview

E-commerce businesses generate large amounts of customer, order, product, payment, delivery, and review data. The objective of this project is to build an end-to-end analytics workflow that converts raw transactional data into structured analytical datasets and business insights.

Understand sales and revenue performance

Analyze customer purchasing behaviour

Identify high-value customers

Understand repeat-customer behaviour

Analyze delivery and review patterns

Perform business analysis using SQL

Explore repeat-purchase prediction using machine learning

Present findings through Power BI dashboards

Business Problem

How are sales changing over time?

Which states contribute the most revenue?

Who are the highest-value customers?

How many customers make repeat purchases?

What does customer behaviour look like based on recency and spending?

How do delivery performance and reviews relate to orders?

Can historical customer behaviour help identify customers who make another purchase?

How can these findings be presented through an interactive dashboard?

Dataset

This project uses the Olist Brazilian E-Commerce Public Dataset. The dataset contains information related to customers, orders, order items, products, sellers, payments, reviews, delivery, customer locations, and product categories. The raw dataset is not included in this repository because of its size.

Project Workflow

Raw E-Commerce Data
        ↓
Python / Pandas
        ↓
Data Quality Checks
        ↓
Data Cleaning & Transformation
        ↓
Analytical Dataset Creation
        ↓
MySQL Database
        ↓
SQL Business Analysis
        ↓
Customer Analytics
        ↓
Machine Learning
        ↓
Power BI Dashboard
        ↓
Business Insights

1. Data Processing & ETL

Python and Pandas were used to load, inspect, clean, transform, and combine the datasets.

Loaded multiple CSV files

Understood dataset structure

Checked data types

Checked missing values

Checked duplicate records

Validated identifier uniqueness

Converted date and time columns

Created delivery-related metrics

Aggregated order-level information

Aggregated customer-level information

Combined customer, order, payment, review, and product information

Created analytical features

Data Quality

Missing values were investigated based on their meaning rather than blindly removing rows. For example, missing delivery dates can occur for orders that were not successfully delivered, while review comments are optional fields. Duplicate records were also investigated individually instead of applying a blanket duplicate-removal approach.

2. Analytical Datasets

order_analytics

Order information

Customer information

Order value

Items

Payment information

Review information

Delivery information

Product/category information

customer_analytics

Customer identifier

Total orders

Delivered orders

Total spend

Average order value

Total items

Average items per order

Average review score

Delivery-related metrics

Recency

Repeat-customer information

Orders           : 99,441
Unique Customers : 96,096

3. MySQL Database

Database:

customer_sales_intelligence

Main analytical tables:

order_analytics
customer_analytics

4. SQL Business Analysis

Sales Analysis

Monthly sales and revenue trends

Average order value

Top revenue months

Customer Analysis

Top customers

High-value customers

Repeat customers

Customer recency

Customer spending

Geographic Analysis

State-wise sales

Revenue contribution by state

Delivery Analysis

Delivery performance

Late delivery analysis

Review Analysis

Review score analysis

Review score and delivery behaviour

Payment Analysis

Payment types

Installment analysis

Order Analysis

Order-status distribution

Overall order performance

Complete SQL queries are available in:

SQL/analysis_queries.sql

5. Machine Learning

Objective

The machine learning component explores whether historical customer behaviour can help identify customers who make another purchase after a defined temporal cutoff. A temporal approach was used rather than randomly mixing past and future transactions.

Temporal cutoff:

2018-07-01

ML dataset:

ML Dataset Size     : 83,748
Positive Customers  : 299
Positive Class Rate : 0.36%
Features Used       : 10

The target variable was highly imbalanced, with only approximately 0.36% positive examples. Because of this severe class imbalance, accuracy was not treated as the primary evaluation metric.

Models Tested

Random Forest

Logistic Regression

Evaluation Metric

PR-AUC (Precision-Recall Area Under the Curve) was used as the primary evaluation metric.

Model

PR-AUC

Random Forest

0.003799

Logistic Regression

0.005227

Selected Model

Logistic Regression. It achieved the higher PR-AUC among the tested models.

Important Features

Feature

Coefficient

total_orders

1.4356

delivered_orders

-0.7181

avg_items_per_order

0.3582

avg_review_score

0.1372

late_delivery_rate

-0.1163

These coefficients describe model associations and should not be interpreted as causal relationships.

Top-K Performance

Top Customer %

Precision %

Recall %

0.5%

1.20%

1.67%

1%

0.60%

1.67%

2%

0.60%

3.33%

5%

0.72%

10.00%

10%

0.60%

16.67%

The ML experiment is exploratory and is not presented as a production-ready prediction system.

6. Power BI Dashboard

Sales Overview

Total Revenue

Total Orders

Total Customers

Average Review Score

Monthly Revenue Trend

Top 10 States by Revenue

Order Status Distribution

Dashboard screenshot: docs/sales-overview.png

Customer Intelligence

Repeat Customers

Repeat Customer Rate

Average Customer Spend

One-Time vs Repeat Customers

Customer Segments by Recency

Top 10 High-Value Customers

Dashboard screenshot: docs/customer-intelligence.png

Machine Learning Results

Screenshot: docs/ml-results.png

SQL Analysis

Screenshot: docs/sql-analysis.png

Key Business Insights

Sales performance can be examined across months and geographic regions.

Customer-level analysis helps identify high-value, repeat, one-time, recent, at-risk, and inactive customers based on the implemented recency and spending logic.

The overall repeat-customer rate is approximately 3.12%.

The repeat-purchase prediction experiment demonstrates the difficulty of classification when the positive class is extremely rare.

PR-AUC is more informative than accuracy for this highly imbalanced ML problem.

Technologies Used

Category

Tools

Programming

Python

Data Processing

Pandas, NumPy

Machine Learning

Scikit-learn

Database

MySQL

Querying

SQL

Visualization

Power BI

Notebook

Jupyter / Google Colab

Version Control

Git & GitHub

Project Structure

customer-sales-intelligence/
│
├── dashboard/
│   └── customer-sales-intelligence.pbix
├── docs/
│   ├── sales-overview.png
│   ├── customer-intelligence.png
│   ├── ml-results.png
│   └── sql-analysis.png
├── python/
│   └── etl-project.ipynb
├── SQL/
│   └── analysis_queries.sql
├── .gitignore
├── requirements.txt
└── README.md

How to Run

1. Clone the repository

git clone https://github.com/your-username/customer-sales-intelligence.git

2. Navigate to the project

cd customer-sales-intelligence

3. Install dependencies

pip install -r requirements.txt

4. Run the notebook

Open python/etl-project.ipynb using Jupyter Notebook, JupyterLab, or Google Colab.

5. MySQL

Create the customer_sales_intelligence database, load the analytical datasets, and run SQL/analysis_queries.sql.

6. Power BI

Open dashboard/customer-sales-intelligence.pbix to explore the interactive dashboards.

Project Limitations

The positive ML class is extremely small.

The repeat-purchase problem is highly imbalanced.

The future observation window is relatively limited.

The tested models should not be considered production-ready.

The analysis is based on the available Olist public dataset and reflects its characteristics and limitations.

Future Improvements

Better class-imbalance handling

Hyperparameter tuning

Additional classification models

Longer temporal validation

Model explainability

Automated ETL execution

Automated dashboard refresh

Customer lifetime value modelling

More advanced customer segmentation

Project Outcome

Data
 ↓
Cleaning
 ↓
ETL
 ↓
MySQL
 ↓
SQL Analysis
 ↓
Customer Analytics
 ↓
Machine Learning
 ↓
Power BI
 ↓
Business Insights

This project combines Python, SQL, Machine Learning, and Power BI into one end-to-end data analytics project.

Author

Dipti Wagh
M.Tech — Artificial Intelligence & Data Science
# 🚚 End-to-End Supply Chain Analytics Pipeline

## 📌 Project Overview
This project is an end-to-end Data Engineering and Business Intelligence solution designed to diagnose SLA (Service Level Agreement) failures in a logistics network. By processing over 100,000 anonymized e-commerce orders, this project identifies the root causes of delivery delays and their direct impact on customer satisfaction scores.

## 🏗️ Architecture & Technology Stack
* **Language:** Python (Pandas, SQLAlchemy)
* **Database:** PostgreSQL (On-Premise via DBeaver)
* **Business Intelligence:** Power BI (DAX, Data Modeling)
* **Methodology:** ELT (Extract, Load, Transform), Star Schema Modeling, Denormalization

## ⚙️ The Pipeline Workflow
1. **Data Ingestion (Python ELT):** Engineered a Python pipeline to bypass traditional GUI import limitations, programmatically reading messy CSV files and aggressively loading ~1.5 million relational rows into PostgreSQL staging tables.
2. **Data Transformation (SQL):** Utilized CTEs and standard SQL date-math to clean dirty data, exclude anomalies, and calculate precise delivery variance (Days Early/Late) against estimated delivery SLAs. 
3. **Analytical View Creation:** Flattened the relational database into a denormalized Master View (`vw_supply_chain_datamart`) to optimize compute performance for the BI layer.
4. **Data Modeling & Visualization (Power BI):** Built a scalable Star Schema model connecting the datamart to a Portuguese-to-English translation table. Authored explicit DAX measures for executive KPIs and designed a Z-pattern dashboard for root-cause analysis.

## 📊 Dashboard & Key Insights
![Supply Chain Dashboard](dashboard/Dashboard_Screenshot.png)

* **The SLA Breakdown:** Identified two catastrophic system failures in November 2017 (12.40% late rate) and March 2018 (18.96% late rate), correlating directly with massive drops in average customer review scores (down to 3.74).
* **The Root Cause:** Cross-filtering the data model revealed that freight carriers were systematically failing to handle large, bulky items during peak seasons. `Furniture, Mattresses, and Upholstery` was identified as the worst-performing product category, requiring immediate SLA renegotiation with logistics partners.

## 🚀 How to Run the Project
1. Download the raw Brazilian E-Commerce dataset from Kaggle and place the CSVs in the `01_data` folder.
2. Update the credentials in `scripts/ingest_data.py` and copy the ingest.py file in your '01_data' folder then run the script to provision the PostgreSQL database.
3. Then Execute the SQL scripts in the `03_sql_scripts` folder in sequential order to build the analytical view.
4. Open the `.pbix` file from 04_dashboard in Power BI Desktop and refresh the data connection.
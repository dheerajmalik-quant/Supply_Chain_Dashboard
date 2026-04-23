# 📦 Dataset Procurement

To adhere to GitHub's file size limits and data distribution best practices, the raw CSV files for this project are not hosted in this repository. 

To execute this pipeline locally, you have to download the source data directly from Kaggle.

## Download Instructions
1. Navigate to the Kaggle dataset page: **[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)**.
2. Click the **Download** button (you may need to create a free Kaggle account).
3. Unzip the downloaded archive.
4. Move the following extracted CSV files directly into this `01_data` directory:
   * `olist_customers_dataset.csv`
   * `olist_geolocation_dataset.csv`
   * `olist_order_items_dataset.csv`
   * `olist_order_payments_dataset.csv`
   * `olist_order_reviews_dataset.csv`
   * `olist_orders_dataset.csv`
   * `olist_products_dataset.csv`
   * `olist_sellers_dataset.csv`
   * `product_category_name_translation.csv`

Once the data is securely in this folder, proceed to the `02_python_script` directory and copy the ingest_data.py file to the '01_data' directory to initiate the ELT ingestion pipeline.
And execute the .py file 
** You will need these libraries>>
* pandas
* sqlalchemy
* psycopg2-binary

**************Install the Required Libraries
!pip install pandas sqlalchemy psycopg2-binary

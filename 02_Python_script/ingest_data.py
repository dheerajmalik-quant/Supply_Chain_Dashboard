import pandas as pd
from sqlalchemy import create_engine
import os
from urllib.parse import quote_plus

# 1. Database Connection Credentials
# UPDATE THESE WITH YOUR POSTGRESQL USERNAME AND PASSWORD
DB_USER = 'password' # Put your Actual username here, 
DB_PASSWORD = ' '  # Put your actual password here
DB_HOST = 'localhost'
DB_PORT = '5432'
DB_NAME = 'logistics_analytics_db' #The Exact name of your Database!

# URL-encode the password to handle special characters (like @) safely
encoded_password = quote_plus(DB_PASSWORD)

# Create the SQLAlchemy Engine using the encoded password
engine = create_engine(f'postgresql+psycopg2://{DB_USER}:{encoded_password}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# 2. Define the Files and Target Tables
files_to_load = {
    'olist_customers_dataset.csv': 'olist_customers_dataset',
    'olist_geolocation_dataset.csv': 'olist_geolocation_dataset',
    'olist_order_items_dataset.csv': 'olist_order_items_dataset',
    'olist_order_payments_dataset.csv': 'olist_order_payments_dataset',
    'olist_order_reviews_dataset.csv': 'olist_order_reviews_dataset',
    'olist_orders_dataset.csv': 'olist_orders_dataset',
    'olist_products_dataset.csv': 'olist_products_dataset',
    'olist_sellers_dataset.csv': 'olist_sellers_dataset',
    'product_category_name_translation.csv': 'product_category_name_translation'
}

# 3. Execute the ELT Pipeline
print("Initiating Python ELT Pipeline...")

for file_name, table_name in files_to_load.items():
    # Check if the file exists in the current directory
    if not os.path.exists(file_name):
        print(f"ERROR: Could not find {file_name} in the current directory. Skipping.")
        continue
        
    print(f"Reading {file_name} into memory...")
    
    # Read the CSV into a Pandas DataFrame
    try:
        df = pd.read_csv(file_name)
    except Exception as e:
        print(f"Failed to read {file_name}. Error: {e}")
        continue
    
    print(f"Pushing {len(df)} rows to PostgreSQL table '{table_name}'...")
    
    # Push the DataFrame to PostgreSQL
    try:
        df.to_sql(name=table_name, con=engine, if_exists='replace', index=False)
        print(f"SUCCESS: {table_name} loaded.\n")
    except Exception as e:
        print(f"Failed to load {table_name} into database. Error: {e}\n")

print("Pipeline execution complete. Verify the tables in DBeaver.")
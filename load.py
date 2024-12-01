import pandas as pd
import psycopg2
from psycopg2 import sql

conn = psycopg2.connect(
    host="localhost",
    database="olist",
    user="brulari",
    password="senha123"
)
cur = conn.cursor()


def carregar_dados(tabela, arquivo_csv):
    df = pd.read_csv(arquivo_csv)
    for index, row in df.iterrows():
        cols = ", ".join([str(i) for i in df.columns])
        vals = ", ".join([f"%({i})s" for i in df.columns])
        query = sql.SQL(f"INSERT INTO {tabela} ({cols}) VALUES ({vals})")
        cur.execute(query, row.to_dict())


carregar_dados('olist_orders_dataset', 'olist_orders_dataset.csv')
carregar_dados('olist_order_payments_dataset', 'olist_order_payments_dataset.csv')
carregar_dados('olist_order_reviews_dataset', 'olist_order_reviews_dataset.csv')
carregar_dados('olist_order_items_dataset', 'olist_order_items_dataset.csv')
carregar_dados('olist_order_customer_dataset', 'olist_order_customer_dataset.csv')
carregar_dados('olist_products_dataset', 'olist_products_dataset.csv')
carregar_dados('olist_sellers_dataset', 'olist_sellers_dataset.csv')
carregar_dados('olist_geolocation_dataset', 'olist_geolocation_dataset.csv')


conn.commit()
cur.close()
conn.close()

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

def carregar_wide_table():
    query = """
    INSERT INTO wide_table (
        order_id, order_item_id, customer_id, customer_unique_id, customer_zip_code_prefix, 
        customer_city, customer_state, product_id, product_category_name, product_name_length, 
        product_description_length, product_photos_qty, product_weight_g, product_length_cm, 
        product_height_cm, product_width_cm, seller_id, seller_zip_code_prefix, seller_city, 
        seller_state, seller_lat, seller_lng, purchase_date, order_status, price, freight_value, 
        payment_type, payment_installments, payment_value, review_score
    )
    SELECT 
        o.order_id, oi.order_item_id, oc.customer_id, oc.customer_unique_id, 
        oc.customer_zip_code_prefix, oc.customer_city, oc.customer_state,
        p.product_id, p.product_category_name, p.product_name_length,
        p.product_description_length, p.product_photos_qty, p.product_weight_g,
        p.product_length_cm, p.product_height_cm, p.product_width_cm, 
        s.seller_id, s.seller_zip_code_prefix, s.seller_city, s.seller_state,
        g.geolocation_lat AS seller_lat, g.geolocation_lng AS seller_lng,
        o.order_purchase_timestamp, o.order_status, oi.price, oi.freight_value,
        op.payment_type, op.payment_installments, op.payment_value, orv.review_score
    FROM 
        olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    JOIN olist_order_customer_dataset oc ON o.customer_id = oc.customer_id
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    JOIN olist_sellers_dataset s ON oi.seller_id = s.seller_id
    JOIN olist_geolocation_dataset g ON s.seller_zip_code_prefix = g.zip_code_prefix
    JOIN olist_order_payments_dataset op ON o.order_id = op.order_id
    JOIN olist_order_reviews_dataset orv ON o.order_id = orv.order_id;
    """
    cur.execute(query)
    conn.commit()

carregar_wide_table()
cur.close()
conn.close()

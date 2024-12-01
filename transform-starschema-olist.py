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

def carregar_fact_sales():
    query = """
    INSERT INTO fact_sales (
        order_id, order_item_id, customer_id, product_id, seller_id, 
        purchase_date, order_status, price, freight_value, payment_type, 
        payment_installments, payment_value, review_score
    )
    SELECT 
        o.order_id, oi.order_item_id, oc.customer_id, oi.product_id, oi.seller_id,
        o.order_purchase_timestamp, o.order_status, oi.price, oi.freight_value,
        op.payment_type, op.payment_installments, op.payment_value, orv.review_score
    FROM 
        olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    JOIN olist_order_customer_dataset oc ON o.customer_id = oc.customer_id
    JOIN olist_order_payments_dataset op ON o.order_id = op.order_id
    JOIN olist_order_reviews_dataset orv ON o.order_id = orv.order_id;
    """
    cur.execute(query)
    conn.commit()

carregar_fact_sales()
cur.close()
conn.close()

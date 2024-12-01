CREATE DATABASE olist;

CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES olist_order_customer_dataset(customer_id)
);

CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(255),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id)
);

CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(255) PRIMARY KEY,
    order_id VARCHAR(255),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id)
);

CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(255),
    order_item_id INTEGER,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id),
    FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id),
    FOREIGN KEY (seller_id) REFERENCES olist_sellers_dataset(seller_id)
);

CREATE TABLE olist_order_customer_dataset (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(255),
    customer_state VARCHAR(50)
);

CREATE TABLE olist_products_dataset (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(255),
    seller_state VARCHAR(50),
    FOREIGN KEY (seller_zip_code_prefix) REFERENCES olist_geolocation_dataset(zip_code_prefix)
);

CREATE TABLE olist_geolocation_dataset (
    zip_code_prefix INTEGER PRIMARY KEY,
    geolocation_lat DECIMAL(8, 6),
    geolocation_lng DECIMAL(8, 6),
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(50)
);

ALTER TABLE orders ADD CONSTRAINT orders_customers_fk
FOREIGN KEY (customer_id)
REFERENCES customers (customer_unique_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE customers ADD CONSTRAINT customers_geolocation_fk
FOREIGN KEY (customer_zip_code_prefix)
REFERENCES geolocation (geolocation_zip_code_prefix)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sellers ADD CONSTRAINT geolocation_sellers_fk
FOREIGN KEY (seller_zip_code_prefix)
REFERENCES geolocation (geolocation_zip_code_prefix)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE orders ADD CONSTRAINT orders_sellers_fk
FOREIGN KEY (order_id)
REFERENCES order_items (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_items ADD CONSTRAINT order_items_products_fk
FOREIGN KEY (product_id)
REFERENCES products (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_items ADD CONSTRAINT order_items_orders_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE payments ADD CONSTRAINT payments_orders_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE reviews ADD CONSTRAINT reviews_orders_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;








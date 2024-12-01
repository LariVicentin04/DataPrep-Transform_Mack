
CREATE TABLE dim_customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(255),
    customer_state VARCHAR(50),
    FOREIGN KEY (customer_zip_code_prefix) REFERENCES dim_geolocation(zip_code_prefix)
);


CREATE TABLE dim_products (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);


CREATE TABLE dim_sellers (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(255),
    seller_state VARCHAR(50),
    FOREIGN KEY (seller_zip_code_prefix) REFERENCES dim_geolocation(zip_code_prefix)
);


CREATE TABLE dim_geolocation (
    zip_code_prefix INTEGER PRIMARY KEY,
    geolocation_lat DECIMAL(8, 6),
    geolocation_lng DECIMAL(8, 6),
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(50)
);


CREATE TABLE dim_time (
    time_id SERIAL PRIMARY KEY,
    date TIMESTAMP,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    day INTEGER,
    week INTEGER,
    day_of_week INTEGER
);


CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    order_id VARCHAR(255),
    order_item_id INTEGER,
    customer_id VARCHAR(255),
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    purchase_date TIMESTAMP,
    time_id INTEGER,
    order_status VARCHAR(50),
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value DECIMAL(10, 2),
    review_score INTEGER,
    FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (seller_id) REFERENCES dim_sellers(seller_id),
    FOREIGN KEY (time_id) REFERENCES dim_time(time_id)
);


ALTER TABLE dim_customers ADD CONSTRAINT dim_customers_geolocation_fk
FOREIGN KEY (customer_zip_code_prefix)
REFERENCES dim_geolocation(zip_code_prefix)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dim_sellers ADD CONSTRAINT dim_sellers_geolocation_fk
FOREIGN KEY (seller_zip_code_prefix)
REFERENCES dim_geolocation(zip_code_prefix)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_orders_fk
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset(order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_customers_fk
FOREIGN KEY (customer_id)
REFERENCES dim_customers(customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_products_fk
FOREIGN KEY (product_id)
REFERENCES dim_products(product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_sellers_fk
FOREIGN KEY (seller_id)
REFERENCES dim_sellers(seller_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_time_fk
FOREIGN KEY (time_id)
REFERENCES dim_time(time_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

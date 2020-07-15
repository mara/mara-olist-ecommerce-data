DROP SCHEMA IF EXISTS ecommerce CASCADE;
CREATE SCHEMA ecommerce;

--This table has information about the customer and its location. Use it to identify unique customers in the orders table and to find the orders delivery location.
--At our system each order is assigned to a unique customer_id.
--This means that the same customer will get different ids for different orders.
--The purpose of having a customer_unique_id on the table is to allow you to identify customers that made repurchases at the store.
--Otherwise you would find that each order had a different customer associated with.
DROP TABLE IF EXISTS ecommerce.customers CASCADE;
CREATE TABLE ecommerce.customers
(
    customer_id              TEXT, --key to the orders table. Each order has a unique customer_id.
    customer_unique_id       TEXT, --unique identifier of a customer.
    customer_zip_code_prefix TEXT, --first five digits of customer zip code
    customer_city            TEXT, --customer city name
    customer_state           TEXT  --customer state
);

--This table has information Brazilian zip codes and its lat/lng coordinates. Use it to plot maps and find distances between sellers and customers.
DROP TABLE IF EXISTS ecommerce.geolocation CASCADE;
CREATE TABLE ecommerce.geolocation
(
    geolocation_zip_code_prefix TEXT,             --first 5 digits of zip code
    geolocation_lat             DOUBLE PRECISION, --latitude
    geolocation_lng             DOUBLE PRECISION, --longitude
    geolocation_city            TEXT,             --city name
    geolocation_state           TEXT              --state
);

--This table includes data about the items purchased within each order.
DROP TABLE IF EXISTS ecommerce.order_items CASCADE;
CREATE TABLE ecommerce.order_items
(
    order_id            TEXT,                     --order unique identifier
    order_item_id       INTEGER,                  --sequential number identifying number of items included in the same order.
    product_id          TEXT,                     --product unique identifier
    seller_id           TEXT,                     --seller unique identifier
    shipping_limit_date TIMESTAMP WITH TIME ZONE, --Shows the seller shipping limit date for handling the order over to the logistic partner.
    price               DOUBLE PRECISION,         --item price
    freight_value       DOUBLE PRECISION          --item freight value item (if an order has more than one item the freight value is splitted between items)
);

--This table includes data about the orders payment options.
DROP TABLE IF EXISTS ecommerce.order_payments CASCADE;
CREATE TABLE ecommerce.order_payments
(
    order_id             TEXT,            --unique identifier of an order.
    payment_sequential   INTEGER,         --a customer may pay an order with more than one payment method. If he does so, a sequence will be created to
    payment_type         TEXT,            --method of payment chosen by the customer.
    payment_installments INTEGER,         --number of installments chosen by the customer.
    payment_value        DOUBLE PRECISION --transaction value.
);

--This table includes data about the reviews made by the customers.
--After a customer purchases the product from Olist Store a seller gets notified to fulfill that order.
--Once the customer receives the product, or the estimated delivery date is due,
--the customer gets a satisfaction survey by email where he can give a note for the purchase experience and write down some comments.
DROP TABLE IF EXISTS ecommerce.order_reviews CASCADE;
CREATE TABLE ecommerce.order_reviews
(
    review_id               TEXT,                     --unique review identifier
    order_id                TEXT,                     --unique order identifier
    review_score            INTEGER,                  --Note ranging from 1 to 5 given by the customer on a satisfaction survey.
    review_comment_title    TEXT,                     --Comment title from the review left by the customer, in Portuguese.
    review_comment_message  TEXT,                     --Comment message from the review left by the customer, in Portuguese.
    review_creation_date    TIMESTAMP WITH TIME ZONE, --Shows the date in which the satisfaction survey was sent to the customer.
    review_answer_timestamp TIMESTAMP WITH TIME ZONE  --Shows satisfaction survey answer timestamp.
);

--This is the core table. From each order you might find all other information.
DROP TABLE IF EXISTS ecommerce.orders CASCADE;
CREATE TABLE ecommerce.orders
(
    order_id                      TEXT,                     --unique identifier of the order.
    customer_id                   TEXT,                     --key to the customer table. Each order has a unique customer_id.
    order_status                  TEXT,                     --Reference to the order status (delivered, shipped, etc).
    order_purchase_timestamp      TIMESTAMP,                --Shows the purchase timestamp.
    order_approved_at             TIMESTAMP WITH TIME ZONE, --Shows the payment approval timestamp.
    order_delivered_carrier_date  TIMESTAMP WITH TIME ZONE, --Shows the order posting timestamp. When it was handled to the logistic partner.
    order_delivered_customer_date TIMESTAMP WITH TIME ZONE, --Shows the actual order delivery date to the customer.
    order_estimated_delivery_date TIMESTAMP WITH TIME ZONE  --Shows the estimated delivery date that was informed to customer at the purchase moment.
);

--This table includes data about the products sold by Olist.
DROP TABLE IF EXISTS ecommerce.products CASCADE;
CREATE TABLE ecommerce.products
(
    product_id            TEXT,    --unique product identifier
    product_category_name TEXT,    --root category of product, in Portuguese.
    product_name_length   INTEGER, --number of characters extracted from the product name.
    description_length    INTEGER, --number of characters extracted from the product description.
    product_photos_qty    INTEGER, --number of product published photos
    product_weight_g      INTEGER, --product weight measured in grams.
    product_lenght_cm     INTEGER, --product length measured in centimeters.
    product_height_cm     INTEGER, --product height measured in centimeters.
    product_width_cm      INTEGER  --product width measured in centimeters.
);

--This table includes data about the sellers that fulfilled orders made at Olist. Use it to find the seller location and to identify which seller fulfilled each product.
DROP TABLE IF EXISTS ecommerce.sellers CASCADE;
CREATE TABLE ecommerce.sellers
(
    seller_id              TEXT, --seller unique identifier
    seller_zip_code_prefix TEXT, --first 5 digits of seller zip code
    seller_city            TEXT, --seller city name
    seller_state           TEXT  --seller state
);

--Translates the product_category_name to english.
DROP TABLE IF EXISTS ecommerce.product_category_name_translation CASCADE;
CREATE TABLE ecommerce.product_category_name_translation
(
    product_category_name         TEXT, --category name in Portuguese
    product_category_name_english TEXT  --category name in English
);
{{
    config(
        materialized = 'table',
        unique_key = 'order_guid'
    )
}}

WITH customer_orders AS (
    SELECT order_guid, 
           user_guid, 
           address_guid,
           order_created_at, 
           order_cost,
           shipping_cost,
           shipping_service,
           order_total_cost, 
           delivered_at,
           order_status
    FROM {{ ref('stg_orders') }}
),

customer_order_items AS (
    SELECT order_guid,
           product_guid,
           order_product_quantity
    FROM {{ ref('stg_order_items') }}
),

fact_orders AS (
SELECT user_guid,
       promo_id,
       address_guid,
       custo.order_guid, 
       custoi.product_guid, 
       order_created_at, 
       order_cost,
       order_total_cost,
       order_created_at, 
       order_status,
       shipping_cost,
       shipping_service,
       order_product_quantity,
       delivered_at
FROM customer_orders AS custo
JOIN customer_order_items AS custoi
ON custo.order_guid = custoi.order_guid
)

SELECT * FROM fact_orders

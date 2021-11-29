{{
  config(
    materialized='table'
  )
}}

SELECT 
    id AS order_guid,
    promo_id,
    user_id AS user_guid,
    address_id AS address_guid,
    created_at AS order_created_at,
    order_cost,
    shipping_cost,
    order_total AS order_total_cost,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status AS order_status
FROM {{ source('greenery', 'orders') }}
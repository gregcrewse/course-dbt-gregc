{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name AS product_name,
    price AS product_price,
    quantity AS product_quantity
FROM {{ source('greenery', 'products') }}
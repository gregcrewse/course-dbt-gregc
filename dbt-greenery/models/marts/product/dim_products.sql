{{
    config(
        materialized = 'table',
        unique_key = 'product_id'
    )
}}

with pd as (

SELECT 
    product_id,
    product_name,
    product_price,
    product_quantity
FROM
{{ref ("stg_products")}}
)

SELECT * from pd
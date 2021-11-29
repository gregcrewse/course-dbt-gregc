
select user_guid, 
       sum(order_product_quantity) as total_order_quantity
from {{ ref('fact_order') }}
group by user_guid
having not(sum(order_product_quantity) > 0)
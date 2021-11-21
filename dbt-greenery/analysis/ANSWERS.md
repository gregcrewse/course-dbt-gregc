### 1) How many users do we have?

*130*

SELECT COUNT(*) 
       FROM dbt.dbt_greg_c.stg_users;

### 2) On average, how many orders do we receive per hour?

 *8.35*

SELECT COUNT(*)/(EXTRACT(EPOCH FROM max(created_at)- min(created_at))/3600)  
FROM dbt.dbt_greg_c.stg_orders;

### 3) On average, how long does an order take from being placed to being delivered?

*3 days 22:13:10.504451*

SELECT AVG(days) as avg_time_to_deliver
FROM (
    SELECT
     order_id
     , delivered_at - created_at as days
     FROM dbt.dbt_greg_c.stg_orders
     GROUP BY 1, 2) ORDERS;

### 4) How many users have only made one purchase? Two purchases? Three+ purchases?

*One Order: 25*
*Two Orders: 22*
*Three or more orders: 81*

SELECT
    CASE WHEN count_orders = 1 then 'one_order' 
    WHEN count_orders = 2 then 'two_orders' 
    WHEN count_orders >= 3 then 'three_or_more_orders' END as user_order_count
    , COUNT(DISTINCT user_id) 
    FROM (
        SELECT user_id
        , COUNT(distinct order_id) as count_orders 
        FROM dbt.dbt_greg_c.stg_orders group by 1) ORDERS
    group by 1;

### 5) On average, how many unique sessions do we have per hour?

*120.56*

SELECT AVG(unique_session) FROM (
SELECT EXTRACT(hour FROM a.created_at),  
COUNT (DISTINCT a.session_id) unique_session FROM dbt.dbt_greg_c.stg_events a 
GROUP BY EXTRACT(hour FROM a.created_at)) b;
{{
    config(
        materialized='table'
    )
}}


with page_views as ( 
select 
event_id,
event_guid,
session_guid,
user_guid,
created_at,
page_url
FROM
{{ref ('stg_events')}}
WHERE
event_type='page_view'

)


select * from page_views
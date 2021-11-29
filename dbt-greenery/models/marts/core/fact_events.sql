{{
    config(
        materialized = 'table',
        unique_key = 'event_guid'
    )
}}

with fact_events as (
    select 
        event_id,
        event_guid,
        session_guid,
        user_guid,
        created_at,
        page_url,
        event_type
    from {{ ref('stg_events') }}
)

select * from fact_events
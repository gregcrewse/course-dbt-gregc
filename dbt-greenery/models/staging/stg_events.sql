{{
    config(
        materialized = 'view',
        unique_key = 'event_id'
    )
}}

with events_src as (
    
    select 
        id as event_id,
        event_id as event_guid,
        session_id as session_guid,
        user_id as user_guid,
        page_url,
        created_at,
        event_type
    from {{ source('greenery', 'events') }}
)


select * from events_src
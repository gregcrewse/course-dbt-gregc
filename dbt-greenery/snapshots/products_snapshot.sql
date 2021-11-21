{% snapshot snapshot_products %}

  {{
    config(
      target_schema='snapshots',
      unique_key='product_id',

      strategy='check',
      check_cols=['quantity']
    )
  }}

  SELECT * 
  FROM {{ source('tutorial', 'products') }}

{% endsnapshot %}
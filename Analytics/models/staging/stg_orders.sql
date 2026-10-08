{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with source_data as (
  select
    id,
    user_id,
    order_date,
    status,
    _etl_loaded_at
  from {{ source('jaffle_shop', 'orders') }}
)

select
  id as order_id,
  user_id as customer_id,
  order_date,
  status,
  _etl_loaded_at as loaded_at
from source_data

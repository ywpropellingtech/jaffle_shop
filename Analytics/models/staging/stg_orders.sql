{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with source_data as (
  select
    order_id,
    customer_id,
    order_date,
    total_amount,
    status
  from {{ source('raw_data', 'orders') }}
)

select
  order_id,
  customer_id,
  order_date,
  total_amount,
  status,
  current_timestamp() as loaded_at
from source_data

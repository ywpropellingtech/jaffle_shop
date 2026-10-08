{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with source_data as (
  select
    customer_id,
    customer_name,
    email,
    created_at
  from {{ source('raw_data', 'customers') }}
)

select
  customer_id,
  customer_name,
  email,
  created_at,
  current_timestamp() as loaded_at
from source_data

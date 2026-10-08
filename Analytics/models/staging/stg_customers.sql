{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with source_data as (
  select
    id,
    first_name,
    last_name
  from {{ source('jaffle_shop', 'customers') }}
)

select
  id as customer_id,
  first_name,
  last_name,
  current_timestamp() as loaded_at
from source_data

{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with source_data as (
  select
    id,
    orderid,
    paymentmethod,
    status,
    amount,
    created,
    _batched_at
  from {{ source('stripe', 'payment') }}
)

select
  id as payment_id,
  orderid as order_id,
  paymentmethod as payment_method,
  status,
  amount / 100.0 as amount_usd,
  created as payment_date,
  _batched_at as batched_at
from source_data

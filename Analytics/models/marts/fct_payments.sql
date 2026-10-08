{{ config(
  materialized = 'table',
  tags = ['daily']
) }}

select
  payment_id,
  order_id,
  customer_id,
  payment_method,
  payment_status,
  amount_usd,
  payment_date,
  batched_at,
  order_status,
  order_date,
  current_timestamp() as created_at
from {{ ref('int_orders_payments') }}
where payment_id is not null

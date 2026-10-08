{{ config(
  materialized = 'table',
  tags = ['daily']
) }}

select
  order_id,
  customer_id,
  order_date,
  order_status,
  payment_id,
  payment_method,
  payment_status,
  amount_usd,
  payment_date,
  current_timestamp() as created_at
from {{ ref('int_orders_payments') }}
where order_id is not null

{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with orders as (
  select * from {{ ref('stg_orders') }}
  where status in ('completed', 'pending', 'cancelled', 'return', 'returned')
),

payments as (
  select * from {{ ref('stg_payments') }}
  where status in ('success', 'failed', 'pending')
),

joined as (
  select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status as order_status,
    p.payment_id,
    p.payment_method,
    p.status as payment_status,
    p.amount_usd,
    p.payment_date,
    p.batched_at
  from orders o
  left join payments p on o.order_id = p.order_id
)

select * from joined

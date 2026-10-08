{{ config(
  materialized = 'view',
  tags = ['daily']
) }}

with customers as (
  select * from {{ ref('stg_customers') }}
),

orders as (
  select * from {{ ref('stg_orders') }}
  where status in ('completed', 'pending', 'cancelled', 'return', 'returned')
),

joined as (
  select
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.status as order_status,
    o.loaded_at as order_loaded_at
  from customers c
  left join orders o on c.customer_id = o.customer_id
)

select * from joined

{{ config(
  materialized = 'table',
  tags = ['daily']
) }}

with customers as (
  select * from {{ ref('stg_customers') }}
),

customer_orders as (
  select
    customer_id,
    count(distinct order_id) as total_orders,
    sum(amount_usd) as total_spent,
    max(order_date) as last_order_date
  from {{ ref('int_orders_payments') }}
  where customer_id is not null
  group by customer_id
)

select
  c.customer_id,
  c.first_name,
  c.last_name,
  coalesce(co.total_orders, 0) as total_orders,
  coalesce(co.total_spent, 0) as total_spent,
  co.last_order_date,
  current_timestamp() as created_at
from customers c
left join customer_orders co on c.customer_id = co.customer_id

select
    order_id,
    customer_id,
    order_date,
    status,
    payment.amount
from {{ ref('stg_orders') }} as orders
left join {{ref('stg_payments') }} as payment using (order_id)
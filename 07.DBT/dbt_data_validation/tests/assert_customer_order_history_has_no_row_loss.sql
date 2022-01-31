select *
from (
        select customer_oh.customer_id
        from {{ ref('customer_order_history') }} customer_oh
            left join {{ ref('customers') }} customer on customer_oh.customer_id = customer.customer_id
        where customer.customer_id is null
        UNION ALL
        select customer.customer_id
        from {{ ref('stg_customers') }} customer
            left join {{ ref('customer_order_history') }} customer_oh on customer_oh.customer_id = customer.customer_id
        where customer_oh.customer_id is null
    ) check
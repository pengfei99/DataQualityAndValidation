with stg_customers as (
    select
       customer_id,
       first_name,
       last_name,
       first_name||" "||last_name as full_name
    from {{ref('customers')}}
)

select * from stg_customers
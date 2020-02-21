{% set payment_methods_query %}
select distinct payment_method from {{ ref('stg_payments') }}
{% endset %}

{% set results = run_query(payment_methods_query) %}

{% if execute %}
{% for row in results.table %}
{{ row }}
{% endfor %}
{% endif %}

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

select
    order_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method  = '{{ payment_method }}' then amount else 0 end) as  {{ payment_method }}_amount
    {% if not loop.last %}
    ,
    {% endif %}
    {% endfor %}
from {{ ref('stg_payments') }}
group by 1
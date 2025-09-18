{{ config(alias=var('stg_customer_prefix') ~ '_customers') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    customer_id,
    {{ clean_columns('first_name') }} AS first_name,
    {{ clean_columns('last_name') }} AS last_name,
    {{ clean_columns('email') }} AS email,
    created_at
FROM
    {{ source('public_raw_data', 'raw_customers') }}
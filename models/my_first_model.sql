{{ config(
    materialized='incremental'
) }}

{% if not is_incremental() %}

-- This is the full refresh logic
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    created_at
FROM
    {{ ref('stg_customers') }}

{% else %}

-- This is the incremental logic
WITH max_created_at AS (
    SELECT MAX(created_at) FROM {{ this }}
)

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    created_at
FROM
    {{ ref('stg_customers') }}

WHERE created_at > (SELECT * FROM max_created_at)

{% endif %}
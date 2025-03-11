{{ config(
    materialized='incremental'
) }}

SELECT DISTINCT *
FROM {{ source('staging', 'stg_Iris') }}
WHERE DATE(timestamp_created) >= DATE_SUB('2024-03-06', INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}  -- ✅ Use ref() instead of source()
  )
{% endif %}

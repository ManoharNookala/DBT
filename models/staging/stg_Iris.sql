{{ config(
    materialized='incremental',
    schema='staging'
) }}

SELECT DISTINCT *
FROM {{ source('landing', 'Iris') }}
WHERE DATE(timestamp_created) > DATE_SUB('2025-03-06', INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}  -- ✅ Use ref() instead of source()
  )
{% endif %}

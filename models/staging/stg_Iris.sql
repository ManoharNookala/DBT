{{ config(
    materialized='incremental'
) }}

{% if target.profile == 'DBT_staging' %}

SELECT DISTINCT *
FROM {{ source('landing', 'Iris') }}
WHERE DATE(timestamp_created) > DATE_SUB('2025-03-06', INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}  -- ✅ Use ref() instead of source()
  )
{% endif %}


{% else %}
    -- Skip execution if the profile is not 'DBT_staging'
    SELECT * FROM {{ this }} WHERE FALSE
{% endif %}
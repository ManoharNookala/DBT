{{ config(
    materialized='incremental'
) }}

SELECT DISTINCT *
FROM {{ source('staging', 'stg_Iris') }}

{% if is_incremental() %}
   WHERE timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}  -- ✅ Correct way to reference a dbt model
  )
{% endif %}

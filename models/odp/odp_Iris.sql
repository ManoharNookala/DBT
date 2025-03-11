{{ config(
    materialized='incremental',
    enabled=(target.profile == 'DBT_odp')
) }}

SELECT DISTINCT *
FROM {{ source('staging', 'stg_Iris') }}

{% if is_incremental() %}
   WHERE timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ ref('odp_Iris') }}  -- ✅ Correct way to reference a dbt model
  )
{% endif %}

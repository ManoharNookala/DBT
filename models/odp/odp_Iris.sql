{{ config(
    materialized='incremental'
) }}

{% if target.profile == 'DBT_odp' %}

SELECT DISTINCT *
FROM {{ source('staging', 'stg_Iris') }}
 

{% if is_incremental() %}
   WHERE timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ source('odp', 'odp_Iris') }}
      --{{ ref('odp_Iris') }}  -- ✅ Use ref() instead of source()
  )
{% endif %}



{% else %}
    -- Skip execution if the profile is not 'DBT_staging'
    SELECT * FROM UNNEST([]) AS empty_table
{% endif %}

{{ config(
  materialized='incremental'
) }}

SELECT DISTINCT *
FROM {{source('staging', 'stg_Iris')}}

{% if is_incremental() %}
  WHERE timestamp_created > (
      SELECT COALESCE(MAX(timestamp_created), TIMESTAMP('1900-01-01')) 
      FROM {{source('odp', 'odp_Iris')}}  -- ✅ Refers to the target table (odp.odp_Iris)
  )
{% endif %}
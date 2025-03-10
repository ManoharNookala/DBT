{{ config(
  materialized='incremental',
  schema="odp",
  post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
  
) }}

-- ,
--   post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"

SELECT DISTINCT *
FROM {{source('staging', 'stg_Iris')}}
--{{ ref('stg_Iris') }}
--{{source('staging', 'stg_Iris')}}
 
{% if is_incremental() %}
  where timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{source('odp', 'odp_Iris')}}
  )
{% endif %}

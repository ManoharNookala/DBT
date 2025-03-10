{{ config(
  materialized='incremental',
  post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
  
) }}

SELECT DISTINCT *
FROM {{source('staging', 'stg_Iris')}}
--{{ ref('stg_Iris') }}
--{{source('staging', 'stg_Iris')}}
where 
{% if is_incremental() %}
   timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}
  )
{% endif %}

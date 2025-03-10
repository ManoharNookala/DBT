{{ config(
  materialized='incremental',
  post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
  
) }}

SELECT DISTINCT *
FROM {{ ref('stg_Iris') }}
--{{source('staging', 'stg_Iris')}}

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{ this }}
  )
{% endif %}

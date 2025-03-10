{{ config(
  materialized='incremental',
  pre_hook = "
            DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE;

            DELETE FROM {{source('landing', 'Iris')}}
            WHERE order_id IN (
              SELECT order_id FROM {{source('landing', 'Consent_Removal')}}
            );

            DELETE FROM {{source('odp', 'odp_Iris')}}
            WHERE order_id IN (
              SELECT order_id FROM {{source('landing', 'Consent_Removal')}}
            );"
  
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
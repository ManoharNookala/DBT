{{ config(
    materialized='incremental',
    pre_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{source('landing', 'Iris')}}
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(DATE(MAX(timestamp_created)), DATE('1900-01-01')) 
      FROM {{source('staging', 'stg_Iris')}}
  )
{% endif %}
{{ config(
  materialized='incremental',
  post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{source('staging', 'stg_Iris')}}
{{ config(
  materialized='incremental',
  schema='odp',
  post_hook="DELETE FROM {{source('staging', 'stg_Iris')}} WHERE TRUE"
  
) }}

SELECT DISTINCT *
FROM {{ ref('stg_Iris') }}
--{{source('staging', 'stg_Iris')}}

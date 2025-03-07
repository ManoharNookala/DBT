{{ config(
  materialized='incremental',
  schema="odp",
  post_hook="DELETE FROM {{sources('staging', 'stg_Iris')}} WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{sources('staging', 'stg_Iris')}}
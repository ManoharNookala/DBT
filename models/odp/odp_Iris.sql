{{ config(
  materialized='incremental',
  schema="odp",
  post_hook="DELETE FROM {{ database }}.staging.stg_Iris WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{ database }}.staging.stg_Iris
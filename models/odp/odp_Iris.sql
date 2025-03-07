{{ config(
  materialized='incremental',
  schema="odp",
  post_hook="DELETE FROM {{ database }}.staging.stg_Iris WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{ ref('stg_Iris') }}



/*
-- is_incremental() → Ensures only new data is inserted in future runs:
-- First run → Loads everything from yesterday
-- Next runs → Loads only records newer than the latest timestamp in {{ this }} (i.e., odp.{{ model_name }})
*/
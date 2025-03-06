{{ config(
  materialized='incremental',
  post_hook="DELETE FROM `learn-436612.staging.stg_Iris` WHERE TRUE"
  ) }}


SELECT DISTINCT *
FROM `learn-436612.staging.stg_Iris`


/*
-- is_incremental() → Ensures only new data is inserted in future runs:
-- First run → Loads everything from yesterday
-- Next runs → Loads only records newer than the latest timestamp in {{ this }} (i.e., odp.{{ model_name }})
*/
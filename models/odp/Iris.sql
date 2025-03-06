{{ config(
  materialized='incremental',
  schema='odp'
  ) }}


SELECT DISTINCT *
FROM `learn-436612.staging.Iris`

{% if is_incremental() %}
  AND DATE(timestamp_created) > (SELECT MAX(DATE(timestamp_created)) FROM `{{learn-436612.odp.Iris }}`)
{% endif %}

/*
-- is_incremental() → Ensures only new data is inserted in future runs:
-- First run → Loads everything from yesterday
-- Next runs → Loads only records newer than the latest timestamp in {{ this }} (i.e., odp.{{ model_name }})
*/
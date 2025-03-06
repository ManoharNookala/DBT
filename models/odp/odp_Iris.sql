-- {{ config(materialized='incremental') }}
{{ config(materialized='incremental') }}

SELECT DISTINCT *
FROM `learn-436612.staging.Iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND DATE(timestamp_created) > (SELECT MAX(DATE(timestamp_created)) FROM {{ this }})
{% endif %}


-- is_incremental() → Ensures only new data is inserted in future runs:
-- First run → Loads everything from yesterday
-- Next runs → Loads only records newer than the latest timestamp in {{ this }} (i.e., odp.{{ model_name }})
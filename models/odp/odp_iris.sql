{{ config(
  schema='odp',
    materialized='incremental'
) }}

SELECT DISTINCT *
FROM `learn-436612.staging.staging_iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND DATE(timestamp_created) > (SELECT MAX(DATE(timestamp_created)) FROM {{ this }})  -- Only new data
{% endif %}

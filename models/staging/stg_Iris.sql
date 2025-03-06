{{ config(
    materialized='incremental'
) }}

SELECT DISTINCT *
FROM `learn-436612.landing.Iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(MAX(timestamp_created), '1900-01-01') FROM {{ this }}  -- ✅ Use {{ this }} to reference the target table
  )
{% endif %}

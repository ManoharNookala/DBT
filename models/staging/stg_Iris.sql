{{ config(
    materialized='incremental',
    pre_hook="DELETE FROM {{ ref('stg_Iris') }} WHERE TRUE"
) }}

SELECT DISTINCT *
FROM {{ ref('landing_Iris') }}  -- ✅ Use ref() to ensure dbt resolves dependencies correctly
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND timestamp_created > (
      SELECT COALESCE(MAX(timestamp_created), TIMESTAMP('1900-01-01')) FROM {{ this }}  -- ✅ Ensure correct type matching
  )
{% endif %}

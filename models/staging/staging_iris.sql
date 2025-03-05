{{ config(
    materialized='incremental'
) }}

SELECT DISTINCT *
FROM `learn-436612.landing.Iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

{% if is_incremental() %}
  AND DATE(timestamp_created) > (SELECT MAX(DATE(timestamp_created)) FROM {{ this }})  -- Only new data
{% endif %}

-- If your model uses materialized: table, dbt drops and recreates the table every time.
-- If your model uses materialized: view, dbt replaces the view.
-- ✅ Fix: Use materialized: incremental instead.

--dbt inserts data into the table that matches the model name inside your BigQuery dataset.
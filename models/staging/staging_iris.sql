{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite'
) }}


SELECT DISTINCT * 
FROM `learn-436612.landing.Iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

-- If your model uses materialized: table, dbt drops and recreates the table every time.
-- If your model uses materialized: view, dbt replaces the view.
-- ✅ Fix: Use materialized: incremental instead.
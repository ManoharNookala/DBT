-- {{ config(
--   schema='staging',
--     materialized='incremental',
--     partition_by={
--     "field": "timestamp_created",
--     "data_type": "timestamp",
--     "granularity": "day"
--     }
-- ) }}

{{ config(materialized='incremental') }}

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
/*
models/staging/staging_iris.sql
✅ dbt creates or updates tables based on the model filename.
✅ dbt uses dbt_project.yml to determine the dataset.
✅ {{ this }} in is_incremental() automatically refers to the correct target table.
✅ Run dbt compile to verify where data is being inserted.
*/
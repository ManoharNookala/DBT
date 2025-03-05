{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite'
) }}


SELECT DISTINCT * 
FROM `learn-436612.landing.Iris`
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY);


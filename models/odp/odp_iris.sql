{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key=None
) }}


SELECT DISTINCT *  
FROM `learn-436612.staging.Iris`;
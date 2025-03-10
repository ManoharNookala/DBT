
{{ config(
  materialized='view',
  pre_hook = "
            DELETE FROM {{source('odp', 'odp_Iris')}}
            WHERE Id IN (
              SELECT Id FROM {{source('landing', 'Consent_Removal')}}
            );"
) }}

SELECT DISTINCT *
FROM {{source('landing', 'Iris')}}
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

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
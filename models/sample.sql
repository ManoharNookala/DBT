
Insert into `{{source('landing', 'Iris')}}`
SELECT DISTINCT *
FROM {{source('landing', 'Iris')}}
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)

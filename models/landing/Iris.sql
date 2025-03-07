SELECT * 
FROM {{ source('landing', 'Iris') }}  -- Use 'source' instead of 'ref'
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
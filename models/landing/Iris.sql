select * 
from {{ database }}.staging.stg_Iris
WHERE DATE(timestamp_created) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
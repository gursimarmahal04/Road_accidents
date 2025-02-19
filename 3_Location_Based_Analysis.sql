--Areas with the highest number of accidents

WITH a1 AS (
    SELECT local_authority_district,
           COUNT(*) AS accident_count
    FROM road_accidents_stagging
    GROUP BY local_authority_district
),
total_accidents AS (
    SELECT SUM(accident_count) AS total 
    FROM a1
)
SELECT 
    a1.local_authority_district, 
    a1.accident_count, 
    ROUND(a1.accident_count * 100.0 / total_accidents.total, 2) AS Percentage
FROM a1, total_accidents
ORDER BY a1.accident_count DESC
LIMIT 10;

-- Most accident-prone junction types

SELECT junction_control,junction_detail,count(*)
FROM road_accidents_stagging
GROUP BY 1,2
ORDER BY 3 DESC;

--Mapping high-risk accident zones using latitude and longitude

SELECT 
    Lat_Group, 
    Lon_Group, 
    COUNT(*) AS Accident_Count
FROM (
    SELECT ROUND(longitude::NUMERIC, 3) AS Lon_Group,
           ROUND(latitude::NUMERIC, 3) AS Lat_Group
    FROM road_accidents_stagging
) a1
GROUP BY Lat_Group, Lon_Group
ORDER BY Accident_Count DESC
LIMIT 10;

--Comparing accident counts in clear vs. adverse weather conditions.

SELECT 
    CASE 
        WHEN weather_conditions IN ('Fine no high winds') THEN 'Clear Weather'
        ELSE 'Adverse weather'
    END AS Weather_catagory,
    COUNT(*) AS Accident_Count,
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2)
FROM road_accidents_stagging
GROUP BY Weather_catagory
ORDER BY Accident_Count;

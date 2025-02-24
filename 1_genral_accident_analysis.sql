--Total number of accidents

SELECT COUNT(*) AS Total_accidents
FROM road_accidents_stagging;

-- Monthly and yearly trend 

SELECT month ,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY month
ORDER BY 2 DESC;

--Most common accident days 

SELECT year,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY year
ORDER BY 2 DESC;


-- Most common accident hours

SELECT 
    CONCAT(
        LPAD(CAST(EXTRACT(HOUR FROM time) AS TEXT), 2, '0'), ':00 - ', 
        LPAD(CAST(EXTRACT(HOUR FROM time) + 1 AS TEXT), 2, '0'), ':00'
    ) AS time_range,
    COUNT(*) AS accident_count
FROM road_accidents_stagging
GROUP BY EXTRACT(HOUR FROM time)
ORDER BY accident_count DESC
LIMIT 10;


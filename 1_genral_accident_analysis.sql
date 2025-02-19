--Total number of accidents

SELECT COUNT(*) AS Total_accidents
FROM road_accidents_stagging;

-- Monthly and yearly trend 

SELECT month ,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY month
ORDER BY 2 DESC

--Most common accident days 

SELECT year,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY year
ORDER BY 2 DESC

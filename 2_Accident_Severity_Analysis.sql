--Count of accidents by severity level

SELECT accident_severity, COUNT(*)
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;

--Severity distribution across different weather conditions.

SELECT weather_conditions,  
    accident_severity,
    COUNT(*) AS Total_accidents,
    ROUND(COUNT(*) *100/SUM(COUNT(*)) OVER(PARTITION BY weather_conditions),2) AS Percentage
FROM 
    road_accidents_stagging
GROUP BY 1,2
ORDER BY 1,4 DESC;


--Severity distribution across different road surface types.

SELECT road_surface_conditions,  
    accident_severity,
    COUNT(*) AS Total_accidents,
    ROUND(COUNT(*) *100/SUM(COUNT(*)) OVER(PARTITION BY road_surface_conditions),2) AS Percentage
FROM 
    road_accidents_stagging
GROUP BY 1,2
ORDER BY 1,4 DESC;

--Average number of vehicles involved per accident

SELECT 
    accident_severity,
    ROUND(AVG(number_of_vehicles), 2) AS avg_vehicles_per_accident
FROM road_accidents_stagging
GROUP BY accident_severity
ORDER BY avg_vehicles_per_accident DESC;

--Vehicle types most frequently involved in accidents

SELECT vehicle_type,
    COUNT(*) AS Accident_Count
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;

--Number of casualties per accident severity level

SELECT 
    accident_severity, 
    SUM(number_of_casualties) AS total_casualties,
    COUNT(*) AS total_accidents,
    ROUND(AVG(number_of_casualties), 2) AS avg_casualties_per_accident
FROM road_accidents_stagging
GROUP BY accident_severity
ORDER BY total_casualties DESC;

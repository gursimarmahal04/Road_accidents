--Accidents grouped by speed limits

SELECT speed_limit,COUNT(*)
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;

--Relationship between road surface conditions and accident count

SELECT 
    road_surface_conditions, 
    COUNT(*) AS accident_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM road_accidents_stagging
GROUP BY road_surface_conditions
ORDER BY accident_count DESC;

--Effect of lighting conditions (e.g., daylight vs. night-time)

SELECT 
    light_conditions, 
    COUNT(*) AS accident_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;
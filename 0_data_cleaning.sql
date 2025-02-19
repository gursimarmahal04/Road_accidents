with duplicate_rows AS(
    SELECT accident_id,
        ROW_NUMBER() OVER(PARTITION BY accident_id) AS row_num
    FROM
        road_accidents
)

SELECT * FROM duplicate_rows
WHERE row_num >1;

CREATE TABLE road_accidents_stagging (
    accident_id VARCHAR(100),
    accident_date VARCHAR(100),
    month VARCHAR(10),
    day_of_week VARCHAR(255),
    year INT,
    junction_control VARCHAR(100),
    junction_detail VARCHAR(100),
    accident_severity VARCHAR(100),
    latitude FLOAT,
    light_conditions VARCHAR(100),
    local_authority_district VARCHAR(100),
    carriageway_hazards VARCHAR(255),
    longitude FLOAT,
    number_of_casualties INT,
    number_of_vehicles INT,
    police_force VARCHAR(100),
    road_surface_conditions VARCHAR(100),
    road_type VARCHAR(100),
    speed_limit INT,
    time VARCHAR(100),
    urban_or_rural_area VARCHAR(25),
    weather_conditions VARCHAR(100),
    vehicle_type VARCHAR(100),
    row_num int

);

INSERT INTO road_accidents_stagging
SELECT * ,
    ROW_NUMBER() OVER(PARTITION BY accident_id) AS row_num
FROM 
    road_accidents;


DELETE  
FROM road_accidents_stagging
WHERE row_num>1;

DELETE  
FROM road_accidents_stagging
WHERE road_surface_conditions IS NULL;

DELETE  
FROM road_accidents_stagging
WHERE weather_conditions IS NULL;

--

ALTER TABLE road_accidents_stagging
DROP accident_date,
DROP row_num;

ALTER TABLE road_accidents_stagging
ALTER COLUMN time TYPE TIME USING time::TIME;

SELECT * FROM road_accidents_stagging LIMIT 100;


SELECT vehicle_type
FROM road_accidents_stagging
GROUP by 1

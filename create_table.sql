
DROP TABLE IF EXISTS road_accidents;

CREATE TABLE road_accidents (
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
    vehicle_type VARCHAR(100)

);

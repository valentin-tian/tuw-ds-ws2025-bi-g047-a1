-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_location
-- =======================================

-- Step 1: Truncate target table
TRUNCATE TABLE dim_location RESTART IDENTITY CASCADE;

INSERT INTO dim_location ( 
	sensordevice_id,
    tb_country_id,
    country_name,
    country_population,
    tb_city_id,
    city_name,
    city_population,
    location_name,
    location_type,
    location_altitude,
    installedat,
	etl_load_timestamp)
SELECT
    sd.id AS sensordevice_id,
    c.id AS tb_country_id,
    c.countryname AS country_name,
    c.population AS country_population,
    ci.id AS tb_city_id,
    ci.cityname AS city_name,
    ci.population AS city_population,
    sd.locationname AS location_name,
    sd.locationtype AS location_type,
    sd.altitude AS location_altitude,
    sd.installedat,
	CURRENT_TIMESTAMP
FROM tb_sensordevice sd
JOIN tb_city ci ON sd.cityid = ci.id
JOIN tb_country c ON ci.countryid = c.id;






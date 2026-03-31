-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_device
-- =======================================

-- Step 1: Truncate target table
TRUNCATE TABLE dim_device RESTART IDENTITY CASCADE;

INSERT INTO dim_device (
	sensordevice_id,
    sensortype_id,
    sensortype_name,
    manufacturer,
    technology,
	etl_load_timestamp
	)
	
SELECT
    sd.id AS sensordevice_id,
    st.id AS sensortype_id,
    st.typename AS sensortype_name,
    st.manufacturer,
    st.technology,
	CURRENT_TIMESTAMP   -- insert the current timestamp value
FROM tb_sensordevice sd
JOIN tb_sensortype st ON sd.sensortypeid = st.id;






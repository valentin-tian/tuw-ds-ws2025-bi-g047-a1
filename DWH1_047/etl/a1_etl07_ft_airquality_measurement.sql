-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load ft_airquality_measurement (seed, FK-safe)
-- =======================================

-- 1) Truncate target
TRUNCATE TABLE ft_airquality_measurement RESTART IDENTITY CASCADE;

-- 2) Insert a small, valid seed set
WITH seeds AS (
    SELECT *
    FROM tb_readingevent re
    ORDER BY id
    LIMIT 10   -- we take only 10 rows
)
INSERT INTO ft_airquality_measurement (
    day_id, 
	sk_location, 
	sk_device, 
	sk_parameter,
    recordedvalue, 
	dataquality, 
	datavolumekb, 
	alert_exceeded_flag,
    tempdaymin, 
	tempdaymax, 
	tempdayavg, 
	precipmm, 
	pressure, 
	windspeed, 
	windgusts,
    etl_load_timestamp
)
SELECT
    dtd.id AS day_id,
    dl.sk_location,
    dd.sk_device,
    dp.sk_parameter,
    re.recordedvalue,
    re.dataquality,
    re.datavolumekb,
    CASE WHEN pa.alertid IS NOT NULL THEN TRUE ELSE FALSE END AS alert_exceeded_flag,
    w.tempdaymin,
    w.tempdaymax,
    w.tempdayavg,
    w.precipmm,
    w.pressure,
    w.windspeed,
    w.windgusts,
    CURRENT_TIMESTAMP
FROM seeds re
INNER JOIN dim_device dd   -- we take only existing measurements
    ON dd.sensordevice_id = re.sensordevid
INNER JOIN dim_location dl
    ON dl.sensordevice_id = dd.sensordevice_id
INNER JOIN dim_parameter dp
    ON dp.tb_param_id = re.paramid
INNER JOIN dim_timeday dtd
    ON dtd.fulldate = re.readat
LEFT JOIN tb_paramalert pa
    ON pa.paramid = re.paramid
   AND re.recordedvalue > pa.threshold
LEFT JOIN tb_weather w
    ON w.cityid = dl.tb_city_id
   AND w.observedat = dtd.fulldate
ORDER BY re.id;

-- 3) Refresh stats (optional but recommended)
ANALYZE ft_airquality_measurement;




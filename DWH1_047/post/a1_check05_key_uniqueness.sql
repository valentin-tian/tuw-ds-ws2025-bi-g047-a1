-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Check key uniqueness for ft_airquality_measurement
-- =======================================

WITH key_uniqueness_check AS (
    SELECT
        'ft_airquality_measurement' AS table_name,
        COUNT(airquality_measurement_id) - COUNT(DISTINCT airquality_measurement_id) AS duplicate_keys
    FROM ft_airquality_measurement
)

SELECT
    table_name,
    duplicate_keys,
    CASE WHEN duplicate_keys = 0 THEN 'OK' ELSE 'FAIL' END AS status_check,
    CURRENT_TIMESTAMP(0)::timestamp AS run_time
FROM key_uniqueness_check;
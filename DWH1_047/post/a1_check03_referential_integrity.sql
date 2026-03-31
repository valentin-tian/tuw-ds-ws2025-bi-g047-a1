-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Check the referential integrity for ft_service_event - check that all foreign key in the fact table correspond to existing rows in the related dimension
-- =======================================
WITH ref_integrity_check AS (   
    SELECT
        'ft_service_event' AS table_name,
        SUM(CASE WHEN day_id NOT IN (SELECT id FROM dim_timeday) THEN 1 ELSE 0 END +
            CASE WHEN sk_location NOT IN (SELECT sk_location FROM dim_location) THEN 1 ELSE 0 END +
            CASE WHEN sk_device NOT IN (SELECT sk_device FROM dim_device) THEN 1 ELSE 0 END +
            CASE WHEN sk_servicetype NOT IN (SELECT sk_servicetype FROM dim_servicetype) THEN 1 ELSE 0 END +
            CASE WHEN sk_technician_role NOT IN (SELECT sk_technician_role FROM dim_technician_role_scd2) THEN 1 ELSE 0 END
        ) AS fk_violations
    FROM ft_service_event
)

SELECT 
    table_name,
    fk_violations,
    CASE WHEN fk_violations = 0 THEN 'OK' ELSE 'FAIL' END AS status_check,
    CURRENT_TIMESTAMP(0)::timestamp AS run_time
FROM ref_integrity_check;

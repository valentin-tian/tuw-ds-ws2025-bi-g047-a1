-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Measure ranges for servicequality, servicecost and durationminutes in ft_service_event
-- =======================================
WITH measure_check AS (
    SELECT
        'ft_service_event' AS table_name,
        SUM(CASE WHEN servicequality < 1 OR servicequality > 5 THEN 1 ELSE 0 END) AS invalid_servicequality,
        SUM(CASE WHEN servicecost < 0 THEN 1 ELSE 0 END) AS negative_costs,
        SUM(CASE WHEN durationminutes < 0 THEN 1 ELSE 0 END) AS negative_duration
    FROM ft_service_event
)

SELECT
    table_name,
    invalid_servicequality,
    negative_costs,
    negative_duration,
    CASE 
        WHEN invalid_servicequality = 0 AND negative_costs = 0 AND negative_duration = 0 THEN 'OK'
        ELSE 'FAIL'
    END AS status_check,
    CURRENT_TIMESTAMP(0)::timestamp AS run_time
FROM measure_check;
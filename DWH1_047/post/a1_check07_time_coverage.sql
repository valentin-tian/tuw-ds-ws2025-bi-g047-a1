-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- check if min and max dates are as expected and there are no unexplained gaps
-- =======================================
WITH time_ranges AS (
    SELECT
        MIN(fulldate) AS min_date,
        MAX(fulldate) AS max_date
    FROM dim_timeday
),
gaps AS (
    SELECT COUNT(*) AS missing_days
    FROM (
        SELECT generate_series(MIN(fulldate), MAX(fulldate), '1 day'::interval)::date AS day
        FROM dim_timeday
    ) s
    LEFT JOIN dim_timeday dtd ON s.day = dtd.fulldate
    WHERE dtd.fulldate IS NULL
)

SELECT
    tr.min_date,
    tr.max_date,
    g.missing_days,
    CASE 
        WHEN g.missing_days = 0 THEN 'OK' 
        ELSE 'FAIL' 
    END AS status_check,
    CURRENT_TIMESTAMP(0)::timestamp AS run_time
FROM time_ranges tr
CROSS JOIN gaps g;
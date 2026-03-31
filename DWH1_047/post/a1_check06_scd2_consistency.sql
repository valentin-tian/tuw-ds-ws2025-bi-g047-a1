-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- SCD Type 2 - check for overlapping validity periods and if there is exactly one row per badge number
-- =======================================
WITH overlap_check AS (  -- check if there are overlapping validity ranges
    SELECT
        badgenumber,
        COUNT(*) AS overlap_count
    FROM (
        SELECT a.badgenumber, a.effective_from, a.effective_to, b.effective_from AS b_from, b.effective_to AS b_to
        FROM dim_technician_role_scd2 a
        JOIN dim_technician_role_scd2 b
          ON a.badgenumber = b.badgenumber
         AND a.sk_technician_role <> b.sk_technician_role
         AND a.effective_from <= b.effective_to
         AND a.effective_to >= b.effective_from
    ) t
    GROUP BY badgenumber
),


current_row_check AS (   -- check if the number of current row per badgenumber = 1
    SELECT
        badgenumber,
        COUNT(*) AS current_rows
    FROM dim_technician_role_scd2
    WHERE is_current = TRUE
    GROUP BY badgenumber
)

SELECT
    'SCD2_overlap' AS check_type,
    SUM(COALESCE(overlap_count, 0)) AS total_overlaps,
    SUM(CASE WHEN COALESCE(current_rows,0) = 1 THEN 0 ELSE 1 END) AS current_row_issues,
    CASE 
        WHEN SUM(COALESCE(overlap_count,0)) = 0 AND SUM(CASE WHEN COALESCE(current_rows,0) = 1 THEN 0 ELSE 1 END) = 0 
        THEN 'OK' ELSE 'FAIL' 
    END AS status_check,
    CURRENT_TIMESTAMP(0)::timestamp AS run_time
FROM overlap_check o
FULL OUTER JOIN current_row_check c ON o.badgenumber = c.badgenumber;
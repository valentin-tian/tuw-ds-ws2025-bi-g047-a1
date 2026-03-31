-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_technician_role_scd2
-- =======================================

-- Step 1: Truncate target table
TRUNCATE TABLE dim_technician_role_scd2 RESTART IDENTITY CASCADE;

-- Step 2: materialize role history rows as SCD2 versions
WITH role_history AS 
(
  SELECT 
	e.id AS employeeid,
    e.badgenumber,
    r.rolelevel,
    r.category,
    r.rolename,
    e.validfrom AS effective_from,
    COALESCE(e.validto, DATE '9999-12-31') AS effective_to,
    (e.validto IS NULL) AS is_current
  FROM tb_employee e
  INNER JOIN tb_role r ON r.id = e.roleid
),

-- find the certifications that were valid during the role period
role_validcert AS (
    SELECT
        rh.badgenumber,
        rh.employeeid,
        rh.rolelevel,
        rh.category,
        rh.rolename,
        rh.effective_from,
        rh.effective_to,
        rh.is_current,
        c.certificationlevel
    FROM role_history rh
    LEFT JOIN tb_employeecertification ec
        ON ec.employeeid = rh.employeeid
        AND ec.acquireddat <= rh.effective_to
        AND COALESCE(ec.expirydat, DATE '9999-12-31') >= rh.effective_from
    LEFT JOIN tb_certification c
        ON ec.certificationid = c.id
),

-- find the highest certification level per role period
top_cert AS (
    SELECT
		employeeid,
        badgenumber,
        rolelevel,
        category,
        rolename,
        effective_from,
        effective_to,
        is_current,
        MAX(
            CASE certificationlevel
                WHEN 'Entry' THEN 1
                WHEN 'Advanced' THEN 2
                WHEN 'Expert' THEN 3
            END
        ) AS highest_cert
    FROM role_validcert
    GROUP BY employeeid, badgenumber, rolelevel, category, rolename, effective_from, effective_to, is_current
)

INSERT INTO dim_technician_role_scd2 (
	badgenumber,
    rolelevel,
    category,
    rolename,
    effective_from,
    effective_to,
    is_current,
    top_certification_level,
    etl_load_timestamp
)
SELECT
    badgenumber,
    rolelevel,
    category,
    rolename,
    effective_from,
    effective_to,
    is_current,
    CASE COALESCE(highest_cert, 1) -- if no certification if found, we assign Entry level
        WHEN 1 THEN 'Entry'
        WHEN 2 THEN 'Advanced'
        WHEN 3 THEN 'Expert'
    END AS top_certification_level,
    CURRENT_TIMESTAMP
FROM top_cert
ORDER BY badgenumber, effective_from;






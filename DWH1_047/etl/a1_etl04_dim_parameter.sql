-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_parameter
-- =======================================

-- Step 1: Truncate target table
TRUNCATE TABLE dim_parameter RESTART IDENTITY CASCADE;

INSERT INTO dim_parameter (
	tb_param_id,
    paramname,
    category,
    purpose,
    unit,
	etl_load_timestamp)
	
SELECT
    p.id AS tb_param_id,
    p.paramname,
    p.category,
    p.purpose,
    p.unit,
	CURRENT_TIMESTAMP
FROM tb_param p;






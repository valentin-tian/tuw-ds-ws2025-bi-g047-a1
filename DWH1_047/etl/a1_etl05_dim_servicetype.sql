-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_servicetype
-- =======================================

-- Step 1: Truncate target table
TRUNCATE TABLE dim_servicetype RESTART IDENTITY CASCADE;

INSERT INTO dim_servicetype (
	tb_servicetype_id,
    typename,
    category,
    servicegroup,
    minlevel,
    details,
    required_certification_level,
	etl_load_timestamp)
	
SELECT
    st.id AS tb_servicetype_id,
    st.typename,
    st.category,
    st.servicegroup,
    st.minlevel,
    st.details,
    CASE
		WHEN st.minlevel = 1 THEN 'Entry'   
		WHEN st.minlevel = 2 THEN 'Entry / Advanced'    -- some service types accept multiple certification levels as sufficient
		WHEN st.minlevel = 3 THEN 'Advanced / Expert'
		WHEN st.minlevel = 4 THEN 'Expert'
    ELSE NULL
END AS required_certification_level,
CURRENT_TIMESTAMP
FROM tb_servicetype st;





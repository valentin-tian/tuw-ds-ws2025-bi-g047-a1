-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load dim_timeday
-- =======================================

-- Step 1: Truncate target table, the dim_timeday in this case
TRUNCATE TABLE dim_timeday RESTART IDENTITY CASCADE;

-- Step 2: Insert data into the dim_timeday
INSERT INTO dim_timeday (
	id, 
	fulldate, 
	day_of_month, 
	month_num, 
	month_name, 
	quarter_num, 
	year_num,
	etl_load_timestamp)
-- place time dimension creating mechanism here
SELECT
    ROW_NUMBER() OVER (ORDER BY d) AS id,   -- generating id starts at 1
    d::DATE AS fulldate,
    EXTRACT(DAY FROM d) AS day_of_month,
    EXTRACT(MONTH FROM d) AS month_num,
    TO_CHAR(d, 'Month') AS month_name,
    EXTRACT(QUARTER FROM d) AS quarter_num,
    EXTRACT(YEAR FROM d) AS year_num,
    CURRENT_TIMESTAMP AS etl_load_timestamp
FROM generate_series(
        DATE '2021-01-01',   -- start date
        DATE '2030-12-31',   -- end date
        INTERVAL '1 day'     -- step = 1 day
    ) AS g(d);





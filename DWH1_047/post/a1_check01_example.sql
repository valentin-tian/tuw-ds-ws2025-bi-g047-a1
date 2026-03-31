-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh2_047, stg2_047;
-- =======================================
-- Check  if dim_servicetype and tb_servicetype have the same number of rows
-- =======================================
SELECT
    f.month_key,
    f.city_key,
    f.param_key,
    f.exceed_days_any,
    tm.days_in_month
FROM ft_param_city_month f
JOIN dim_timemonth tm ON tm.month_key = f.month_key
WHERE f.exceed_days_any > tm.days_in_month;



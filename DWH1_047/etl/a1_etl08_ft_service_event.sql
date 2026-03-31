-- Make A1 dwh_xxx, stg_xxx schemas the default for this session
SET search_path TO dwh_047, stg_047;

-- =======================================
-- Load ft_service_event (seed, FK-safe)
-- =======================================

-- 1) Truncate target
TRUNCATE TABLE ft_service_event RESTART IDENTITY CASCADE;

-- 2) Insert a small, valid seed set
WITH seeds AS (
    SELECT *
    FROM tb_serviceevent
    ORDER BY id
    LIMIT 10   -- we take only 10 rows
)
INSERT INTO ft_service_event (
	day_id, 
	sk_location, 
	sk_device, 
	sk_servicetype, 
	sk_technician_role,
    servicecost, 
	durationminutes, 
	servicequality, 
	underqualified_flag, 
	expired_certification_flag,
    etl_load_timestamp
)
SELECT
    dtd.id AS day_id,
    dl.sk_location,
    dd.sk_device,
    ds.sk_servicetype,
    tr.sk_technician_role,
    se.servicecost,
    se.durationminutes,
    se.servicequality,
    
	CASE     -- the technician is underqualified if role level < required and highest certification < required
        WHEN tr.rolelevel < ds.minlevel
            AND COALESCE(
                MAX(
                    CASE c.certificationlevel
                         WHEN 'Entry' THEN 1
                         WHEN 'Advanced' THEN 2
                         WHEN 'Expert' THEN 3
                    END
                ) OVER (PARTITION BY se.employeeid), 0
            ) < ds.minlevel
        THEN TRUE
        ELSE FALSE
    END AS underqualified_flag,
    
    CASE
        WHEN ec.expirydat IS NOT NULL
             AND ec.expirydat < se.servicedat THEN TRUE
        ELSE FALSE
    END AS expired_certification_flag,
    
    CURRENT_TIMESTAMP
	
FROM seeds se
LEFT JOIN dim_timeday dtd ON dtd.fulldate = se.servicedat
LEFT JOIN dim_location dl ON dl.sensordevice_id = se.sensordevid
LEFT JOIN dim_device dd ON dd.sensordevice_id = se.sensordevid
LEFT JOIN dim_servicetype ds ON ds.tb_servicetype_id = se.servicetypeid
LEFT JOIN dim_technician_role_scd2 tr 
    ON tr.badgenumber = (
        SELECT e.badgenumber 
        FROM tb_employee e 
        WHERE e.id = se.employeeid 
        AND se.servicedat BETWEEN e.validfrom AND COALESCE(e.validto, DATE '9999-12-31')
    )
LEFT JOIN tb_employeecertification ec
    ON ec.employeeid = se.employeeid 
    AND se.servicedat BETWEEN ec.acquireddat AND COALESCE(ec.expirydat, DATE '9999-12-31')
LEFT JOIN tb_certification c
    ON ec.certificationid = c.id
ORDER BY se.id;

-- 3) Refresh stats (optional but recommended)
ANALYZE ft_service_event;


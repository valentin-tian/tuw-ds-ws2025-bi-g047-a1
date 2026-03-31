-- Make A1 dwh_xxx schema the default for this session
SET search_path TO dwh_047;

-- -------------------------------
-- 2) DROP TABLE before attempting to create DWH schema tables
-- -------------------------------
DROP TABLE IF EXISTS ft_service_event;
DROP TABLE IF EXISTS ft_airquality_measurement;

DROP TABLE IF EXISTS dim_technician_role_scd2;
DROP TABLE IF EXISTS dim_servicetype;
DROP TABLE IF EXISTS dim_parameter;
DROP TABLE IF EXISTS dim_device;
DROP TABLE IF EXISTS dim_location;
DROP TABLE IF EXISTS dim_timeday;

-- -------------------------------
-- 3) CREATE TABLE statements for facts and dimensions
-- Please make sure the order in which individual statements are executed respects the FOREIGN KEY constraints
-- -------------------------------
CREATE TABLE dim_timeday (
    id INT NOT NULL PRIMARY KEY
    , fulldate DATE NOT NULL
    , day_of_month INT NOT NULL
    , month_num INT NOT NULL
    , month_name VARCHAR(20) NOT NULL
    , quarter_num INT NOT NULL
    , year_num INT NOT NULL
	, etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_location (
	sk_location BIGSERIAL PRIMARY KEY			-- surrogate key
	, sensordevice_id INT NOT NULL				-- ID from OLTP (tb_sensordevice.id)
	, tb_country_id INT NOT NULL					-- OLTP reference
	, country_name VARCHAR(100) NOT NULL			-- level 1 of hierarchy
	, country_population INT NOT NULL
	, tb_city_id INT NOT NULL					-- OLTP reference
	, city_name VARCHAR(100) NOT NULL			-- level 2 of hierarchy
	, city_population INT NOT NULL
	, location_name VARCHAR(100) NOT NULL		-- level 3 of hierarchy
	, location_type VARCHAR(50) NOT NULL
	, location_altitude INT NOT NULL
	, installedat DATE NOT NULL
	, etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT uq_dim_location_bk UNIQUE (sensordevice_id)
);

CREATE TABLE dim_device (
	sk_device BIGSERIAL PRIMARY KEY				-- surrogate key
	, sensordevice_id INT NOT NULL				-- ID from OLTP (tb_sensordevice.id)
	, sensortype_id INT NOT NULL					-- OLTP type id
	, sensortype_name VARCHAR(255) NOT NULL
	, manufacturer VARCHAR(255) NOT NULL
	, technology VARCHAR(100) NOT NULL
	, etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT uq_dim_device_bk UNIQUE (sensordevice_id)
);

CREATE TABLE dim_parameter (
  sk_parameter BIGSERIAL PRIMARY KEY   			-- surrogate key
  , tb_param_id INT NOT NULL           			-- ID from OLTP (tb_param.id)
  , paramname VARCHAR(255) NOT NULL    			-- e.g., 'PM2', 'Mercury'
  , category VARCHAR(255) NOT NULL     			-- e.g. Particulate matter, Heavy Metal
  , purpose VARCHAR(100) NOT NULL
  , unit VARCHAR(50) NOT NULL          			-- e.g., 'count/m3'
  , etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
  , CONSTRAINT uq_dim_parameter_bk UNIQUE (tb_param_id)
);

CREATE TABLE dim_servicetype (
  sk_servicetype BIGSERIAL PRIMARY KEY       	-- surrogate key
  , tb_servicetype_id INT NOT NULL           	-- ID from OLTP (tb_servicetype.id)
  , typename VARCHAR(255) NOT NULL				-- hierarchy level 1
  , category VARCHAR(255) NOT NULL				-- hierarchy level 2
  , servicegroup VARCHAR(255) NOT NULL			-- hierarchy level 3
  , minlevel INT NOT NULL
  , details VARCHAR(255) NOT NULL
  , required_certification_level VARCHAR(20)		-- required certfication level to check under/overqualification: 'Entry', 'Advanced', 'Expert' (to add manually)
  , etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
  , CONSTRAINT uq_dim_servicetype_bk UNIQUE (tb_servicetype_id)
);

CREATE TABLE dim_technician_role_scd2 (
  sk_technician_role BIGSERIAL PRIMARY KEY		-- surrogate key
  , badgenumber VARCHAR(255) NOT NULL   			-- business key
  , rolelevel INT NOT NULL						-- 1=Entry, 2=Junior, 3=Senior, 4=Lead
  , category VARCHAR(255) NOT NULL
  , rolename VARCHAR(255) NOT NULL
  , effective_from DATE NOT NULL
  , effective_to DATE NOT NULL  					-- '9999-12-31' for current
  , is_current BOOLEAN NOT NULL
  , top_certification_level VARCHAR(20) NOT NULL -- the highest cetification level during the period of the role: 'Entry', 'Advanced', 'Expert'
  , etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
  , CONSTRAINT ux_techrole_bk_timerange UNIQUE (badgenumber, effective_from, effective_to)
);

-- .......

-- FACT 1: ft_airquality_measurement - linked to TimeDay + Location + Device + Parameter
CREATE TABLE ft_airquality_measurement (
   airquality_measurement_id BIGSERIAL PRIMARY KEY		-- surrogate PK for the fact table
	, day_id INT NOT NULL								-- -> dim_timeday.id
	, sk_location BIGINT NOT NULL						-- -> dim_location.sk_location
	, sk_device BIGINT NOT NULL							-- -> dim_device.sk_device
	, sk_parameter BIGINT NOT NULL						-- -> dim_parameter.sk_parameter
	
	, recordedvalue NUMERIC(10, 4) NOT NULL
	, dataquality INT NOT NULL CHECK (dataquality BETWEEN 1 AND 5)
	, datavolumekb INT NOT NULL
	, alert_exceeded_flag BOOLEAN NOT NULL
	, tempdaymin NUMERIC(6,1)							-- minimum temperature of the day
	, tempdaymax NUMERIC(6,1)							-- maximum temperature of the day
	, tempdayavg NUMERIC(6,1)							-- average temperature of the day
	, precipmm NUMERIC(6,1)								-- precipitation amount in mm
	, pressure NUMERIC(6,1)								-- average air pressure
	, windspeed NUMERIC(6,1)								-- average wind speed
	, windgusts NUMERIC(6,1)								-- maximum wind gusts
	
	, etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT fk_airquality_measurement_day FOREIGN KEY (day_id) REFERENCES dim_timeday(id)
	, CONSTRAINT fk_airquality_measurement_location FOREIGN KEY (sk_location) REFERENCES dim_location(sk_location)
	, CONSTRAINT fk_airquality_measurement_device FOREIGN KEY (sk_device) REFERENCES dim_device(sk_device)
	, CONSTRAINT fk_airquality_measurement_param FOREIGN KEY (sk_parameter) REFERENCES dim_parameter(sk_parameter)
);

CREATE INDEX ix_ft_airquality_measurement_day ON ft_airquality_measurement(day_id);
CREATE INDEX ix_ft_airquality_measurement_location ON ft_airquality_measurement(sk_location);
CREATE INDEX ix_ft_airquality_measurement_device ON ft_airquality_measurement(sk_device);
CREATE INDEX ix_ft_airquality_measurement_param ON ft_airquality_measurement(sk_parameter);

-- FACT 2: ft_service_event - linked to TimeDay + Location + Device + Servicetype + Technician Role (SCD2)
CREATE TABLE ft_service_event (
    service_event_id BIGSERIAL PRIMARY KEY				-- surrogate PK for the fact table
	, day_id INT NOT NULL								-- -> dim_timeday.id
	, sk_location BIGINT NOT NULL						-- -> dim_location.sk_location
	, sk_device BIGINT NOT NULL							-- -> dim_device.sk_device
	, sk_servicetype BIGINT NOT NULL						-- -> dim_servicetype.sk_servicetype
	, sk_technician_role BIGINT NOT NULL					-- -> dim_technician_role_scd2.sk_technician_role
	
	, servicecost INT NOT NULL
	, durationminutes INT NOT NULL
	, servicequality INT NOT NULL CHECK (servicequality BETWEEN 1 AND 5)
	, underqualified_flag BOOLEAN NOT NULL				-- TRUE if technician below required certification level
	, expired_certification_flag BOOLEAN NOT NULL		-- TRUE if technician's certificate expired at event time
	
	, etl_load_timestamp TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT fk_service_event_day FOREIGN KEY (day_id) REFERENCES dim_timeday(id)
	, CONSTRAINT fk_service_event_location FOREIGN KEY (sk_location) REFERENCES dim_location(sk_location)
	, CONSTRAINT fk_service_event_device FOREIGN KEY (sk_device) REFERENCES dim_device(sk_device)
	, CONSTRAINT fk_service_event_type FOREIGN KEY (sk_servicetype) REFERENCES dim_servicetype(sk_servicetype)
	, CONSTRAINT fk_service_event_role FOREIGN KEY (sk_technician_role) REFERENCES dim_technician_role_scd2(sk_technician_role)
);

CREATE INDEX ix_ft_service_event_day ON ft_service_event(day_id);
CREATE INDEX ix_ft_service_event_location ON ft_service_event(sk_location);
CREATE INDEX ix_ft_service_event_device ON ft_service_event(sk_device);
CREATE INDEX ix_ft_service_event_type ON ft_service_event(sk_servicetype);
CREATE INDEX ix_ft_service_event_role ON ft_service_event(sk_technician_role);



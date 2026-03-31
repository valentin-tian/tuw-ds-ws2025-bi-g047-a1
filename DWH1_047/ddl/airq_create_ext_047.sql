-- please remember to give a meaningful name to both Table X (instead of tb_x) and TableY (instead of tb_y)

-- Make the A1's stg_xxx schema the default for this session
SET search_path TO stg_047;

-- -------------------------------
-- 2) DROP TABLE before attempting to create OLTP snapshot tables
-- -------------------------------
DROP TABLE IF EXISTS tb_employeecertification;
DROP TABLE IF EXISTS tb_certification;

-- give a meaningful name and create Table X
CREATE TABLE tb_certification (
    id INT NOT NULL PRIMARY KEY
    -- the other columns here
    , certificationname VARCHAR(100) NOT NULL
    , certificationlevel VARCHAR(20) NOT NULL
    , validity_months INT NOT NULL
    , description VARCHAR(255) NOT NULL
    , CHECK (certificationlevel IN ('Entry', 'Advanced', 'Expert'))
    , CONSTRAINT uc_certification_certificationname UNIQUE (certificationname) 
);

-- give a meaningful name and create Table Y
CREATE TABLE tb_employeecertification (
    id INT NOT NULL PRIMARY KEY
    -- the other columns here
	-- remember to implement foreign keys correctly
    , employeeid INT NOT NULL
    , certificationid INT NOT NULL
    , acquireddat DATE NOT NULL
    , expirydat DATE NOT NULL
    , CONSTRAINT uc_employeecertification UNIQUE (employeeid, certificationid)
    , CONSTRAINT fk_employeecertification_employeeid FOREIGN KEY (employeeid) REFERENCES tb_employee(id)
    , CONSTRAINT fk_employeecertification_certificationid FOREIGN KEY (certificationid) REFERENCES tb_certification(id)
);



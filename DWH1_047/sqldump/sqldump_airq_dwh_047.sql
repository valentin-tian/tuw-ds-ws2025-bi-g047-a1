--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dwh_047; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dwh_047;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_device; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_device (
    sk_device bigint NOT NULL,
    sensordevice_id integer NOT NULL,
    sensortype_id integer NOT NULL,
    sensortype_name character varying(255) NOT NULL,
    manufacturer character varying(255) NOT NULL,
    technology character varying(100) NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: dim_device_sk_device_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.dim_device_sk_device_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dim_device_sk_device_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.dim_device_sk_device_seq OWNED BY dwh_047.dim_device.sk_device;


--
-- Name: dim_location; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_location (
    sk_location bigint NOT NULL,
    sensordevice_id integer NOT NULL,
    tb_country_id integer NOT NULL,
    country_name character varying(100) NOT NULL,
    country_population integer NOT NULL,
    tb_city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    city_population integer NOT NULL,
    location_name character varying(100) NOT NULL,
    location_type character varying(50) NOT NULL,
    location_altitude integer NOT NULL,
    installedat date NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: dim_location_sk_location_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.dim_location_sk_location_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dim_location_sk_location_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.dim_location_sk_location_seq OWNED BY dwh_047.dim_location.sk_location;


--
-- Name: dim_parameter; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_parameter (
    sk_parameter bigint NOT NULL,
    tb_param_id integer NOT NULL,
    paramname character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    purpose character varying(100) NOT NULL,
    unit character varying(50) NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: dim_parameter_sk_parameter_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.dim_parameter_sk_parameter_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dim_parameter_sk_parameter_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.dim_parameter_sk_parameter_seq OWNED BY dwh_047.dim_parameter.sk_parameter;


--
-- Name: dim_servicetype; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_servicetype (
    sk_servicetype bigint NOT NULL,
    tb_servicetype_id integer NOT NULL,
    typename character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    servicegroup character varying(255) NOT NULL,
    minlevel integer NOT NULL,
    details character varying(255) NOT NULL,
    required_certification_level character varying(20),
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: dim_servicetype_sk_servicetype_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.dim_servicetype_sk_servicetype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dim_servicetype_sk_servicetype_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.dim_servicetype_sk_servicetype_seq OWNED BY dwh_047.dim_servicetype.sk_servicetype;


--
-- Name: dim_technician_role_scd2; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_technician_role_scd2 (
    sk_technician_role bigint NOT NULL,
    badgenumber character varying(255) NOT NULL,
    rolelevel integer NOT NULL,
    category character varying(255) NOT NULL,
    rolename character varying(255) NOT NULL,
    effective_from date NOT NULL,
    effective_to date NOT NULL,
    is_current boolean NOT NULL,
    top_certification_level character varying(20) NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: dim_technician_role_scd2_sk_technician_role_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.dim_technician_role_scd2_sk_technician_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dim_technician_role_scd2_sk_technician_role_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.dim_technician_role_scd2_sk_technician_role_seq OWNED BY dwh_047.dim_technician_role_scd2.sk_technician_role;


--
-- Name: dim_timeday; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.dim_timeday (
    id integer NOT NULL,
    fulldate date NOT NULL,
    day_of_month integer NOT NULL,
    month_num integer NOT NULL,
    month_name character varying(20) NOT NULL,
    quarter_num integer NOT NULL,
    year_num integer NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ft_airquality_measurement; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.ft_airquality_measurement (
    airquality_measurement_id bigint NOT NULL,
    day_id integer NOT NULL,
    sk_location bigint NOT NULL,
    sk_device bigint NOT NULL,
    sk_parameter bigint NOT NULL,
    recordedvalue numeric(10,4) NOT NULL,
    dataquality integer NOT NULL,
    datavolumekb integer NOT NULL,
    alert_exceeded_flag boolean NOT NULL,
    tempdaymin numeric(6,1),
    tempdaymax numeric(6,1),
    tempdayavg numeric(6,1),
    precipmm numeric(6,1),
    pressure numeric(6,1),
    windspeed numeric(6,1),
    windgusts numeric(6,1),
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ft_airquality_measurement_dataquality_check CHECK (((dataquality >= 1) AND (dataquality <= 5)))
);


--
-- Name: ft_airquality_measurement_airquality_measurement_id_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.ft_airquality_measurement_airquality_measurement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ft_airquality_measurement_airquality_measurement_id_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.ft_airquality_measurement_airquality_measurement_id_seq OWNED BY dwh_047.ft_airquality_measurement.airquality_measurement_id;


--
-- Name: ft_service_event; Type: TABLE; Schema: dwh_047; Owner: -
--

CREATE TABLE dwh_047.ft_service_event (
    service_event_id bigint NOT NULL,
    day_id integer NOT NULL,
    sk_location bigint NOT NULL,
    sk_device bigint NOT NULL,
    sk_servicetype bigint NOT NULL,
    sk_technician_role bigint NOT NULL,
    servicecost integer NOT NULL,
    durationminutes integer NOT NULL,
    servicequality integer NOT NULL,
    underqualified_flag boolean NOT NULL,
    expired_certification_flag boolean NOT NULL,
    etl_load_timestamp timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ft_service_event_servicequality_check CHECK (((servicequality >= 1) AND (servicequality <= 5)))
);


--
-- Name: ft_service_event_service_event_id_seq; Type: SEQUENCE; Schema: dwh_047; Owner: -
--

CREATE SEQUENCE dwh_047.ft_service_event_service_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ft_service_event_service_event_id_seq; Type: SEQUENCE OWNED BY; Schema: dwh_047; Owner: -
--

ALTER SEQUENCE dwh_047.ft_service_event_service_event_id_seq OWNED BY dwh_047.ft_service_event.service_event_id;


--
-- Name: dim_device sk_device; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_device ALTER COLUMN sk_device SET DEFAULT nextval('dwh_047.dim_device_sk_device_seq'::regclass);


--
-- Name: dim_location sk_location; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_location ALTER COLUMN sk_location SET DEFAULT nextval('dwh_047.dim_location_sk_location_seq'::regclass);


--
-- Name: dim_parameter sk_parameter; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_parameter ALTER COLUMN sk_parameter SET DEFAULT nextval('dwh_047.dim_parameter_sk_parameter_seq'::regclass);


--
-- Name: dim_servicetype sk_servicetype; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_servicetype ALTER COLUMN sk_servicetype SET DEFAULT nextval('dwh_047.dim_servicetype_sk_servicetype_seq'::regclass);


--
-- Name: dim_technician_role_scd2 sk_technician_role; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_technician_role_scd2 ALTER COLUMN sk_technician_role SET DEFAULT nextval('dwh_047.dim_technician_role_scd2_sk_technician_role_seq'::regclass);


--
-- Name: ft_airquality_measurement airquality_measurement_id; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement ALTER COLUMN airquality_measurement_id SET DEFAULT nextval('dwh_047.ft_airquality_measurement_airquality_measurement_id_seq'::regclass);


--
-- Name: ft_service_event service_event_id; Type: DEFAULT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event ALTER COLUMN service_event_id SET DEFAULT nextval('dwh_047.ft_service_event_service_event_id_seq'::regclass);


--
-- Data for Name: dim_device; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_device (sk_device, sensordevice_id, sensortype_id, sensortype_name, manufacturer, technology, etl_load_timestamp) FROM stdin;
1	1001	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
2	1002	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
3	1003	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
4	1004	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
5	1005	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
6	1006	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
7	1007	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
8	1008	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
9	1009	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
10	1010	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
11	1011	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
12	1012	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
13	1013	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
14	1014	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
15	1015	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
16	1016	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
17	1017	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
18	1018	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
19	1019	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
20	1020	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
21	1021	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
22	1022	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
23	1023	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
24	1024	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
25	1025	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
26	1026	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
27	1027	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
28	1028	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
29	1029	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
30	1030	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
31	1031	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
32	1032	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
33	1033	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
34	1034	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
35	1035	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
36	1036	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
37	1037	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
38	1038	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
39	1039	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
40	1040	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
41	1041	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
42	1042	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
43	1043	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
44	1044	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
45	1045	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
46	1046	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
47	1047	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
48	1048	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
49	1049	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
50	1050	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
51	1051	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
52	1052	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
53	1053	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
54	1054	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
55	1055	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
56	1056	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
57	1057	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
58	1058	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
59	1059	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
60	1060	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
61	1061	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
62	1062	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
63	1063	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
64	1064	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
65	1065	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
66	1066	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
67	1067	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
68	1068	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
69	1069	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
70	1070	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
71	1071	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
72	1072	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
73	1073	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
74	1074	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
75	1075	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
76	1076	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
77	1077	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
78	1078	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
79	1079	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
80	1080	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
81	1081	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
82	1082	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
83	1083	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
84	1084	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
85	1085	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
86	1086	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
87	1087	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
88	1088	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
89	1089	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
90	1090	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
91	1091	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
92	1092	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
93	1093	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
94	1094	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
95	1095	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
96	1096	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
97	1097	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
98	1098	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
99	1099	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
100	1100	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
101	1101	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
102	1102	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
103	1103	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
104	1104	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
105	1105	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
106	1106	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
107	1107	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
108	1108	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
109	1109	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
110	1110	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
111	1111	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
112	1112	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
113	1113	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
114	1114	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
115	1115	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
116	1116	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
117	1117	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
118	1118	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
119	1119	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
120	1120	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
121	1121	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
122	1122	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
123	1123	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
124	1124	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
125	1125	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
126	1126	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
127	1127	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
128	1128	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
129	1129	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
130	1130	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
131	1131	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
132	1132	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
133	1133	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
134	1134	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
135	1135	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
136	1136	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
137	1137	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
138	1138	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
139	1139	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
140	1140	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
141	1141	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
142	1142	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
143	1143	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
144	1144	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
145	1145	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
146	1146	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
147	1147	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
148	1148	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
149	1149	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
150	1150	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
151	1151	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
152	1152	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
153	1153	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
154	1154	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
155	1155	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
156	1156	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
157	1157	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
158	1158	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
159	1159	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
160	1160	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
161	1161	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
162	1162	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
163	1163	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
164	1164	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
165	1165	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
166	1166	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
167	1167	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
168	1168	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
169	1169	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
170	1170	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
171	1171	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
172	1172	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
173	1173	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
174	1174	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
175	1175	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
176	1176	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
177	1177	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
178	1178	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
179	1179	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
180	1180	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
181	1181	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
182	1182	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
183	1183	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
184	1184	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
185	1185	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
186	1186	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
187	1187	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
188	1188	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
189	1189	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
190	1190	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
191	1191	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
192	1192	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
193	1193	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
194	1194	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
195	1195	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
196	1196	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
197	1197	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
198	1198	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
199	1199	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
200	1200	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
201	1201	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
202	1202	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
203	1203	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
204	1204	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
205	1205	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
206	1206	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
207	1207	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
208	1208	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
209	1209	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
210	1210	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
211	1211	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
212	1212	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
213	1213	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
214	1214	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
215	1215	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
216	1216	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
217	1217	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
218	1218	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
219	1219	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
220	1220	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
221	1221	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
222	1222	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
223	1223	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
224	1224	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
225	1225	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
226	1226	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
227	1227	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
228	1228	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
229	1229	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
230	1230	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
231	1231	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
232	1232	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
233	1233	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
234	1234	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
235	1235	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
236	1236	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
237	1237	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
238	1238	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
239	1239	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
240	1240	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
241	1241	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
242	1242	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
243	1243	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
244	1244	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
245	1245	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
246	1246	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
247	1247	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
248	1248	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
249	1249	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
250	1250	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
251	1251	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
252	1252	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
253	1253	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
254	1254	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
255	1255	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
256	1256	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
257	1257	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
258	1258	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
259	1259	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
260	1260	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
261	1261	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
262	1262	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
263	1263	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
264	1264	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
265	1265	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
266	1266	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
267	1267	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
268	1268	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
269	1269	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
270	1270	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
271	1271	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
272	1272	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
273	1273	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
274	1274	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
275	1275	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
276	1276	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
277	1277	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
278	1278	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
279	1279	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
280	1280	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
281	1281	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
282	1282	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
283	1283	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
284	1284	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
285	1285	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
286	1286	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
287	1287	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
288	1288	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
289	1289	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
290	1290	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
291	1291	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
292	1292	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
293	1293	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
294	1294	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
295	1295	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
296	1296	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
297	1297	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
298	1298	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
299	1299	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
300	1300	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
301	1301	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
302	1302	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
303	1303	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
304	1304	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
305	1305	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
306	1306	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
307	1307	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
308	1308	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
309	1309	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
310	1310	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
311	1311	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
312	1312	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
313	1313	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
314	1314	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
315	1315	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
316	1316	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
317	1317	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
318	1318	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
319	1319	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
320	1320	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
321	1321	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
322	1322	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
323	1323	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
324	1324	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
325	1325	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
326	1326	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
327	1327	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
328	1328	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
329	1329	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
330	1330	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
331	1331	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
332	1332	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
333	1333	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
334	1334	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
335	1335	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
336	1336	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
337	1337	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
338	1338	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
339	1339	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
340	1340	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
341	1341	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
342	1342	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
343	1343	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
344	1344	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
345	1345	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
346	1346	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
347	1347	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
348	1348	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
349	1349	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
350	1350	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
351	1351	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
352	1352	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
353	1353	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
354	1354	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
355	1355	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
356	1356	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
357	1357	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
358	1358	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
359	1359	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
360	1360	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
361	1361	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
362	1362	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
363	1363	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
364	1364	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
365	1365	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
366	1366	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
367	1367	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
368	1368	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
369	1369	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
370	1370	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
371	1371	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
372	1372	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
373	1373	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
374	1374	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
375	1375	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
376	1376	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
377	1377	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
378	1378	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
379	1379	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
380	1380	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
381	1381	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
382	1382	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
383	1383	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
384	1384	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
385	1385	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
386	1386	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
387	1387	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
388	1388	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
389	1389	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
390	1390	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
391	1391	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
392	1392	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
393	1393	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
394	1394	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
395	1395	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
396	1396	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
397	1397	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
398	1398	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
399	1399	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
400	1400	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
401	1401	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
402	1402	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
403	1403	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
404	1404	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
405	1405	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
406	1406	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
407	1407	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
408	1408	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
409	1409	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
410	1410	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
411	1411	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
412	1412	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
413	1413	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
414	1414	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
415	1415	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
416	1416	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
417	1417	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
418	1418	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
419	1419	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
420	1420	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
421	1421	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
422	1422	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
423	1423	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
424	1424	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
425	1425	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
426	1426	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
427	1427	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
428	1428	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
429	1429	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
430	1430	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
431	1431	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
432	1432	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
433	1433	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
434	1434	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
435	1435	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
436	1436	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
437	1437	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
438	1438	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
439	1439	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
440	1440	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
441	1441	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
442	1442	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
443	1443	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
444	1444	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
445	1445	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
446	1446	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
447	1447	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
448	1448	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
449	1449	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
450	1450	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
451	1451	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
452	1452	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
453	1453	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
454	1454	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
455	1455	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
456	1456	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
457	1457	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
458	1458	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
459	1459	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
460	1460	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
461	1461	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
462	1462	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
463	1463	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
464	1464	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
465	1465	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
466	1466	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
467	1467	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
468	1468	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
469	1469	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
470	1470	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
471	1471	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
472	1472	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
473	1473	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
474	1474	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
475	1475	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
476	1476	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
477	1477	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
478	1478	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
479	1479	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
480	1480	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
481	1481	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
482	1482	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
483	1483	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
484	1484	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
485	1485	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
486	1486	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
487	1487	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
488	1488	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
489	1489	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
490	1490	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
491	1491	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
492	1492	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
493	1493	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
494	1494	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
495	1495	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
496	1496	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
497	1497	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
498	1498	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
499	1499	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
500	1500	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
501	1501	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
502	1502	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
503	1503	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
504	1504	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
505	1505	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
506	1506	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
507	1507	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
508	1508	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
509	1509	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
510	1510	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
511	1511	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
512	1512	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
513	1513	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
514	1514	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
515	1515	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
516	1516	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
517	1517	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
518	1518	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
519	1519	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
520	1520	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
521	1521	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
522	1522	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
523	1523	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
524	1524	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
525	1525	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
526	1526	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
527	1527	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
528	1528	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
529	1529	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
530	1530	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
531	1531	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
532	1532	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
533	1533	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
534	1534	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
535	1535	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
536	1536	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
537	1537	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
538	1538	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
539	1539	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
540	1540	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
541	1541	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
542	1542	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
543	1543	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
544	1544	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
545	1545	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
546	1546	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
547	1547	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
548	1548	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
549	1549	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
550	1550	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
551	1551	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
552	1552	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
553	1553	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
554	1554	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
555	1555	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
556	1556	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
557	1557	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
558	1558	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
559	1559	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
560	1560	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
561	1561	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
562	1562	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
563	1563	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
564	1564	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
565	1565	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
566	1566	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
567	1567	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
568	1568	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
569	1569	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
570	1570	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
571	1571	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
572	1572	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
573	1573	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
574	1574	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
575	1575	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
576	1576	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
577	1577	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
578	1578	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
579	1579	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
580	1580	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
581	1581	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
582	1582	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
583	1583	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
584	1584	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
585	1585	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
586	1586	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
587	1587	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
588	1588	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
589	1589	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
590	1590	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
591	1591	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
592	1592	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
593	1593	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
594	1594	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
595	1595	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
596	1596	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
597	1597	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
598	1598	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
599	1599	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
600	1600	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
601	1601	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
602	1602	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
603	1603	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
604	1604	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
605	1605	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
606	1606	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
607	1607	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
608	1608	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
609	1609	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
610	1610	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
611	1611	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
612	1612	1011	MicroScan	Sensirion	Laser	2025-11-03 20:25:50
613	1613	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
614	1614	1001	AQSense S100	Sensirion	Optical	2025-11-03 20:25:50
615	1615	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
616	1616	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
617	1617	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
618	1618	1008	NanoAir	Other	Electrochemical	2025-11-03 20:25:50
619	1619	1005	EnviroGuard Neo	Honeywell	Electrochemical	2025-11-03 20:25:50
620	1620	1006	EnviroGuard Max	Honeywell	Electrochemical	2025-11-03 20:25:50
621	1621	1009	PureSense	Bosch	Optical	2025-11-03 20:25:50
622	1622	1010	SafeAir	Honeywell	Laser	2025-11-03 20:25:50
623	1623	1004	CleanAir Lite	Bosch	Laser	2025-11-03 20:25:50
624	1624	1003	CleanAir Pro	Bosch	Laser	2025-11-03 20:25:50
625	1625	1002	AQSense S200	Sensirion	Optical	2025-11-03 20:25:50
626	1626	1007	EcoTrack	Other	Optical	2025-11-03 20:25:50
627	1627	1012	CityBreathe	Sensirion	Electrochemical	2025-11-03 20:25:50
\.


--
-- Data for Name: dim_location; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_location (sk_location, sensordevice_id, tb_country_id, country_name, country_population, tb_city_id, city_name, city_population, location_name, location_type, location_altitude, installedat, etl_load_timestamp) FROM stdin;
1	1001	1013	Netherlands	17500	1001	Amsterdam	905	Dam Square	Industrial	120	2019-01-05	2025-11-03 20:25:50
2	1002	1013	Netherlands	17500	1001	Amsterdam	905	Rijksmuseum	Other	7	2020-10-08	2025-11-03 20:25:50
3	1003	1013	Netherlands	17500	1001	Amsterdam	905	Van Gogh Museum	Urban	158	2018-07-21	2025-11-03 20:25:50
4	1004	1013	Netherlands	17500	1001	Amsterdam	905	Anne Frank House	Urban	109	2021-03-14	2025-11-03 20:25:50
5	1005	1013	Netherlands	17500	1001	Amsterdam	905	Vondelpark	Industrial	100	2017-02-06	2025-11-03 20:25:50
6	1006	1013	Netherlands	17500	1001	Amsterdam	905	Magere Brug (Skinny Bridge)	Suburban	27	2017-11-05	2025-11-03 20:25:50
7	1007	1019	Turkey	85300	1002	Ankara	5600	Anitkabir	Other	1	2020-05-09	2025-11-03 20:25:50
8	1008	1019	Turkey	85300	1002	Ankara	5600	Museum of Anatolian Civilizations	Suburban	10	2021-07-22	2025-11-03 20:25:50
9	1009	1019	Turkey	85300	1002	Ankara	5600	Ankara Castle (Hisar)	Urban	25	2019-08-08	2025-11-03 20:25:50
10	1010	1019	Turkey	85300	1002	Ankara	5600	Haci Bayram Mosque	Urban	29	2020-03-30	2025-11-03 20:25:50
11	1011	1019	Turkey	85300	1002	Ankara	5600	Temple of Augustus and Rome	Urban	39	2020-10-15	2025-11-03 20:25:50
12	1012	1019	Turkey	85300	1002	Ankara	5600	Kocatepe Mosque	Urban	3	2022-04-10	2025-11-03 20:25:50
13	1013	1019	Turkey	85300	1002	Ankara	5600	Genclik Parki (Youth Park)	Industrial	38	2021-10-26	2025-11-03 20:25:50
14	1014	1019	Turkey	85300	1002	Ankara	5600	Atakule Tower	Industrial	13	2021-09-11	2025-11-03 20:25:50
15	1015	1019	Turkey	85300	1002	Ankara	5600	Ankara Ethnography Museum	Suburban	4	2018-11-17	2025-11-03 20:25:50
16	1016	1019	Turkey	85300	1002	Ankara	5600	War of Independence Museum	Other	28	2022-01-21	2025-11-03 20:25:50
17	1017	1019	Turkey	85300	1002	Ankara	5600	Central Park	Other	7	2022-09-23	2025-11-03 20:25:50
18	1018	1019	Turkey	85300	1002	Ankara	5600	City Stadium	Industrial	1	2020-07-03	2025-11-03 20:25:50
19	1019	1019	Turkey	85300	1002	Ankara	5600	City Museum	Other	14	2022-09-07	2025-11-03 20:25:50
20	1020	1019	Turkey	85300	1002	Ankara	5600	National Library	Suburban	19	2018-03-10	2025-11-03 20:25:50
21	1021	1019	Turkey	85300	1002	Ankara	5600	New Bazaar	Suburban	18	2022-09-27	2025-11-03 20:25:50
22	1022	1019	Turkey	85300	1002	Ankara	5600	Downtown Mall	Other	37	2017-09-28	2025-11-03 20:25:50
23	1023	1019	Turkey	85300	1002	Ankara	5600	City Park	Urban	12	2017-10-19	2025-11-03 20:25:50
24	1024	1019	Turkey	85300	1002	Ankara	5600	General Hospital	Suburban	22	2019-11-09	2025-11-03 20:25:50
25	1025	1010	Greece	10400	1003	Athens	3100	Acropolis of Athens	Suburban	34	2020-06-26	2025-11-03 20:25:50
26	1026	1010	Greece	10400	1003	Athens	3100	Ancient Agora	Suburban	6	2021-05-31	2025-11-03 20:25:50
27	1027	1010	Greece	10400	1003	Athens	3100	Temple of Olympian Zeus	Urban	5	2021-11-15	2025-11-03 20:25:50
28	1028	1010	Greece	10400	1003	Athens	3100	Panathenaic Stadium	Urban	25	2021-10-24	2025-11-03 20:25:50
29	1029	1010	Greece	10400	1003	Athens	3100	National Archaeological Museum	Suburban	7	2017-06-28	2025-11-03 20:25:50
30	1030	1010	Greece	10400	1003	Athens	3100	Odeon of Herodes Atticus	Other	1	2019-12-27	2025-11-03 20:25:50
31	1031	1010	Greece	10400	1003	Athens	3100	Mount Lycabettus	Urban	107	2021-02-04	2025-11-03 20:25:50
32	1032	1010	Greece	10400	1003	Athens	3100	Theatre of Dionysus	Urban	15	2019-09-24	2025-11-03 20:25:50
33	1033	1010	Greece	10400	1003	Athens	3100	Syntagma Square	Urban	22	2018-11-10	2025-11-03 20:25:50
34	1034	1010	Greece	10400	1003	Athens	3100	Acropolis Museum	Industrial	11	2020-05-24	2025-11-03 20:25:50
35	1035	1010	Greece	10400	1003	Athens	3100	Plaka	Industrial	12	2019-09-29	2025-11-03 20:25:50
36	1036	1010	Greece	10400	1003	Athens	3100	Arch of Hadrian	Industrial	19	2017-01-12	2025-11-03 20:25:50
37	1037	1010	Greece	10400	1003	Athens	3100	Erechtheion	Other	16	2020-10-09	2025-11-03 20:25:50
38	1038	1010	Greece	10400	1003	Athens	3100	Temple of Hephaestus	Urban	9	2019-07-06	2025-11-03 20:25:50
39	1039	1010	Greece	10400	1003	Athens	3100	Monastiraki Square	Suburban	3	2019-08-03	2025-11-03 20:25:50
40	1040	1010	Greece	10400	1003	Athens	3100	City Garden	Suburban	4	2021-10-10	2025-11-03 20:25:50
41	1041	1010	Greece	10400	1003	Athens	3100	Old Castle	Urban	31	2021-05-21	2025-11-03 20:25:50
42	1042	1017	Spain	47300	1004	Barcelona	1650	Basilica de la Sagrada Familia	Other	7	2018-04-11	2025-11-03 20:25:50
43	1043	1017	Spain	47300	1004	Barcelona	1650	Park Guell	Suburban	17	2020-06-15	2025-11-03 20:25:50
44	1044	1017	Spain	47300	1004	Barcelona	1650	Casa Batllo	Other	8	2020-08-14	2025-11-03 20:25:50
45	1045	1017	Spain	47300	1004	Barcelona	1650	Casa Mila (La Pedrera)	Other	15	2022-05-25	2025-11-03 20:25:50
46	1046	1017	Spain	47300	1004	Barcelona	1650	Casa Vicens	Suburban	22	2021-03-05	2025-11-03 20:25:50
47	1047	1017	Spain	47300	1004	Barcelona	1650	Cathedral of Barcelona	Suburban	10	2022-07-25	2025-11-03 20:25:50
48	1048	1017	Spain	47300	1004	Barcelona	1650	La Boqueria Market	Urban	3	2022-12-04	2025-11-03 20:25:50
49	1049	1017	Spain	47300	1004	Barcelona	1650	Montjuic Hill & Castle	Other	36	2021-08-06	2025-11-03 20:25:50
50	1050	1017	Spain	47300	1004	Barcelona	1650	Barceloneta Beach	Urban	2	2017-04-15	2025-11-03 20:25:50
51	1051	1017	Spain	47300	1004	Barcelona	1650	Parc de la Ciutadella	Suburban	14	2022-03-27	2025-11-03 20:25:50
52	1052	1017	Spain	47300	1004	Barcelona	1650	Tibidabo	Suburban	22	2017-10-04	2025-11-03 20:25:50
53	1053	1017	Spain	47300	1004	Barcelona	1650	Camp Nou	Urban	11	2020-04-13	2025-11-03 20:25:50
54	1054	1017	Spain	47300	1004	Barcelona	1650	Poble Espanyol	Suburban	6	2021-11-27	2025-11-03 20:25:50
55	1055	1017	Spain	47300	1004	Barcelona	1650	Palau de la Musica Catalana	Industrial	23	2022-08-02	2025-11-03 20:25:50
56	1056	1017	Spain	47300	1004	Barcelona	1650	Gothic Quarter (Barri Gotic)	Other	19	2018-09-19	2025-11-03 20:25:50
57	1057	1016	Serbia	6900	1005	Belgrade	1370	Belgrade Fortress (Kalemegdan)	Urban	35	2020-02-11	2025-11-03 20:25:50
58	1058	1016	Serbia	6900	1005	Belgrade	1370	Knez Mihailova Street	Urban	9	2022-08-30	2025-11-03 20:25:50
59	1059	1016	Serbia	6900	1005	Belgrade	1370	Temple of Saint Sava	Other	18	2018-07-17	2025-11-03 20:25:50
60	1060	1016	Serbia	6900	1005	Belgrade	1370	Skadarlija	Industrial	4	2020-03-07	2025-11-03 20:25:50
61	1061	1016	Serbia	6900	1005	Belgrade	1370	Republic Square	Other	11	2022-09-17	2025-11-03 20:25:50
62	1062	1016	Serbia	6900	1005	Belgrade	1370	Ada Ciganlija	Other	4	2021-09-28	2025-11-03 20:25:50
63	1063	1016	Serbia	6900	1005	Belgrade	1370	Avala Tower	Industrial	35	2022-10-19	2025-11-03 20:25:50
64	1064	1016	Serbia	6900	1005	Belgrade	1370	Nikola Tesla Museum	Other	8	2017-04-08	2025-11-03 20:25:50
65	1065	1016	Serbia	6900	1005	Belgrade	1370	Royal Arena	Urban	22	2021-06-28	2025-11-03 20:25:50
66	1066	1016	Serbia	6900	1005	Belgrade	1370	City Park	Urban	7	2018-04-05	2025-11-03 20:25:50
67	1067	1009	Germany	83100	1006	Berlin	3700	Brandenburg Gate	Industrial	7	2022-04-16	2025-11-03 20:25:50
68	1068	1009	Germany	83100	1006	Berlin	3700	Reichstag Building	Suburban	22	2017-10-25	2025-11-03 20:25:50
69	1069	1009	Germany	83100	1006	Berlin	3700	East Side Gallery (Berlin Wall)	Urban	13	2022-04-25	2025-11-03 20:25:50
70	1070	1009	Germany	83100	1006	Berlin	3700	Checkpoint Charlie	Suburban	3	2022-01-10	2025-11-03 20:25:50
71	1071	1009	Germany	83100	1006	Berlin	3700	Fernsehturm (TV Tower)	Suburban	27	2022-01-27	2025-11-03 20:25:50
72	1072	1009	Germany	83100	1006	Berlin	3700	Museum Island	Industrial	6	2022-08-23	2025-11-03 20:25:50
73	1073	1009	Germany	83100	1006	Berlin	3700	Berlin Cathedral (Berliner Dom)	Other	12	2018-03-20	2025-11-03 20:25:50
74	1074	1009	Germany	83100	1006	Berlin	3700	Holocaust Memorial	Urban	5	2021-10-13	2025-11-03 20:25:50
75	1075	1009	Germany	83100	1006	Berlin	3700	Victory Column (Siegessaule)	Industrial	8	2018-12-15	2025-11-03 20:25:50
76	1076	1009	Germany	83100	1006	Berlin	3700	Charlottenburg Palace	Industrial	25	2017-12-14	2025-11-03 20:25:50
77	1077	1009	Germany	83100	1006	Berlin	3700	Gendarmenmarkt	Industrial	9	2017-10-17	2025-11-03 20:25:50
78	1078	1009	Germany	83100	1006	Berlin	3700	Potsdamer Platz	Industrial	30	2017-12-06	2025-11-03 20:25:50
79	1079	1009	Germany	83100	1006	Berlin	3700	Kaiser Wilhelm Memorial Church	Urban	16	2021-02-05	2025-11-03 20:25:50
80	1080	1009	Germany	83100	1006	Berlin	3700	Alexanderplatz	Industrial	19	2021-05-16	2025-11-03 20:25:50
81	1081	1009	Germany	83100	1006	Berlin	3700	Central Library	Other	11	2018-12-12	2025-11-03 20:25:50
82	1082	1009	Germany	83100	1006	Berlin	3700	City Mall	Suburban	26	2022-07-06	2025-11-03 20:25:50
83	1083	1009	Germany	83100	1006	Berlin	3700	Grand Station	Urban	5	2017-07-06	2025-11-03 20:25:50
84	1084	1009	Germany	83100	1006	Berlin	3700	New Park	Suburban	4	2019-10-10	2025-11-03 20:25:50
85	1085	1009	Germany	83100	1006	Berlin	3700	Royal Museum	Suburban	21	2022-11-14	2025-11-03 20:25:50
86	1086	1009	Germany	83100	1006	Berlin	3700	Downtown Hall	Other	32	2020-06-26	2025-11-03 20:25:50
87	1087	1009	Germany	83100	1006	Berlin	3700	Central Station	Other	3	2017-10-20	2025-11-03 20:25:50
88	1088	1009	Germany	83100	1006	Berlin	3700	Western Hall	Industrial	24	2018-09-28	2025-11-03 20:25:50
89	1089	1009	Germany	83100	1006	Berlin	3700	General Garden	Urban	34	2017-10-16	2025-11-03 20:25:50
90	1090	1009	Germany	83100	1006	Berlin	3700	Main Stadium	Urban	37	2019-02-12	2025-11-03 20:25:50
91	1091	1005	Czech Republic	10800	1007	Brno	380	Spilberk Castle	Suburban	28	2022-03-20	2025-11-03 20:25:50
92	1092	1005	Czech Republic	10800	1007	Brno	380	Cathedral of St. Peter and Paul	Suburban	14	2019-07-12	2025-11-03 20:25:50
93	1093	1005	Czech Republic	10800	1007	Brno	380	Villa Tugendhat	Urban	2	2021-07-22	2025-11-03 20:25:50
94	1094	1005	Czech Republic	10800	1007	Brno	380	Freedom Square (Namesti Svobody)	Suburban	5	2022-08-11	2025-11-03 20:25:50
95	1095	1005	Czech Republic	10800	1007	Brno	380	Central Park	Other	4	2017-02-08	2025-11-03 20:25:50
96	1096	1005	Czech Republic	10800	1007	Brno	380	Main Hall	Industrial	11	2021-04-09	2025-11-03 20:25:50
97	1097	1003	Belgium	11500	1008	Brussels	1200	Grand Place (Grote Markt)	Other	8	2020-05-03	2025-11-03 20:25:50
98	1098	1003	Belgium	11500	1008	Brussels	1200	Galeries Royales Saint-Hubert	Other	17	2020-04-20	2025-11-03 20:25:50
99	1099	1003	Belgium	11500	1008	Brussels	1200	Atomium	Other	86	2019-05-16	2025-11-03 20:25:50
100	1100	1003	Belgium	11500	1008	Brussels	1200	Cathedral of St. Michael and St. Gudula	Urban	5	2020-08-15	2025-11-03 20:25:50
101	1101	1003	Belgium	11500	1008	Brussels	1200	Manneken Pis	Other	3	2020-10-29	2025-11-03 20:25:50
102	1102	1003	Belgium	11500	1008	Brussels	1200	Royal Palace of Brussels	Suburban	14	2021-10-16	2025-11-03 20:25:50
103	1103	1003	Belgium	11500	1008	Brussels	1200	Cinquantenaire Arch	Urban	41	2017-12-18	2025-11-03 20:25:50
104	1104	1003	Belgium	11500	1008	Brussels	1200	European Parliament	Industrial	24	2018-09-15	2025-11-03 20:25:50
105	1105	1003	Belgium	11500	1008	Brussels	1200	Palace of Justice	Other	10	2018-05-30	2025-11-03 20:25:50
106	1106	1003	Belgium	11500	1008	Brussels	1200	Mont des Arts	Industrial	13	2020-11-21	2025-11-03 20:25:50
107	1107	1003	Belgium	11500	1008	Brussels	1200	Old Library	Urban	23	2017-12-03	2025-11-03 20:25:50
108	1108	1003	Belgium	11500	1008	Brussels	1200	New Stadium	Urban	32	2020-02-13	2025-11-03 20:25:50
109	1109	1003	Belgium	11500	1008	Brussels	1200	City Museum	Industrial	18	2021-01-17	2025-11-03 20:25:50
110	1110	1011	Hungary	9700	1009	Budapest	1750	Hungarian Parliament Building	Suburban	18	2020-05-14	2025-11-03 20:25:50
111	1111	1011	Hungary	9700	1009	Budapest	1750	Szechenyi Thermal Baths	Suburban	5	2018-06-23	2025-11-03 20:25:50
112	1112	1011	Hungary	9700	1009	Budapest	1750	Buda Castle & Castle Hill	Other	32	2018-05-25	2025-11-03 20:25:50
113	1113	1011	Hungary	9700	1009	Budapest	1750	Szechenyi Chain Bridge	Urban	12	2018-12-14	2025-11-03 20:25:50
114	1114	1011	Hungary	9700	1009	Budapest	1750	Fisherman Bastion	Suburban	3	2022-02-19	2025-11-03 20:25:50
115	1115	1011	Hungary	9700	1009	Budapest	1750	St. Stephen Basilica	Urban	11	2022-07-05	2025-11-03 20:25:50
116	1116	1011	Hungary	9700	1009	Budapest	1750	Matthias Church	Suburban	7	2020-11-15	2025-11-03 20:25:50
117	1117	1011	Hungary	9700	1009	Budapest	1750	Heroes Square	Urban	4	2022-06-08	2025-11-03 20:25:50
118	1118	1011	Hungary	9700	1009	Budapest	1750	Citadella (Gellert Hill)	Suburban	130	2020-03-20	2025-11-03 20:25:50
119	1119	1011	Hungary	9700	1009	Budapest	1750	Hungarian State Opera House	Suburban	23	2019-09-04	2025-11-03 20:25:50
120	1120	1011	Hungary	9700	1009	Budapest	1750	New Park	Urban	26	2022-07-21	2025-11-03 20:25:50
121	1121	1011	Hungary	9700	1009	Budapest	1750	Central Market	Other	19	2021-11-03	2025-11-03 20:25:50
122	1122	1011	Hungary	9700	1009	Budapest	1750	City Garden	Industrial	32	2020-09-13	2025-11-03 20:25:50
123	1123	1011	Hungary	9700	1009	Budapest	1750	National Stadium	Industrial	38	2022-07-04	2025-11-03 20:25:50
124	1124	1011	Hungary	9700	1009	Budapest	1750	Old Bridge	Other	8	2017-11-07	2025-11-03 20:25:50
125	1125	1011	Hungary	9700	1009	Budapest	1750	Royal Museum	Urban	4	2019-02-18	2025-11-03 20:25:50
126	1126	1006	Denmark	5900	1010	Copenhagen	800	Nyhavn	Industrial	3	2020-11-08	2025-11-03 20:25:50
127	1127	1006	Denmark	5900	1010	Copenhagen	800	The Little Mermaid	Other	1	2020-10-31	2025-11-03 20:25:50
128	1128	1006	Denmark	5900	1010	Copenhagen	800	Tivoli Gardens	Industrial	7	2017-02-10	2025-11-03 20:25:50
129	1129	1006	Denmark	5900	1010	Copenhagen	800	Rosenborg Castle	Other	10	2022-10-10	2025-11-03 20:25:50
130	1130	1006	Denmark	5900	1010	Copenhagen	800	The Round Tower (Rundetaarn)	Other	30	2017-04-21	2025-11-03 20:25:50
131	1131	1006	Denmark	5900	1010	Copenhagen	800	Christiansborg Palace	Suburban	14	2019-05-24	2025-11-03 20:25:50
132	1132	1006	Denmark	5900	1010	Copenhagen	800	Amalienborg Palace	Other	6	2017-06-09	2025-11-03 20:25:50
133	1133	1006	Denmark	5900	1010	Copenhagen	800	Church of Our Saviour	Urban	33	2021-11-28	2025-11-03 20:25:50
134	1134	1006	Denmark	5900	1010	Copenhagen	800	Copenhagen Opera House	Suburban	9	2019-11-07	2025-11-03 20:25:50
135	1135	1006	Denmark	5900	1010	Copenhagen	800	Frederik Church (Marmorkirken)	Urban	18	2021-05-26	2025-11-03 20:25:50
136	1136	1006	Denmark	5900	1010	Copenhagen	800	Central Station	Suburban	12	2019-12-30	2025-11-03 20:25:50
137	1137	1006	Denmark	5900	1010	Copenhagen	800	City Hall	Suburban	4	2020-09-02	2025-11-03 20:25:50
138	1138	1006	Denmark	5900	1010	Copenhagen	800	Main Library	Industrial	8	2020-12-16	2025-11-03 20:25:50
139	1139	1006	Denmark	5900	1010	Copenhagen	800	Downtown Market	Other	3	2017-07-01	2025-11-03 20:25:50
140	1140	1006	Denmark	5900	1010	Copenhagen	800	Royal Theater	Suburban	11	2017-03-26	2025-11-03 20:25:50
141	1141	1006	Denmark	5900	1010	Copenhagen	800	Central Park	Suburban	5	2019-09-04	2025-11-03 20:25:50
142	1142	1020	United Kingdom	67200	1011	Edinburgh	540	Edinburgh Castle	Suburban	15	2022-10-21	2025-11-03 20:25:50
143	1143	1020	United Kingdom	67200	1011	Edinburgh	540	Royal Mile	Other	4	2022-09-24	2025-11-03 20:25:50
144	1144	1020	United Kingdom	67200	1011	Edinburgh	540	Arthur Seat	Other	95	2021-08-29	2025-11-03 20:25:50
145	1145	1020	United Kingdom	67200	1011	Edinburgh	540	Palace of Holyroodhouse	Urban	7	2020-10-18	2025-11-03 20:25:50
146	1146	1020	United Kingdom	67200	1011	Edinburgh	540	Calton Hill	Urban	98	2018-07-29	2025-11-03 20:25:50
147	1147	1020	United Kingdom	67200	1011	Edinburgh	540	Scott Monument	Urban	61	2021-10-15	2025-11-03 20:25:50
148	1148	1020	United Kingdom	67200	1011	Edinburgh	540	St. Giles Cathedral	Suburban	4	2019-09-14	2025-11-03 20:25:50
149	1149	1020	United Kingdom	67200	1011	Edinburgh	540	Old Gallery	Industrial	11	2021-07-24	2025-11-03 20:25:50
150	1150	1020	United Kingdom	67200	1011	Edinburgh	540	Central Park	Other	3	2018-04-28	2025-11-03 20:25:50
151	1151	1018	Sweden	10500	1012	Gothenburg	580	Liseberg	Industrial	31	2019-04-09	2025-11-03 20:25:50
152	1152	1018	Sweden	10500	1012	Gothenburg	580	Haga	Industrial	5	2017-02-05	2025-11-03 20:25:50
153	1153	1018	Sweden	10500	1012	Gothenburg	580	Skansen Kronan	Industrial	19	2021-03-18	2025-11-03 20:25:50
154	1154	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg Opera House	Industrial	8	2021-10-16	2025-11-03 20:25:50
155	1155	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg Central Station	Urban	5	2022-12-15	2025-11-03 20:25:50
156	1156	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg Botanical Garden	Urban	65	2018-12-25	2025-11-03 20:25:50
157	1157	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg University	Other	8	2022-06-04	2025-11-03 20:25:50
158	1158	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg Harbor	Suburban	4	2018-07-05	2025-11-03 20:25:50
159	1159	1018	Sweden	10500	1012	Gothenburg	580	Gothenburg Refinery	Urban	3	2018-07-17	2025-11-03 20:25:50
160	1160	1018	Sweden	10500	1012	Gothenburg	580	Lindholmen	Other	2	2020-03-17	2025-11-03 20:25:50
161	1161	1001	Austria	9000	1013	Graz	330	Schlossberg Clock Tower	Other	9	2019-01-18	2025-11-03 20:25:50
162	1162	1001	Austria	9000	1013	Graz	330	Eggenberg Palace	Industrial	6	2021-09-26	2025-11-03 20:25:50
163	1163	1001	Austria	9000	1013	Graz	330	Murinsel	Other	5	2020-04-25	2025-11-03 20:25:50
164	1164	1001	Austria	9000	1013	Graz	330	Graz Cathedral	Other	11	2021-10-29	2025-11-03 20:25:50
165	1165	1001	Austria	9000	1013	Graz	330	Graz Central Station	Suburban	4	2020-10-14	2025-11-03 20:25:50
166	1166	1001	Austria	9000	1013	Graz	330	Jakomini	Industrial	26	2019-04-26	2025-11-03 20:25:50
167	1167	1001	Austria	9000	1013	Graz	330	Andritz Industrial Park	Urban	21	2021-09-21	2025-11-03 20:25:50
168	1168	1001	Austria	9000	1013	Graz	330	Murpark	Urban	3	2019-11-19	2025-11-03 20:25:50
169	1169	1001	Austria	9000	1013	Graz	330	University District	Other	10	2018-09-23	2025-11-03 20:25:50
170	1170	1001	Austria	9000	1013	Graz	330	Graz Airport	Urban	28	2017-01-16	2025-11-03 20:25:50
171	1171	1009	Germany	83100	1014	Hamburg	1850	Elbphilharmonie	Suburban	9	2021-09-07	2025-11-03 20:25:50
172	1172	1009	Germany	83100	1014	Hamburg	1850	Speicherstadt	Other	6	2017-02-21	2025-11-03 20:25:50
173	1173	1009	Germany	83100	1014	Hamburg	1850	St. Michael Church	Industrial	4	2022-07-10	2025-11-03 20:25:50
174	1174	1009	Germany	83100	1014	Hamburg	1850	Hamburg Rathaus	Industrial	8	2017-08-08	2025-11-03 20:25:50
175	1175	1009	Germany	83100	1014	Hamburg	1850	Reeperbahn	Suburban	7	2019-09-29	2025-11-03 20:25:50
176	1176	1009	Germany	83100	1014	Hamburg	1850	Miniatur Wunderland	Urban	30	2017-07-24	2025-11-03 20:25:50
177	1177	1009	Germany	83100	1014	Hamburg	1850	Landungsbrucken	Urban	5	2017-02-27	2025-11-03 20:25:50
178	1178	1009	Germany	83100	1014	Hamburg	1850	Binnenalster	Suburban	6	2019-07-12	2025-11-03 20:25:50
179	1179	1009	Germany	83100	1014	Hamburg	1850	Jungfernstieg	Suburban	19	2018-12-29	2025-11-03 20:25:50
180	1180	1009	Germany	83100	1014	Hamburg	1850	Planten un Blomen	Industrial	2	2019-01-04	2025-11-03 20:25:50
181	1181	1007	Finland	5550	1015	Helsinki	655	Helsinki Cathedral	Other	39	2018-10-04	2025-11-03 20:25:50
182	1182	1007	Finland	5550	1015	Helsinki	655	Suomenlinna Fortress	Urban	5	2020-02-19	2025-11-03 20:25:50
183	1183	1007	Finland	5550	1015	Helsinki	655	Temppeliaukio Church	Urban	31	2022-08-28	2025-11-03 20:25:50
184	1184	1007	Finland	5550	1015	Helsinki	655	Sibelius Monument	Suburban	8	2019-06-02	2025-11-03 20:25:50
185	1185	1007	Finland	5550	1015	Helsinki	655	Uspenski Cathedral	Suburban	6	2020-01-18	2025-11-03 20:25:50
186	1186	1007	Finland	5550	1015	Helsinki	655	Kauppatori	Urban	2	2021-06-19	2025-11-03 20:25:50
187	1187	1007	Finland	5550	1015	Helsinki	655	Helsinki Central Station	Industrial	4	2020-07-30	2025-11-03 20:25:50
188	1188	1007	Finland	5550	1015	Helsinki	655	Kamppi	Industrial	3	2022-08-21	2025-11-03 20:25:50
189	1189	1007	Finland	5550	1015	Helsinki	655	Pasila	Industrial	1	2018-05-13	2025-11-03 20:25:50
190	1190	1007	Finland	5550	1015	Helsinki	655	Vuosaari Harbor	Other	7	2020-07-18	2025-11-03 20:25:50
191	1191	1019	Turkey	85300	1016	Istanbul	15500	Hagia Sophia Grand Mosque	Urban	3	2021-06-03	2025-11-03 20:25:50
192	1192	1019	Turkey	85300	1016	Istanbul	15500	Blue Mosque (Sultan Ahmed)	Industrial	2	2019-02-05	2025-11-03 20:25:50
193	1193	1019	Turkey	85300	1016	Istanbul	15500	Topkapi Palace	Other	31	2020-01-26	2025-11-03 20:25:50
194	1194	1019	Turkey	85300	1016	Istanbul	15500	Grand Bazaar	Industrial	14	2018-03-15	2025-11-03 20:25:50
195	1195	1019	Turkey	85300	1016	Istanbul	15500	Galata Tower	Industrial	11	2020-04-28	2025-11-03 20:25:50
196	1196	1019	Turkey	85300	1016	Istanbul	15500	Dolmabahce Palace	Industrial	8	2018-04-19	2025-11-03 20:25:50
197	1197	1019	Turkey	85300	1016	Istanbul	15500	Suleymaniye Mosque	Industrial	2	2021-02-03	2025-11-03 20:25:50
198	1198	1019	Turkey	85300	1016	Istanbul	15500	Beylerbeyi Palace	Industrial	25	2017-03-18	2025-11-03 20:25:50
199	1199	1019	Turkey	85300	1016	Istanbul	15500	Bosphorus Strait	Other	226	2020-03-31	2025-11-03 20:25:50
200	1200	1019	Turkey	85300	1016	Istanbul	15500	Belgrad Forest	Other	20	2020-09-22	2025-11-03 20:25:50
201	1201	1019	Turkey	85300	1016	Istanbul	15500	Yildiz Park	Urban	37	2021-07-29	2025-11-03 20:25:50
202	1202	1019	Turkey	85300	1016	Istanbul	15500	Princes Islands	Industrial	24	2021-07-10	2025-11-03 20:25:50
203	1203	1019	Turkey	85300	1016	Istanbul	15500	Golden Horn	Urban	1	2018-10-14	2025-11-03 20:25:50
204	1204	1019	Turkey	85300	1016	Istanbul	15500	Taksim Square	Urban	24	2019-02-06	2025-11-03 20:25:50
205	1205	1019	Turkey	85300	1016	Istanbul	15500	Istiklal Street	Other	28	2021-07-31	2025-11-03 20:25:50
206	1206	1019	Turkey	85300	1016	Istanbul	15500	Maiden Tower	Urban	18	2019-05-13	2025-11-03 20:25:50
207	1207	1019	Turkey	85300	1016	Istanbul	15500	Camlica Tower	Other	30	2021-11-26	2025-11-03 20:25:50
208	1208	1019	Turkey	85300	1016	Istanbul	15500	Kadikoy	Industrial	16	2019-03-18	2025-11-03 20:25:50
209	1209	1019	Turkey	85300	1016	Istanbul	15500	Uskudar	Industrial	16	2017-03-06	2025-11-03 20:25:50
210	1210	1019	Turkey	85300	1016	Istanbul	15500	Galata Bridge	Urban	25	2018-03-09	2025-11-03 20:25:50
211	1211	1019	Turkey	85300	1016	Istanbul	15500	15 July Martyrs Bridge	Suburban	21	2021-07-27	2025-11-03 20:25:50
212	1212	1019	Turkey	85300	1016	Istanbul	15500	Camlica Mosque	Urban	17	2020-07-09	2025-11-03 20:25:50
213	1213	1019	Turkey	85300	1016	Istanbul	15500	Eyup Sultan Mosque	Urban	18	2017-07-11	2025-11-03 20:25:50
214	1214	1019	Turkey	85300	1016	Istanbul	15500	Spice Bazaar	Other	13	2018-06-01	2025-11-03 20:25:50
215	1215	1019	Turkey	85300	1016	Istanbul	15500	Chora Mosque (Kariye)	Suburban	32	2022-10-22	2025-11-03 20:25:50
216	1216	1019	Turkey	85300	1016	Istanbul	15500	Istanbul Archaeological Museums	Industrial	32	2020-06-14	2025-11-03 20:25:50
217	1217	1019	Turkey	85300	1016	Istanbul	15500	Pierre Loti Hill	Suburban	106	2017-05-28	2025-11-03 20:25:50
218	1218	1019	Turkey	85300	1016	Istanbul	15500	Ortakoy Mosque	Industrial	38	2021-12-01	2025-11-03 20:25:50
219	1219	1019	Turkey	85300	1016	Istanbul	15500	Rumeli Fortress	Suburban	23	2020-03-28	2025-11-03 20:25:50
220	1220	1019	Turkey	85300	1016	Istanbul	15500	Grand Arena	Industrial	37	2018-03-22	2025-11-03 20:25:50
221	1221	1019	Turkey	85300	1016	Istanbul	15500	Downtown Palace	Other	8	2019-06-30	2025-11-03 20:25:50
222	1222	1019	Turkey	85300	1016	Istanbul	15500	National Zoo	Suburban	40	2021-12-07	2025-11-03 20:25:50
223	1223	1019	Turkey	85300	1016	Istanbul	15500	Old Tower	Other	29	2018-08-12	2025-11-03 20:25:50
224	1224	1019	Turkey	85300	1016	Istanbul	15500	Old Airport	Other	20	2018-01-17	2025-11-03 20:25:50
225	1225	1019	Turkey	85300	1016	Istanbul	15500	Main Zoo	Urban	295	2020-01-30	2025-11-03 20:25:50
226	1226	1019	Turkey	85300	1016	Istanbul	15500	Grand Airport	Other	14	2020-08-18	2025-11-03 20:25:50
227	1227	1019	Turkey	85300	1016	Istanbul	15500	Western Stadium	Urban	6	2018-09-10	2025-11-03 20:25:50
228	1228	1019	Turkey	85300	1016	Istanbul	15500	Old Park	Other	5	2020-03-22	2025-11-03 20:25:50
229	1229	1019	Turkey	85300	1016	Istanbul	15500	Eastern Airport	Industrial	39	2018-03-22	2025-11-03 20:25:50
230	1230	1019	Turkey	85300	1016	Istanbul	15500	Eastern Bridge	Urban	123	2018-05-06	2025-11-03 20:25:50
231	1231	1019	Turkey	85300	1016	Istanbul	15500	Northern Arena	Suburban	30	2018-02-15	2025-11-03 20:25:50
232	1232	1019	Turkey	85300	1016	Istanbul	15500	Downtown Gallery	Urban	38	2021-08-20	2025-11-03 20:25:50
233	1233	1019	Turkey	85300	1016	Istanbul	15500	Southern Opera House	Other	35	2022-02-01	2025-11-03 20:25:50
234	1234	1019	Turkey	85300	1016	Istanbul	15500	Old Gallery	Industrial	18	2022-09-21	2025-11-03 20:25:50
235	1235	1019	Turkey	85300	1016	Istanbul	15500	Downtown Memorial	Other	252	2019-10-18	2025-11-03 20:25:50
236	1236	1019	Turkey	85300	1016	Istanbul	15500	National Bridge	Suburban	37	2019-03-09	2025-11-03 20:25:50
237	1237	1019	Turkey	85300	1016	Istanbul	15500	Main Monument	Industrial	20	2021-08-25	2025-11-03 20:25:50
238	1238	1019	Turkey	85300	1016	Istanbul	15500	Southern Memorial	Other	33	2022-12-04	2025-11-03 20:25:50
239	1239	1019	Turkey	85300	1016	Istanbul	15500	Eastern Library	Industrial	39	2020-02-01	2025-11-03 20:25:50
240	1240	1019	Turkey	85300	1016	Istanbul	15500	Downtown Bridge	Suburban	39	2017-09-17	2025-11-03 20:25:50
241	1241	1019	Turkey	85300	1016	Istanbul	15500	Royal Tower	Industrial	296	2018-01-21	2025-11-03 20:25:50
242	1242	1019	Turkey	85300	1016	Istanbul	15500	Western Center	Other	2	2021-12-19	2025-11-03 20:25:50
243	1243	1019	Turkey	85300	1016	Istanbul	15500	Downtown Library	Industrial	12	2019-11-07	2025-11-03 20:25:50
244	1244	1019	Turkey	85300	1016	Istanbul	15500	City Monument	Other	18	2017-11-17	2025-11-03 20:25:50
245	1245	1019	Turkey	85300	1016	Istanbul	15500	Downtown Hospital	Industrial	32	2018-07-17	2025-11-03 20:25:50
246	1246	1019	Turkey	85300	1016	Istanbul	15500	National Stadium	Other	22	2022-10-05	2025-11-03 20:25:50
247	1247	1019	Turkey	85300	1016	Istanbul	15500	City Theater	Industrial	22	2021-09-05	2025-11-03 20:25:50
248	1248	1019	Turkey	85300	1016	Istanbul	15500	Western Bridge	Urban	26	2017-10-15	2025-11-03 20:25:50
249	1249	1019	Turkey	85300	1016	Istanbul	15500	Central Hospital	Suburban	21	2019-01-31	2025-11-03 20:25:50
250	1250	1019	Turkey	85300	1016	Istanbul	15500	Southern Zoo	Suburban	26	2018-08-13	2025-11-03 20:25:50
251	1251	1019	Turkey	85300	1016	Istanbul	15500	Western Zoo	Urban	35	2019-01-19	2025-11-03 20:25:50
252	1252	1019	Turkey	85300	1016	Istanbul	15500	Eastern Mall	Other	182	2021-05-09	2025-11-03 20:25:50
253	1253	1019	Turkey	85300	1016	Istanbul	15500	New Square	Industrial	29	2019-02-05	2025-11-03 20:25:50
254	1254	1019	Turkey	85300	1016	Istanbul	15500	Southern Tower	Industrial	9	2019-07-09	2025-11-03 20:25:50
255	1255	1019	Turkey	85300	1016	Istanbul	15500	Western Airport	Industrial	32	2017-08-31	2025-11-03 20:25:50
256	1256	1019	Turkey	85300	1016	Istanbul	15500	Istanbul University	Other	39	2018-11-05	2025-11-03 20:25:50
257	1257	1019	Turkey	85300	1016	Istanbul	15500	Main Airport	Urban	1	2017-04-22	2025-11-03 20:25:50
258	1258	1019	Turkey	85300	1016	Istanbul	15500	National Tower	Urban	265	2020-12-09	2025-11-03 20:25:50
259	1259	1019	Turkey	85300	1016	Istanbul	15500	Northern Mall	Industrial	10	2018-08-17	2025-11-03 20:25:50
260	1260	1019	Turkey	85300	1016	Istanbul	15500	Western Hall	Urban	18	2019-12-11	2025-11-03 20:25:50
261	1261	1019	Turkey	85300	1016	Istanbul	15500	Istanbul Station	Industrial	16	2021-10-26	2025-11-03 20:25:50
262	1262	1019	Turkey	85300	1016	Istanbul	15500	Central Garden	Industrial	13	2022-08-16	2025-11-03 20:25:50
263	1263	1019	Turkey	85300	1016	Istanbul	15500	National Station	Suburban	9	2021-04-08	2025-11-03 20:25:50
264	1264	1019	Turkey	85300	1016	Istanbul	15500	Western Theater	Urban	27	2017-05-05	2025-11-03 20:25:50
265	1265	1019	Turkey	85300	1016	Istanbul	15500	Main Theater	Suburban	1	2021-06-26	2025-11-03 20:25:50
266	1266	1019	Turkey	85300	1016	Istanbul	15500	General Bridge	Industrial	38	2017-11-09	2025-11-03 20:25:50
267	1267	1019	Turkey	85300	1016	Istanbul	15500	Downtown Zoo	Industrial	29	2019-05-15	2025-11-03 20:25:50
268	1268	1019	Turkey	85300	1016	Istanbul	15500	Royal Palace	Other	36	2017-09-13	2025-11-03 20:25:50
269	1269	1019	Turkey	85300	1016	Istanbul	15500	Northern Park	Urban	21	2019-06-15	2025-11-03 20:25:50
270	1270	1019	Turkey	85300	1016	Istanbul	15500	Istanbul Library	Other	15	2020-01-26	2025-11-03 20:25:50
271	1271	1019	Turkey	85300	1016	Istanbul	15500	City University	Other	31	2017-07-05	2025-11-03 20:25:50
272	1272	1019	Turkey	85300	1016	Istanbul	15500	Western Monument	Industrial	10	2017-08-16	2025-11-03 20:25:50
273	1273	1019	Turkey	85300	1016	Istanbul	15500	Royal Library	Other	38	2017-05-13	2025-11-03 20:25:50
274	1274	1019	Turkey	85300	1016	Istanbul	15500	Royal Center	Industrial	29	2019-05-13	2025-11-03 20:25:50
275	1275	1019	Turkey	85300	1016	Istanbul	15500	Grand Palace	Suburban	1	2019-08-24	2025-11-03 20:25:50
276	1276	1019	Turkey	85300	1016	Istanbul	15500	Old Castle	Urban	10	2018-06-20	2025-11-03 20:25:50
277	1277	1019	Turkey	85300	1016	Istanbul	15500	Central Park	Suburban	17	2017-10-18	2025-11-03 20:25:50
278	1278	1019	Turkey	85300	1016	Istanbul	15500	Eastern Hospital	Other	6	2022-03-09	2025-11-03 20:25:50
279	1279	1019	Turkey	85300	1016	Istanbul	15500	Royal Hall	Other	21	2018-06-03	2025-11-03 20:25:50
280	1280	1019	Turkey	85300	1016	Istanbul	15500	Northern Library	Industrial	3	2018-02-14	2025-11-03 20:25:50
281	1281	1019	Turkey	85300	1016	Istanbul	15500	Central University	Urban	19	2017-11-30	2025-11-03 20:25:50
282	1282	1019	Turkey	85300	1016	Istanbul	15500	New Station	Suburban	7	2019-01-21	2025-11-03 20:25:50
283	1283	1019	Turkey	85300	1016	Istanbul	15500	Central Center	Industrial	20	2017-03-17	2025-11-03 20:25:50
284	1284	1019	Turkey	85300	1016	Istanbul	15500	City Arena	Urban	4	2022-07-31	2025-11-03 20:25:50
285	1285	1019	Turkey	85300	1016	Istanbul	15500	General Hall	Suburban	10	2019-03-18	2025-11-03 20:25:50
286	1286	1019	Turkey	85300	1016	Istanbul	15500	Main Tower	Industrial	12	2020-02-01	2025-11-03 20:25:50
287	1287	1015	Russia	146000	1017	Kazan	1250	Kazan Aircraft Production Association	Industrial	28	2020-05-11	2025-11-03 20:25:50
288	1288	1015	Russia	146000	1017	Kazan	1250	Tatneft Arena Logistics Zone	Other	10	2019-03-15	2025-11-03 20:25:50
289	1289	1015	Russia	146000	1017	Kazan	1250	Baumana Street	Other	5	2019-10-10	2025-11-03 20:25:50
290	1290	1015	Russia	146000	1017	Kazan	1250	Soyembika Tower	Other	19	2017-08-07	2025-11-03 20:25:50
291	1291	1015	Russia	146000	1017	Kazan	1250	Kazan Family Center	Urban	6	2020-08-18	2025-11-03 20:25:50
292	1292	1015	Russia	146000	1017	Kazan	1250	Kazan Kremlin	Suburban	14	2021-12-18	2025-11-03 20:25:50
293	1293	1015	Russia	146000	1017	Kazan	1250	Kazan Railway Station	Urban	37	2022-07-05	2025-11-03 20:25:50
294	1294	1015	Russia	146000	1017	Kazan	1250	Salavat Kupere Residential Complex	Other	4	2017-05-04	2025-11-03 20:25:50
295	1295	1015	Russia	146000	1017	Kazan	1250	Kazan State University Main Campus	Other	3	2019-12-03	2025-11-03 20:25:50
296	1296	1009	Germany	83100	1018	Leipzig	625	Monument to the Battle of the Nations	Industrial	10	2018-11-20	2025-11-03 20:25:50
297	1297	1009	Germany	83100	1018	Leipzig	625	St. Thomas Church	Urban	9	2021-03-09	2025-11-03 20:25:50
298	1298	1009	Germany	83100	1018	Leipzig	625	St. Nicholas Church	Industrial	8	2022-11-15	2025-11-03 20:25:50
299	1299	1009	Germany	83100	1018	Leipzig	625	Leipzig Hauptbahnhof	Suburban	5	2021-10-21	2025-11-03 20:25:50
300	1300	1009	Germany	83100	1018	Leipzig	625	Central Park	Urban	16	2018-10-04	2025-11-03 20:25:50
301	1301	1009	Germany	83100	1018	Leipzig	625	New Garden	Urban	23	2022-09-25	2025-11-03 20:25:50
302	1302	1009	Germany	83100	1018	Leipzig	625	City Museum	Other	3	2019-04-04	2025-11-03 20:25:50
303	1303	1009	Germany	83100	1018	Leipzig	625	Old Monument	Industrial	1	2017-04-29	2025-11-03 20:25:50
304	1304	1009	Germany	83100	1018	Leipzig	625	Downtown Hall	Suburban	14	2018-04-21	2025-11-03 20:25:50
305	1305	1020	United Kingdom	67200	1019	London	8900	Buckingham Palace	Other	15	2017-11-28	2025-11-03 20:25:50
306	1306	1020	United Kingdom	67200	1019	London	8900	Big Ben & Houses of Parliament	Suburban	3	2021-01-14	2025-11-03 20:25:50
307	1307	1020	United Kingdom	67200	1019	London	8900	Tower of London	Urban	7	2020-10-04	2025-11-03 20:25:50
308	1308	1020	United Kingdom	67200	1019	London	8900	Tower Bridge	Urban	42	2021-11-23	2025-11-03 20:25:50
309	1309	1020	United Kingdom	67200	1019	London	8900	London Eye	Other	135	2021-05-01	2025-11-03 20:25:50
310	1310	1020	United Kingdom	67200	1019	London	8900	Westminster Abbey	Suburban	8	2019-08-17	2025-11-03 20:25:50
311	1311	1020	United Kingdom	67200	1019	London	8900	St. Paul Cathedral	Urban	5	2020-07-27	2025-11-03 20:25:50
312	1312	1020	United Kingdom	67200	1019	London	8900	British Museum	Other	4	2019-07-31	2025-11-03 20:25:50
313	1313	1020	United Kingdom	67200	1019	London	8900	National Gallery	Urban	7	2017-04-10	2025-11-03 20:25:50
314	1314	1020	United Kingdom	67200	1019	London	8900	Trafalgar Square	Urban	14	2017-05-20	2025-11-03 20:25:50
315	1315	1020	United Kingdom	67200	1019	London	8900	Piccadilly Circus	Industrial	12	2022-02-17	2025-11-03 20:25:50
316	1316	1020	United Kingdom	67200	1019	London	8900	Hyde Park	Industrial	17	2022-07-28	2025-11-03 20:25:50
317	1317	1020	United Kingdom	67200	1019	London	8900	Covent Garden	Other	8	2020-07-02	2025-11-03 20:25:50
318	1318	1020	United Kingdom	67200	1019	London	8900	Madame Tussauds	Suburban	3	2021-12-10	2025-11-03 20:25:50
319	1319	1020	United Kingdom	67200	1019	London	8900	Kensington Palace	Other	11	2020-12-27	2025-11-03 20:25:50
320	1320	1020	United Kingdom	67200	1019	London	8900	The Shard	Industrial	289	2019-01-10	2025-11-03 20:25:50
321	1321	1020	United Kingdom	67200	1019	London	8900	The Gherkin	Other	180	2022-12-11	2025-11-03 20:25:50
322	1322	1020	United Kingdom	67200	1019	London	8900	Canary Wharf	Urban	6	2021-10-22	2025-11-03 20:25:50
323	1323	1020	United Kingdom	67200	1019	London	8900	Oxford Street	Urban	5	2018-11-30	2025-11-03 20:25:50
324	1324	1020	United Kingdom	67200	1019	London	8900	Camden Market	Industrial	2	2018-12-26	2025-11-03 20:25:50
325	1325	1020	United Kingdom	67200	1019	London	8900	Shakespeare Globe	Other	8	2017-04-27	2025-11-03 20:25:50
326	1326	1020	United Kingdom	67200	1019	London	8900	Greenwich Observatory	Suburban	47	2020-06-30	2025-11-03 20:25:50
327	1327	1020	United Kingdom	67200	1019	London	8900	Cutty Sark	Other	4	2017-10-27	2025-11-03 20:25:50
328	1328	1020	United Kingdom	67200	1019	London	8900	Kew Gardens	Other	14	2021-06-02	2025-11-03 20:25:50
329	1329	1020	United Kingdom	67200	1019	London	8900	St Pancras International	Industrial	9	2020-08-09	2025-11-03 20:25:50
330	1330	1020	United Kingdom	67200	1019	London	8900	Leicester Square	Urban	2	2021-02-16	2025-11-03 20:25:50
331	1331	1020	United Kingdom	67200	1019	London	8900	Borough Market	Suburban	1	2019-11-11	2025-11-03 20:25:50
332	1332	1020	United Kingdom	67200	1019	London	8900	10 Downing Street	Urban	3	2018-05-12	2025-11-03 20:25:50
333	1333	1020	United Kingdom	67200	1019	London	8900	Sky Garden	Suburban	155	2018-01-22	2025-11-03 20:25:50
334	1334	1020	United Kingdom	67200	1019	London	8900	Wembley Stadium	Suburban	45	2017-03-24	2025-11-03 20:25:50
335	1335	1020	United Kingdom	67200	1019	London	8900	The O2 Arena	Industrial	52	2019-11-04	2025-11-03 20:25:50
336	1336	1020	United Kingdom	67200	1019	London	8900	Harrods	Other	6	2020-08-11	2025-11-03 20:25:50
337	1337	1020	United Kingdom	67200	1019	London	8900	Victoria and Albert Museum	Industrial	5	2019-08-21	2025-11-03 20:25:50
338	1338	1020	United Kingdom	67200	1019	London	8900	Natural History Museum	Other	7	2021-06-25	2025-11-03 20:25:50
339	1339	1020	United Kingdom	67200	1019	London	8900	Science Museum	Urban	4	2021-11-13	2025-11-03 20:25:50
340	1340	1020	United Kingdom	67200	1019	London	8900	Battersea Power Station	Other	9	2017-06-27	2025-11-03 20:25:50
341	1341	1020	United Kingdom	67200	1019	London	8900	Downtown Hall	Urban	18	2020-07-13	2025-11-03 20:25:50
342	1342	1020	United Kingdom	67200	1019	London	8900	Main Library	Industrial	2	2017-06-29	2025-11-03 20:25:50
343	1343	1020	United Kingdom	67200	1019	London	8900	National Museum	Other	7	2021-10-20	2025-11-03 20:25:50
344	1344	1020	United Kingdom	67200	1019	London	8900	City University	Suburban	13	2018-03-11	2025-11-03 20:25:50
345	1345	1020	United Kingdom	67200	1019	London	8900	Central Park	Industrial	4	2019-06-25	2025-11-03 20:25:50
346	1346	1020	United Kingdom	67200	1019	London	8900	City Hospital	Other	22	2017-01-27	2025-11-03 20:25:50
347	1347	1020	United Kingdom	67200	1019	London	8900	Royal Theater	Other	8	2021-07-24	2025-11-03 20:25:50
348	1348	1020	United Kingdom	67200	1019	London	8900	Grand Memorial	Industrial	6	2018-10-24	2025-11-03 20:25:50
349	1349	1020	United Kingdom	67200	1019	London	8900	Old Bridge	Other	3	2018-10-16	2025-11-03 20:25:50
350	1350	1020	United Kingdom	67200	1019	London	8900	Western Market	Suburban	11	2021-12-22	2025-11-03 20:25:50
351	1351	1020	United Kingdom	67200	1019	London	8900	New Center	Suburban	16	2017-08-07	2025-11-03 20:25:50
352	1352	1008	France	68000	1020	Lyon	520	Basilica of Notre-Dame de Fourviere	Suburban	8	2020-04-01	2025-11-03 20:25:50
353	1353	1008	France	68000	1020	Lyon	520	Vieux Lyon	Industrial	4	2020-12-06	2025-11-03 20:25:50
354	1354	1008	France	68000	1020	Lyon	520	Place Bellecour	Urban	7	2022-04-27	2025-11-03 20:25:50
355	1355	1008	France	68000	1020	Lyon	520	Parc de la Tete dOr	Urban	3	2019-04-15	2025-11-03 20:25:50
356	1356	1008	France	68000	1020	Lyon	520	Lyon Cathedral (St. Jean)	Other	5	2020-01-15	2025-11-03 20:25:50
357	1357	1008	France	68000	1020	Lyon	520	Main Museum	Urban	11	2018-11-29	2025-11-03 20:25:50
358	1358	1008	France	68000	1020	Lyon	520	Central Park	Suburban	2	2018-05-12	2025-11-03 20:25:50
359	1359	1008	France	68000	1020	Lyon	520	City Hall	Other	6	2022-08-30	2025-11-03 20:25:50
360	1360	1008	France	68000	1020	Lyon	520	Old Theatre	Urban	1	2022-02-16	2025-11-03 20:25:50
361	1361	1008	France	68000	1020	Lyon	520	Grand Library	Suburban	4	2022-12-24	2025-11-03 20:25:50
362	1362	1008	France	68000	1021	Marseille	870	Old Port of Marseille (Vieux-Port)	Other	5	2017-05-03	2025-11-03 20:25:50
363	1363	1008	France	68000	1021	Marseille	870	Basilique Notre-Dame de la Garde	Industrial	12	2021-03-23	2025-11-03 20:25:50
364	1364	1008	France	68000	1021	Marseille	870	Chateau dIf	Other	38	2021-04-14	2025-11-03 20:25:50
365	1365	1008	France	68000	1021	Marseille	870	Calanques National Park	Urban	45	2020-07-15	2025-11-03 20:25:50
366	1366	1008	France	68000	1021	Marseille	870	Le Panier	Other	21	2017-10-13	2025-11-03 20:25:50
367	1367	1008	France	68000	1021	Marseille	870	Palais Longchamp	Urban	9	2020-10-12	2025-11-03 20:25:50
368	1368	1008	France	68000	1021	Marseille	870	Central Museum	Other	7	2022-04-25	2025-11-03 20:25:50
369	1369	1008	France	68000	1021	Marseille	870	Downtown Garden	Suburban	2	2017-03-10	2025-11-03 20:25:50
370	1370	1008	France	68000	1021	Marseille	870	Main Square	Urban	4	2017-01-13	2025-11-03 20:25:50
371	1371	1008	France	68000	1021	Marseille	870	City Stadium	Urban	29	2022-12-23	2025-11-03 20:25:50
372	1372	1008	France	68000	1021	Marseille	870	Old Cathedral	Urban	6	2018-06-25	2025-11-03 20:25:50
373	1373	1012	Italy	59000	1022	Milan	1380	Milan Cathedral (Duomo di Milano)	Suburban	5	2022-04-10	2025-11-03 20:25:50
374	1374	1012	Italy	59000	1022	Milan	1380	Galleria Vittorio Emanuele II	Industrial	8	2020-09-27	2025-11-03 20:25:50
375	1375	1012	Italy	59000	1022	Milan	1380	La Scala Theatre	Suburban	6	2017-03-16	2025-11-03 20:25:50
376	1376	1012	Italy	59000	1022	Milan	1380	Sforza Castle (Castello Sforzesco)	Other	13	2017-11-13	2025-11-03 20:25:50
377	1377	1012	Italy	59000	1022	Milan	1380	Navigli Canals	Suburban	2	2022-01-16	2025-11-03 20:25:50
378	1378	1012	Italy	59000	1022	Milan	1380	Santa Maria delle Grazie	Industrial	9	2019-12-09	2025-11-03 20:25:50
379	1379	1012	Italy	59000	1022	Milan	1380	San Siro Stadium	Urban	23	2018-10-02	2025-11-03 20:25:50
380	1380	1012	Italy	59000	1022	Milan	1380	City Park	Industrial	4	2021-09-04	2025-11-03 20:25:50
381	1381	1012	Italy	59000	1022	Milan	1380	Central Station	Industrial	1	2019-06-21	2025-11-03 20:25:50
382	1382	1012	Italy	59000	1022	Milan	1380	Old Market	Urban	6	2022-12-20	2025-11-03 20:25:50
383	1383	1012	Italy	59000	1022	Milan	1380	Main Library	Urban	3	2017-01-21	2025-11-03 20:25:50
384	1384	1012	Italy	59000	1022	Milan	1380	Downtown Arena	Other	27	2021-06-17	2025-11-03 20:25:50
385	1385	1012	Italy	59000	1022	Milan	1380	National Museum	Industrial	11	2018-04-21	2025-11-03 20:25:50
386	1386	1002	Belarus	9400	1023	Minsk	2000	Independence Square	Industrial	12	2019-05-16	2025-11-03 20:25:50
387	1387	1002	Belarus	9400	1023	Minsk	2000	Minsk Hero City Obelisk (Victory Monument)	Suburban	10	2020-08-12	2025-11-03 20:25:50
388	1388	1002	Belarus	9400	1023	Minsk	2000	National Library of Belarus	Industrial	8	2022-10-24	2025-11-03 20:25:50
389	1389	1002	Belarus	9400	1023	Minsk	2000	Trinity Hill (Trojeckaje Pradmiescie)	Urban	2	2021-08-29	2025-11-03 20:25:50
390	1390	1002	Belarus	9400	1023	Minsk	2000	Gates of Minsk	Suburban	1	2018-08-11	2025-11-03 20:25:50
391	1391	1002	Belarus	9400	1023	Minsk	2000	Central Park	Industrial	6	2020-08-03	2025-11-03 20:25:50
392	1392	1002	Belarus	9400	1023	Minsk	2000	City Museum	Industrial	5	2022-06-15	2025-11-03 20:25:50
393	1393	1002	Belarus	9400	1023	Minsk	2000	Main Stadium	Urban	19	2017-04-28	2025-11-03 20:25:50
394	1394	1002	Belarus	9400	1023	Minsk	2000	Downtown Square	Urban	3	2019-09-25	2025-11-03 20:25:50
395	1395	1002	Belarus	9400	1023	Minsk	2000	Old Fortress	Urban	4	2020-02-25	2025-11-03 20:25:50
396	1396	1015	Russia	146000	1024	Moscow	12600	Kremlin & Red Square	Other	25	2021-09-19	2025-11-03 20:25:50
397	1397	1015	Russia	146000	1024	Moscow	12600	Olimpiyskiy Sports Complex	Urban	12	2018-11-19	2025-11-03 20:25:50
398	1398	1015	Russia	146000	1024	Moscow	12600	Bolshoi Theatre	Other	5	2021-01-29	2025-11-03 20:25:50
399	1399	1015	Russia	146000	1024	Moscow	12600	Sheremetyevo Airport Cargo Complex	Industrial	6	2018-10-15	2025-11-03 20:25:50
400	1400	1015	Russia	146000	1024	Moscow	12600	Altufyevo Industrial Zone	Industrial	8	2019-07-18	2025-11-03 20:25:50
401	1401	1015	Russia	146000	1024	Moscow	12600	Domodedovo Airport Cargo Village	Industrial	20	2017-11-19	2025-11-03 20:25:50
402	1402	1015	Russia	146000	1024	Moscow	12600	ZiL Industrial Zone	Industrial	7	2020-07-23	2025-11-03 20:25:50
403	1403	1015	Russia	146000	1024	Moscow	12600	Kuntsevo Industrial Park	Industrial	2	2021-12-05	2025-11-03 20:25:50
404	1404	1015	Russia	146000	1024	Moscow	12600	Ostankino TV Tower	Suburban	147	2022-11-04	2025-11-03 20:25:50
405	1405	1015	Russia	146000	1024	Moscow	12600	VDNKh (Exhibition Center)	Urban	42	2022-11-21	2025-11-03 20:25:50
406	1406	1015	Russia	146000	1024	Moscow	12600	Moscow State University (MSU)	Other	201	2022-05-17	2025-11-03 20:25:50
407	1407	1015	Russia	146000	1024	Moscow	12600	Novodevichy Convent	Other	18	2019-08-24	2025-11-03 20:25:50
408	1408	1015	Russia	146000	1024	Moscow	12600	Kolomenskoye Estate	Other	35	2020-06-14	2025-11-03 20:25:50
409	1409	1015	Russia	146000	1024	Moscow	12600	Tretyakov Gallery	Urban	17	2020-11-23	2025-11-03 20:25:50
410	1410	1015	Russia	146000	1024	Moscow	12600	Victory Park (Poklonnaya Hill)	Other	41	2018-10-29	2025-11-03 20:25:50
411	1411	1015	Russia	146000	1024	Moscow	12600	Luzhniki Stadium	Other	39	2018-11-22	2025-11-03 20:25:50
412	1412	1015	Russia	146000	1024	Moscow	12600	Zaryadye Park	Urban	11	2020-09-21	2025-11-03 20:25:50
413	1413	1015	Russia	146000	1024	Moscow	12600	Izmailovo Kremlin	Other	7	2017-11-11	2025-11-03 20:25:50
414	1414	1015	Russia	146000	1024	Moscow	12600	Vnukovo Airport Logistics Terminal	Industrial	4	2017-12-29	2025-11-03 20:25:50
415	1415	1015	Russia	146000	1024	Moscow	12600	Lyublino Industrial Zone	Industrial	3	2017-02-12	2025-11-03 20:25:50
416	1416	1015	Russia	146000	1024	Moscow	12600	Gorky Park	Urban	8	2017-02-17	2025-11-03 20:25:50
417	1417	1015	Russia	146000	1024	Moscow	12600	Solntsevo District	Other	6	2019-02-20	2025-11-03 20:25:50
418	1418	1015	Russia	146000	1024	Moscow	12600	Moscow Oil Refinery (Kapotnya)	Industrial	12	2020-02-16	2025-11-03 20:25:50
419	1419	1015	Russia	146000	1024	Moscow	12600	Biryulyovo Freight Station & Distribution Yard	Industrial	5	2020-03-31	2025-11-03 20:25:50
420	1420	1015	Russia	146000	1024	Moscow	12600	Tsaritsyno Park	Suburban	9	2018-10-24	2025-11-03 20:25:50
421	1421	1015	Russia	146000	1024	Moscow	12600	Belorussky Railway Station	Other	8	2017-10-09	2025-11-03 20:25:50
422	1422	1015	Russia	146000	1024	Moscow	12600	Luzhniki Stadium	Urban	36	2022-04-03	2025-11-03 20:25:50
423	1423	1015	Russia	146000	1024	Moscow	12600	Arbat Street	Urban	15	2022-01-19	2025-11-03 20:25:50
424	1424	1015	Russia	146000	1024	Moscow	12600	Kuzminki District	Other	4	2019-03-14	2025-11-03 20:25:50
425	1425	1015	Russia	146000	1024	Moscow	12600	Patriarch Ponds Area	Urban	14	2018-06-06	2025-11-03 20:25:50
426	1426	1015	Russia	146000	1024	Moscow	12600	Tushino Industrial Zone	Industrial	37	2017-01-15	2025-11-03 20:25:50
427	1427	1015	Russia	146000	1024	Moscow	12600	Krylatskoye District	Other	4	2018-01-29	2025-11-03 20:25:50
428	1428	1015	Russia	146000	1024	Moscow	12600	Skhodnya Logistics Hub	Industrial	10	2018-05-17	2025-11-03 20:25:50
429	1429	1015	Russia	146000	1024	Moscow	12600	Lubyanka Square & Metro Hub	Urban	16	2018-03-23	2025-11-03 20:25:50
430	1430	1009	Germany	83100	1025	Munich	1550	Marienplatz	Suburban	6	2020-11-01	2025-11-03 20:25:50
431	1431	1009	Germany	83100	1025	Munich	1550	Nymphenburg Palace	Industrial	10	2020-07-23	2025-11-03 20:25:50
432	1432	1009	Germany	83100	1025	Munich	1550	Englischer Garten	Suburban	2	2022-01-02	2025-11-03 20:25:50
433	1433	1009	Germany	83100	1025	Munich	1550	Hofbrauhaus	Suburban	3	2018-01-15	2025-11-03 20:25:50
434	1434	1009	Germany	83100	1025	Munich	1550	Allianz Arena	Urban	16	2019-04-04	2025-11-03 20:25:50
435	1435	1009	Germany	83100	1025	Munich	1550	BMW Museum & Welt	Other	4	2018-05-13	2025-11-03 20:25:50
436	1436	1009	Germany	83100	1025	Munich	1550	Frauenkirche	Industrial	5	2020-06-03	2025-11-03 20:25:50
437	1437	1009	Germany	83100	1025	Munich	1550	Olympiapark	Suburban	7	2018-08-18	2025-11-03 20:25:50
438	1438	1009	Germany	83100	1025	Munich	1550	Central Station	Urban	10	2019-07-04	2025-11-03 20:25:50
439	1439	1009	Germany	83100	1025	Munich	1550	City Library	Industrial	2	2019-07-01	2025-11-03 20:25:50
440	1440	1009	Germany	83100	1025	Munich	1550	National Museum	Urban	6	2021-10-08	2025-11-03 20:25:50
441	1441	1009	Germany	83100	1025	Munich	1550	New Hall	Other	12	2022-01-12	2025-11-03 20:25:50
442	1442	1009	Germany	83100	1025	Munich	1550	Old Garden	Industrial	8	2021-09-27	2025-11-03 20:25:50
443	1443	1009	Germany	83100	1025	Munich	1550	Main Square	Other	1	2018-03-23	2025-11-03 20:25:50
444	1444	1009	Germany	83100	1025	Munich	1550	City Theater	Suburban	9	2020-08-03	2025-11-03 20:25:50
445	1445	1008	France	68000	1026	Paris	2160	Eiffel Tower	Other	324	2022-07-01	2025-11-03 20:25:50
446	1446	1008	France	68000	1026	Paris	2160	Louvre Museum	Urban	9	2021-04-18	2025-11-03 20:25:50
447	1447	1008	France	68000	1026	Paris	2160	Notre-Dame Cathedral	Other	5	2022-06-11	2025-11-03 20:25:50
448	1448	1008	France	68000	1026	Paris	2160	Arc de Triomphe	Industrial	50	2022-04-14	2025-11-03 20:25:50
449	1449	1008	France	68000	1026	Paris	2160	Champs-Elysees	Other	7	2017-10-28	2025-11-03 20:25:50
450	1450	1008	France	68000	1026	Paris	2160	Sacre-Coeur Basilica	Industrial	18	2017-04-27	2025-11-03 20:25:50
451	1451	1008	France	68000	1026	Paris	2160	Montmartre	Urban	130	2018-08-26	2025-11-03 20:25:50
452	1452	1008	France	68000	1026	Paris	2160	Musee dOrsay	Industrial	8	2021-05-25	2025-11-03 20:25:50
453	1453	1008	France	68000	1026	Paris	2160	Centre Pompidou	Industrial	5	2021-04-02	2025-11-03 20:25:50
454	1454	1008	France	68000	1026	Paris	2160	Luxembourg Gardens	Urban	14	2020-11-17	2025-11-03 20:25:50
455	1455	1008	France	68000	1026	Paris	2160	Place de la Concorde	Suburban	8	2020-04-03	2025-11-03 20:25:50
456	1456	1008	France	68000	1026	Paris	2160	Les Invalides	Suburban	6	2018-01-13	2025-11-03 20:25:50
457	1457	1008	France	68000	1026	Paris	2160	Sainte-Chapelle	Urban	2	2018-02-20	2025-11-03 20:25:50
458	1458	1008	France	68000	1026	Paris	2160	Moulin Rouge	Urban	11	2020-03-29	2025-11-03 20:25:50
459	1459	1008	France	68000	1026	Paris	2160	Palais Garnier (Opera Garnier)	Suburban	4	2022-02-16	2025-11-03 20:25:50
460	1460	1008	France	68000	1026	Paris	2160	Grand Palais & Petit Palais	Suburban	7	2017-01-20	2025-11-03 20:25:50
461	1461	1008	France	68000	1026	Paris	2160	Pantheon	Other	3	2020-08-15	2025-11-03 20:25:50
462	1462	1008	France	68000	1026	Paris	2160	Catacombs of Paris	Industrial	19	2018-11-19	2025-11-03 20:25:50
463	1463	1008	France	68000	1026	Paris	2160	Grande Arche de la Defense	Other	110	2022-09-10	2025-11-03 20:25:50
464	1464	1008	France	68000	1026	Paris	2160	Main Library	Industrial	5	2020-05-09	2025-11-03 20:25:50
465	1465	1008	France	68000	1026	Paris	2160	City Zoo	Other	9	2019-11-15	2025-11-03 20:25:50
466	1466	1008	France	68000	1026	Paris	2160	Old Market	Urban	14	2020-04-17	2025-11-03 20:25:50
467	1467	1008	France	68000	1026	Paris	2160	Downtown Museum	Suburban	6	2017-12-21	2025-11-03 20:25:50
468	1468	1008	France	68000	1026	Paris	2160	National Theatre	Urban	2	2018-05-02	2025-11-03 20:25:50
469	1469	1008	France	68000	1026	Paris	2160	Central Station	Suburban	4	2017-05-01	2025-11-03 20:25:50
470	1470	1005	Czech Republic	10800	1027	Prague	1300	Prague Castle	Industrial	8	2018-06-15	2025-11-03 20:25:50
471	1471	1005	Czech Republic	10800	1027	Prague	1300	Charles Bridge	Industrial	6	2021-10-21	2025-11-03 20:25:50
472	1472	1005	Czech Republic	10800	1027	Prague	1300	Old Town Square	Suburban	3	2017-11-19	2025-11-03 20:25:50
473	1473	1005	Czech Republic	10800	1027	Prague	1300	St. Vitus Cathedral	Other	4	2018-10-11	2025-11-03 20:25:50
474	1474	1005	Czech Republic	10800	1027	Prague	1300	Wenceslas Square	Other	2	2020-12-13	2025-11-03 20:25:50
475	1475	1005	Czech Republic	10800	1027	Prague	1300	Lennon Wall	Urban	1	2017-03-27	2025-11-03 20:25:50
476	1476	1005	Czech Republic	10800	1027	Prague	1300	Vysehrad	Industrial	36	2022-11-30	2025-11-03 20:25:50
477	1477	1005	Czech Republic	10800	1027	Prague	1300	Petrin Tower	Industrial	23	2017-12-22	2025-11-03 20:25:50
478	1478	1005	Czech Republic	10800	1027	Prague	1300	Dancing House	Urban	6	2020-05-05	2025-11-03 20:25:50
479	1479	1005	Czech Republic	10800	1027	Prague	1300	National Theatre	Other	3	2020-01-26	2025-11-03 20:25:50
480	1480	1005	Czech Republic	10800	1027	Prague	1300	Central Park	Suburban	7	2021-03-20	2025-11-03 20:25:50
481	1481	1005	Czech Republic	10800	1027	Prague	1300	Main Station	Urban	14	2018-11-19	2025-11-03 20:25:50
482	1482	1005	Czech Republic	10800	1027	Prague	1300	City Museum	Suburban	8	2022-07-05	2025-11-03 20:25:50
483	1483	1005	Czech Republic	10800	1027	Prague	1300	Old Tower	Industrial	27	2021-08-01	2025-11-03 20:25:50
484	1484	1005	Czech Republic	10800	1027	Prague	1300	New Garden	Urban	12	2017-07-19	2025-11-03 20:25:50
485	1485	1012	Italy	59000	1028	Rome	2870	Colosseum	Suburban	18	2017-12-13	2025-11-03 20:25:50
486	1486	1012	Italy	59000	1028	Rome	2870	Roman Forum	Urban	11	2021-09-01	2025-11-03 20:25:50
487	1487	1012	Italy	59000	1028	Rome	2870	Pantheon	Industrial	4	2022-07-03	2025-11-03 20:25:50
488	1488	1012	Italy	59000	1028	Rome	2870	Trevi Fountain	Industrial	3	2020-10-06	2025-11-03 20:25:50
489	1489	1012	Italy	59000	1028	Rome	2870	St. Peter Basilica	Suburban	9	2020-04-27	2025-11-03 20:25:50
490	1490	1012	Italy	59000	1028	Rome	2870	Spanish Steps	Suburban	4	2020-04-20	2025-11-03 20:25:50
491	1491	1012	Italy	59000	1028	Rome	2870	Piazza Navona	Suburban	2	2019-10-06	2025-11-03 20:25:50
492	1492	1012	Italy	59000	1028	Rome	2870	Vatican Museums	Suburban	13	2018-07-17	2025-11-03 20:25:50
493	1493	1012	Italy	59000	1028	Rome	2870	Castel Sant Angelo	Urban	5	2017-11-19	2025-11-03 20:25:50
494	1494	1012	Italy	59000	1028	Rome	2870	Villa Borghese & Galleria Borghese	Other	6	2022-04-15	2025-11-03 20:25:50
495	1495	1012	Italy	59000	1028	Rome	2870	Trastevere	Urban	14	2021-12-02	2025-11-03 20:25:50
496	1496	1012	Italy	59000	1028	Rome	2870	Capitoline Hill & Museums	Other	47	2021-04-17	2025-11-03 20:25:50
497	1497	1012	Italy	59000	1028	Rome	2870	Circus Maximus	Other	3	2021-08-18	2025-11-03 20:25:50
498	1498	1012	Italy	59000	1028	Rome	2870	Appian Way (Via Appia Antica)	Suburban	9	2022-08-30	2025-11-03 20:25:50
499	1499	1012	Italy	59000	1028	Rome	2870	Baths of Caracalla	Suburban	6	2019-01-10	2025-11-03 20:25:50
500	1500	1012	Italy	59000	1028	Rome	2870	New Park	Industrial	11	2021-03-09	2025-11-03 20:25:50
501	1501	1012	Italy	59000	1028	Rome	2870	Old Church	Industrial	4	2017-12-25	2025-11-03 20:25:50
502	1502	1012	Italy	59000	1028	Rome	2870	City Library	Suburban	2	2019-06-29	2025-11-03 20:25:50
503	1503	1012	Italy	59000	1028	Rome	2870	Central Museum	Other	7	2022-08-10	2025-11-03 20:25:50
504	1504	1012	Italy	59000	1028	Rome	2870	Royal Palace	Other	16	2019-05-20	2025-11-03 20:25:50
505	1505	1012	Italy	59000	1028	Rome	2870	National Gallery	Suburban	5	2019-09-11	2025-11-03 20:25:50
506	1506	1001	Austria	9000	1029	Salzburg	155	Hohensalzburg Fortress	Other	36	2020-08-20	2025-11-03 20:25:50
507	1507	1001	Austria	9000	1029	Salzburg	155	Salzburg Cathedral	Urban	5	2017-01-21	2025-11-03 20:25:50
508	1508	1001	Austria	9000	1029	Salzburg	155	Mirabell Palace & Gardens	Urban	4	2017-02-08	2025-11-03 20:25:50
509	1509	1001	Austria	9000	1029	Salzburg	155	Mozart Birthplace	Industrial	2	2017-12-29	2025-11-03 20:25:50
510	1510	1001	Austria	9000	1029	Salzburg	155	Hellbrunn Palace	Other	7	2017-02-03	2025-11-03 20:25:50
511	1511	1001	Austria	9000	1029	Salzburg	155	Main Museum	Urban	3	2020-05-23	2025-11-03 20:25:50
512	1512	1001	Austria	9000	1029	Salzburg	155	Old Market	Urban	1	2020-01-05	2025-11-03 20:25:50
513	1513	1001	Austria	9000	1029	Salzburg	155	City Park	Industrial	8	2022-05-15	2025-11-03 20:25:50
514	1514	1001	Austria	9000	1029	Salzburg	155	Downtown Monument	Industrial	15	2022-06-02	2025-11-03 20:25:50
515	1515	1001	Austria	9000	1029	Salzburg	155	Central Library	Urban	4	2017-04-28	2025-11-03 20:25:50
516	1516	1015	Russia	146000	1030	St. Petersburg	5400	State Hermitage Museum	Urban	11	2021-01-11	2025-11-03 20:25:50
517	1517	1015	Russia	146000	1030	St. Petersburg	5400	Peter and Paul Fortress	Other	16	2020-06-02	2025-11-03 20:25:50
518	1518	1015	Russia	146000	1030	St. Petersburg	5400	Admiralteyskaya Embankment	Other	7	2021-11-06	2025-11-03 20:25:50
519	1519	1015	Russia	146000	1030	St. Petersburg	5400	St. Isaac Cathedral	Other	5	2022-10-20	2025-11-03 20:25:50
520	1520	1015	Russia	146000	1030	St. Petersburg	5400	Nevsky Prospekt	Other	3	2017-07-28	2025-11-03 20:25:50
521	1521	1015	Russia	146000	1030	St. Petersburg	5400	Palace Square	Other	11	2019-08-28	2025-11-03 20:25:50
522	1522	1015	Russia	146000	1030	St. Petersburg	5400	Peterhof Palace	Suburban	19	2022-10-18	2025-11-03 20:25:50
523	1523	1015	Russia	146000	1030	St. Petersburg	5400	Catherine Palace (Tsarskoye Selo)	Suburban	32	2022-04-02	2025-11-03 20:25:50
524	1524	1015	Russia	146000	1030	St. Petersburg	5400	Kazan Cathedral	Suburban	8	2017-03-26	2025-11-03 20:25:50
525	1525	1015	Russia	146000	1030	St. Petersburg	5400	Kolpino Izhora Plants Area	Industrial	4	2020-11-18	2025-11-03 20:25:50
526	1526	1015	Russia	146000	1030	St. Petersburg	5400	Pulkovo Airport Cargo Terminal	Industrial	14	2019-02-02	2025-11-03 20:25:50
527	1527	1015	Russia	146000	1030	St. Petersburg	5400	Smolny Cathedral	Other	5	2020-06-19	2025-11-03 20:25:50
528	1528	1015	Russia	146000	1030	St. Petersburg	5400	Bronze Horseman	Urban	3	2020-01-27	2025-11-03 20:25:50
529	1529	1015	Russia	146000	1030	St. Petersburg	5400	Lomonosov (Oranienbaum)	Suburban	6	2022-07-28	2025-11-03 20:25:50
530	1530	1015	Russia	146000	1030	St. Petersburg	5400	Komendantsky Prospekt Area	Suburban	9	2017-01-23	2025-11-03 20:25:50
531	1531	1015	Russia	146000	1030	St. Petersburg	5400	Liteyny Prospekt	Urban	4	2018-07-14	2025-11-03 20:25:50
532	1532	1015	Russia	146000	1030	St. Petersburg	5400	Sadovaya Street	Other	27	2021-05-02	2025-11-03 20:25:50
533	1533	1015	Russia	146000	1030	St. Petersburg	5400	Moskovsky Railway Station	Other	12	2020-11-17	2025-11-03 20:25:50
534	1534	1015	Russia	146000	1030	St. Petersburg	5400	Baltiysky Shopping Center	Urban	17	2019-02-23	2025-11-03 20:25:50
535	1535	1015	Russia	146000	1030	St. Petersburg	5400	Kupchino District	Other	3	2022-04-28	2025-11-03 20:25:50
536	1536	1015	Russia	146000	1030	St. Petersburg	5400	Ligovsky Prospekt	Urban	7	2019-08-05	2025-11-03 20:25:50
537	1537	1015	Russia	146000	1030	St. Petersburg	5400	Lakhta Center	Urban	30	2019-10-28	2025-11-03 20:25:50
538	1538	1015	Russia	146000	1030	St. Petersburg	5400	Pushkin (Tsarskoye Selo)	Suburban	5	2020-01-18	2025-11-03 20:25:50
539	1539	1015	Russia	146000	1030	St. Petersburg	5400	Mariinsky Theatre	Other	6	2020-11-06	2025-11-03 20:25:50
540	1540	1015	Russia	146000	1030	St. Petersburg	5400	Bronka Port Terminal	Industrial	8	2017-06-17	2025-11-03 20:25:50
541	1541	1018	Sweden	10500	1031	Stockholm	975	Gamla Stan	Urban	12	2017-05-04	2025-11-03 20:25:50
542	1542	1018	Sweden	10500	1031	Stockholm	975	Stockholm Royal Palace	Industrial	7	2020-01-05	2025-11-03 20:25:50
543	1543	1018	Sweden	10500	1031	Stockholm	975	Vasa Museum	Suburban	5	2019-11-04	2025-11-03 20:25:50
544	1544	1018	Sweden	10500	1031	Stockholm	975	Skansen	Urban	22	2017-07-03	2025-11-03 20:25:50
545	1545	1018	Sweden	10500	1031	Stockholm	975	Stockholm City Hall	Other	2	2020-09-03	2025-11-03 20:25:50
546	1546	1018	Sweden	10500	1031	Stockholm	975	Drottningholm Palace	Industrial	14	2020-04-02	2025-11-03 20:25:50
547	1547	1018	Sweden	10500	1031	Stockholm	975	ABBA Museum	Urban	4	2017-08-13	2025-11-03 20:25:50
548	1548	1018	Sweden	10500	1031	Stockholm	975	Central Park	Other	8	2018-03-06	2025-11-03 20:25:50
549	1549	1018	Sweden	10500	1031	Stockholm	975	Main Library	Industrial	3	2018-09-25	2025-11-03 20:25:50
550	1550	1018	Sweden	10500	1031	Stockholm	975	National Museum	Suburban	6	2022-11-18	2025-11-03 20:25:50
551	1551	1018	Sweden	10500	1031	Stockholm	975	Downtown Arena	Suburban	31	2021-03-30	2025-11-03 20:25:50
552	1552	1018	Sweden	10500	1031	Stockholm	975	City Theatre	Suburban	5	2018-11-23	2025-11-03 20:25:50
553	1553	1018	Sweden	10500	1031	Stockholm	975	Western Market	Industrial	9	2020-01-02	2025-11-03 20:25:50
554	1554	1018	Sweden	10500	1031	Stockholm	975	Old Cathedral	Urban	7	2018-09-08	2025-11-03 20:25:50
555	1555	1018	Sweden	10500	1031	Stockholm	975	Grand Square	Suburban	4	2019-11-02	2025-11-03 20:25:50
556	1556	1018	Sweden	10500	1031	Stockholm	975	Central Station	Urban	1	2021-09-04	2025-11-03 20:25:50
557	1557	1009	Germany	83100	1032	Stuttgart	635	Mercedes-Benz Museum	Suburban	5	2017-08-29	2025-11-03 20:25:50
558	1558	1009	Germany	83100	1032	Stuttgart	635	Porsche Museum	Industrial	4	2019-09-24	2025-11-03 20:25:50
559	1559	1009	Germany	83100	1032	Stuttgart	635	Schlossplatz	Suburban	3	2021-06-07	2025-11-03 20:25:50
560	1560	1009	Germany	83100	1032	Stuttgart	635	New Palace (Neues Schloss)	Suburban	2	2021-06-10	2025-11-03 20:25:50
561	1561	1009	Germany	83100	1032	Stuttgart	635	Stuttgart TV Tower	Urban	48	2021-06-08	2025-11-03 20:25:50
562	1562	1009	Germany	83100	1032	Stuttgart	635	City Library	Urban	6	2021-08-13	2025-11-03 20:25:50
563	1563	1009	Germany	83100	1032	Stuttgart	635	Central Park	Suburban	8	2018-12-11	2025-11-03 20:25:50
564	1564	1009	Germany	83100	1032	Stuttgart	635	Main Station	Other	10	2020-12-10	2025-11-03 20:25:50
565	1565	1009	Germany	83100	1032	Stuttgart	635	Old Hall	Urban	19	2018-01-13	2025-11-03 20:25:50
566	1566	1009	Germany	83100	1032	Stuttgart	635	Grand Arena	Suburban	7	2018-02-15	2025-11-03 20:25:50
567	1567	1015	Russia	146000	1033	Ufa	1150	Bashneft Ufa Oil Refinery	Industrial	10	2021-07-29	2025-11-03 20:25:50
568	1568	1015	Russia	146000	1033	Ufa	1150	Seven Girls Fountain	Suburban	3	2017-11-11	2025-11-03 20:25:50
569	1569	1015	Russia	146000	1033	Ufa	1150	Lala Tulpan Mosque	Urban	6	2018-06-04	2025-11-03 20:25:50
570	1570	1015	Russia	146000	1033	Ufa	1150	Ufa Engine Industrial Association (UMPO)	Industrial	9	2019-08-29	2025-11-03 20:25:50
571	1571	1015	Russia	146000	1033	Ufa	1150	Monument Druzhby (Friendship Monument)	Other	5	2018-07-02	2025-11-03 20:25:50
572	1572	1015	Russia	146000	1033	Ufa	1150	Maximovka Industrial Park	Industrial	4	2021-10-12	2025-11-03 20:25:50
573	1573	1015	Russia	146000	1033	Ufa	1150	Bashkir State Opera and Ballet Theatre	Urban	8	2018-03-15	2025-11-03 20:25:50
574	1574	1015	Russia	146000	1033	Ufa	1150	South-Ufa Logistics Center	Industrial	6	2018-03-21	2025-11-03 20:25:50
575	1575	1015	Russia	146000	1033	Ufa	1150	Victory Park	Suburban	2	2022-04-20	2025-11-03 20:25:50
576	1576	1015	Russia	146000	1033	Ufa	1150	Ufa State Circus	Other	20	2017-05-12	2025-11-03 20:25:50
577	1577	1015	Russia	146000	1033	Ufa	1150	Ufa Pipe Plant	Industrial	3	2017-07-18	2025-11-03 20:25:50
578	1578	1015	Russia	146000	1033	Ufa	1150	Ufa Railway Station	Industrial	4	2022-03-29	2025-11-03 20:25:50
579	1579	1015	Russia	146000	1033	Ufa	1150	Gostiny Dvor	Urban	5	2017-05-30	2025-11-03 20:25:50
580	1580	1015	Russia	146000	1033	Ufa	1150	Neftebaza Ufa-2	Industrial	2	2017-03-10	2025-11-03 20:25:50
581	1581	1015	Russia	146000	1033	Ufa	1150	Iremel Shopping Center	Urban	7	2021-10-19	2025-11-03 20:25:50
582	1582	1015	Russia	146000	1033	Ufa	1150	Bashkir State University Campus	Urban	6	2017-07-06	2025-11-03 20:25:50
583	1583	1015	Russia	146000	1033	Ufa	1150	Ufa-Arena	Suburban	1	2019-07-19	2025-11-03 20:25:50
584	1584	1015	Russia	146000	1033	Ufa	1150	National Museum of Bashkortostan	Other	11	2018-11-09	2025-11-03 20:25:50
585	1585	1015	Russia	146000	1033	Ufa	1150	Ufa International Airport	Industrial	17	2022-02-23	2025-11-03 20:25:50
586	1586	1015	Russia	146000	1033	Ufa	1150	Salavat Yulaev Monument	Urban	4	2022-11-13	2025-11-03 20:25:50
587	1587	1015	Russia	146000	1033	Ufa	1150	Lenin Square	Other	3	2019-07-13	2025-11-03 20:25:50
588	1588	1001	Austria	9000	1034	Vienna	1920	Inzersdorf Industrial Area	Industrial	31	2021-09-05	2025-11-03 20:25:50
589	1589	1001	Austria	9000	1034	Vienna	1920	St. Stephen Cathedral	Urban	5	2018-01-15	2025-11-03 20:25:50
590	1590	1001	Austria	9000	1034	Vienna	1920	Hofburg Palace	Other	19	2021-09-22	2025-11-03 20:25:50
591	1591	1001	Austria	9000	1034	Vienna	1920	Belvedere Palace	Other	8	2021-07-16	2025-11-03 20:25:50
592	1592	1001	Austria	9000	1034	Vienna	1920	Aspern Innovation Campus	Industrial	5	2019-07-27	2025-11-03 20:25:50
593	1593	1001	Austria	9000	1034	Vienna	1920	Freudenau Port Zone	Industrial	65	2020-05-08	2025-11-03 20:25:50
594	1594	1001	Austria	9000	1034	Vienna	1920	Vienna City Hall (Rathaus)	Other	8	2018-06-13	2025-11-03 20:25:50
595	1595	1001	Austria	9000	1034	Vienna	1920	Kledering Freight Terminal	Industrial	4	2021-05-12	2025-11-03 20:25:50
596	1596	1001	Austria	9000	1034	Vienna	1920	Lobau Oil Terminal	Industrial	3	2021-07-23	2025-11-03 20:25:50
597	1597	1001	Austria	9000	1034	Vienna	1920	Vienna Schwechat Airport Cargo Terminal	Industrial	2	2020-04-30	2025-11-03 20:25:50
598	1598	1001	Austria	9000	1034	Vienna	1920	Vienna State Opera	Urban	9	2022-12-23	2025-11-03 20:25:50
599	1599	1001	Austria	9000	1034	Vienna	1920	Pfaffenau Waste-to-Energy Plant	Industrial	6	2017-03-08	2025-11-03 20:25:50
600	1600	1001	Austria	9000	1034	Vienna	1920	Transdanubia Residential Zone	Suburban	5	2022-03-03	2025-11-03 20:25:50
601	1601	1001	Austria	9000	1034	Vienna	1920	Prater Park	Suburban	11	2019-03-18	2025-11-03 20:25:50
602	1602	1001	Austria	9000	1034	Vienna	1920	Schonbrunn Palace	Other	4	2021-06-04	2025-11-03 20:25:50
603	1603	1001	Austria	9000	1034	Vienna	1920	Votivkirche Square	Urban	26	2018-05-09	2025-11-03 20:25:50
604	1604	1001	Austria	9000	1034	Vienna	1920	Breitenlee Residential Quarter	Suburban	21	2017-10-03	2025-11-03 20:25:50
605	1605	1014	Poland	37900	1035	Warsaw	1790	Old Town Market Square	Suburban	3	2021-04-15	2025-11-03 20:25:50
606	1606	1014	Poland	37900	1035	Warsaw	1790	Royal Castle	Industrial	10	2017-09-21	2025-11-03 20:25:50
607	1607	1014	Poland	37900	1035	Warsaw	1790	Palace of Culture and Science	Suburban	28	2019-12-09	2025-11-03 20:25:50
608	1608	1014	Poland	37900	1035	Warsaw	1790	Lazienki Park & Palace	Other	9	2020-08-01	2025-11-03 20:25:50
609	1609	1014	Poland	37900	1035	Warsaw	1790	Wilanow Palace	Other	6	2020-06-02	2025-11-03 20:25:50
610	1610	1014	Poland	37900	1035	Warsaw	1790	Warsaw Uprising Monument	Urban	4	2021-08-03	2025-11-03 20:25:50
611	1611	1014	Poland	37900	1035	Warsaw	1790	Warsaw Barbican	Urban	8	2019-06-05	2025-11-03 20:25:50
612	1612	1014	Poland	37900	1035	Warsaw	1790	Central Park	Urban	7	2018-05-21	2025-11-03 20:25:50
613	1613	1014	Poland	37900	1035	Warsaw	1790	New Stadium	Industrial	30	2018-06-25	2025-11-03 20:25:50
614	1614	1014	Poland	37900	1035	Warsaw	1790	City Museum	Other	5	2019-04-02	2025-11-03 20:25:50
615	1615	1014	Poland	37900	1035	Warsaw	1790	Main Library	Urban	6	2017-08-15	2025-11-03 20:25:50
616	1616	1014	Poland	37900	1035	Warsaw	1790	Old Fortress	Industrial	19	2021-05-30	2025-11-03 20:25:50
617	1617	1014	Poland	37900	1035	Warsaw	1790	Downtown Market	Other	2	2018-08-27	2025-11-03 20:25:50
618	1618	1004	Croatia	3900	1036	Zagreb	770	Ban Jelacic Square	Suburban	39	2019-10-18	2025-11-03 20:25:50
619	1619	1004	Croatia	3900	1036	Zagreb	770	Zagreb Cathedral	Urban	5	2018-12-20	2025-11-03 20:25:50
620	1620	1004	Croatia	3900	1036	Zagreb	770	St. Mark Church	Other	31	2020-12-06	2025-11-03 20:25:50
621	1621	1004	Croatia	3900	1036	Zagreb	770	Lotrscak Tower	Other	8	2017-12-23	2025-11-03 20:25:50
622	1622	1004	Croatia	3900	1036	Zagreb	770	Mirogoj Cemetery	Industrial	6	2022-02-02	2025-11-03 20:25:50
623	1623	1004	Croatia	3900	1036	Zagreb	770	Dolac Market	Industrial	2	2022-08-25	2025-11-03 20:25:50
624	1624	1004	Croatia	3900	1036	Zagreb	770	Central Park	Industrial	4	2018-12-19	2025-11-03 20:25:50
625	1625	1004	Croatia	3900	1036	Zagreb	770	City Museum	Suburban	3	2019-09-24	2025-11-03 20:25:50
626	1626	1004	Croatia	3900	1036	Zagreb	770	Old Hall	Industrial	1	2018-08-22	2025-11-03 20:25:50
627	1627	1004	Croatia	3900	1036	Zagreb	770	Main Library	Urban	7	2018-02-09	2025-11-03 20:25:50
\.


--
-- Data for Name: dim_parameter; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_parameter (sk_parameter, tb_param_id, paramname, category, purpose, unit, etl_load_timestamp) FROM stdin;
1	1001	PM1	Particulate matter	Health Risk	mcg/m3	2025-11-03 20:25:50
2	1002	PM2	Particulate matter	Health Risk	mcg/m3	2025-11-03 20:25:50
3	1003	PM4	Particulate matter	Health Risk	mcg/m3	2025-11-03 20:25:50
4	1004	PM10	Particulate matter	Regulatory Compliance	mcg/m3	2025-11-03 20:25:50
5	1005	TSP	Particulate matter	Environmental Monitoring	mcg/m3	2025-11-03 20:25:50
6	1006	BlackCarbon	Particulate matter	Scientific Study	mcg/m3	2025-11-03 20:25:50
7	1007	CO2	Gas	Comfort	ppm	2025-11-03 20:25:50
8	1008	CO	Gas	Health Risk	ppm	2025-11-03 20:25:50
9	1009	NO2	Gas	Health Risk	ppb	2025-11-03 20:25:50
10	1010	O3	Gas	Health Risk	ppb	2025-11-03 20:25:50
11	1011	SO2	Gas	Regulatory Compliance	ppb	2025-11-03 20:25:50
12	1012	CH4	Gas	Environmental Monitoring	ppm	2025-11-03 20:25:50
13	1013	Lead	Heavy Metal	Health Risk	mcg/m3	2025-11-03 20:25:50
14	1014	Mercury	Heavy Metal	Health Risk	mcg/m3	2025-11-03 20:25:50
15	1015	Cadmium	Heavy Metal	Regulatory Compliance	mcg/m3	2025-11-03 20:25:50
16	1016	Arsenic	Heavy Metal	Health Risk	mcg/m3	2025-11-03 20:25:50
17	1017	Nickel	Heavy Metal	Health Risk	mcg/m3	2025-11-03 20:25:50
18	1018	Chromium	Heavy Metal	Scientific Study	mcg/m3	2025-11-03 20:25:50
19	1019	Benzene	Volatile Organic Compound	Health Risk	ppb	2025-11-03 20:25:50
20	1020	Toluene	Volatile Organic Compound	Comfort	ppb	2025-11-03 20:25:50
21	1021	Formaldehyde	Volatile Organic Compound	Health Risk	ppb	2025-11-03 20:25:50
22	1022	Ethylbenzene	Volatile Organic Compound	Scientific Study	ppb	2025-11-03 20:25:50
23	1023	Acetone	Volatile Organic Compound	Environmental Monitoring	ppb	2025-11-03 20:25:50
24	1024	Xylene	Volatile Organic Compound	Regulatory Compliance	ppb	2025-11-03 20:25:50
25	1025	MoldSpores	Biological	Health Risk	count/m3	2025-11-03 20:25:50
26	1026	Bacteria	Biological	Health Risk	CFU/m3	2025-11-03 20:25:50
27	1027	FungalSpores	Biological	Scientific Study	count/m3	2025-11-03 20:25:50
28	1028	Yeasts	Biological	Scientific Study	count/m3	2025-11-03 20:25:50
29	1029	Actinomycetes	Biological	Health Risk	count/m3	2025-11-03 20:25:50
30	1030	Viruses	Biological	Scientific Study	count/m3	2025-11-03 20:25:50
\.


--
-- Data for Name: dim_servicetype; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_servicetype (sk_servicetype, tb_servicetype_id, typename, category, servicegroup, minlevel, details, required_certification_level, etl_load_timestamp) FROM stdin;
1	1001	Diagnostics Scan	Diagnostics	Health Checks	2	Interpret error codes and sensor status	Entry / Advanced	2025-11-03 20:25:50
2	1002	Firmware Update	Software	Security and Access	2	Upload new firmware version	Entry / Advanced	2025-11-03 20:25:50
3	1003	Remote Calibration Check	Calibration	Sensor Precision	3	Check calibration levels via control signals	Advanced / Expert	2025-11-03 20:25:50
4	1004	Software Patch Deployment	Software	Update Procedures	1	Apply bug fixes or small updates	Entry	2025-11-03 20:25:50
5	1005	Threshold Adjustment	Diagnostics	Stability Analysis	3	Change parameter thresholds for alerts	Advanced / Expert	2025-11-03 20:25:50
6	1006	Sensor Network Reconfiguration	Software	Security and Access	2	Update communication settings across sensors	Entry / Advanced	2025-11-03 20:25:50
7	1007	Performance Audit	Diagnostics	Stability Analysis	4	Analyse long-term sensor performance trends	Expert	2025-11-03 20:25:50
8	1008	Battery Performance Review	Hardware	Device Reconfiguration	2	Evaluate telemetry data for battery condition	Entry / Advanced	2025-11-03 20:25:50
9	1009	Sensor Data Validation	Diagnostics	Communication Logs	2	Detect missing or erroneous readings	Entry / Advanced	2025-11-03 20:25:50
10	1010	Connectivity Test	Diagnostics	Health Checks	1	Ping sensors and verify data transmission	Entry	2025-11-03 20:25:50
11	1011	Environmental Correlation Analysis	Calibration	Sensor Precision	4	Compare readings with local weather data	Expert	2025-11-03 20:25:50
12	1012	Sensor Synchronization Check	Hardware	Component Maintenance	2	Verify timing consistency across distributed sensors	Entry / Advanced	2025-11-03 20:25:50
13	1013	Temperature Probe Replacement	Hardware	Structural Inspection	1	Installing a new temperature probe due to drift or damage	Entry	2025-11-03 20:25:50
14	1014	Laser Alignment Check	Calibration	Reference Matching	2	Verifying and adjusting the alignment of optical measurement components	Entry / Advanced	2025-11-03 20:25:50
15	1015	Backup Battery Replacement	Hardware	Device Reconfiguration	2	Replacing the backup power module to ensure uninterrupted operation	Entry / Advanced	2025-11-03 20:25:50
16	1016	Telemetry Sync Test	Diagnostics	Communication Logs	1	Testing synchronization of telemetry modules with base stations	Entry	2025-11-03 20:25:50
17	1017	Error Code Resolution	Diagnostics	Communication Logs	1	Resolving error codes shown during system self-checks	Entry	2025-11-03 20:25:50
18	1018	Radio Frequency Scan	Diagnostics	Stability Analysis	1	Scanning RF spectrum to avoid interference with sensor communications	Entry	2025-11-03 20:25:50
19	1019	Sensor Recalibration	Calibration	Reference Matching	1	Recalibrating sensors to correct drift and ensure accurate measurements	Entry	2025-11-03 20:25:50
20	1020	Realtime Clock Reset	Hardware	Structural Inspection	1	Resetting or replacing the real-time clock module for timestamp accuracy	Entry	2025-11-03 20:25:50
21	1021	Remote Security Audit	Software	Security and Access	3	Remotely check access logs and authentication configuration	Advanced / Expert	2025-11-03 20:25:50
22	1022	Deep System Audit	Diagnostics	Stability Analysis	3	Performing a comprehensive system audit to ensure regulatory compliance	Advanced / Expert	2025-11-03 20:25:50
23	1023	System Reboot	Software	Data Management	1	Scheduled or manual reboot to refresh system processes	Entry	2025-11-03 20:25:50
24	1024	Board-Level Voltage Check	Hardware	Structural Inspection	3	Checking voltages across circuit boards for consistency	Advanced / Expert	2025-11-03 20:25:50
\.


--
-- Data for Name: dim_technician_role_scd2; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_technician_role_scd2 (sk_technician_role, badgenumber, rolelevel, category, rolename, effective_from, effective_to, is_current, top_certification_level, etl_load_timestamp) FROM stdin;
1	EMP001	2	Software	Device Programmer	2023-01-01	2023-05-20	f	Entry	2025-11-03 20:25:50
2	EMP001	4	Software	Software Lead	2023-05-21	2023-11-15	f	Advanced	2025-11-03 20:25:50
3	EMP001	2	Software	Device Programmer	2023-11-16	9999-12-31	t	Advanced	2025-11-03 20:25:50
4	EMP002	1	Calibration	Calibration Trainee	2023-01-01	2023-05-02	f	Entry	2025-11-03 20:25:50
5	EMP002	4	Calibration	Calibration Lead	2023-05-03	2023-08-03	f	Advanced	2025-11-03 20:25:50
6	EMP002	2	Calibration	Calibration Technician	2023-08-04	9999-12-31	t	Expert	2025-11-03 20:25:50
7	EMP003	3	Software	Firmware Specialist	2023-01-01	2023-04-22	f	Entry	2025-11-03 20:25:50
8	EMP003	2	Software	Device Programmer	2023-04-23	9999-12-31	t	Expert	2025-11-03 20:25:50
9	EMP004	1	Hardware	Hardware Assistant	2023-01-01	9999-12-31	t	Expert	2025-11-03 20:25:50
10	EMP005	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-04-10	f	Expert	2025-11-03 20:25:50
11	EMP005	4	Diagnostics	Diagnostics Lead	2023-04-11	2023-08-25	f	Entry	2025-11-03 20:25:50
12	EMP005	3	Diagnostics	Fault Analysis Specialist	2023-08-26	2024-01-23	f	Advanced	2025-11-03 20:25:50
13	EMP005	1	Diagnostics	Diagnostics Assistant	2024-01-24	9999-12-31	t	Entry	2025-11-03 20:25:50
14	EMP006	1	Hardware	Hardware Assistant	2023-01-01	9999-12-31	t	Advanced	2025-11-03 20:25:50
15	EMP007	1	Software	Software Assistant	2023-01-01	2023-05-05	f	Entry	2025-11-03 20:25:50
16	EMP007	3	Software	Firmware Specialist	2023-05-06	9999-12-31	t	Entry	2025-11-03 20:25:50
17	EMP008	2	Hardware	Hardware Technician	2023-01-01	2023-05-26	f	Entry	2025-11-03 20:25:50
18	EMP008	1	Hardware	Hardware Assistant	2023-05-27	9999-12-31	t	Entry	2025-11-03 20:25:50
19	EMP009	2	Calibration	Calibration Technician	2023-01-01	2023-04-14	f	Entry	2025-11-03 20:25:50
20	EMP009	4	Calibration	Calibration Lead	2023-04-15	2023-07-25	f	Entry	2025-11-03 20:25:50
21	EMP009	2	Calibration	Calibration Technician	2023-07-26	9999-12-31	t	Entry	2025-11-03 20:25:50
22	EMP010	4	Calibration	Calibration Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
23	EMP011	1	Hardware	Hardware Assistant	2023-01-01	2023-04-18	f	Entry	2025-11-03 20:25:50
24	EMP011	2	Hardware	Hardware Technician	2023-04-19	9999-12-31	t	Entry	2025-11-03 20:25:50
25	EMP012	4	Calibration	Calibration Lead	2023-01-01	2023-06-08	f	Entry	2025-11-03 20:25:50
26	EMP012	3	Calibration	Calibration Specialist	2023-06-09	2023-10-12	f	Entry	2025-11-03 20:25:50
27	EMP012	4	Calibration	Calibration Lead	2023-10-13	2024-01-14	f	Entry	2025-11-03 20:25:50
28	EMP012	1	Calibration	Calibration Trainee	2024-01-15	9999-12-31	t	Entry	2025-11-03 20:25:50
29	EMP013	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-04-18	f	Entry	2025-11-03 20:25:50
30	EMP013	1	Diagnostics	Diagnostics Assistant	2023-04-19	2023-07-23	f	Entry	2025-11-03 20:25:50
31	EMP013	4	Diagnostics	Diagnostics Lead	2023-07-24	2024-01-17	f	Entry	2025-11-03 20:25:50
32	EMP013	1	Diagnostics	Diagnostics Assistant	2024-01-18	9999-12-31	t	Entry	2025-11-03 20:25:50
33	EMP014	1	Calibration	Calibration Trainee	2023-01-01	2023-06-17	f	Entry	2025-11-03 20:25:50
34	EMP014	4	Calibration	Calibration Lead	2023-06-18	9999-12-31	t	Entry	2025-11-03 20:25:50
35	EMP015	2	Hardware	Hardware Technician	2023-01-01	2023-04-29	f	Entry	2025-11-03 20:25:50
36	EMP015	3	Hardware	Senior Hardware Technician	2023-04-30	2023-09-13	f	Entry	2025-11-03 20:25:50
37	EMP015	4	Hardware	Hardware Lead	2023-09-14	2024-02-09	f	Entry	2025-11-03 20:25:50
38	EMP015	3	Hardware	Senior Hardware Technician	2024-02-10	9999-12-31	t	Entry	2025-11-03 20:25:50
39	EMP016	1	Calibration	Calibration Trainee	2023-01-01	2023-06-25	f	Entry	2025-11-03 20:25:50
40	EMP016	3	Calibration	Calibration Specialist	2023-06-26	2023-12-02	f	Entry	2025-11-03 20:25:50
41	EMP016	1	Calibration	Calibration Trainee	2023-12-03	2024-05-28	f	Entry	2025-11-03 20:25:50
42	EMP016	2	Calibration	Calibration Technician	2024-05-29	9999-12-31	t	Entry	2025-11-03 20:25:50
43	EMP017	3	Calibration	Calibration Specialist	2023-01-01	2023-06-19	f	Entry	2025-11-03 20:25:50
44	EMP017	2	Calibration	Calibration Technician	2023-06-20	2023-10-25	f	Entry	2025-11-03 20:25:50
45	EMP017	3	Calibration	Calibration Specialist	2023-10-26	9999-12-31	t	Entry	2025-11-03 20:25:50
46	EMP018	2	Software	Device Programmer	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
47	EMP019	2	Hardware	Hardware Technician	2023-01-01	2023-04-24	f	Entry	2025-11-03 20:25:50
48	EMP019	3	Hardware	Senior Hardware Technician	2023-04-25	9999-12-31	t	Entry	2025-11-03 20:25:50
49	EMP020	2	Hardware	Hardware Technician	2023-01-01	2023-06-10	f	Entry	2025-11-03 20:25:50
50	EMP020	4	Hardware	Hardware Lead	2023-06-11	9999-12-31	t	Entry	2025-11-03 20:25:50
51	EMP021	3	Calibration	Calibration Specialist	2023-01-01	2023-04-16	f	Entry	2025-11-03 20:25:50
52	EMP021	1	Calibration	Calibration Trainee	2023-04-17	9999-12-31	t	Entry	2025-11-03 20:25:50
53	EMP022	4	Hardware	Hardware Lead	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
54	EMP022	3	Hardware	Senior Hardware Technician	2023-06-17	2023-10-09	f	Entry	2025-11-03 20:25:50
55	EMP022	4	Hardware	Hardware Lead	2023-10-10	2024-03-11	f	Entry	2025-11-03 20:25:50
56	EMP022	2	Hardware	Hardware Technician	2024-03-12	9999-12-31	t	Entry	2025-11-03 20:25:50
57	EMP023	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-04-04	f	Entry	2025-11-03 20:25:50
58	EMP023	1	Diagnostics	Diagnostics Assistant	2023-04-05	2023-09-17	f	Entry	2025-11-03 20:25:50
59	EMP023	4	Diagnostics	Diagnostics Lead	2023-09-18	9999-12-31	t	Entry	2025-11-03 20:25:50
60	EMP024	2	Software	Device Programmer	2023-01-01	2023-05-23	f	Entry	2025-11-03 20:25:50
61	EMP024	4	Software	Software Lead	2023-05-24	9999-12-31	t	Entry	2025-11-03 20:25:50
62	EMP025	3	Hardware	Senior Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
63	EMP026	3	Calibration	Calibration Specialist	2023-01-01	2023-05-07	f	Entry	2025-11-03 20:25:50
64	EMP026	1	Calibration	Calibration Trainee	2023-05-08	9999-12-31	t	Entry	2025-11-03 20:25:50
65	EMP027	2	Calibration	Calibration Technician	2023-01-01	2023-04-16	f	Entry	2025-11-03 20:25:50
66	EMP027	4	Calibration	Calibration Lead	2023-04-17	2023-08-20	f	Entry	2025-11-03 20:25:50
67	EMP027	3	Calibration	Calibration Specialist	2023-08-21	9999-12-31	t	Entry	2025-11-03 20:25:50
68	EMP028	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-06-02	f	Entry	2025-11-03 20:25:50
69	EMP028	3	Diagnostics	Fault Analysis Specialist	2023-06-03	2023-10-01	f	Entry	2025-11-03 20:25:50
70	EMP028	1	Diagnostics	Diagnostics Assistant	2023-10-02	2024-03-04	f	Entry	2025-11-03 20:25:50
71	EMP028	3	Diagnostics	Fault Analysis Specialist	2024-03-05	9999-12-31	t	Entry	2025-11-03 20:25:50
72	EMP029	4	Software	Software Lead	2023-01-01	2023-04-24	f	Entry	2025-11-03 20:25:50
73	EMP029	2	Software	Device Programmer	2023-04-25	2023-08-30	f	Entry	2025-11-03 20:25:50
74	EMP029	1	Software	Software Assistant	2023-08-31	2023-12-30	f	Entry	2025-11-03 20:25:50
75	EMP029	3	Software	Firmware Specialist	2023-12-31	9999-12-31	t	Entry	2025-11-03 20:25:50
76	EMP030	1	Calibration	Calibration Trainee	2023-01-01	2023-06-18	f	Entry	2025-11-03 20:25:50
77	EMP030	4	Calibration	Calibration Lead	2023-06-19	2023-12-16	f	Entry	2025-11-03 20:25:50
78	EMP030	3	Calibration	Calibration Specialist	2023-12-17	2024-03-19	f	Entry	2025-11-03 20:25:50
79	EMP030	4	Calibration	Calibration Lead	2024-03-20	9999-12-31	t	Entry	2025-11-03 20:25:50
80	EMP031	4	Calibration	Calibration Lead	2023-01-01	2023-05-12	f	Entry	2025-11-03 20:25:50
81	EMP031	2	Calibration	Calibration Technician	2023-05-13	9999-12-31	t	Entry	2025-11-03 20:25:50
82	EMP032	1	Calibration	Calibration Trainee	2023-01-01	2023-04-29	f	Entry	2025-11-03 20:25:50
83	EMP032	2	Calibration	Calibration Technician	2023-04-30	9999-12-31	t	Entry	2025-11-03 20:25:50
84	EMP033	1	Software	Software Assistant	2023-01-01	2023-06-23	f	Entry	2025-11-03 20:25:50
85	EMP033	4	Software	Software Lead	2023-06-24	2023-11-28	f	Entry	2025-11-03 20:25:50
86	EMP033	2	Software	Device Programmer	2023-11-29	2024-03-01	f	Entry	2025-11-03 20:25:50
87	EMP033	1	Software	Software Assistant	2024-03-02	9999-12-31	t	Entry	2025-11-03 20:25:50
88	EMP034	2	Hardware	Hardware Technician	2023-01-01	2023-05-20	f	Entry	2025-11-03 20:25:50
89	EMP034	4	Hardware	Hardware Lead	2023-05-21	2023-09-11	f	Entry	2025-11-03 20:25:50
90	EMP034	1	Hardware	Hardware Assistant	2023-09-12	9999-12-31	t	Entry	2025-11-03 20:25:50
91	EMP035	4	Software	Software Lead	2023-01-01	2023-04-09	f	Entry	2025-11-03 20:25:50
92	EMP035	3	Software	Firmware Specialist	2023-04-10	2023-09-15	f	Entry	2025-11-03 20:25:50
93	EMP035	4	Software	Software Lead	2023-09-16	9999-12-31	t	Entry	2025-11-03 20:25:50
94	EMP036	3	Software	Firmware Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
95	EMP037	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-04-12	f	Entry	2025-11-03 20:25:50
96	EMP037	3	Diagnostics	Fault Analysis Specialist	2023-04-13	9999-12-31	t	Entry	2025-11-03 20:25:50
97	EMP038	3	Hardware	Senior Hardware Technician	2023-01-01	2023-04-14	f	Entry	2025-11-03 20:25:50
98	EMP038	2	Hardware	Hardware Technician	2023-04-15	2023-09-01	f	Entry	2025-11-03 20:25:50
99	EMP038	1	Hardware	Hardware Assistant	2023-09-02	2024-02-08	f	Entry	2025-11-03 20:25:50
100	EMP038	3	Hardware	Senior Hardware Technician	2024-02-09	9999-12-31	t	Entry	2025-11-03 20:25:50
101	EMP039	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-04-11	f	Entry	2025-11-03 20:25:50
102	EMP039	1	Diagnostics	Diagnostics Assistant	2023-04-12	2023-08-27	f	Entry	2025-11-03 20:25:50
103	EMP039	3	Diagnostics	Fault Analysis Specialist	2023-08-28	2024-01-09	f	Entry	2025-11-03 20:25:50
104	EMP039	1	Diagnostics	Diagnostics Assistant	2024-01-10	9999-12-31	t	Entry	2025-11-03 20:25:50
105	EMP040	3	Software	Firmware Specialist	2023-01-01	2023-04-21	f	Entry	2025-11-03 20:25:50
106	EMP040	1	Software	Software Assistant	2023-04-22	2023-07-29	f	Entry	2025-11-03 20:25:50
107	EMP040	2	Software	Device Programmer	2023-07-30	2023-12-07	f	Entry	2025-11-03 20:25:50
108	EMP040	3	Software	Firmware Specialist	2023-12-08	9999-12-31	t	Entry	2025-11-03 20:25:50
109	EMP041	1	Diagnostics	Diagnostics Assistant	2023-01-01	2023-04-25	f	Entry	2025-11-03 20:25:50
110	EMP041	2	Diagnostics	Diagnostics Technician	2023-04-26	2023-09-17	f	Entry	2025-11-03 20:25:50
111	EMP041	4	Diagnostics	Diagnostics Lead	2023-09-18	9999-12-31	t	Entry	2025-11-03 20:25:50
112	EMP042	2	Hardware	Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
113	EMP043	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-04-22	f	Entry	2025-11-03 20:25:50
114	EMP043	2	Diagnostics	Diagnostics Technician	2023-04-23	2023-09-27	f	Entry	2025-11-03 20:25:50
115	EMP043	3	Diagnostics	Fault Analysis Specialist	2023-09-28	9999-12-31	t	Entry	2025-11-03 20:25:50
116	EMP044	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-06-13	f	Entry	2025-11-03 20:25:50
117	EMP044	4	Diagnostics	Diagnostics Lead	2023-06-14	2023-10-02	f	Entry	2025-11-03 20:25:50
118	EMP044	1	Diagnostics	Diagnostics Assistant	2023-10-03	2024-01-04	f	Entry	2025-11-03 20:25:50
119	EMP044	3	Diagnostics	Fault Analysis Specialist	2024-01-05	9999-12-31	t	Entry	2025-11-03 20:25:50
120	EMP045	3	Software	Firmware Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
121	EMP046	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-05-08	f	Entry	2025-11-03 20:25:50
122	EMP046	2	Diagnostics	Diagnostics Technician	2023-05-09	2023-09-12	f	Entry	2025-11-03 20:25:50
123	EMP046	1	Diagnostics	Diagnostics Assistant	2023-09-13	9999-12-31	t	Entry	2025-11-03 20:25:50
124	EMP047	3	Diagnostics	Fault Analysis Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
125	EMP048	1	Calibration	Calibration Trainee	2023-01-01	2023-05-18	f	Entry	2025-11-03 20:25:50
126	EMP048	4	Calibration	Calibration Lead	2023-05-19	9999-12-31	t	Entry	2025-11-03 20:25:50
127	EMP049	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
128	EMP049	3	Diagnostics	Fault Analysis Specialist	2023-06-17	9999-12-31	t	Entry	2025-11-03 20:25:50
129	EMP050	2	Calibration	Calibration Technician	2023-01-01	2023-04-05	f	Entry	2025-11-03 20:25:50
130	EMP050	1	Calibration	Calibration Trainee	2023-04-06	2023-07-12	f	Entry	2025-11-03 20:25:50
131	EMP050	3	Calibration	Calibration Specialist	2023-07-13	2023-12-28	f	Entry	2025-11-03 20:25:50
132	EMP050	2	Calibration	Calibration Technician	2023-12-29	9999-12-31	t	Entry	2025-11-03 20:25:50
133	EMP051	4	Software	Software Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
134	EMP052	4	Hardware	Hardware Lead	2023-01-01	2023-06-19	f	Entry	2025-11-03 20:25:50
135	EMP052	1	Hardware	Hardware Assistant	2023-06-20	2023-10-03	f	Entry	2025-11-03 20:25:50
136	EMP052	4	Hardware	Hardware Lead	2023-10-04	2024-02-22	f	Entry	2025-11-03 20:25:50
137	EMP052	2	Hardware	Hardware Technician	2024-02-23	9999-12-31	t	Entry	2025-11-03 20:25:50
138	EMP053	1	Hardware	Hardware Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
139	EMP054	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
140	EMP055	3	Calibration	Calibration Specialist	2023-01-01	2023-04-05	f	Entry	2025-11-03 20:25:50
141	EMP055	1	Calibration	Calibration Trainee	2023-04-06	2023-09-22	f	Entry	2025-11-03 20:25:50
142	EMP055	4	Calibration	Calibration Lead	2023-09-23	2024-03-13	f	Entry	2025-11-03 20:25:50
143	EMP055	1	Calibration	Calibration Trainee	2024-03-14	9999-12-31	t	Entry	2025-11-03 20:25:50
144	EMP056	3	Calibration	Calibration Specialist	2023-01-01	2023-05-31	f	Entry	2025-11-03 20:25:50
145	EMP056	1	Calibration	Calibration Trainee	2023-06-01	2023-10-16	f	Entry	2025-11-03 20:25:50
146	EMP056	4	Calibration	Calibration Lead	2023-10-17	2024-03-30	f	Entry	2025-11-03 20:25:50
147	EMP056	1	Calibration	Calibration Trainee	2024-03-31	9999-12-31	t	Entry	2025-11-03 20:25:50
148	EMP057	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-04-24	f	Entry	2025-11-03 20:25:50
149	EMP057	4	Diagnostics	Diagnostics Lead	2023-04-25	9999-12-31	t	Entry	2025-11-03 20:25:50
150	EMP058	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-06-03	f	Entry	2025-11-03 20:25:50
151	EMP058	3	Diagnostics	Fault Analysis Specialist	2023-06-04	2023-09-13	f	Entry	2025-11-03 20:25:50
152	EMP058	1	Diagnostics	Diagnostics Assistant	2023-09-14	9999-12-31	t	Entry	2025-11-03 20:25:50
153	EMP059	1	Software	Software Assistant	2023-01-01	2023-06-24	f	Entry	2025-11-03 20:25:50
154	EMP059	2	Software	Device Programmer	2023-06-25	9999-12-31	t	Entry	2025-11-03 20:25:50
155	EMP060	3	Diagnostics	Fault Analysis Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
156	EMP061	2	Software	Device Programmer	2023-01-01	2023-05-03	f	Entry	2025-11-03 20:25:50
157	EMP061	1	Software	Software Assistant	2023-05-04	9999-12-31	t	Entry	2025-11-03 20:25:50
158	EMP062	1	Diagnostics	Diagnostics Assistant	2023-01-01	2023-06-03	f	Entry	2025-11-03 20:25:50
159	EMP062	2	Diagnostics	Diagnostics Technician	2023-06-04	9999-12-31	t	Entry	2025-11-03 20:25:50
160	EMP063	1	Hardware	Hardware Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
161	EMP064	1	Software	Software Assistant	2023-01-01	2023-04-26	f	Entry	2025-11-03 20:25:50
162	EMP064	3	Software	Firmware Specialist	2023-04-27	2023-09-10	f	Entry	2025-11-03 20:25:50
163	EMP064	1	Software	Software Assistant	2023-09-11	9999-12-31	t	Entry	2025-11-03 20:25:50
164	EMP065	3	Software	Firmware Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
165	EMP066	1	Software	Software Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
166	EMP067	2	Calibration	Calibration Technician	2023-01-01	2023-06-09	f	Entry	2025-11-03 20:25:50
167	EMP067	1	Calibration	Calibration Trainee	2023-06-10	9999-12-31	t	Entry	2025-11-03 20:25:50
168	EMP068	2	Calibration	Calibration Technician	2023-01-01	2023-05-08	f	Entry	2025-11-03 20:25:50
169	EMP068	1	Calibration	Calibration Trainee	2023-05-09	2023-09-20	f	Entry	2025-11-03 20:25:50
170	EMP068	4	Calibration	Calibration Lead	2023-09-21	9999-12-31	t	Entry	2025-11-03 20:25:50
171	EMP069	3	Calibration	Calibration Specialist	2023-01-01	2023-05-28	f	Entry	2025-11-03 20:25:50
172	EMP069	2	Calibration	Calibration Technician	2023-05-29	2023-10-10	f	Entry	2025-11-03 20:25:50
173	EMP069	3	Calibration	Calibration Specialist	2023-10-11	2024-03-28	f	Entry	2025-11-03 20:25:50
174	EMP069	2	Calibration	Calibration Technician	2024-03-29	9999-12-31	t	Entry	2025-11-03 20:25:50
175	EMP070	1	Hardware	Hardware Assistant	2023-01-01	2023-05-28	f	Entry	2025-11-03 20:25:50
176	EMP070	2	Hardware	Hardware Technician	2023-05-29	9999-12-31	t	Entry	2025-11-03 20:25:50
177	EMP071	4	Calibration	Calibration Lead	2023-01-01	2023-05-29	f	Entry	2025-11-03 20:25:50
178	EMP071	1	Calibration	Calibration Trainee	2023-05-30	2023-10-28	f	Entry	2025-11-03 20:25:50
179	EMP071	3	Calibration	Calibration Specialist	2023-10-29	9999-12-31	t	Entry	2025-11-03 20:25:50
180	EMP072	3	Hardware	Senior Hardware Technician	2023-01-01	2023-04-11	f	Entry	2025-11-03 20:25:50
181	EMP072	1	Hardware	Hardware Assistant	2023-04-12	9999-12-31	t	Entry	2025-11-03 20:25:50
182	EMP073	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-05-01	f	Entry	2025-11-03 20:25:50
183	EMP073	2	Diagnostics	Diagnostics Technician	2023-05-02	2023-08-27	f	Entry	2025-11-03 20:25:50
184	EMP073	1	Diagnostics	Diagnostics Assistant	2023-08-28	9999-12-31	t	Entry	2025-11-03 20:25:50
185	EMP074	1	Calibration	Calibration Trainee	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
186	EMP074	4	Calibration	Calibration Lead	2023-06-17	2023-11-18	f	Entry	2025-11-03 20:25:50
187	EMP074	2	Calibration	Calibration Technician	2023-11-19	2024-03-17	f	Entry	2025-11-03 20:25:50
188	EMP074	4	Calibration	Calibration Lead	2024-03-18	9999-12-31	t	Entry	2025-11-03 20:25:50
189	EMP075	2	Calibration	Calibration Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
190	EMP076	1	Software	Software Assistant	2023-01-01	2023-04-03	f	Entry	2025-11-03 20:25:50
191	EMP076	3	Software	Firmware Specialist	2023-04-04	2023-09-17	f	Entry	2025-11-03 20:25:50
192	EMP076	1	Software	Software Assistant	2023-09-18	2024-01-10	f	Entry	2025-11-03 20:25:50
193	EMP076	3	Software	Firmware Specialist	2024-01-11	9999-12-31	t	Entry	2025-11-03 20:25:50
194	EMP077	2	Calibration	Calibration Technician	2023-01-01	2023-05-24	f	Entry	2025-11-03 20:25:50
195	EMP077	3	Calibration	Calibration Specialist	2023-05-25	2023-09-29	f	Entry	2025-11-03 20:25:50
196	EMP077	2	Calibration	Calibration Technician	2023-09-30	9999-12-31	t	Entry	2025-11-03 20:25:50
197	EMP078	4	Hardware	Hardware Lead	2023-01-01	2023-05-09	f	Entry	2025-11-03 20:25:50
198	EMP078	1	Hardware	Hardware Assistant	2023-05-10	2023-09-21	f	Entry	2025-11-03 20:25:50
199	EMP078	2	Hardware	Hardware Technician	2023-09-22	2024-03-17	f	Entry	2025-11-03 20:25:50
200	EMP078	4	Hardware	Hardware Lead	2024-03-18	9999-12-31	t	Entry	2025-11-03 20:25:50
201	EMP079	3	Hardware	Senior Hardware Technician	2023-01-01	2023-06-13	f	Entry	2025-11-03 20:25:50
202	EMP079	2	Hardware	Hardware Technician	2023-06-14	9999-12-31	t	Entry	2025-11-03 20:25:50
203	EMP080	1	Calibration	Calibration Trainee	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
204	EMP081	3	Calibration	Calibration Specialist	2023-01-01	2023-04-22	f	Entry	2025-11-03 20:25:50
205	EMP081	4	Calibration	Calibration Lead	2023-04-23	2023-09-28	f	Entry	2025-11-03 20:25:50
206	EMP081	2	Calibration	Calibration Technician	2023-09-29	2024-01-14	f	Entry	2025-11-03 20:25:50
207	EMP081	3	Calibration	Calibration Specialist	2024-01-15	9999-12-31	t	Entry	2025-11-03 20:25:50
208	EMP082	2	Hardware	Hardware Technician	2023-01-01	2023-06-01	f	Entry	2025-11-03 20:25:50
209	EMP082	4	Hardware	Hardware Lead	2023-06-02	2023-09-02	f	Entry	2025-11-03 20:25:50
210	EMP082	1	Hardware	Hardware Assistant	2023-09-03	2023-12-26	f	Entry	2025-11-03 20:25:50
211	EMP082	2	Hardware	Hardware Technician	2023-12-27	9999-12-31	t	Entry	2025-11-03 20:25:50
212	EMP083	1	Hardware	Hardware Assistant	2023-01-01	2023-06-25	f	Entry	2025-11-03 20:25:50
213	EMP083	3	Hardware	Senior Hardware Technician	2023-06-26	2023-12-17	f	Entry	2025-11-03 20:25:50
214	EMP083	4	Hardware	Hardware Lead	2023-12-18	9999-12-31	t	Entry	2025-11-03 20:25:50
215	EMP084	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
216	EMP085	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-05-18	f	Entry	2025-11-03 20:25:50
217	EMP085	1	Diagnostics	Diagnostics Assistant	2023-05-19	2023-08-25	f	Entry	2025-11-03 20:25:50
218	EMP085	4	Diagnostics	Diagnostics Lead	2023-08-26	9999-12-31	t	Entry	2025-11-03 20:25:50
219	EMP086	1	Hardware	Hardware Assistant	2023-01-01	2023-05-26	f	Entry	2025-11-03 20:25:50
220	EMP086	4	Hardware	Hardware Lead	2023-05-27	9999-12-31	t	Entry	2025-11-03 20:25:50
221	EMP087	1	Hardware	Hardware Assistant	2023-01-01	2023-06-30	f	Entry	2025-11-03 20:25:50
222	EMP087	3	Hardware	Senior Hardware Technician	2023-07-01	2023-10-15	f	Entry	2025-11-03 20:25:50
223	EMP087	1	Hardware	Hardware Assistant	2023-10-16	2024-03-22	f	Entry	2025-11-03 20:25:50
224	EMP087	4	Hardware	Hardware Lead	2024-03-23	9999-12-31	t	Entry	2025-11-03 20:25:50
225	EMP088	4	Calibration	Calibration Lead	2023-01-01	2023-04-07	f	Entry	2025-11-03 20:25:50
226	EMP088	3	Calibration	Calibration Specialist	2023-04-08	9999-12-31	t	Entry	2025-11-03 20:25:50
227	EMP089	2	Hardware	Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
228	EMP090	2	Software	Device Programmer	2023-01-01	2023-06-27	f	Entry	2025-11-03 20:25:50
229	EMP090	1	Software	Software Assistant	2023-06-28	2023-10-09	f	Entry	2025-11-03 20:25:50
230	EMP090	4	Software	Software Lead	2023-10-10	2024-02-26	f	Entry	2025-11-03 20:25:50
231	EMP090	1	Software	Software Assistant	2024-02-27	9999-12-31	t	Entry	2025-11-03 20:25:50
232	EMP091	1	Hardware	Hardware Assistant	2023-01-01	2023-04-23	f	Entry	2025-11-03 20:25:50
233	EMP091	2	Hardware	Hardware Technician	2023-04-24	9999-12-31	t	Entry	2025-11-03 20:25:50
234	EMP092	4	Hardware	Hardware Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
235	EMP093	3	Hardware	Senior Hardware Technician	2023-01-01	2023-05-04	f	Entry	2025-11-03 20:25:50
236	EMP093	1	Hardware	Hardware Assistant	2023-05-05	2023-08-26	f	Entry	2025-11-03 20:25:50
237	EMP093	3	Hardware	Senior Hardware Technician	2023-08-27	9999-12-31	t	Entry	2025-11-03 20:25:50
238	EMP094	1	Calibration	Calibration Trainee	2023-01-01	2023-05-30	f	Entry	2025-11-03 20:25:50
239	EMP094	3	Calibration	Calibration Specialist	2023-05-31	2023-10-12	f	Entry	2025-11-03 20:25:50
240	EMP094	1	Calibration	Calibration Trainee	2023-10-13	9999-12-31	t	Entry	2025-11-03 20:25:50
241	EMP095	1	Calibration	Calibration Trainee	2023-01-01	2023-04-09	f	Entry	2025-11-03 20:25:50
242	EMP095	2	Calibration	Calibration Technician	2023-04-10	2023-09-02	f	Entry	2025-11-03 20:25:50
243	EMP095	3	Calibration	Calibration Specialist	2023-09-03	9999-12-31	t	Entry	2025-11-03 20:25:50
244	EMP096	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-05-04	f	Entry	2025-11-03 20:25:50
245	EMP096	1	Diagnostics	Diagnostics Assistant	2023-05-05	2023-10-23	f	Entry	2025-11-03 20:25:50
246	EMP096	4	Diagnostics	Diagnostics Lead	2023-10-24	2024-03-31	f	Entry	2025-11-03 20:25:50
247	EMP096	2	Diagnostics	Diagnostics Technician	2024-04-01	9999-12-31	t	Entry	2025-11-03 20:25:50
248	EMP097	2	Calibration	Calibration Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
249	EMP098	2	Software	Device Programmer	2023-01-01	2023-05-28	f	Entry	2025-11-03 20:25:50
250	EMP098	4	Software	Software Lead	2023-05-29	2023-11-17	f	Entry	2025-11-03 20:25:50
251	EMP098	1	Software	Software Assistant	2023-11-18	9999-12-31	t	Entry	2025-11-03 20:25:50
252	EMP099	2	Calibration	Calibration Technician	2023-01-01	2023-04-09	f	Entry	2025-11-03 20:25:50
253	EMP099	4	Calibration	Calibration Lead	2023-04-10	9999-12-31	t	Entry	2025-11-03 20:25:50
254	EMP100	3	Software	Firmware Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
255	EMP101	4	Software	Software Lead	2023-01-01	2023-04-14	f	Entry	2025-11-03 20:25:50
256	EMP101	3	Software	Firmware Specialist	2023-04-15	9999-12-31	t	Entry	2025-11-03 20:25:50
257	EMP102	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-04-05	f	Entry	2025-11-03 20:25:50
258	EMP102	3	Diagnostics	Fault Analysis Specialist	2023-04-06	2023-09-23	f	Entry	2025-11-03 20:25:50
259	EMP102	1	Diagnostics	Diagnostics Assistant	2023-09-24	9999-12-31	t	Entry	2025-11-03 20:25:50
260	EMP103	3	Calibration	Calibration Specialist	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
261	EMP103	2	Calibration	Calibration Technician	2023-06-17	2023-09-21	f	Entry	2025-11-03 20:25:50
262	EMP103	1	Calibration	Calibration Trainee	2023-09-22	9999-12-31	t	Entry	2025-11-03 20:25:50
263	EMP104	3	Software	Firmware Specialist	2023-01-01	2023-04-02	f	Entry	2025-11-03 20:25:50
264	EMP104	4	Software	Software Lead	2023-04-03	2023-09-14	f	Entry	2025-11-03 20:25:50
265	EMP104	1	Software	Software Assistant	2023-09-15	2024-02-21	f	Entry	2025-11-03 20:25:50
266	EMP104	3	Software	Firmware Specialist	2024-02-22	9999-12-31	t	Entry	2025-11-03 20:25:50
267	EMP105	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
268	EMP106	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-06-17	f	Entry	2025-11-03 20:25:50
269	EMP106	1	Diagnostics	Diagnostics Assistant	2023-06-18	2023-10-28	f	Entry	2025-11-03 20:25:50
270	EMP106	2	Diagnostics	Diagnostics Technician	2023-10-29	9999-12-31	t	Entry	2025-11-03 20:25:50
271	EMP107	2	Software	Device Programmer	2023-01-01	2023-04-08	f	Entry	2025-11-03 20:25:50
272	EMP107	1	Software	Software Assistant	2023-04-09	2023-09-18	f	Entry	2025-11-03 20:25:50
273	EMP107	2	Software	Device Programmer	2023-09-19	9999-12-31	t	Entry	2025-11-03 20:25:50
274	EMP108	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-04-28	f	Entry	2025-11-03 20:25:50
275	EMP108	2	Diagnostics	Diagnostics Technician	2023-04-29	2023-10-09	f	Entry	2025-11-03 20:25:50
276	EMP108	1	Diagnostics	Diagnostics Assistant	2023-10-10	2024-02-27	f	Entry	2025-11-03 20:25:50
277	EMP108	4	Diagnostics	Diagnostics Lead	2024-02-28	9999-12-31	t	Entry	2025-11-03 20:25:50
278	EMP109	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
279	EMP110	1	Diagnostics	Diagnostics Assistant	2023-01-01	2023-05-19	f	Entry	2025-11-03 20:25:50
280	EMP110	4	Diagnostics	Diagnostics Lead	2023-05-20	2023-08-23	f	Entry	2025-11-03 20:25:50
281	EMP110	2	Diagnostics	Diagnostics Technician	2023-08-24	2024-01-28	f	Entry	2025-11-03 20:25:50
282	EMP110	1	Diagnostics	Diagnostics Assistant	2024-01-29	9999-12-31	t	Entry	2025-11-03 20:25:50
283	EMP111	1	Calibration	Calibration Trainee	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
284	EMP111	4	Calibration	Calibration Lead	2023-06-17	2023-12-12	f	Entry	2025-11-03 20:25:50
285	EMP111	1	Calibration	Calibration Trainee	2023-12-13	2024-05-22	f	Entry	2025-11-03 20:25:50
286	EMP111	3	Calibration	Calibration Specialist	2024-05-23	9999-12-31	t	Entry	2025-11-03 20:25:50
287	EMP112	3	Hardware	Senior Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
288	EMP113	1	Software	Software Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
289	EMP114	2	Software	Device Programmer	2023-01-01	2023-04-27	f	Entry	2025-11-03 20:25:50
290	EMP114	3	Software	Firmware Specialist	2023-04-28	2023-10-19	f	Entry	2025-11-03 20:25:50
291	EMP114	4	Software	Software Lead	2023-10-20	9999-12-31	t	Entry	2025-11-03 20:25:50
292	EMP115	1	Calibration	Calibration Trainee	2023-01-01	2023-05-04	f	Entry	2025-11-03 20:25:50
293	EMP115	4	Calibration	Calibration Lead	2023-05-05	2023-08-17	f	Entry	2025-11-03 20:25:50
294	EMP115	2	Calibration	Calibration Technician	2023-08-18	2023-12-15	f	Entry	2025-11-03 20:25:50
295	EMP115	1	Calibration	Calibration Trainee	2023-12-16	9999-12-31	t	Entry	2025-11-03 20:25:50
296	EMP116	3	Calibration	Calibration Specialist	2023-01-01	2023-06-03	f	Entry	2025-11-03 20:25:50
297	EMP116	1	Calibration	Calibration Trainee	2023-06-04	9999-12-31	t	Entry	2025-11-03 20:25:50
298	EMP117	2	Software	Device Programmer	2023-01-01	2023-06-30	f	Entry	2025-11-03 20:25:50
299	EMP117	1	Software	Software Assistant	2023-07-01	2023-12-27	f	Entry	2025-11-03 20:25:50
300	EMP117	4	Software	Software Lead	2023-12-28	2024-04-23	f	Entry	2025-11-03 20:25:50
301	EMP117	3	Software	Firmware Specialist	2024-04-24	9999-12-31	t	Entry	2025-11-03 20:25:50
302	EMP118	4	Hardware	Hardware Lead	2023-01-01	2023-05-17	f	Entry	2025-11-03 20:25:50
303	EMP118	1	Hardware	Hardware Assistant	2023-05-18	2023-11-13	f	Entry	2025-11-03 20:25:50
304	EMP118	3	Hardware	Senior Hardware Technician	2023-11-14	9999-12-31	t	Entry	2025-11-03 20:25:50
305	EMP119	1	Diagnostics	Diagnostics Assistant	2023-01-01	2023-04-01	f	Entry	2025-11-03 20:25:50
306	EMP119	4	Diagnostics	Diagnostics Lead	2023-04-02	9999-12-31	t	Entry	2025-11-03 20:25:50
307	EMP120	4	Hardware	Hardware Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
308	EMP121	3	Calibration	Calibration Specialist	2023-01-01	2023-06-14	f	Entry	2025-11-03 20:25:50
309	EMP121	4	Calibration	Calibration Lead	2023-06-15	9999-12-31	t	Entry	2025-11-03 20:25:50
310	EMP122	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-05-31	f	Entry	2025-11-03 20:25:50
311	EMP122	4	Diagnostics	Diagnostics Lead	2023-06-01	9999-12-31	t	Entry	2025-11-03 20:25:50
312	EMP123	2	Calibration	Calibration Technician	2023-01-01	2023-05-25	f	Entry	2025-11-03 20:25:50
313	EMP123	1	Calibration	Calibration Trainee	2023-05-26	2023-10-01	f	Entry	2025-11-03 20:25:50
314	EMP123	4	Calibration	Calibration Lead	2023-10-02	2024-02-23	f	Entry	2025-11-03 20:25:50
315	EMP123	2	Calibration	Calibration Technician	2024-02-24	9999-12-31	t	Entry	2025-11-03 20:25:50
316	EMP124	2	Software	Device Programmer	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
317	EMP125	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-06-29	f	Entry	2025-11-03 20:25:50
318	EMP125	1	Diagnostics	Diagnostics Assistant	2023-06-30	2023-12-02	f	Entry	2025-11-03 20:25:50
319	EMP125	3	Diagnostics	Fault Analysis Specialist	2023-12-03	2024-03-30	f	Entry	2025-11-03 20:25:50
320	EMP125	2	Diagnostics	Diagnostics Technician	2024-03-31	9999-12-31	t	Entry	2025-11-03 20:25:50
321	EMP126	4	Hardware	Hardware Lead	2023-01-01	2023-05-29	f	Entry	2025-11-03 20:25:50
322	EMP126	3	Hardware	Senior Hardware Technician	2023-05-30	9999-12-31	t	Entry	2025-11-03 20:25:50
323	EMP127	2	Hardware	Hardware Technician	2023-01-01	2023-04-23	f	Entry	2025-11-03 20:25:50
324	EMP127	4	Hardware	Hardware Lead	2023-04-24	2023-10-06	f	Entry	2025-11-03 20:25:50
325	EMP127	1	Hardware	Hardware Assistant	2023-10-07	9999-12-31	t	Entry	2025-11-03 20:25:50
326	EMP128	3	Software	Firmware Specialist	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
327	EMP129	4	Calibration	Calibration Lead	2023-01-01	2023-05-01	f	Entry	2025-11-03 20:25:50
328	EMP129	2	Calibration	Calibration Technician	2023-05-02	2023-08-20	f	Entry	2025-11-03 20:25:50
329	EMP129	4	Calibration	Calibration Lead	2023-08-21	9999-12-31	t	Entry	2025-11-03 20:25:50
330	EMP130	1	Calibration	Calibration Trainee	2023-01-01	2023-05-24	f	Entry	2025-11-03 20:25:50
331	EMP130	4	Calibration	Calibration Lead	2023-05-25	9999-12-31	t	Entry	2025-11-03 20:25:50
332	EMP131	3	Software	Firmware Specialist	2023-01-01	2023-05-19	f	Entry	2025-11-03 20:25:50
333	EMP131	1	Software	Software Assistant	2023-05-20	2023-11-16	f	Entry	2025-11-03 20:25:50
334	EMP131	3	Software	Firmware Specialist	2023-11-17	9999-12-31	t	Entry	2025-11-03 20:25:50
335	EMP132	4	Software	Software Lead	2023-01-01	2023-05-23	f	Entry	2025-11-03 20:25:50
336	EMP132	3	Software	Firmware Specialist	2023-05-24	2023-09-27	f	Entry	2025-11-03 20:25:50
337	EMP132	4	Software	Software Lead	2023-09-28	2023-12-28	f	Entry	2025-11-03 20:25:50
338	EMP132	3	Software	Firmware Specialist	2023-12-29	9999-12-31	t	Entry	2025-11-03 20:25:50
339	EMP133	2	Hardware	Hardware Technician	2023-01-01	2023-04-17	f	Entry	2025-11-03 20:25:50
340	EMP133	1	Hardware	Hardware Assistant	2023-04-18	9999-12-31	t	Entry	2025-11-03 20:25:50
341	EMP134	2	Calibration	Calibration Technician	2023-01-01	2023-06-22	f	Entry	2025-11-03 20:25:50
342	EMP134	3	Calibration	Calibration Specialist	2023-06-23	2023-10-13	f	Entry	2025-11-03 20:25:50
343	EMP134	2	Calibration	Calibration Technician	2023-10-14	2024-02-02	f	Entry	2025-11-03 20:25:50
344	EMP134	1	Calibration	Calibration Trainee	2024-02-03	9999-12-31	t	Entry	2025-11-03 20:25:50
345	EMP135	2	Calibration	Calibration Technician	2023-01-01	2023-05-31	f	Entry	2025-11-03 20:25:50
346	EMP135	3	Calibration	Calibration Specialist	2023-06-01	2023-11-14	f	Entry	2025-11-03 20:25:50
347	EMP135	1	Calibration	Calibration Trainee	2023-11-15	9999-12-31	t	Entry	2025-11-03 20:25:50
348	EMP136	1	Hardware	Hardware Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
349	EMP137	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-06-26	f	Entry	2025-11-03 20:25:50
350	EMP137	1	Diagnostics	Diagnostics Assistant	2023-06-27	2023-10-14	f	Entry	2025-11-03 20:25:50
351	EMP137	4	Diagnostics	Diagnostics Lead	2023-10-15	9999-12-31	t	Entry	2025-11-03 20:25:50
352	EMP138	1	Calibration	Calibration Trainee	2023-01-01	2023-04-29	f	Entry	2025-11-03 20:25:50
353	EMP138	3	Calibration	Calibration Specialist	2023-04-30	2023-10-10	f	Entry	2025-11-03 20:25:50
354	EMP138	2	Calibration	Calibration Technician	2023-10-11	2024-03-08	f	Entry	2025-11-03 20:25:50
355	EMP138	3	Calibration	Calibration Specialist	2024-03-09	9999-12-31	t	Entry	2025-11-03 20:25:50
356	EMP139	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
357	EMP140	2	Hardware	Hardware Technician	2023-01-01	2023-06-04	f	Entry	2025-11-03 20:25:50
358	EMP140	4	Hardware	Hardware Lead	2023-06-05	2023-10-31	f	Entry	2025-11-03 20:25:50
359	EMP140	2	Hardware	Hardware Technician	2023-11-01	9999-12-31	t	Entry	2025-11-03 20:25:50
360	EMP141	4	Hardware	Hardware Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
361	EMP142	2	Software	Device Programmer	2023-01-01	2023-06-18	f	Entry	2025-11-03 20:25:50
362	EMP142	1	Software	Software Assistant	2023-06-19	2023-11-10	f	Entry	2025-11-03 20:25:50
363	EMP142	2	Software	Device Programmer	2023-11-11	2024-02-10	f	Entry	2025-11-03 20:25:50
364	EMP142	1	Software	Software Assistant	2024-02-11	9999-12-31	t	Entry	2025-11-03 20:25:50
365	EMP143	4	Calibration	Calibration Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
366	EMP144	3	Hardware	Senior Hardware Technician	2023-01-01	2023-04-15	f	Entry	2025-11-03 20:25:50
367	EMP144	1	Hardware	Hardware Assistant	2023-04-16	2023-08-15	f	Entry	2025-11-03 20:25:50
368	EMP144	4	Hardware	Hardware Lead	2023-08-16	9999-12-31	t	Entry	2025-11-03 20:25:50
369	EMP145	3	Hardware	Senior Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
370	EMP146	2	Software	Device Programmer	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
371	EMP147	2	Diagnostics	Diagnostics Technician	2023-01-01	2023-05-19	f	Entry	2025-11-03 20:25:50
372	EMP147	1	Diagnostics	Diagnostics Assistant	2023-05-20	2023-09-23	f	Entry	2025-11-03 20:25:50
373	EMP147	3	Diagnostics	Fault Analysis Specialist	2023-09-24	9999-12-31	t	Entry	2025-11-03 20:25:50
374	EMP148	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-05-17	f	Entry	2025-11-03 20:25:50
375	EMP148	2	Diagnostics	Diagnostics Technician	2023-05-18	2023-11-07	f	Entry	2025-11-03 20:25:50
376	EMP148	3	Diagnostics	Fault Analysis Specialist	2023-11-08	2024-03-03	f	Entry	2025-11-03 20:25:50
377	EMP148	4	Diagnostics	Diagnostics Lead	2024-03-04	9999-12-31	t	Entry	2025-11-03 20:25:50
378	EMP149	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-06-03	f	Entry	2025-11-03 20:25:50
379	EMP149	3	Diagnostics	Fault Analysis Specialist	2023-06-04	2023-10-06	f	Entry	2025-11-03 20:25:50
380	EMP149	1	Diagnostics	Diagnostics Assistant	2023-10-07	2024-02-23	f	Entry	2025-11-03 20:25:50
381	EMP149	2	Diagnostics	Diagnostics Technician	2024-02-24	9999-12-31	t	Entry	2025-11-03 20:25:50
382	EMP150	3	Hardware	Senior Hardware Technician	2023-01-01	2023-04-12	f	Entry	2025-11-03 20:25:50
383	EMP150	1	Hardware	Hardware Assistant	2023-04-13	2023-10-04	f	Entry	2025-11-03 20:25:50
384	EMP150	2	Hardware	Hardware Technician	2023-10-05	2024-01-09	f	Entry	2025-11-03 20:25:50
385	EMP150	4	Hardware	Hardware Lead	2024-01-10	9999-12-31	t	Entry	2025-11-03 20:25:50
386	EMP151	2	Software	Device Programmer	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
387	EMP152	1	Software	Software Assistant	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
388	EMP153	1	Calibration	Calibration Trainee	2023-01-01	2023-06-20	f	Entry	2025-11-03 20:25:50
389	EMP153	4	Calibration	Calibration Lead	2023-06-21	2023-11-06	f	Entry	2025-11-03 20:25:50
390	EMP153	2	Calibration	Calibration Technician	2023-11-07	9999-12-31	t	Entry	2025-11-03 20:25:50
391	EMP154	1	Software	Software Assistant	2023-01-01	2023-06-04	f	Entry	2025-11-03 20:25:50
392	EMP154	2	Software	Device Programmer	2023-06-05	2023-09-25	f	Entry	2025-11-03 20:25:50
393	EMP154	3	Software	Firmware Specialist	2023-09-26	9999-12-31	t	Entry	2025-11-03 20:25:50
394	EMP155	4	Diagnostics	Diagnostics Lead	2023-01-01	2023-05-07	f	Entry	2025-11-03 20:25:50
395	EMP155	1	Diagnostics	Diagnostics Assistant	2023-05-08	2023-08-29	f	Entry	2025-11-03 20:25:50
396	EMP155	3	Diagnostics	Fault Analysis Specialist	2023-08-30	9999-12-31	t	Entry	2025-11-03 20:25:50
397	EMP156	1	Hardware	Hardware Assistant	2023-01-01	2023-05-31	f	Entry	2025-11-03 20:25:50
398	EMP156	3	Hardware	Senior Hardware Technician	2023-06-01	2023-10-10	f	Entry	2025-11-03 20:25:50
399	EMP156	4	Hardware	Hardware Lead	2023-10-11	2024-02-24	f	Entry	2025-11-03 20:25:50
400	EMP156	3	Hardware	Senior Hardware Technician	2024-02-25	9999-12-31	t	Entry	2025-11-03 20:25:50
401	EMP157	4	Hardware	Hardware Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
402	EMP158	2	Calibration	Calibration Technician	2023-01-01	2023-04-05	f	Entry	2025-11-03 20:25:50
403	EMP158	4	Calibration	Calibration Lead	2023-04-06	2023-09-30	f	Entry	2025-11-03 20:25:50
404	EMP158	1	Calibration	Calibration Trainee	2023-10-01	9999-12-31	t	Entry	2025-11-03 20:25:50
405	EMP159	1	Diagnostics	Diagnostics Assistant	2023-01-01	2023-06-22	f	Entry	2025-11-03 20:25:50
406	EMP159	4	Diagnostics	Diagnostics Lead	2023-06-23	2023-10-14	f	Entry	2025-11-03 20:25:50
407	EMP159	2	Diagnostics	Diagnostics Technician	2023-10-15	2024-02-20	f	Entry	2025-11-03 20:25:50
408	EMP159	1	Diagnostics	Diagnostics Assistant	2024-02-21	9999-12-31	t	Entry	2025-11-03 20:25:50
409	EMP160	4	Hardware	Hardware Lead	2023-01-01	2023-05-20	f	Entry	2025-11-03 20:25:50
410	EMP160	3	Hardware	Senior Hardware Technician	2023-05-21	2023-08-23	f	Entry	2025-11-03 20:25:50
411	EMP160	1	Hardware	Hardware Assistant	2023-08-24	9999-12-31	t	Entry	2025-11-03 20:25:50
412	EMP161	2	Diagnostics	Diagnostics Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
413	EMP162	3	Hardware	Senior Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
414	EMP163	1	Software	Software Assistant	2023-01-01	2023-04-07	f	Entry	2025-11-03 20:25:50
415	EMP163	4	Software	Software Lead	2023-04-08	2023-07-29	f	Entry	2025-11-03 20:25:50
416	EMP163	3	Software	Firmware Specialist	2023-07-30	9999-12-31	t	Entry	2025-11-03 20:25:50
417	EMP164	3	Hardware	Senior Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
418	EMP165	2	Diagnostics	Diagnostics Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
419	EMP166	1	Software	Software Assistant	2023-01-01	2023-05-24	f	Entry	2025-11-03 20:25:50
420	EMP166	2	Software	Device Programmer	2023-05-25	2023-10-31	f	Entry	2025-11-03 20:25:50
421	EMP166	4	Software	Software Lead	2023-11-01	9999-12-31	t	Entry	2025-11-03 20:25:50
422	EMP167	2	Software	Device Programmer	2023-01-01	2023-05-24	f	Entry	2025-11-03 20:25:50
423	EMP167	1	Software	Software Assistant	2023-05-25	2023-08-28	f	Entry	2025-11-03 20:25:50
424	EMP167	4	Software	Software Lead	2023-08-29	9999-12-31	t	Entry	2025-11-03 20:25:50
425	EMP168	4	Hardware	Hardware Lead	2023-01-01	2023-05-26	f	Entry	2025-11-03 20:25:50
426	EMP168	3	Hardware	Senior Hardware Technician	2023-05-27	9999-12-31	t	Entry	2025-11-03 20:25:50
427	EMP169	4	Software	Software Lead	2023-01-01	2023-06-09	f	Entry	2025-11-03 20:25:50
428	EMP169	2	Software	Device Programmer	2023-06-10	2023-11-10	f	Entry	2025-11-03 20:25:50
429	EMP169	3	Software	Firmware Specialist	2023-11-11	2024-02-14	f	Entry	2025-11-03 20:25:50
430	EMP169	1	Software	Software Assistant	2024-02-15	9999-12-31	t	Entry	2025-11-03 20:25:50
431	EMP170	2	Hardware	Hardware Technician	2023-01-01	2023-05-25	f	Entry	2025-11-03 20:25:50
432	EMP170	1	Hardware	Hardware Assistant	2023-05-26	9999-12-31	t	Entry	2025-11-03 20:25:50
433	EMP171	4	Calibration	Calibration Lead	2023-01-01	2023-05-18	f	Entry	2025-11-03 20:25:50
434	EMP171	3	Calibration	Calibration Specialist	2023-05-19	2023-09-18	f	Entry	2025-11-03 20:25:50
435	EMP171	4	Calibration	Calibration Lead	2023-09-19	2023-12-28	f	Entry	2025-11-03 20:25:50
436	EMP171	1	Calibration	Calibration Trainee	2023-12-29	9999-12-31	t	Entry	2025-11-03 20:25:50
437	EMP172	4	Software	Software Lead	2023-01-01	2023-05-05	f	Entry	2025-11-03 20:25:50
438	EMP172	2	Software	Device Programmer	2023-05-06	9999-12-31	t	Entry	2025-11-03 20:25:50
439	EMP173	4	Calibration	Calibration Lead	2023-01-01	2023-06-12	f	Entry	2025-11-03 20:25:50
440	EMP173	3	Calibration	Calibration Specialist	2023-06-13	9999-12-31	t	Entry	2025-11-03 20:25:50
441	EMP174	1	Calibration	Calibration Trainee	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
442	EMP175	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-05-12	f	Entry	2025-11-03 20:25:50
443	EMP175	4	Diagnostics	Diagnostics Lead	2023-05-13	2023-10-23	f	Entry	2025-11-03 20:25:50
444	EMP175	3	Diagnostics	Fault Analysis Specialist	2023-10-24	9999-12-31	t	Entry	2025-11-03 20:25:50
445	EMP176	3	Calibration	Calibration Specialist	2023-01-01	2023-04-14	f	Entry	2025-11-03 20:25:50
446	EMP176	4	Calibration	Calibration Lead	2023-04-15	9999-12-31	t	Entry	2025-11-03 20:25:50
447	EMP177	1	Calibration	Calibration Trainee	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
448	EMP178	2	Calibration	Calibration Technician	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
449	EMP178	4	Calibration	Calibration Lead	2023-06-17	2023-10-12	f	Entry	2025-11-03 20:25:50
450	EMP178	2	Calibration	Calibration Technician	2023-10-13	9999-12-31	t	Entry	2025-11-03 20:25:50
451	EMP179	3	Diagnostics	Fault Analysis Specialist	2023-01-01	2023-05-01	f	Entry	2025-11-03 20:25:50
452	EMP179	4	Diagnostics	Diagnostics Lead	2023-05-02	2023-09-03	f	Entry	2025-11-03 20:25:50
453	EMP179	1	Diagnostics	Diagnostics Assistant	2023-09-04	9999-12-31	t	Entry	2025-11-03 20:25:50
454	EMP180	1	Calibration	Calibration Trainee	2023-01-01	2023-05-09	f	Entry	2025-11-03 20:25:50
455	EMP180	3	Calibration	Calibration Specialist	2023-05-10	2023-09-26	f	Entry	2025-11-03 20:25:50
456	EMP180	2	Calibration	Calibration Technician	2023-09-27	9999-12-31	t	Entry	2025-11-03 20:25:50
457	EMP181	2	Calibration	Calibration Technician	2023-01-01	2023-04-19	f	Entry	2025-11-03 20:25:50
458	EMP181	4	Calibration	Calibration Lead	2023-04-20	9999-12-31	t	Entry	2025-11-03 20:25:50
459	EMP182	4	Calibration	Calibration Lead	2023-01-01	2023-04-20	f	Entry	2025-11-03 20:25:50
460	EMP182	1	Calibration	Calibration Trainee	2023-04-21	2023-08-21	f	Entry	2025-11-03 20:25:50
461	EMP182	3	Calibration	Calibration Specialist	2023-08-22	9999-12-31	t	Entry	2025-11-03 20:25:50
462	EMP183	2	Calibration	Calibration Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
463	EMP184	2	Hardware	Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
464	EMP185	1	Software	Software Assistant	2023-01-01	2023-04-04	f	Entry	2025-11-03 20:25:50
465	EMP185	3	Software	Firmware Specialist	2023-04-05	2023-08-24	f	Entry	2025-11-03 20:25:50
466	EMP185	1	Software	Software Assistant	2023-08-25	2024-01-19	f	Entry	2025-11-03 20:25:50
467	EMP185	2	Software	Device Programmer	2024-01-20	9999-12-31	t	Entry	2025-11-03 20:25:50
468	EMP186	3	Software	Firmware Specialist	2023-01-01	2023-04-24	f	Entry	2025-11-03 20:25:50
469	EMP186	4	Software	Software Lead	2023-04-25	2023-09-03	f	Entry	2025-11-03 20:25:50
470	EMP186	1	Software	Software Assistant	2023-09-04	2024-01-13	f	Entry	2025-11-03 20:25:50
471	EMP186	2	Software	Device Programmer	2024-01-14	9999-12-31	t	Entry	2025-11-03 20:25:50
472	EMP187	4	Diagnostics	Diagnostics Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
473	EMP188	4	Software	Software Lead	2023-01-01	2023-05-10	f	Entry	2025-11-03 20:25:50
474	EMP188	2	Software	Device Programmer	2023-05-11	2023-11-04	f	Entry	2025-11-03 20:25:50
475	EMP188	4	Software	Software Lead	2023-11-05	2024-04-26	f	Entry	2025-11-03 20:25:50
476	EMP188	1	Software	Software Assistant	2024-04-27	9999-12-31	t	Entry	2025-11-03 20:25:50
477	EMP189	2	Hardware	Hardware Technician	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
478	EMP190	1	Hardware	Hardware Assistant	2023-01-01	2023-05-26	f	Entry	2025-11-03 20:25:50
479	EMP190	4	Hardware	Hardware Lead	2023-05-27	9999-12-31	t	Entry	2025-11-03 20:25:50
480	EMP191	4	Hardware	Hardware Lead	2023-01-01	9999-12-31	t	Entry	2025-11-03 20:25:50
481	EMP192	1	Software	Software Assistant	2023-01-01	2023-06-16	f	Entry	2025-11-03 20:25:50
482	EMP192	2	Software	Device Programmer	2023-06-17	2023-10-04	f	Entry	2025-11-03 20:25:50
483	EMP192	4	Software	Software Lead	2023-10-05	2024-01-13	f	Entry	2025-11-03 20:25:50
484	EMP192	1	Software	Software Assistant	2024-01-14	9999-12-31	t	Entry	2025-11-03 20:25:50
\.


--
-- Data for Name: dim_timeday; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.dim_timeday (id, fulldate, day_of_month, month_num, month_name, quarter_num, year_num, etl_load_timestamp) FROM stdin;
1	2021-01-01	1	1	January  	1	2021	2025-11-03 20:25:50
2	2021-01-02	2	1	January  	1	2021	2025-11-03 20:25:50
3	2021-01-03	3	1	January  	1	2021	2025-11-03 20:25:50
4	2021-01-04	4	1	January  	1	2021	2025-11-03 20:25:50
5	2021-01-05	5	1	January  	1	2021	2025-11-03 20:25:50
6	2021-01-06	6	1	January  	1	2021	2025-11-03 20:25:50
7	2021-01-07	7	1	January  	1	2021	2025-11-03 20:25:50
8	2021-01-08	8	1	January  	1	2021	2025-11-03 20:25:50
9	2021-01-09	9	1	January  	1	2021	2025-11-03 20:25:50
10	2021-01-10	10	1	January  	1	2021	2025-11-03 20:25:50
11	2021-01-11	11	1	January  	1	2021	2025-11-03 20:25:50
12	2021-01-12	12	1	January  	1	2021	2025-11-03 20:25:50
13	2021-01-13	13	1	January  	1	2021	2025-11-03 20:25:50
14	2021-01-14	14	1	January  	1	2021	2025-11-03 20:25:50
15	2021-01-15	15	1	January  	1	2021	2025-11-03 20:25:50
16	2021-01-16	16	1	January  	1	2021	2025-11-03 20:25:50
17	2021-01-17	17	1	January  	1	2021	2025-11-03 20:25:50
18	2021-01-18	18	1	January  	1	2021	2025-11-03 20:25:50
19	2021-01-19	19	1	January  	1	2021	2025-11-03 20:25:50
20	2021-01-20	20	1	January  	1	2021	2025-11-03 20:25:50
21	2021-01-21	21	1	January  	1	2021	2025-11-03 20:25:50
22	2021-01-22	22	1	January  	1	2021	2025-11-03 20:25:50
23	2021-01-23	23	1	January  	1	2021	2025-11-03 20:25:50
24	2021-01-24	24	1	January  	1	2021	2025-11-03 20:25:50
25	2021-01-25	25	1	January  	1	2021	2025-11-03 20:25:50
26	2021-01-26	26	1	January  	1	2021	2025-11-03 20:25:50
27	2021-01-27	27	1	January  	1	2021	2025-11-03 20:25:50
28	2021-01-28	28	1	January  	1	2021	2025-11-03 20:25:50
29	2021-01-29	29	1	January  	1	2021	2025-11-03 20:25:50
30	2021-01-30	30	1	January  	1	2021	2025-11-03 20:25:50
31	2021-01-31	31	1	January  	1	2021	2025-11-03 20:25:50
32	2021-02-01	1	2	February 	1	2021	2025-11-03 20:25:50
33	2021-02-02	2	2	February 	1	2021	2025-11-03 20:25:50
34	2021-02-03	3	2	February 	1	2021	2025-11-03 20:25:50
35	2021-02-04	4	2	February 	1	2021	2025-11-03 20:25:50
36	2021-02-05	5	2	February 	1	2021	2025-11-03 20:25:50
37	2021-02-06	6	2	February 	1	2021	2025-11-03 20:25:50
38	2021-02-07	7	2	February 	1	2021	2025-11-03 20:25:50
39	2021-02-08	8	2	February 	1	2021	2025-11-03 20:25:50
40	2021-02-09	9	2	February 	1	2021	2025-11-03 20:25:50
41	2021-02-10	10	2	February 	1	2021	2025-11-03 20:25:50
42	2021-02-11	11	2	February 	1	2021	2025-11-03 20:25:50
43	2021-02-12	12	2	February 	1	2021	2025-11-03 20:25:50
44	2021-02-13	13	2	February 	1	2021	2025-11-03 20:25:50
45	2021-02-14	14	2	February 	1	2021	2025-11-03 20:25:50
46	2021-02-15	15	2	February 	1	2021	2025-11-03 20:25:50
47	2021-02-16	16	2	February 	1	2021	2025-11-03 20:25:50
48	2021-02-17	17	2	February 	1	2021	2025-11-03 20:25:50
49	2021-02-18	18	2	February 	1	2021	2025-11-03 20:25:50
50	2021-02-19	19	2	February 	1	2021	2025-11-03 20:25:50
51	2021-02-20	20	2	February 	1	2021	2025-11-03 20:25:50
52	2021-02-21	21	2	February 	1	2021	2025-11-03 20:25:50
53	2021-02-22	22	2	February 	1	2021	2025-11-03 20:25:50
54	2021-02-23	23	2	February 	1	2021	2025-11-03 20:25:50
55	2021-02-24	24	2	February 	1	2021	2025-11-03 20:25:50
56	2021-02-25	25	2	February 	1	2021	2025-11-03 20:25:50
57	2021-02-26	26	2	February 	1	2021	2025-11-03 20:25:50
58	2021-02-27	27	2	February 	1	2021	2025-11-03 20:25:50
59	2021-02-28	28	2	February 	1	2021	2025-11-03 20:25:50
60	2021-03-01	1	3	March    	1	2021	2025-11-03 20:25:50
61	2021-03-02	2	3	March    	1	2021	2025-11-03 20:25:50
62	2021-03-03	3	3	March    	1	2021	2025-11-03 20:25:50
63	2021-03-04	4	3	March    	1	2021	2025-11-03 20:25:50
64	2021-03-05	5	3	March    	1	2021	2025-11-03 20:25:50
65	2021-03-06	6	3	March    	1	2021	2025-11-03 20:25:50
66	2021-03-07	7	3	March    	1	2021	2025-11-03 20:25:50
67	2021-03-08	8	3	March    	1	2021	2025-11-03 20:25:50
68	2021-03-09	9	3	March    	1	2021	2025-11-03 20:25:50
69	2021-03-10	10	3	March    	1	2021	2025-11-03 20:25:50
70	2021-03-11	11	3	March    	1	2021	2025-11-03 20:25:50
71	2021-03-12	12	3	March    	1	2021	2025-11-03 20:25:50
72	2021-03-13	13	3	March    	1	2021	2025-11-03 20:25:50
73	2021-03-14	14	3	March    	1	2021	2025-11-03 20:25:50
74	2021-03-15	15	3	March    	1	2021	2025-11-03 20:25:50
75	2021-03-16	16	3	March    	1	2021	2025-11-03 20:25:50
76	2021-03-17	17	3	March    	1	2021	2025-11-03 20:25:50
77	2021-03-18	18	3	March    	1	2021	2025-11-03 20:25:50
78	2021-03-19	19	3	March    	1	2021	2025-11-03 20:25:50
79	2021-03-20	20	3	March    	1	2021	2025-11-03 20:25:50
80	2021-03-21	21	3	March    	1	2021	2025-11-03 20:25:50
81	2021-03-22	22	3	March    	1	2021	2025-11-03 20:25:50
82	2021-03-23	23	3	March    	1	2021	2025-11-03 20:25:50
83	2021-03-24	24	3	March    	1	2021	2025-11-03 20:25:50
84	2021-03-25	25	3	March    	1	2021	2025-11-03 20:25:50
85	2021-03-26	26	3	March    	1	2021	2025-11-03 20:25:50
86	2021-03-27	27	3	March    	1	2021	2025-11-03 20:25:50
87	2021-03-28	28	3	March    	1	2021	2025-11-03 20:25:50
88	2021-03-29	29	3	March    	1	2021	2025-11-03 20:25:50
89	2021-03-30	30	3	March    	1	2021	2025-11-03 20:25:50
90	2021-03-31	31	3	March    	1	2021	2025-11-03 20:25:50
91	2021-04-01	1	4	April    	2	2021	2025-11-03 20:25:50
92	2021-04-02	2	4	April    	2	2021	2025-11-03 20:25:50
93	2021-04-03	3	4	April    	2	2021	2025-11-03 20:25:50
94	2021-04-04	4	4	April    	2	2021	2025-11-03 20:25:50
95	2021-04-05	5	4	April    	2	2021	2025-11-03 20:25:50
96	2021-04-06	6	4	April    	2	2021	2025-11-03 20:25:50
97	2021-04-07	7	4	April    	2	2021	2025-11-03 20:25:50
98	2021-04-08	8	4	April    	2	2021	2025-11-03 20:25:50
99	2021-04-09	9	4	April    	2	2021	2025-11-03 20:25:50
100	2021-04-10	10	4	April    	2	2021	2025-11-03 20:25:50
101	2021-04-11	11	4	April    	2	2021	2025-11-03 20:25:50
102	2021-04-12	12	4	April    	2	2021	2025-11-03 20:25:50
103	2021-04-13	13	4	April    	2	2021	2025-11-03 20:25:50
104	2021-04-14	14	4	April    	2	2021	2025-11-03 20:25:50
105	2021-04-15	15	4	April    	2	2021	2025-11-03 20:25:50
106	2021-04-16	16	4	April    	2	2021	2025-11-03 20:25:50
107	2021-04-17	17	4	April    	2	2021	2025-11-03 20:25:50
108	2021-04-18	18	4	April    	2	2021	2025-11-03 20:25:50
109	2021-04-19	19	4	April    	2	2021	2025-11-03 20:25:50
110	2021-04-20	20	4	April    	2	2021	2025-11-03 20:25:50
111	2021-04-21	21	4	April    	2	2021	2025-11-03 20:25:50
112	2021-04-22	22	4	April    	2	2021	2025-11-03 20:25:50
113	2021-04-23	23	4	April    	2	2021	2025-11-03 20:25:50
114	2021-04-24	24	4	April    	2	2021	2025-11-03 20:25:50
115	2021-04-25	25	4	April    	2	2021	2025-11-03 20:25:50
116	2021-04-26	26	4	April    	2	2021	2025-11-03 20:25:50
117	2021-04-27	27	4	April    	2	2021	2025-11-03 20:25:50
118	2021-04-28	28	4	April    	2	2021	2025-11-03 20:25:50
119	2021-04-29	29	4	April    	2	2021	2025-11-03 20:25:50
120	2021-04-30	30	4	April    	2	2021	2025-11-03 20:25:50
121	2021-05-01	1	5	May      	2	2021	2025-11-03 20:25:50
122	2021-05-02	2	5	May      	2	2021	2025-11-03 20:25:50
123	2021-05-03	3	5	May      	2	2021	2025-11-03 20:25:50
124	2021-05-04	4	5	May      	2	2021	2025-11-03 20:25:50
125	2021-05-05	5	5	May      	2	2021	2025-11-03 20:25:50
126	2021-05-06	6	5	May      	2	2021	2025-11-03 20:25:50
127	2021-05-07	7	5	May      	2	2021	2025-11-03 20:25:50
128	2021-05-08	8	5	May      	2	2021	2025-11-03 20:25:50
129	2021-05-09	9	5	May      	2	2021	2025-11-03 20:25:50
130	2021-05-10	10	5	May      	2	2021	2025-11-03 20:25:50
131	2021-05-11	11	5	May      	2	2021	2025-11-03 20:25:50
132	2021-05-12	12	5	May      	2	2021	2025-11-03 20:25:50
133	2021-05-13	13	5	May      	2	2021	2025-11-03 20:25:50
134	2021-05-14	14	5	May      	2	2021	2025-11-03 20:25:50
135	2021-05-15	15	5	May      	2	2021	2025-11-03 20:25:50
136	2021-05-16	16	5	May      	2	2021	2025-11-03 20:25:50
137	2021-05-17	17	5	May      	2	2021	2025-11-03 20:25:50
138	2021-05-18	18	5	May      	2	2021	2025-11-03 20:25:50
139	2021-05-19	19	5	May      	2	2021	2025-11-03 20:25:50
140	2021-05-20	20	5	May      	2	2021	2025-11-03 20:25:50
141	2021-05-21	21	5	May      	2	2021	2025-11-03 20:25:50
142	2021-05-22	22	5	May      	2	2021	2025-11-03 20:25:50
143	2021-05-23	23	5	May      	2	2021	2025-11-03 20:25:50
144	2021-05-24	24	5	May      	2	2021	2025-11-03 20:25:50
145	2021-05-25	25	5	May      	2	2021	2025-11-03 20:25:50
146	2021-05-26	26	5	May      	2	2021	2025-11-03 20:25:50
147	2021-05-27	27	5	May      	2	2021	2025-11-03 20:25:50
148	2021-05-28	28	5	May      	2	2021	2025-11-03 20:25:50
149	2021-05-29	29	5	May      	2	2021	2025-11-03 20:25:50
150	2021-05-30	30	5	May      	2	2021	2025-11-03 20:25:50
151	2021-05-31	31	5	May      	2	2021	2025-11-03 20:25:50
152	2021-06-01	1	6	June     	2	2021	2025-11-03 20:25:50
153	2021-06-02	2	6	June     	2	2021	2025-11-03 20:25:50
154	2021-06-03	3	6	June     	2	2021	2025-11-03 20:25:50
155	2021-06-04	4	6	June     	2	2021	2025-11-03 20:25:50
156	2021-06-05	5	6	June     	2	2021	2025-11-03 20:25:50
157	2021-06-06	6	6	June     	2	2021	2025-11-03 20:25:50
158	2021-06-07	7	6	June     	2	2021	2025-11-03 20:25:50
159	2021-06-08	8	6	June     	2	2021	2025-11-03 20:25:50
160	2021-06-09	9	6	June     	2	2021	2025-11-03 20:25:50
161	2021-06-10	10	6	June     	2	2021	2025-11-03 20:25:50
162	2021-06-11	11	6	June     	2	2021	2025-11-03 20:25:50
163	2021-06-12	12	6	June     	2	2021	2025-11-03 20:25:50
164	2021-06-13	13	6	June     	2	2021	2025-11-03 20:25:50
165	2021-06-14	14	6	June     	2	2021	2025-11-03 20:25:50
166	2021-06-15	15	6	June     	2	2021	2025-11-03 20:25:50
167	2021-06-16	16	6	June     	2	2021	2025-11-03 20:25:50
168	2021-06-17	17	6	June     	2	2021	2025-11-03 20:25:50
169	2021-06-18	18	6	June     	2	2021	2025-11-03 20:25:50
170	2021-06-19	19	6	June     	2	2021	2025-11-03 20:25:50
171	2021-06-20	20	6	June     	2	2021	2025-11-03 20:25:50
172	2021-06-21	21	6	June     	2	2021	2025-11-03 20:25:50
173	2021-06-22	22	6	June     	2	2021	2025-11-03 20:25:50
174	2021-06-23	23	6	June     	2	2021	2025-11-03 20:25:50
175	2021-06-24	24	6	June     	2	2021	2025-11-03 20:25:50
176	2021-06-25	25	6	June     	2	2021	2025-11-03 20:25:50
177	2021-06-26	26	6	June     	2	2021	2025-11-03 20:25:50
178	2021-06-27	27	6	June     	2	2021	2025-11-03 20:25:50
179	2021-06-28	28	6	June     	2	2021	2025-11-03 20:25:50
180	2021-06-29	29	6	June     	2	2021	2025-11-03 20:25:50
181	2021-06-30	30	6	June     	2	2021	2025-11-03 20:25:50
182	2021-07-01	1	7	July     	3	2021	2025-11-03 20:25:50
183	2021-07-02	2	7	July     	3	2021	2025-11-03 20:25:50
184	2021-07-03	3	7	July     	3	2021	2025-11-03 20:25:50
185	2021-07-04	4	7	July     	3	2021	2025-11-03 20:25:50
186	2021-07-05	5	7	July     	3	2021	2025-11-03 20:25:50
187	2021-07-06	6	7	July     	3	2021	2025-11-03 20:25:50
188	2021-07-07	7	7	July     	3	2021	2025-11-03 20:25:50
189	2021-07-08	8	7	July     	3	2021	2025-11-03 20:25:50
190	2021-07-09	9	7	July     	3	2021	2025-11-03 20:25:50
191	2021-07-10	10	7	July     	3	2021	2025-11-03 20:25:50
192	2021-07-11	11	7	July     	3	2021	2025-11-03 20:25:50
193	2021-07-12	12	7	July     	3	2021	2025-11-03 20:25:50
194	2021-07-13	13	7	July     	3	2021	2025-11-03 20:25:50
195	2021-07-14	14	7	July     	3	2021	2025-11-03 20:25:50
196	2021-07-15	15	7	July     	3	2021	2025-11-03 20:25:50
197	2021-07-16	16	7	July     	3	2021	2025-11-03 20:25:50
198	2021-07-17	17	7	July     	3	2021	2025-11-03 20:25:50
199	2021-07-18	18	7	July     	3	2021	2025-11-03 20:25:50
200	2021-07-19	19	7	July     	3	2021	2025-11-03 20:25:50
201	2021-07-20	20	7	July     	3	2021	2025-11-03 20:25:50
202	2021-07-21	21	7	July     	3	2021	2025-11-03 20:25:50
203	2021-07-22	22	7	July     	3	2021	2025-11-03 20:25:50
204	2021-07-23	23	7	July     	3	2021	2025-11-03 20:25:50
205	2021-07-24	24	7	July     	3	2021	2025-11-03 20:25:50
206	2021-07-25	25	7	July     	3	2021	2025-11-03 20:25:50
207	2021-07-26	26	7	July     	3	2021	2025-11-03 20:25:50
208	2021-07-27	27	7	July     	3	2021	2025-11-03 20:25:50
209	2021-07-28	28	7	July     	3	2021	2025-11-03 20:25:50
210	2021-07-29	29	7	July     	3	2021	2025-11-03 20:25:50
211	2021-07-30	30	7	July     	3	2021	2025-11-03 20:25:50
212	2021-07-31	31	7	July     	3	2021	2025-11-03 20:25:50
213	2021-08-01	1	8	August   	3	2021	2025-11-03 20:25:50
214	2021-08-02	2	8	August   	3	2021	2025-11-03 20:25:50
215	2021-08-03	3	8	August   	3	2021	2025-11-03 20:25:50
216	2021-08-04	4	8	August   	3	2021	2025-11-03 20:25:50
217	2021-08-05	5	8	August   	3	2021	2025-11-03 20:25:50
218	2021-08-06	6	8	August   	3	2021	2025-11-03 20:25:50
219	2021-08-07	7	8	August   	3	2021	2025-11-03 20:25:50
220	2021-08-08	8	8	August   	3	2021	2025-11-03 20:25:50
221	2021-08-09	9	8	August   	3	2021	2025-11-03 20:25:50
222	2021-08-10	10	8	August   	3	2021	2025-11-03 20:25:50
223	2021-08-11	11	8	August   	3	2021	2025-11-03 20:25:50
224	2021-08-12	12	8	August   	3	2021	2025-11-03 20:25:50
225	2021-08-13	13	8	August   	3	2021	2025-11-03 20:25:50
226	2021-08-14	14	8	August   	3	2021	2025-11-03 20:25:50
227	2021-08-15	15	8	August   	3	2021	2025-11-03 20:25:50
228	2021-08-16	16	8	August   	3	2021	2025-11-03 20:25:50
229	2021-08-17	17	8	August   	3	2021	2025-11-03 20:25:50
230	2021-08-18	18	8	August   	3	2021	2025-11-03 20:25:50
231	2021-08-19	19	8	August   	3	2021	2025-11-03 20:25:50
232	2021-08-20	20	8	August   	3	2021	2025-11-03 20:25:50
233	2021-08-21	21	8	August   	3	2021	2025-11-03 20:25:50
234	2021-08-22	22	8	August   	3	2021	2025-11-03 20:25:50
235	2021-08-23	23	8	August   	3	2021	2025-11-03 20:25:50
236	2021-08-24	24	8	August   	3	2021	2025-11-03 20:25:50
237	2021-08-25	25	8	August   	3	2021	2025-11-03 20:25:50
238	2021-08-26	26	8	August   	3	2021	2025-11-03 20:25:50
239	2021-08-27	27	8	August   	3	2021	2025-11-03 20:25:50
240	2021-08-28	28	8	August   	3	2021	2025-11-03 20:25:50
241	2021-08-29	29	8	August   	3	2021	2025-11-03 20:25:50
242	2021-08-30	30	8	August   	3	2021	2025-11-03 20:25:50
243	2021-08-31	31	8	August   	3	2021	2025-11-03 20:25:50
244	2021-09-01	1	9	September	3	2021	2025-11-03 20:25:50
245	2021-09-02	2	9	September	3	2021	2025-11-03 20:25:50
246	2021-09-03	3	9	September	3	2021	2025-11-03 20:25:50
247	2021-09-04	4	9	September	3	2021	2025-11-03 20:25:50
248	2021-09-05	5	9	September	3	2021	2025-11-03 20:25:50
249	2021-09-06	6	9	September	3	2021	2025-11-03 20:25:50
250	2021-09-07	7	9	September	3	2021	2025-11-03 20:25:50
251	2021-09-08	8	9	September	3	2021	2025-11-03 20:25:50
252	2021-09-09	9	9	September	3	2021	2025-11-03 20:25:50
253	2021-09-10	10	9	September	3	2021	2025-11-03 20:25:50
254	2021-09-11	11	9	September	3	2021	2025-11-03 20:25:50
255	2021-09-12	12	9	September	3	2021	2025-11-03 20:25:50
256	2021-09-13	13	9	September	3	2021	2025-11-03 20:25:50
257	2021-09-14	14	9	September	3	2021	2025-11-03 20:25:50
258	2021-09-15	15	9	September	3	2021	2025-11-03 20:25:50
259	2021-09-16	16	9	September	3	2021	2025-11-03 20:25:50
260	2021-09-17	17	9	September	3	2021	2025-11-03 20:25:50
261	2021-09-18	18	9	September	3	2021	2025-11-03 20:25:50
262	2021-09-19	19	9	September	3	2021	2025-11-03 20:25:50
263	2021-09-20	20	9	September	3	2021	2025-11-03 20:25:50
264	2021-09-21	21	9	September	3	2021	2025-11-03 20:25:50
265	2021-09-22	22	9	September	3	2021	2025-11-03 20:25:50
266	2021-09-23	23	9	September	3	2021	2025-11-03 20:25:50
267	2021-09-24	24	9	September	3	2021	2025-11-03 20:25:50
268	2021-09-25	25	9	September	3	2021	2025-11-03 20:25:50
269	2021-09-26	26	9	September	3	2021	2025-11-03 20:25:50
270	2021-09-27	27	9	September	3	2021	2025-11-03 20:25:50
271	2021-09-28	28	9	September	3	2021	2025-11-03 20:25:50
272	2021-09-29	29	9	September	3	2021	2025-11-03 20:25:50
273	2021-09-30	30	9	September	3	2021	2025-11-03 20:25:50
274	2021-10-01	1	10	October  	4	2021	2025-11-03 20:25:50
275	2021-10-02	2	10	October  	4	2021	2025-11-03 20:25:50
276	2021-10-03	3	10	October  	4	2021	2025-11-03 20:25:50
277	2021-10-04	4	10	October  	4	2021	2025-11-03 20:25:50
278	2021-10-05	5	10	October  	4	2021	2025-11-03 20:25:50
279	2021-10-06	6	10	October  	4	2021	2025-11-03 20:25:50
280	2021-10-07	7	10	October  	4	2021	2025-11-03 20:25:50
281	2021-10-08	8	10	October  	4	2021	2025-11-03 20:25:50
282	2021-10-09	9	10	October  	4	2021	2025-11-03 20:25:50
283	2021-10-10	10	10	October  	4	2021	2025-11-03 20:25:50
284	2021-10-11	11	10	October  	4	2021	2025-11-03 20:25:50
285	2021-10-12	12	10	October  	4	2021	2025-11-03 20:25:50
286	2021-10-13	13	10	October  	4	2021	2025-11-03 20:25:50
287	2021-10-14	14	10	October  	4	2021	2025-11-03 20:25:50
288	2021-10-15	15	10	October  	4	2021	2025-11-03 20:25:50
289	2021-10-16	16	10	October  	4	2021	2025-11-03 20:25:50
290	2021-10-17	17	10	October  	4	2021	2025-11-03 20:25:50
291	2021-10-18	18	10	October  	4	2021	2025-11-03 20:25:50
292	2021-10-19	19	10	October  	4	2021	2025-11-03 20:25:50
293	2021-10-20	20	10	October  	4	2021	2025-11-03 20:25:50
294	2021-10-21	21	10	October  	4	2021	2025-11-03 20:25:50
295	2021-10-22	22	10	October  	4	2021	2025-11-03 20:25:50
296	2021-10-23	23	10	October  	4	2021	2025-11-03 20:25:50
297	2021-10-24	24	10	October  	4	2021	2025-11-03 20:25:50
298	2021-10-25	25	10	October  	4	2021	2025-11-03 20:25:50
299	2021-10-26	26	10	October  	4	2021	2025-11-03 20:25:50
300	2021-10-27	27	10	October  	4	2021	2025-11-03 20:25:50
301	2021-10-28	28	10	October  	4	2021	2025-11-03 20:25:50
302	2021-10-29	29	10	October  	4	2021	2025-11-03 20:25:50
303	2021-10-30	30	10	October  	4	2021	2025-11-03 20:25:50
304	2021-10-31	31	10	October  	4	2021	2025-11-03 20:25:50
305	2021-11-01	1	11	November 	4	2021	2025-11-03 20:25:50
306	2021-11-02	2	11	November 	4	2021	2025-11-03 20:25:50
307	2021-11-03	3	11	November 	4	2021	2025-11-03 20:25:50
308	2021-11-04	4	11	November 	4	2021	2025-11-03 20:25:50
309	2021-11-05	5	11	November 	4	2021	2025-11-03 20:25:50
310	2021-11-06	6	11	November 	4	2021	2025-11-03 20:25:50
311	2021-11-07	7	11	November 	4	2021	2025-11-03 20:25:50
312	2021-11-08	8	11	November 	4	2021	2025-11-03 20:25:50
313	2021-11-09	9	11	November 	4	2021	2025-11-03 20:25:50
314	2021-11-10	10	11	November 	4	2021	2025-11-03 20:25:50
315	2021-11-11	11	11	November 	4	2021	2025-11-03 20:25:50
316	2021-11-12	12	11	November 	4	2021	2025-11-03 20:25:50
317	2021-11-13	13	11	November 	4	2021	2025-11-03 20:25:50
318	2021-11-14	14	11	November 	4	2021	2025-11-03 20:25:50
319	2021-11-15	15	11	November 	4	2021	2025-11-03 20:25:50
320	2021-11-16	16	11	November 	4	2021	2025-11-03 20:25:50
321	2021-11-17	17	11	November 	4	2021	2025-11-03 20:25:50
322	2021-11-18	18	11	November 	4	2021	2025-11-03 20:25:50
323	2021-11-19	19	11	November 	4	2021	2025-11-03 20:25:50
324	2021-11-20	20	11	November 	4	2021	2025-11-03 20:25:50
325	2021-11-21	21	11	November 	4	2021	2025-11-03 20:25:50
326	2021-11-22	22	11	November 	4	2021	2025-11-03 20:25:50
327	2021-11-23	23	11	November 	4	2021	2025-11-03 20:25:50
328	2021-11-24	24	11	November 	4	2021	2025-11-03 20:25:50
329	2021-11-25	25	11	November 	4	2021	2025-11-03 20:25:50
330	2021-11-26	26	11	November 	4	2021	2025-11-03 20:25:50
331	2021-11-27	27	11	November 	4	2021	2025-11-03 20:25:50
332	2021-11-28	28	11	November 	4	2021	2025-11-03 20:25:50
333	2021-11-29	29	11	November 	4	2021	2025-11-03 20:25:50
334	2021-11-30	30	11	November 	4	2021	2025-11-03 20:25:50
335	2021-12-01	1	12	December 	4	2021	2025-11-03 20:25:50
336	2021-12-02	2	12	December 	4	2021	2025-11-03 20:25:50
337	2021-12-03	3	12	December 	4	2021	2025-11-03 20:25:50
338	2021-12-04	4	12	December 	4	2021	2025-11-03 20:25:50
339	2021-12-05	5	12	December 	4	2021	2025-11-03 20:25:50
340	2021-12-06	6	12	December 	4	2021	2025-11-03 20:25:50
341	2021-12-07	7	12	December 	4	2021	2025-11-03 20:25:50
342	2021-12-08	8	12	December 	4	2021	2025-11-03 20:25:50
343	2021-12-09	9	12	December 	4	2021	2025-11-03 20:25:50
344	2021-12-10	10	12	December 	4	2021	2025-11-03 20:25:50
345	2021-12-11	11	12	December 	4	2021	2025-11-03 20:25:50
346	2021-12-12	12	12	December 	4	2021	2025-11-03 20:25:50
347	2021-12-13	13	12	December 	4	2021	2025-11-03 20:25:50
348	2021-12-14	14	12	December 	4	2021	2025-11-03 20:25:50
349	2021-12-15	15	12	December 	4	2021	2025-11-03 20:25:50
350	2021-12-16	16	12	December 	4	2021	2025-11-03 20:25:50
351	2021-12-17	17	12	December 	4	2021	2025-11-03 20:25:50
352	2021-12-18	18	12	December 	4	2021	2025-11-03 20:25:50
353	2021-12-19	19	12	December 	4	2021	2025-11-03 20:25:50
354	2021-12-20	20	12	December 	4	2021	2025-11-03 20:25:50
355	2021-12-21	21	12	December 	4	2021	2025-11-03 20:25:50
356	2021-12-22	22	12	December 	4	2021	2025-11-03 20:25:50
357	2021-12-23	23	12	December 	4	2021	2025-11-03 20:25:50
358	2021-12-24	24	12	December 	4	2021	2025-11-03 20:25:50
359	2021-12-25	25	12	December 	4	2021	2025-11-03 20:25:50
360	2021-12-26	26	12	December 	4	2021	2025-11-03 20:25:50
361	2021-12-27	27	12	December 	4	2021	2025-11-03 20:25:50
362	2021-12-28	28	12	December 	4	2021	2025-11-03 20:25:50
363	2021-12-29	29	12	December 	4	2021	2025-11-03 20:25:50
364	2021-12-30	30	12	December 	4	2021	2025-11-03 20:25:50
365	2021-12-31	31	12	December 	4	2021	2025-11-03 20:25:50
366	2022-01-01	1	1	January  	1	2022	2025-11-03 20:25:50
367	2022-01-02	2	1	January  	1	2022	2025-11-03 20:25:50
368	2022-01-03	3	1	January  	1	2022	2025-11-03 20:25:50
369	2022-01-04	4	1	January  	1	2022	2025-11-03 20:25:50
370	2022-01-05	5	1	January  	1	2022	2025-11-03 20:25:50
371	2022-01-06	6	1	January  	1	2022	2025-11-03 20:25:50
372	2022-01-07	7	1	January  	1	2022	2025-11-03 20:25:50
373	2022-01-08	8	1	January  	1	2022	2025-11-03 20:25:50
374	2022-01-09	9	1	January  	1	2022	2025-11-03 20:25:50
375	2022-01-10	10	1	January  	1	2022	2025-11-03 20:25:50
376	2022-01-11	11	1	January  	1	2022	2025-11-03 20:25:50
377	2022-01-12	12	1	January  	1	2022	2025-11-03 20:25:50
378	2022-01-13	13	1	January  	1	2022	2025-11-03 20:25:50
379	2022-01-14	14	1	January  	1	2022	2025-11-03 20:25:50
380	2022-01-15	15	1	January  	1	2022	2025-11-03 20:25:50
381	2022-01-16	16	1	January  	1	2022	2025-11-03 20:25:50
382	2022-01-17	17	1	January  	1	2022	2025-11-03 20:25:50
383	2022-01-18	18	1	January  	1	2022	2025-11-03 20:25:50
384	2022-01-19	19	1	January  	1	2022	2025-11-03 20:25:50
385	2022-01-20	20	1	January  	1	2022	2025-11-03 20:25:50
386	2022-01-21	21	1	January  	1	2022	2025-11-03 20:25:50
387	2022-01-22	22	1	January  	1	2022	2025-11-03 20:25:50
388	2022-01-23	23	1	January  	1	2022	2025-11-03 20:25:50
389	2022-01-24	24	1	January  	1	2022	2025-11-03 20:25:50
390	2022-01-25	25	1	January  	1	2022	2025-11-03 20:25:50
391	2022-01-26	26	1	January  	1	2022	2025-11-03 20:25:50
392	2022-01-27	27	1	January  	1	2022	2025-11-03 20:25:50
393	2022-01-28	28	1	January  	1	2022	2025-11-03 20:25:50
394	2022-01-29	29	1	January  	1	2022	2025-11-03 20:25:50
395	2022-01-30	30	1	January  	1	2022	2025-11-03 20:25:50
396	2022-01-31	31	1	January  	1	2022	2025-11-03 20:25:50
397	2022-02-01	1	2	February 	1	2022	2025-11-03 20:25:50
398	2022-02-02	2	2	February 	1	2022	2025-11-03 20:25:50
399	2022-02-03	3	2	February 	1	2022	2025-11-03 20:25:50
400	2022-02-04	4	2	February 	1	2022	2025-11-03 20:25:50
401	2022-02-05	5	2	February 	1	2022	2025-11-03 20:25:50
402	2022-02-06	6	2	February 	1	2022	2025-11-03 20:25:50
403	2022-02-07	7	2	February 	1	2022	2025-11-03 20:25:50
404	2022-02-08	8	2	February 	1	2022	2025-11-03 20:25:50
405	2022-02-09	9	2	February 	1	2022	2025-11-03 20:25:50
406	2022-02-10	10	2	February 	1	2022	2025-11-03 20:25:50
407	2022-02-11	11	2	February 	1	2022	2025-11-03 20:25:50
408	2022-02-12	12	2	February 	1	2022	2025-11-03 20:25:50
409	2022-02-13	13	2	February 	1	2022	2025-11-03 20:25:50
410	2022-02-14	14	2	February 	1	2022	2025-11-03 20:25:50
411	2022-02-15	15	2	February 	1	2022	2025-11-03 20:25:50
412	2022-02-16	16	2	February 	1	2022	2025-11-03 20:25:50
413	2022-02-17	17	2	February 	1	2022	2025-11-03 20:25:50
414	2022-02-18	18	2	February 	1	2022	2025-11-03 20:25:50
415	2022-02-19	19	2	February 	1	2022	2025-11-03 20:25:50
416	2022-02-20	20	2	February 	1	2022	2025-11-03 20:25:50
417	2022-02-21	21	2	February 	1	2022	2025-11-03 20:25:50
418	2022-02-22	22	2	February 	1	2022	2025-11-03 20:25:50
419	2022-02-23	23	2	February 	1	2022	2025-11-03 20:25:50
420	2022-02-24	24	2	February 	1	2022	2025-11-03 20:25:50
421	2022-02-25	25	2	February 	1	2022	2025-11-03 20:25:50
422	2022-02-26	26	2	February 	1	2022	2025-11-03 20:25:50
423	2022-02-27	27	2	February 	1	2022	2025-11-03 20:25:50
424	2022-02-28	28	2	February 	1	2022	2025-11-03 20:25:50
425	2022-03-01	1	3	March    	1	2022	2025-11-03 20:25:50
426	2022-03-02	2	3	March    	1	2022	2025-11-03 20:25:50
427	2022-03-03	3	3	March    	1	2022	2025-11-03 20:25:50
428	2022-03-04	4	3	March    	1	2022	2025-11-03 20:25:50
429	2022-03-05	5	3	March    	1	2022	2025-11-03 20:25:50
430	2022-03-06	6	3	March    	1	2022	2025-11-03 20:25:50
431	2022-03-07	7	3	March    	1	2022	2025-11-03 20:25:50
432	2022-03-08	8	3	March    	1	2022	2025-11-03 20:25:50
433	2022-03-09	9	3	March    	1	2022	2025-11-03 20:25:50
434	2022-03-10	10	3	March    	1	2022	2025-11-03 20:25:50
435	2022-03-11	11	3	March    	1	2022	2025-11-03 20:25:50
436	2022-03-12	12	3	March    	1	2022	2025-11-03 20:25:50
437	2022-03-13	13	3	March    	1	2022	2025-11-03 20:25:50
438	2022-03-14	14	3	March    	1	2022	2025-11-03 20:25:50
439	2022-03-15	15	3	March    	1	2022	2025-11-03 20:25:50
440	2022-03-16	16	3	March    	1	2022	2025-11-03 20:25:50
441	2022-03-17	17	3	March    	1	2022	2025-11-03 20:25:50
442	2022-03-18	18	3	March    	1	2022	2025-11-03 20:25:50
443	2022-03-19	19	3	March    	1	2022	2025-11-03 20:25:50
444	2022-03-20	20	3	March    	1	2022	2025-11-03 20:25:50
445	2022-03-21	21	3	March    	1	2022	2025-11-03 20:25:50
446	2022-03-22	22	3	March    	1	2022	2025-11-03 20:25:50
447	2022-03-23	23	3	March    	1	2022	2025-11-03 20:25:50
448	2022-03-24	24	3	March    	1	2022	2025-11-03 20:25:50
449	2022-03-25	25	3	March    	1	2022	2025-11-03 20:25:50
450	2022-03-26	26	3	March    	1	2022	2025-11-03 20:25:50
451	2022-03-27	27	3	March    	1	2022	2025-11-03 20:25:50
452	2022-03-28	28	3	March    	1	2022	2025-11-03 20:25:50
453	2022-03-29	29	3	March    	1	2022	2025-11-03 20:25:50
454	2022-03-30	30	3	March    	1	2022	2025-11-03 20:25:50
455	2022-03-31	31	3	March    	1	2022	2025-11-03 20:25:50
456	2022-04-01	1	4	April    	2	2022	2025-11-03 20:25:50
457	2022-04-02	2	4	April    	2	2022	2025-11-03 20:25:50
458	2022-04-03	3	4	April    	2	2022	2025-11-03 20:25:50
459	2022-04-04	4	4	April    	2	2022	2025-11-03 20:25:50
460	2022-04-05	5	4	April    	2	2022	2025-11-03 20:25:50
461	2022-04-06	6	4	April    	2	2022	2025-11-03 20:25:50
462	2022-04-07	7	4	April    	2	2022	2025-11-03 20:25:50
463	2022-04-08	8	4	April    	2	2022	2025-11-03 20:25:50
464	2022-04-09	9	4	April    	2	2022	2025-11-03 20:25:50
465	2022-04-10	10	4	April    	2	2022	2025-11-03 20:25:50
466	2022-04-11	11	4	April    	2	2022	2025-11-03 20:25:50
467	2022-04-12	12	4	April    	2	2022	2025-11-03 20:25:50
468	2022-04-13	13	4	April    	2	2022	2025-11-03 20:25:50
469	2022-04-14	14	4	April    	2	2022	2025-11-03 20:25:50
470	2022-04-15	15	4	April    	2	2022	2025-11-03 20:25:50
471	2022-04-16	16	4	April    	2	2022	2025-11-03 20:25:50
472	2022-04-17	17	4	April    	2	2022	2025-11-03 20:25:50
473	2022-04-18	18	4	April    	2	2022	2025-11-03 20:25:50
474	2022-04-19	19	4	April    	2	2022	2025-11-03 20:25:50
475	2022-04-20	20	4	April    	2	2022	2025-11-03 20:25:50
476	2022-04-21	21	4	April    	2	2022	2025-11-03 20:25:50
477	2022-04-22	22	4	April    	2	2022	2025-11-03 20:25:50
478	2022-04-23	23	4	April    	2	2022	2025-11-03 20:25:50
479	2022-04-24	24	4	April    	2	2022	2025-11-03 20:25:50
480	2022-04-25	25	4	April    	2	2022	2025-11-03 20:25:50
481	2022-04-26	26	4	April    	2	2022	2025-11-03 20:25:50
482	2022-04-27	27	4	April    	2	2022	2025-11-03 20:25:50
483	2022-04-28	28	4	April    	2	2022	2025-11-03 20:25:50
484	2022-04-29	29	4	April    	2	2022	2025-11-03 20:25:50
485	2022-04-30	30	4	April    	2	2022	2025-11-03 20:25:50
486	2022-05-01	1	5	May      	2	2022	2025-11-03 20:25:50
487	2022-05-02	2	5	May      	2	2022	2025-11-03 20:25:50
488	2022-05-03	3	5	May      	2	2022	2025-11-03 20:25:50
489	2022-05-04	4	5	May      	2	2022	2025-11-03 20:25:50
490	2022-05-05	5	5	May      	2	2022	2025-11-03 20:25:50
491	2022-05-06	6	5	May      	2	2022	2025-11-03 20:25:50
492	2022-05-07	7	5	May      	2	2022	2025-11-03 20:25:50
493	2022-05-08	8	5	May      	2	2022	2025-11-03 20:25:50
494	2022-05-09	9	5	May      	2	2022	2025-11-03 20:25:50
495	2022-05-10	10	5	May      	2	2022	2025-11-03 20:25:50
496	2022-05-11	11	5	May      	2	2022	2025-11-03 20:25:50
497	2022-05-12	12	5	May      	2	2022	2025-11-03 20:25:50
498	2022-05-13	13	5	May      	2	2022	2025-11-03 20:25:50
499	2022-05-14	14	5	May      	2	2022	2025-11-03 20:25:50
500	2022-05-15	15	5	May      	2	2022	2025-11-03 20:25:50
501	2022-05-16	16	5	May      	2	2022	2025-11-03 20:25:50
502	2022-05-17	17	5	May      	2	2022	2025-11-03 20:25:50
503	2022-05-18	18	5	May      	2	2022	2025-11-03 20:25:50
504	2022-05-19	19	5	May      	2	2022	2025-11-03 20:25:50
505	2022-05-20	20	5	May      	2	2022	2025-11-03 20:25:50
506	2022-05-21	21	5	May      	2	2022	2025-11-03 20:25:50
507	2022-05-22	22	5	May      	2	2022	2025-11-03 20:25:50
508	2022-05-23	23	5	May      	2	2022	2025-11-03 20:25:50
509	2022-05-24	24	5	May      	2	2022	2025-11-03 20:25:50
510	2022-05-25	25	5	May      	2	2022	2025-11-03 20:25:50
511	2022-05-26	26	5	May      	2	2022	2025-11-03 20:25:50
512	2022-05-27	27	5	May      	2	2022	2025-11-03 20:25:50
513	2022-05-28	28	5	May      	2	2022	2025-11-03 20:25:50
514	2022-05-29	29	5	May      	2	2022	2025-11-03 20:25:50
515	2022-05-30	30	5	May      	2	2022	2025-11-03 20:25:50
516	2022-05-31	31	5	May      	2	2022	2025-11-03 20:25:50
517	2022-06-01	1	6	June     	2	2022	2025-11-03 20:25:50
518	2022-06-02	2	6	June     	2	2022	2025-11-03 20:25:50
519	2022-06-03	3	6	June     	2	2022	2025-11-03 20:25:50
520	2022-06-04	4	6	June     	2	2022	2025-11-03 20:25:50
521	2022-06-05	5	6	June     	2	2022	2025-11-03 20:25:50
522	2022-06-06	6	6	June     	2	2022	2025-11-03 20:25:50
523	2022-06-07	7	6	June     	2	2022	2025-11-03 20:25:50
524	2022-06-08	8	6	June     	2	2022	2025-11-03 20:25:50
525	2022-06-09	9	6	June     	2	2022	2025-11-03 20:25:50
526	2022-06-10	10	6	June     	2	2022	2025-11-03 20:25:50
527	2022-06-11	11	6	June     	2	2022	2025-11-03 20:25:50
528	2022-06-12	12	6	June     	2	2022	2025-11-03 20:25:50
529	2022-06-13	13	6	June     	2	2022	2025-11-03 20:25:50
530	2022-06-14	14	6	June     	2	2022	2025-11-03 20:25:50
531	2022-06-15	15	6	June     	2	2022	2025-11-03 20:25:50
532	2022-06-16	16	6	June     	2	2022	2025-11-03 20:25:50
533	2022-06-17	17	6	June     	2	2022	2025-11-03 20:25:50
534	2022-06-18	18	6	June     	2	2022	2025-11-03 20:25:50
535	2022-06-19	19	6	June     	2	2022	2025-11-03 20:25:50
536	2022-06-20	20	6	June     	2	2022	2025-11-03 20:25:50
537	2022-06-21	21	6	June     	2	2022	2025-11-03 20:25:50
538	2022-06-22	22	6	June     	2	2022	2025-11-03 20:25:50
539	2022-06-23	23	6	June     	2	2022	2025-11-03 20:25:50
540	2022-06-24	24	6	June     	2	2022	2025-11-03 20:25:50
541	2022-06-25	25	6	June     	2	2022	2025-11-03 20:25:50
542	2022-06-26	26	6	June     	2	2022	2025-11-03 20:25:50
543	2022-06-27	27	6	June     	2	2022	2025-11-03 20:25:50
544	2022-06-28	28	6	June     	2	2022	2025-11-03 20:25:50
545	2022-06-29	29	6	June     	2	2022	2025-11-03 20:25:50
546	2022-06-30	30	6	June     	2	2022	2025-11-03 20:25:50
547	2022-07-01	1	7	July     	3	2022	2025-11-03 20:25:50
548	2022-07-02	2	7	July     	3	2022	2025-11-03 20:25:50
549	2022-07-03	3	7	July     	3	2022	2025-11-03 20:25:50
550	2022-07-04	4	7	July     	3	2022	2025-11-03 20:25:50
551	2022-07-05	5	7	July     	3	2022	2025-11-03 20:25:50
552	2022-07-06	6	7	July     	3	2022	2025-11-03 20:25:50
553	2022-07-07	7	7	July     	3	2022	2025-11-03 20:25:50
554	2022-07-08	8	7	July     	3	2022	2025-11-03 20:25:50
555	2022-07-09	9	7	July     	3	2022	2025-11-03 20:25:50
556	2022-07-10	10	7	July     	3	2022	2025-11-03 20:25:50
557	2022-07-11	11	7	July     	3	2022	2025-11-03 20:25:50
558	2022-07-12	12	7	July     	3	2022	2025-11-03 20:25:50
559	2022-07-13	13	7	July     	3	2022	2025-11-03 20:25:50
560	2022-07-14	14	7	July     	3	2022	2025-11-03 20:25:50
561	2022-07-15	15	7	July     	3	2022	2025-11-03 20:25:50
562	2022-07-16	16	7	July     	3	2022	2025-11-03 20:25:50
563	2022-07-17	17	7	July     	3	2022	2025-11-03 20:25:50
564	2022-07-18	18	7	July     	3	2022	2025-11-03 20:25:50
565	2022-07-19	19	7	July     	3	2022	2025-11-03 20:25:50
566	2022-07-20	20	7	July     	3	2022	2025-11-03 20:25:50
567	2022-07-21	21	7	July     	3	2022	2025-11-03 20:25:50
568	2022-07-22	22	7	July     	3	2022	2025-11-03 20:25:50
569	2022-07-23	23	7	July     	3	2022	2025-11-03 20:25:50
570	2022-07-24	24	7	July     	3	2022	2025-11-03 20:25:50
571	2022-07-25	25	7	July     	3	2022	2025-11-03 20:25:50
572	2022-07-26	26	7	July     	3	2022	2025-11-03 20:25:50
573	2022-07-27	27	7	July     	3	2022	2025-11-03 20:25:50
574	2022-07-28	28	7	July     	3	2022	2025-11-03 20:25:50
575	2022-07-29	29	7	July     	3	2022	2025-11-03 20:25:50
576	2022-07-30	30	7	July     	3	2022	2025-11-03 20:25:50
577	2022-07-31	31	7	July     	3	2022	2025-11-03 20:25:50
578	2022-08-01	1	8	August   	3	2022	2025-11-03 20:25:50
579	2022-08-02	2	8	August   	3	2022	2025-11-03 20:25:50
580	2022-08-03	3	8	August   	3	2022	2025-11-03 20:25:50
581	2022-08-04	4	8	August   	3	2022	2025-11-03 20:25:50
582	2022-08-05	5	8	August   	3	2022	2025-11-03 20:25:50
583	2022-08-06	6	8	August   	3	2022	2025-11-03 20:25:50
584	2022-08-07	7	8	August   	3	2022	2025-11-03 20:25:50
585	2022-08-08	8	8	August   	3	2022	2025-11-03 20:25:50
586	2022-08-09	9	8	August   	3	2022	2025-11-03 20:25:50
587	2022-08-10	10	8	August   	3	2022	2025-11-03 20:25:50
588	2022-08-11	11	8	August   	3	2022	2025-11-03 20:25:50
589	2022-08-12	12	8	August   	3	2022	2025-11-03 20:25:50
590	2022-08-13	13	8	August   	3	2022	2025-11-03 20:25:50
591	2022-08-14	14	8	August   	3	2022	2025-11-03 20:25:50
592	2022-08-15	15	8	August   	3	2022	2025-11-03 20:25:50
593	2022-08-16	16	8	August   	3	2022	2025-11-03 20:25:50
594	2022-08-17	17	8	August   	3	2022	2025-11-03 20:25:50
595	2022-08-18	18	8	August   	3	2022	2025-11-03 20:25:50
596	2022-08-19	19	8	August   	3	2022	2025-11-03 20:25:50
597	2022-08-20	20	8	August   	3	2022	2025-11-03 20:25:50
598	2022-08-21	21	8	August   	3	2022	2025-11-03 20:25:50
599	2022-08-22	22	8	August   	3	2022	2025-11-03 20:25:50
600	2022-08-23	23	8	August   	3	2022	2025-11-03 20:25:50
601	2022-08-24	24	8	August   	3	2022	2025-11-03 20:25:50
602	2022-08-25	25	8	August   	3	2022	2025-11-03 20:25:50
603	2022-08-26	26	8	August   	3	2022	2025-11-03 20:25:50
604	2022-08-27	27	8	August   	3	2022	2025-11-03 20:25:50
605	2022-08-28	28	8	August   	3	2022	2025-11-03 20:25:50
606	2022-08-29	29	8	August   	3	2022	2025-11-03 20:25:50
607	2022-08-30	30	8	August   	3	2022	2025-11-03 20:25:50
608	2022-08-31	31	8	August   	3	2022	2025-11-03 20:25:50
609	2022-09-01	1	9	September	3	2022	2025-11-03 20:25:50
610	2022-09-02	2	9	September	3	2022	2025-11-03 20:25:50
611	2022-09-03	3	9	September	3	2022	2025-11-03 20:25:50
612	2022-09-04	4	9	September	3	2022	2025-11-03 20:25:50
613	2022-09-05	5	9	September	3	2022	2025-11-03 20:25:50
614	2022-09-06	6	9	September	3	2022	2025-11-03 20:25:50
615	2022-09-07	7	9	September	3	2022	2025-11-03 20:25:50
616	2022-09-08	8	9	September	3	2022	2025-11-03 20:25:50
617	2022-09-09	9	9	September	3	2022	2025-11-03 20:25:50
618	2022-09-10	10	9	September	3	2022	2025-11-03 20:25:50
619	2022-09-11	11	9	September	3	2022	2025-11-03 20:25:50
620	2022-09-12	12	9	September	3	2022	2025-11-03 20:25:50
621	2022-09-13	13	9	September	3	2022	2025-11-03 20:25:50
622	2022-09-14	14	9	September	3	2022	2025-11-03 20:25:50
623	2022-09-15	15	9	September	3	2022	2025-11-03 20:25:50
624	2022-09-16	16	9	September	3	2022	2025-11-03 20:25:50
625	2022-09-17	17	9	September	3	2022	2025-11-03 20:25:50
626	2022-09-18	18	9	September	3	2022	2025-11-03 20:25:50
627	2022-09-19	19	9	September	3	2022	2025-11-03 20:25:50
628	2022-09-20	20	9	September	3	2022	2025-11-03 20:25:50
629	2022-09-21	21	9	September	3	2022	2025-11-03 20:25:50
630	2022-09-22	22	9	September	3	2022	2025-11-03 20:25:50
631	2022-09-23	23	9	September	3	2022	2025-11-03 20:25:50
632	2022-09-24	24	9	September	3	2022	2025-11-03 20:25:50
633	2022-09-25	25	9	September	3	2022	2025-11-03 20:25:50
634	2022-09-26	26	9	September	3	2022	2025-11-03 20:25:50
635	2022-09-27	27	9	September	3	2022	2025-11-03 20:25:50
636	2022-09-28	28	9	September	3	2022	2025-11-03 20:25:50
637	2022-09-29	29	9	September	3	2022	2025-11-03 20:25:50
638	2022-09-30	30	9	September	3	2022	2025-11-03 20:25:50
639	2022-10-01	1	10	October  	4	2022	2025-11-03 20:25:50
640	2022-10-02	2	10	October  	4	2022	2025-11-03 20:25:50
641	2022-10-03	3	10	October  	4	2022	2025-11-03 20:25:50
642	2022-10-04	4	10	October  	4	2022	2025-11-03 20:25:50
643	2022-10-05	5	10	October  	4	2022	2025-11-03 20:25:50
644	2022-10-06	6	10	October  	4	2022	2025-11-03 20:25:50
645	2022-10-07	7	10	October  	4	2022	2025-11-03 20:25:50
646	2022-10-08	8	10	October  	4	2022	2025-11-03 20:25:50
647	2022-10-09	9	10	October  	4	2022	2025-11-03 20:25:50
648	2022-10-10	10	10	October  	4	2022	2025-11-03 20:25:50
649	2022-10-11	11	10	October  	4	2022	2025-11-03 20:25:50
650	2022-10-12	12	10	October  	4	2022	2025-11-03 20:25:50
651	2022-10-13	13	10	October  	4	2022	2025-11-03 20:25:50
652	2022-10-14	14	10	October  	4	2022	2025-11-03 20:25:50
653	2022-10-15	15	10	October  	4	2022	2025-11-03 20:25:50
654	2022-10-16	16	10	October  	4	2022	2025-11-03 20:25:50
655	2022-10-17	17	10	October  	4	2022	2025-11-03 20:25:50
656	2022-10-18	18	10	October  	4	2022	2025-11-03 20:25:50
657	2022-10-19	19	10	October  	4	2022	2025-11-03 20:25:50
658	2022-10-20	20	10	October  	4	2022	2025-11-03 20:25:50
659	2022-10-21	21	10	October  	4	2022	2025-11-03 20:25:50
660	2022-10-22	22	10	October  	4	2022	2025-11-03 20:25:50
661	2022-10-23	23	10	October  	4	2022	2025-11-03 20:25:50
662	2022-10-24	24	10	October  	4	2022	2025-11-03 20:25:50
663	2022-10-25	25	10	October  	4	2022	2025-11-03 20:25:50
664	2022-10-26	26	10	October  	4	2022	2025-11-03 20:25:50
665	2022-10-27	27	10	October  	4	2022	2025-11-03 20:25:50
666	2022-10-28	28	10	October  	4	2022	2025-11-03 20:25:50
667	2022-10-29	29	10	October  	4	2022	2025-11-03 20:25:50
668	2022-10-30	30	10	October  	4	2022	2025-11-03 20:25:50
669	2022-10-31	31	10	October  	4	2022	2025-11-03 20:25:50
670	2022-11-01	1	11	November 	4	2022	2025-11-03 20:25:50
671	2022-11-02	2	11	November 	4	2022	2025-11-03 20:25:50
672	2022-11-03	3	11	November 	4	2022	2025-11-03 20:25:50
673	2022-11-04	4	11	November 	4	2022	2025-11-03 20:25:50
674	2022-11-05	5	11	November 	4	2022	2025-11-03 20:25:50
675	2022-11-06	6	11	November 	4	2022	2025-11-03 20:25:50
676	2022-11-07	7	11	November 	4	2022	2025-11-03 20:25:50
677	2022-11-08	8	11	November 	4	2022	2025-11-03 20:25:50
678	2022-11-09	9	11	November 	4	2022	2025-11-03 20:25:50
679	2022-11-10	10	11	November 	4	2022	2025-11-03 20:25:50
680	2022-11-11	11	11	November 	4	2022	2025-11-03 20:25:50
681	2022-11-12	12	11	November 	4	2022	2025-11-03 20:25:50
682	2022-11-13	13	11	November 	4	2022	2025-11-03 20:25:50
683	2022-11-14	14	11	November 	4	2022	2025-11-03 20:25:50
684	2022-11-15	15	11	November 	4	2022	2025-11-03 20:25:50
685	2022-11-16	16	11	November 	4	2022	2025-11-03 20:25:50
686	2022-11-17	17	11	November 	4	2022	2025-11-03 20:25:50
687	2022-11-18	18	11	November 	4	2022	2025-11-03 20:25:50
688	2022-11-19	19	11	November 	4	2022	2025-11-03 20:25:50
689	2022-11-20	20	11	November 	4	2022	2025-11-03 20:25:50
690	2022-11-21	21	11	November 	4	2022	2025-11-03 20:25:50
691	2022-11-22	22	11	November 	4	2022	2025-11-03 20:25:50
692	2022-11-23	23	11	November 	4	2022	2025-11-03 20:25:50
693	2022-11-24	24	11	November 	4	2022	2025-11-03 20:25:50
694	2022-11-25	25	11	November 	4	2022	2025-11-03 20:25:50
695	2022-11-26	26	11	November 	4	2022	2025-11-03 20:25:50
696	2022-11-27	27	11	November 	4	2022	2025-11-03 20:25:50
697	2022-11-28	28	11	November 	4	2022	2025-11-03 20:25:50
698	2022-11-29	29	11	November 	4	2022	2025-11-03 20:25:50
699	2022-11-30	30	11	November 	4	2022	2025-11-03 20:25:50
700	2022-12-01	1	12	December 	4	2022	2025-11-03 20:25:50
701	2022-12-02	2	12	December 	4	2022	2025-11-03 20:25:50
702	2022-12-03	3	12	December 	4	2022	2025-11-03 20:25:50
703	2022-12-04	4	12	December 	4	2022	2025-11-03 20:25:50
704	2022-12-05	5	12	December 	4	2022	2025-11-03 20:25:50
705	2022-12-06	6	12	December 	4	2022	2025-11-03 20:25:50
706	2022-12-07	7	12	December 	4	2022	2025-11-03 20:25:50
707	2022-12-08	8	12	December 	4	2022	2025-11-03 20:25:50
708	2022-12-09	9	12	December 	4	2022	2025-11-03 20:25:50
709	2022-12-10	10	12	December 	4	2022	2025-11-03 20:25:50
710	2022-12-11	11	12	December 	4	2022	2025-11-03 20:25:50
711	2022-12-12	12	12	December 	4	2022	2025-11-03 20:25:50
712	2022-12-13	13	12	December 	4	2022	2025-11-03 20:25:50
713	2022-12-14	14	12	December 	4	2022	2025-11-03 20:25:50
714	2022-12-15	15	12	December 	4	2022	2025-11-03 20:25:50
715	2022-12-16	16	12	December 	4	2022	2025-11-03 20:25:50
716	2022-12-17	17	12	December 	4	2022	2025-11-03 20:25:50
717	2022-12-18	18	12	December 	4	2022	2025-11-03 20:25:50
718	2022-12-19	19	12	December 	4	2022	2025-11-03 20:25:50
719	2022-12-20	20	12	December 	4	2022	2025-11-03 20:25:50
720	2022-12-21	21	12	December 	4	2022	2025-11-03 20:25:50
721	2022-12-22	22	12	December 	4	2022	2025-11-03 20:25:50
722	2022-12-23	23	12	December 	4	2022	2025-11-03 20:25:50
723	2022-12-24	24	12	December 	4	2022	2025-11-03 20:25:50
724	2022-12-25	25	12	December 	4	2022	2025-11-03 20:25:50
725	2022-12-26	26	12	December 	4	2022	2025-11-03 20:25:50
726	2022-12-27	27	12	December 	4	2022	2025-11-03 20:25:50
727	2022-12-28	28	12	December 	4	2022	2025-11-03 20:25:50
728	2022-12-29	29	12	December 	4	2022	2025-11-03 20:25:50
729	2022-12-30	30	12	December 	4	2022	2025-11-03 20:25:50
730	2022-12-31	31	12	December 	4	2022	2025-11-03 20:25:50
731	2023-01-01	1	1	January  	1	2023	2025-11-03 20:25:50
732	2023-01-02	2	1	January  	1	2023	2025-11-03 20:25:50
733	2023-01-03	3	1	January  	1	2023	2025-11-03 20:25:50
734	2023-01-04	4	1	January  	1	2023	2025-11-03 20:25:50
735	2023-01-05	5	1	January  	1	2023	2025-11-03 20:25:50
736	2023-01-06	6	1	January  	1	2023	2025-11-03 20:25:50
737	2023-01-07	7	1	January  	1	2023	2025-11-03 20:25:50
738	2023-01-08	8	1	January  	1	2023	2025-11-03 20:25:50
739	2023-01-09	9	1	January  	1	2023	2025-11-03 20:25:50
740	2023-01-10	10	1	January  	1	2023	2025-11-03 20:25:50
741	2023-01-11	11	1	January  	1	2023	2025-11-03 20:25:50
742	2023-01-12	12	1	January  	1	2023	2025-11-03 20:25:50
743	2023-01-13	13	1	January  	1	2023	2025-11-03 20:25:50
744	2023-01-14	14	1	January  	1	2023	2025-11-03 20:25:50
745	2023-01-15	15	1	January  	1	2023	2025-11-03 20:25:50
746	2023-01-16	16	1	January  	1	2023	2025-11-03 20:25:50
747	2023-01-17	17	1	January  	1	2023	2025-11-03 20:25:50
748	2023-01-18	18	1	January  	1	2023	2025-11-03 20:25:50
749	2023-01-19	19	1	January  	1	2023	2025-11-03 20:25:50
750	2023-01-20	20	1	January  	1	2023	2025-11-03 20:25:50
751	2023-01-21	21	1	January  	1	2023	2025-11-03 20:25:50
752	2023-01-22	22	1	January  	1	2023	2025-11-03 20:25:50
753	2023-01-23	23	1	January  	1	2023	2025-11-03 20:25:50
754	2023-01-24	24	1	January  	1	2023	2025-11-03 20:25:50
755	2023-01-25	25	1	January  	1	2023	2025-11-03 20:25:50
756	2023-01-26	26	1	January  	1	2023	2025-11-03 20:25:50
757	2023-01-27	27	1	January  	1	2023	2025-11-03 20:25:50
758	2023-01-28	28	1	January  	1	2023	2025-11-03 20:25:50
759	2023-01-29	29	1	January  	1	2023	2025-11-03 20:25:50
760	2023-01-30	30	1	January  	1	2023	2025-11-03 20:25:50
761	2023-01-31	31	1	January  	1	2023	2025-11-03 20:25:50
762	2023-02-01	1	2	February 	1	2023	2025-11-03 20:25:50
763	2023-02-02	2	2	February 	1	2023	2025-11-03 20:25:50
764	2023-02-03	3	2	February 	1	2023	2025-11-03 20:25:50
765	2023-02-04	4	2	February 	1	2023	2025-11-03 20:25:50
766	2023-02-05	5	2	February 	1	2023	2025-11-03 20:25:50
767	2023-02-06	6	2	February 	1	2023	2025-11-03 20:25:50
768	2023-02-07	7	2	February 	1	2023	2025-11-03 20:25:50
769	2023-02-08	8	2	February 	1	2023	2025-11-03 20:25:50
770	2023-02-09	9	2	February 	1	2023	2025-11-03 20:25:50
771	2023-02-10	10	2	February 	1	2023	2025-11-03 20:25:50
772	2023-02-11	11	2	February 	1	2023	2025-11-03 20:25:50
773	2023-02-12	12	2	February 	1	2023	2025-11-03 20:25:50
774	2023-02-13	13	2	February 	1	2023	2025-11-03 20:25:50
775	2023-02-14	14	2	February 	1	2023	2025-11-03 20:25:50
776	2023-02-15	15	2	February 	1	2023	2025-11-03 20:25:50
777	2023-02-16	16	2	February 	1	2023	2025-11-03 20:25:50
778	2023-02-17	17	2	February 	1	2023	2025-11-03 20:25:50
779	2023-02-18	18	2	February 	1	2023	2025-11-03 20:25:50
780	2023-02-19	19	2	February 	1	2023	2025-11-03 20:25:50
781	2023-02-20	20	2	February 	1	2023	2025-11-03 20:25:50
782	2023-02-21	21	2	February 	1	2023	2025-11-03 20:25:50
783	2023-02-22	22	2	February 	1	2023	2025-11-03 20:25:50
784	2023-02-23	23	2	February 	1	2023	2025-11-03 20:25:50
785	2023-02-24	24	2	February 	1	2023	2025-11-03 20:25:50
786	2023-02-25	25	2	February 	1	2023	2025-11-03 20:25:50
787	2023-02-26	26	2	February 	1	2023	2025-11-03 20:25:50
788	2023-02-27	27	2	February 	1	2023	2025-11-03 20:25:50
789	2023-02-28	28	2	February 	1	2023	2025-11-03 20:25:50
790	2023-03-01	1	3	March    	1	2023	2025-11-03 20:25:50
791	2023-03-02	2	3	March    	1	2023	2025-11-03 20:25:50
792	2023-03-03	3	3	March    	1	2023	2025-11-03 20:25:50
793	2023-03-04	4	3	March    	1	2023	2025-11-03 20:25:50
794	2023-03-05	5	3	March    	1	2023	2025-11-03 20:25:50
795	2023-03-06	6	3	March    	1	2023	2025-11-03 20:25:50
796	2023-03-07	7	3	March    	1	2023	2025-11-03 20:25:50
797	2023-03-08	8	3	March    	1	2023	2025-11-03 20:25:50
798	2023-03-09	9	3	March    	1	2023	2025-11-03 20:25:50
799	2023-03-10	10	3	March    	1	2023	2025-11-03 20:25:50
800	2023-03-11	11	3	March    	1	2023	2025-11-03 20:25:50
801	2023-03-12	12	3	March    	1	2023	2025-11-03 20:25:50
802	2023-03-13	13	3	March    	1	2023	2025-11-03 20:25:50
803	2023-03-14	14	3	March    	1	2023	2025-11-03 20:25:50
804	2023-03-15	15	3	March    	1	2023	2025-11-03 20:25:50
805	2023-03-16	16	3	March    	1	2023	2025-11-03 20:25:50
806	2023-03-17	17	3	March    	1	2023	2025-11-03 20:25:50
807	2023-03-18	18	3	March    	1	2023	2025-11-03 20:25:50
808	2023-03-19	19	3	March    	1	2023	2025-11-03 20:25:50
809	2023-03-20	20	3	March    	1	2023	2025-11-03 20:25:50
810	2023-03-21	21	3	March    	1	2023	2025-11-03 20:25:50
811	2023-03-22	22	3	March    	1	2023	2025-11-03 20:25:50
812	2023-03-23	23	3	March    	1	2023	2025-11-03 20:25:50
813	2023-03-24	24	3	March    	1	2023	2025-11-03 20:25:50
814	2023-03-25	25	3	March    	1	2023	2025-11-03 20:25:50
815	2023-03-26	26	3	March    	1	2023	2025-11-03 20:25:50
816	2023-03-27	27	3	March    	1	2023	2025-11-03 20:25:50
817	2023-03-28	28	3	March    	1	2023	2025-11-03 20:25:50
818	2023-03-29	29	3	March    	1	2023	2025-11-03 20:25:50
819	2023-03-30	30	3	March    	1	2023	2025-11-03 20:25:50
820	2023-03-31	31	3	March    	1	2023	2025-11-03 20:25:50
821	2023-04-01	1	4	April    	2	2023	2025-11-03 20:25:50
822	2023-04-02	2	4	April    	2	2023	2025-11-03 20:25:50
823	2023-04-03	3	4	April    	2	2023	2025-11-03 20:25:50
824	2023-04-04	4	4	April    	2	2023	2025-11-03 20:25:50
825	2023-04-05	5	4	April    	2	2023	2025-11-03 20:25:50
826	2023-04-06	6	4	April    	2	2023	2025-11-03 20:25:50
827	2023-04-07	7	4	April    	2	2023	2025-11-03 20:25:50
828	2023-04-08	8	4	April    	2	2023	2025-11-03 20:25:50
829	2023-04-09	9	4	April    	2	2023	2025-11-03 20:25:50
830	2023-04-10	10	4	April    	2	2023	2025-11-03 20:25:50
831	2023-04-11	11	4	April    	2	2023	2025-11-03 20:25:50
832	2023-04-12	12	4	April    	2	2023	2025-11-03 20:25:50
833	2023-04-13	13	4	April    	2	2023	2025-11-03 20:25:50
834	2023-04-14	14	4	April    	2	2023	2025-11-03 20:25:50
835	2023-04-15	15	4	April    	2	2023	2025-11-03 20:25:50
836	2023-04-16	16	4	April    	2	2023	2025-11-03 20:25:50
837	2023-04-17	17	4	April    	2	2023	2025-11-03 20:25:50
838	2023-04-18	18	4	April    	2	2023	2025-11-03 20:25:50
839	2023-04-19	19	4	April    	2	2023	2025-11-03 20:25:50
840	2023-04-20	20	4	April    	2	2023	2025-11-03 20:25:50
841	2023-04-21	21	4	April    	2	2023	2025-11-03 20:25:50
842	2023-04-22	22	4	April    	2	2023	2025-11-03 20:25:50
843	2023-04-23	23	4	April    	2	2023	2025-11-03 20:25:50
844	2023-04-24	24	4	April    	2	2023	2025-11-03 20:25:50
845	2023-04-25	25	4	April    	2	2023	2025-11-03 20:25:50
846	2023-04-26	26	4	April    	2	2023	2025-11-03 20:25:50
847	2023-04-27	27	4	April    	2	2023	2025-11-03 20:25:50
848	2023-04-28	28	4	April    	2	2023	2025-11-03 20:25:50
849	2023-04-29	29	4	April    	2	2023	2025-11-03 20:25:50
850	2023-04-30	30	4	April    	2	2023	2025-11-03 20:25:50
851	2023-05-01	1	5	May      	2	2023	2025-11-03 20:25:50
852	2023-05-02	2	5	May      	2	2023	2025-11-03 20:25:50
853	2023-05-03	3	5	May      	2	2023	2025-11-03 20:25:50
854	2023-05-04	4	5	May      	2	2023	2025-11-03 20:25:50
855	2023-05-05	5	5	May      	2	2023	2025-11-03 20:25:50
856	2023-05-06	6	5	May      	2	2023	2025-11-03 20:25:50
857	2023-05-07	7	5	May      	2	2023	2025-11-03 20:25:50
858	2023-05-08	8	5	May      	2	2023	2025-11-03 20:25:50
859	2023-05-09	9	5	May      	2	2023	2025-11-03 20:25:50
860	2023-05-10	10	5	May      	2	2023	2025-11-03 20:25:50
861	2023-05-11	11	5	May      	2	2023	2025-11-03 20:25:50
862	2023-05-12	12	5	May      	2	2023	2025-11-03 20:25:50
863	2023-05-13	13	5	May      	2	2023	2025-11-03 20:25:50
864	2023-05-14	14	5	May      	2	2023	2025-11-03 20:25:50
865	2023-05-15	15	5	May      	2	2023	2025-11-03 20:25:50
866	2023-05-16	16	5	May      	2	2023	2025-11-03 20:25:50
867	2023-05-17	17	5	May      	2	2023	2025-11-03 20:25:50
868	2023-05-18	18	5	May      	2	2023	2025-11-03 20:25:50
869	2023-05-19	19	5	May      	2	2023	2025-11-03 20:25:50
870	2023-05-20	20	5	May      	2	2023	2025-11-03 20:25:50
871	2023-05-21	21	5	May      	2	2023	2025-11-03 20:25:50
872	2023-05-22	22	5	May      	2	2023	2025-11-03 20:25:50
873	2023-05-23	23	5	May      	2	2023	2025-11-03 20:25:50
874	2023-05-24	24	5	May      	2	2023	2025-11-03 20:25:50
875	2023-05-25	25	5	May      	2	2023	2025-11-03 20:25:50
876	2023-05-26	26	5	May      	2	2023	2025-11-03 20:25:50
877	2023-05-27	27	5	May      	2	2023	2025-11-03 20:25:50
878	2023-05-28	28	5	May      	2	2023	2025-11-03 20:25:50
879	2023-05-29	29	5	May      	2	2023	2025-11-03 20:25:50
880	2023-05-30	30	5	May      	2	2023	2025-11-03 20:25:50
881	2023-05-31	31	5	May      	2	2023	2025-11-03 20:25:50
882	2023-06-01	1	6	June     	2	2023	2025-11-03 20:25:50
883	2023-06-02	2	6	June     	2	2023	2025-11-03 20:25:50
884	2023-06-03	3	6	June     	2	2023	2025-11-03 20:25:50
885	2023-06-04	4	6	June     	2	2023	2025-11-03 20:25:50
886	2023-06-05	5	6	June     	2	2023	2025-11-03 20:25:50
887	2023-06-06	6	6	June     	2	2023	2025-11-03 20:25:50
888	2023-06-07	7	6	June     	2	2023	2025-11-03 20:25:50
889	2023-06-08	8	6	June     	2	2023	2025-11-03 20:25:50
890	2023-06-09	9	6	June     	2	2023	2025-11-03 20:25:50
891	2023-06-10	10	6	June     	2	2023	2025-11-03 20:25:50
892	2023-06-11	11	6	June     	2	2023	2025-11-03 20:25:50
893	2023-06-12	12	6	June     	2	2023	2025-11-03 20:25:50
894	2023-06-13	13	6	June     	2	2023	2025-11-03 20:25:50
895	2023-06-14	14	6	June     	2	2023	2025-11-03 20:25:50
896	2023-06-15	15	6	June     	2	2023	2025-11-03 20:25:50
897	2023-06-16	16	6	June     	2	2023	2025-11-03 20:25:50
898	2023-06-17	17	6	June     	2	2023	2025-11-03 20:25:50
899	2023-06-18	18	6	June     	2	2023	2025-11-03 20:25:50
900	2023-06-19	19	6	June     	2	2023	2025-11-03 20:25:50
901	2023-06-20	20	6	June     	2	2023	2025-11-03 20:25:50
902	2023-06-21	21	6	June     	2	2023	2025-11-03 20:25:50
903	2023-06-22	22	6	June     	2	2023	2025-11-03 20:25:50
904	2023-06-23	23	6	June     	2	2023	2025-11-03 20:25:50
905	2023-06-24	24	6	June     	2	2023	2025-11-03 20:25:50
906	2023-06-25	25	6	June     	2	2023	2025-11-03 20:25:50
907	2023-06-26	26	6	June     	2	2023	2025-11-03 20:25:50
908	2023-06-27	27	6	June     	2	2023	2025-11-03 20:25:50
909	2023-06-28	28	6	June     	2	2023	2025-11-03 20:25:50
910	2023-06-29	29	6	June     	2	2023	2025-11-03 20:25:50
911	2023-06-30	30	6	June     	2	2023	2025-11-03 20:25:50
912	2023-07-01	1	7	July     	3	2023	2025-11-03 20:25:50
913	2023-07-02	2	7	July     	3	2023	2025-11-03 20:25:50
914	2023-07-03	3	7	July     	3	2023	2025-11-03 20:25:50
915	2023-07-04	4	7	July     	3	2023	2025-11-03 20:25:50
916	2023-07-05	5	7	July     	3	2023	2025-11-03 20:25:50
917	2023-07-06	6	7	July     	3	2023	2025-11-03 20:25:50
918	2023-07-07	7	7	July     	3	2023	2025-11-03 20:25:50
919	2023-07-08	8	7	July     	3	2023	2025-11-03 20:25:50
920	2023-07-09	9	7	July     	3	2023	2025-11-03 20:25:50
921	2023-07-10	10	7	July     	3	2023	2025-11-03 20:25:50
922	2023-07-11	11	7	July     	3	2023	2025-11-03 20:25:50
923	2023-07-12	12	7	July     	3	2023	2025-11-03 20:25:50
924	2023-07-13	13	7	July     	3	2023	2025-11-03 20:25:50
925	2023-07-14	14	7	July     	3	2023	2025-11-03 20:25:50
926	2023-07-15	15	7	July     	3	2023	2025-11-03 20:25:50
927	2023-07-16	16	7	July     	3	2023	2025-11-03 20:25:50
928	2023-07-17	17	7	July     	3	2023	2025-11-03 20:25:50
929	2023-07-18	18	7	July     	3	2023	2025-11-03 20:25:50
930	2023-07-19	19	7	July     	3	2023	2025-11-03 20:25:50
931	2023-07-20	20	7	July     	3	2023	2025-11-03 20:25:50
932	2023-07-21	21	7	July     	3	2023	2025-11-03 20:25:50
933	2023-07-22	22	7	July     	3	2023	2025-11-03 20:25:50
934	2023-07-23	23	7	July     	3	2023	2025-11-03 20:25:50
935	2023-07-24	24	7	July     	3	2023	2025-11-03 20:25:50
936	2023-07-25	25	7	July     	3	2023	2025-11-03 20:25:50
937	2023-07-26	26	7	July     	3	2023	2025-11-03 20:25:50
938	2023-07-27	27	7	July     	3	2023	2025-11-03 20:25:50
939	2023-07-28	28	7	July     	3	2023	2025-11-03 20:25:50
940	2023-07-29	29	7	July     	3	2023	2025-11-03 20:25:50
941	2023-07-30	30	7	July     	3	2023	2025-11-03 20:25:50
942	2023-07-31	31	7	July     	3	2023	2025-11-03 20:25:50
943	2023-08-01	1	8	August   	3	2023	2025-11-03 20:25:50
944	2023-08-02	2	8	August   	3	2023	2025-11-03 20:25:50
945	2023-08-03	3	8	August   	3	2023	2025-11-03 20:25:50
946	2023-08-04	4	8	August   	3	2023	2025-11-03 20:25:50
947	2023-08-05	5	8	August   	3	2023	2025-11-03 20:25:50
948	2023-08-06	6	8	August   	3	2023	2025-11-03 20:25:50
949	2023-08-07	7	8	August   	3	2023	2025-11-03 20:25:50
950	2023-08-08	8	8	August   	3	2023	2025-11-03 20:25:50
951	2023-08-09	9	8	August   	3	2023	2025-11-03 20:25:50
952	2023-08-10	10	8	August   	3	2023	2025-11-03 20:25:50
953	2023-08-11	11	8	August   	3	2023	2025-11-03 20:25:50
954	2023-08-12	12	8	August   	3	2023	2025-11-03 20:25:50
955	2023-08-13	13	8	August   	3	2023	2025-11-03 20:25:50
956	2023-08-14	14	8	August   	3	2023	2025-11-03 20:25:50
957	2023-08-15	15	8	August   	3	2023	2025-11-03 20:25:50
958	2023-08-16	16	8	August   	3	2023	2025-11-03 20:25:50
959	2023-08-17	17	8	August   	3	2023	2025-11-03 20:25:50
960	2023-08-18	18	8	August   	3	2023	2025-11-03 20:25:50
961	2023-08-19	19	8	August   	3	2023	2025-11-03 20:25:50
962	2023-08-20	20	8	August   	3	2023	2025-11-03 20:25:50
963	2023-08-21	21	8	August   	3	2023	2025-11-03 20:25:50
964	2023-08-22	22	8	August   	3	2023	2025-11-03 20:25:50
965	2023-08-23	23	8	August   	3	2023	2025-11-03 20:25:50
966	2023-08-24	24	8	August   	3	2023	2025-11-03 20:25:50
967	2023-08-25	25	8	August   	3	2023	2025-11-03 20:25:50
968	2023-08-26	26	8	August   	3	2023	2025-11-03 20:25:50
969	2023-08-27	27	8	August   	3	2023	2025-11-03 20:25:50
970	2023-08-28	28	8	August   	3	2023	2025-11-03 20:25:50
971	2023-08-29	29	8	August   	3	2023	2025-11-03 20:25:50
972	2023-08-30	30	8	August   	3	2023	2025-11-03 20:25:50
973	2023-08-31	31	8	August   	3	2023	2025-11-03 20:25:50
974	2023-09-01	1	9	September	3	2023	2025-11-03 20:25:50
975	2023-09-02	2	9	September	3	2023	2025-11-03 20:25:50
976	2023-09-03	3	9	September	3	2023	2025-11-03 20:25:50
977	2023-09-04	4	9	September	3	2023	2025-11-03 20:25:50
978	2023-09-05	5	9	September	3	2023	2025-11-03 20:25:50
979	2023-09-06	6	9	September	3	2023	2025-11-03 20:25:50
980	2023-09-07	7	9	September	3	2023	2025-11-03 20:25:50
981	2023-09-08	8	9	September	3	2023	2025-11-03 20:25:50
982	2023-09-09	9	9	September	3	2023	2025-11-03 20:25:50
983	2023-09-10	10	9	September	3	2023	2025-11-03 20:25:50
984	2023-09-11	11	9	September	3	2023	2025-11-03 20:25:50
985	2023-09-12	12	9	September	3	2023	2025-11-03 20:25:50
986	2023-09-13	13	9	September	3	2023	2025-11-03 20:25:50
987	2023-09-14	14	9	September	3	2023	2025-11-03 20:25:50
988	2023-09-15	15	9	September	3	2023	2025-11-03 20:25:50
989	2023-09-16	16	9	September	3	2023	2025-11-03 20:25:50
990	2023-09-17	17	9	September	3	2023	2025-11-03 20:25:50
991	2023-09-18	18	9	September	3	2023	2025-11-03 20:25:50
992	2023-09-19	19	9	September	3	2023	2025-11-03 20:25:50
993	2023-09-20	20	9	September	3	2023	2025-11-03 20:25:50
994	2023-09-21	21	9	September	3	2023	2025-11-03 20:25:50
995	2023-09-22	22	9	September	3	2023	2025-11-03 20:25:50
996	2023-09-23	23	9	September	3	2023	2025-11-03 20:25:50
997	2023-09-24	24	9	September	3	2023	2025-11-03 20:25:50
998	2023-09-25	25	9	September	3	2023	2025-11-03 20:25:50
999	2023-09-26	26	9	September	3	2023	2025-11-03 20:25:50
1000	2023-09-27	27	9	September	3	2023	2025-11-03 20:25:50
1001	2023-09-28	28	9	September	3	2023	2025-11-03 20:25:50
1002	2023-09-29	29	9	September	3	2023	2025-11-03 20:25:50
1003	2023-09-30	30	9	September	3	2023	2025-11-03 20:25:50
1004	2023-10-01	1	10	October  	4	2023	2025-11-03 20:25:50
1005	2023-10-02	2	10	October  	4	2023	2025-11-03 20:25:50
1006	2023-10-03	3	10	October  	4	2023	2025-11-03 20:25:50
1007	2023-10-04	4	10	October  	4	2023	2025-11-03 20:25:50
1008	2023-10-05	5	10	October  	4	2023	2025-11-03 20:25:50
1009	2023-10-06	6	10	October  	4	2023	2025-11-03 20:25:50
1010	2023-10-07	7	10	October  	4	2023	2025-11-03 20:25:50
1011	2023-10-08	8	10	October  	4	2023	2025-11-03 20:25:50
1012	2023-10-09	9	10	October  	4	2023	2025-11-03 20:25:50
1013	2023-10-10	10	10	October  	4	2023	2025-11-03 20:25:50
1014	2023-10-11	11	10	October  	4	2023	2025-11-03 20:25:50
1015	2023-10-12	12	10	October  	4	2023	2025-11-03 20:25:50
1016	2023-10-13	13	10	October  	4	2023	2025-11-03 20:25:50
1017	2023-10-14	14	10	October  	4	2023	2025-11-03 20:25:50
1018	2023-10-15	15	10	October  	4	2023	2025-11-03 20:25:50
1019	2023-10-16	16	10	October  	4	2023	2025-11-03 20:25:50
1020	2023-10-17	17	10	October  	4	2023	2025-11-03 20:25:50
1021	2023-10-18	18	10	October  	4	2023	2025-11-03 20:25:50
1022	2023-10-19	19	10	October  	4	2023	2025-11-03 20:25:50
1023	2023-10-20	20	10	October  	4	2023	2025-11-03 20:25:50
1024	2023-10-21	21	10	October  	4	2023	2025-11-03 20:25:50
1025	2023-10-22	22	10	October  	4	2023	2025-11-03 20:25:50
1026	2023-10-23	23	10	October  	4	2023	2025-11-03 20:25:50
1027	2023-10-24	24	10	October  	4	2023	2025-11-03 20:25:50
1028	2023-10-25	25	10	October  	4	2023	2025-11-03 20:25:50
1029	2023-10-26	26	10	October  	4	2023	2025-11-03 20:25:50
1030	2023-10-27	27	10	October  	4	2023	2025-11-03 20:25:50
1031	2023-10-28	28	10	October  	4	2023	2025-11-03 20:25:50
1032	2023-10-29	29	10	October  	4	2023	2025-11-03 20:25:50
1033	2023-10-30	30	10	October  	4	2023	2025-11-03 20:25:50
1034	2023-10-31	31	10	October  	4	2023	2025-11-03 20:25:50
1035	2023-11-01	1	11	November 	4	2023	2025-11-03 20:25:50
1036	2023-11-02	2	11	November 	4	2023	2025-11-03 20:25:50
1037	2023-11-03	3	11	November 	4	2023	2025-11-03 20:25:50
1038	2023-11-04	4	11	November 	4	2023	2025-11-03 20:25:50
1039	2023-11-05	5	11	November 	4	2023	2025-11-03 20:25:50
1040	2023-11-06	6	11	November 	4	2023	2025-11-03 20:25:50
1041	2023-11-07	7	11	November 	4	2023	2025-11-03 20:25:50
1042	2023-11-08	8	11	November 	4	2023	2025-11-03 20:25:50
1043	2023-11-09	9	11	November 	4	2023	2025-11-03 20:25:50
1044	2023-11-10	10	11	November 	4	2023	2025-11-03 20:25:50
1045	2023-11-11	11	11	November 	4	2023	2025-11-03 20:25:50
1046	2023-11-12	12	11	November 	4	2023	2025-11-03 20:25:50
1047	2023-11-13	13	11	November 	4	2023	2025-11-03 20:25:50
1048	2023-11-14	14	11	November 	4	2023	2025-11-03 20:25:50
1049	2023-11-15	15	11	November 	4	2023	2025-11-03 20:25:50
1050	2023-11-16	16	11	November 	4	2023	2025-11-03 20:25:50
1051	2023-11-17	17	11	November 	4	2023	2025-11-03 20:25:50
1052	2023-11-18	18	11	November 	4	2023	2025-11-03 20:25:50
1053	2023-11-19	19	11	November 	4	2023	2025-11-03 20:25:50
1054	2023-11-20	20	11	November 	4	2023	2025-11-03 20:25:50
1055	2023-11-21	21	11	November 	4	2023	2025-11-03 20:25:50
1056	2023-11-22	22	11	November 	4	2023	2025-11-03 20:25:50
1057	2023-11-23	23	11	November 	4	2023	2025-11-03 20:25:50
1058	2023-11-24	24	11	November 	4	2023	2025-11-03 20:25:50
1059	2023-11-25	25	11	November 	4	2023	2025-11-03 20:25:50
1060	2023-11-26	26	11	November 	4	2023	2025-11-03 20:25:50
1061	2023-11-27	27	11	November 	4	2023	2025-11-03 20:25:50
1062	2023-11-28	28	11	November 	4	2023	2025-11-03 20:25:50
1063	2023-11-29	29	11	November 	4	2023	2025-11-03 20:25:50
1064	2023-11-30	30	11	November 	4	2023	2025-11-03 20:25:50
1065	2023-12-01	1	12	December 	4	2023	2025-11-03 20:25:50
1066	2023-12-02	2	12	December 	4	2023	2025-11-03 20:25:50
1067	2023-12-03	3	12	December 	4	2023	2025-11-03 20:25:50
1068	2023-12-04	4	12	December 	4	2023	2025-11-03 20:25:50
1069	2023-12-05	5	12	December 	4	2023	2025-11-03 20:25:50
1070	2023-12-06	6	12	December 	4	2023	2025-11-03 20:25:50
1071	2023-12-07	7	12	December 	4	2023	2025-11-03 20:25:50
1072	2023-12-08	8	12	December 	4	2023	2025-11-03 20:25:50
1073	2023-12-09	9	12	December 	4	2023	2025-11-03 20:25:50
1074	2023-12-10	10	12	December 	4	2023	2025-11-03 20:25:50
1075	2023-12-11	11	12	December 	4	2023	2025-11-03 20:25:50
1076	2023-12-12	12	12	December 	4	2023	2025-11-03 20:25:50
1077	2023-12-13	13	12	December 	4	2023	2025-11-03 20:25:50
1078	2023-12-14	14	12	December 	4	2023	2025-11-03 20:25:50
1079	2023-12-15	15	12	December 	4	2023	2025-11-03 20:25:50
1080	2023-12-16	16	12	December 	4	2023	2025-11-03 20:25:50
1081	2023-12-17	17	12	December 	4	2023	2025-11-03 20:25:50
1082	2023-12-18	18	12	December 	4	2023	2025-11-03 20:25:50
1083	2023-12-19	19	12	December 	4	2023	2025-11-03 20:25:50
1084	2023-12-20	20	12	December 	4	2023	2025-11-03 20:25:50
1085	2023-12-21	21	12	December 	4	2023	2025-11-03 20:25:50
1086	2023-12-22	22	12	December 	4	2023	2025-11-03 20:25:50
1087	2023-12-23	23	12	December 	4	2023	2025-11-03 20:25:50
1088	2023-12-24	24	12	December 	4	2023	2025-11-03 20:25:50
1089	2023-12-25	25	12	December 	4	2023	2025-11-03 20:25:50
1090	2023-12-26	26	12	December 	4	2023	2025-11-03 20:25:50
1091	2023-12-27	27	12	December 	4	2023	2025-11-03 20:25:50
1092	2023-12-28	28	12	December 	4	2023	2025-11-03 20:25:50
1093	2023-12-29	29	12	December 	4	2023	2025-11-03 20:25:50
1094	2023-12-30	30	12	December 	4	2023	2025-11-03 20:25:50
1095	2023-12-31	31	12	December 	4	2023	2025-11-03 20:25:50
1096	2024-01-01	1	1	January  	1	2024	2025-11-03 20:25:50
1097	2024-01-02	2	1	January  	1	2024	2025-11-03 20:25:50
1098	2024-01-03	3	1	January  	1	2024	2025-11-03 20:25:50
1099	2024-01-04	4	1	January  	1	2024	2025-11-03 20:25:50
1100	2024-01-05	5	1	January  	1	2024	2025-11-03 20:25:50
1101	2024-01-06	6	1	January  	1	2024	2025-11-03 20:25:50
1102	2024-01-07	7	1	January  	1	2024	2025-11-03 20:25:50
1103	2024-01-08	8	1	January  	1	2024	2025-11-03 20:25:50
1104	2024-01-09	9	1	January  	1	2024	2025-11-03 20:25:50
1105	2024-01-10	10	1	January  	1	2024	2025-11-03 20:25:50
1106	2024-01-11	11	1	January  	1	2024	2025-11-03 20:25:50
1107	2024-01-12	12	1	January  	1	2024	2025-11-03 20:25:50
1108	2024-01-13	13	1	January  	1	2024	2025-11-03 20:25:50
1109	2024-01-14	14	1	January  	1	2024	2025-11-03 20:25:50
1110	2024-01-15	15	1	January  	1	2024	2025-11-03 20:25:50
1111	2024-01-16	16	1	January  	1	2024	2025-11-03 20:25:50
1112	2024-01-17	17	1	January  	1	2024	2025-11-03 20:25:50
1113	2024-01-18	18	1	January  	1	2024	2025-11-03 20:25:50
1114	2024-01-19	19	1	January  	1	2024	2025-11-03 20:25:50
1115	2024-01-20	20	1	January  	1	2024	2025-11-03 20:25:50
1116	2024-01-21	21	1	January  	1	2024	2025-11-03 20:25:50
1117	2024-01-22	22	1	January  	1	2024	2025-11-03 20:25:50
1118	2024-01-23	23	1	January  	1	2024	2025-11-03 20:25:50
1119	2024-01-24	24	1	January  	1	2024	2025-11-03 20:25:50
1120	2024-01-25	25	1	January  	1	2024	2025-11-03 20:25:50
1121	2024-01-26	26	1	January  	1	2024	2025-11-03 20:25:50
1122	2024-01-27	27	1	January  	1	2024	2025-11-03 20:25:50
1123	2024-01-28	28	1	January  	1	2024	2025-11-03 20:25:50
1124	2024-01-29	29	1	January  	1	2024	2025-11-03 20:25:50
1125	2024-01-30	30	1	January  	1	2024	2025-11-03 20:25:50
1126	2024-01-31	31	1	January  	1	2024	2025-11-03 20:25:50
1127	2024-02-01	1	2	February 	1	2024	2025-11-03 20:25:50
1128	2024-02-02	2	2	February 	1	2024	2025-11-03 20:25:50
1129	2024-02-03	3	2	February 	1	2024	2025-11-03 20:25:50
1130	2024-02-04	4	2	February 	1	2024	2025-11-03 20:25:50
1131	2024-02-05	5	2	February 	1	2024	2025-11-03 20:25:50
1132	2024-02-06	6	2	February 	1	2024	2025-11-03 20:25:50
1133	2024-02-07	7	2	February 	1	2024	2025-11-03 20:25:50
1134	2024-02-08	8	2	February 	1	2024	2025-11-03 20:25:50
1135	2024-02-09	9	2	February 	1	2024	2025-11-03 20:25:50
1136	2024-02-10	10	2	February 	1	2024	2025-11-03 20:25:50
1137	2024-02-11	11	2	February 	1	2024	2025-11-03 20:25:50
1138	2024-02-12	12	2	February 	1	2024	2025-11-03 20:25:50
1139	2024-02-13	13	2	February 	1	2024	2025-11-03 20:25:50
1140	2024-02-14	14	2	February 	1	2024	2025-11-03 20:25:50
1141	2024-02-15	15	2	February 	1	2024	2025-11-03 20:25:50
1142	2024-02-16	16	2	February 	1	2024	2025-11-03 20:25:50
1143	2024-02-17	17	2	February 	1	2024	2025-11-03 20:25:50
1144	2024-02-18	18	2	February 	1	2024	2025-11-03 20:25:50
1145	2024-02-19	19	2	February 	1	2024	2025-11-03 20:25:50
1146	2024-02-20	20	2	February 	1	2024	2025-11-03 20:25:50
1147	2024-02-21	21	2	February 	1	2024	2025-11-03 20:25:50
1148	2024-02-22	22	2	February 	1	2024	2025-11-03 20:25:50
1149	2024-02-23	23	2	February 	1	2024	2025-11-03 20:25:50
1150	2024-02-24	24	2	February 	1	2024	2025-11-03 20:25:50
1151	2024-02-25	25	2	February 	1	2024	2025-11-03 20:25:50
1152	2024-02-26	26	2	February 	1	2024	2025-11-03 20:25:50
1153	2024-02-27	27	2	February 	1	2024	2025-11-03 20:25:50
1154	2024-02-28	28	2	February 	1	2024	2025-11-03 20:25:50
1155	2024-02-29	29	2	February 	1	2024	2025-11-03 20:25:50
1156	2024-03-01	1	3	March    	1	2024	2025-11-03 20:25:50
1157	2024-03-02	2	3	March    	1	2024	2025-11-03 20:25:50
1158	2024-03-03	3	3	March    	1	2024	2025-11-03 20:25:50
1159	2024-03-04	4	3	March    	1	2024	2025-11-03 20:25:50
1160	2024-03-05	5	3	March    	1	2024	2025-11-03 20:25:50
1161	2024-03-06	6	3	March    	1	2024	2025-11-03 20:25:50
1162	2024-03-07	7	3	March    	1	2024	2025-11-03 20:25:50
1163	2024-03-08	8	3	March    	1	2024	2025-11-03 20:25:50
1164	2024-03-09	9	3	March    	1	2024	2025-11-03 20:25:50
1165	2024-03-10	10	3	March    	1	2024	2025-11-03 20:25:50
1166	2024-03-11	11	3	March    	1	2024	2025-11-03 20:25:50
1167	2024-03-12	12	3	March    	1	2024	2025-11-03 20:25:50
1168	2024-03-13	13	3	March    	1	2024	2025-11-03 20:25:50
1169	2024-03-14	14	3	March    	1	2024	2025-11-03 20:25:50
1170	2024-03-15	15	3	March    	1	2024	2025-11-03 20:25:50
1171	2024-03-16	16	3	March    	1	2024	2025-11-03 20:25:50
1172	2024-03-17	17	3	March    	1	2024	2025-11-03 20:25:50
1173	2024-03-18	18	3	March    	1	2024	2025-11-03 20:25:50
1174	2024-03-19	19	3	March    	1	2024	2025-11-03 20:25:50
1175	2024-03-20	20	3	March    	1	2024	2025-11-03 20:25:50
1176	2024-03-21	21	3	March    	1	2024	2025-11-03 20:25:50
1177	2024-03-22	22	3	March    	1	2024	2025-11-03 20:25:50
1178	2024-03-23	23	3	March    	1	2024	2025-11-03 20:25:50
1179	2024-03-24	24	3	March    	1	2024	2025-11-03 20:25:50
1180	2024-03-25	25	3	March    	1	2024	2025-11-03 20:25:50
1181	2024-03-26	26	3	March    	1	2024	2025-11-03 20:25:50
1182	2024-03-27	27	3	March    	1	2024	2025-11-03 20:25:50
1183	2024-03-28	28	3	March    	1	2024	2025-11-03 20:25:50
1184	2024-03-29	29	3	March    	1	2024	2025-11-03 20:25:50
1185	2024-03-30	30	3	March    	1	2024	2025-11-03 20:25:50
1186	2024-03-31	31	3	March    	1	2024	2025-11-03 20:25:50
1187	2024-04-01	1	4	April    	2	2024	2025-11-03 20:25:50
1188	2024-04-02	2	4	April    	2	2024	2025-11-03 20:25:50
1189	2024-04-03	3	4	April    	2	2024	2025-11-03 20:25:50
1190	2024-04-04	4	4	April    	2	2024	2025-11-03 20:25:50
1191	2024-04-05	5	4	April    	2	2024	2025-11-03 20:25:50
1192	2024-04-06	6	4	April    	2	2024	2025-11-03 20:25:50
1193	2024-04-07	7	4	April    	2	2024	2025-11-03 20:25:50
1194	2024-04-08	8	4	April    	2	2024	2025-11-03 20:25:50
1195	2024-04-09	9	4	April    	2	2024	2025-11-03 20:25:50
1196	2024-04-10	10	4	April    	2	2024	2025-11-03 20:25:50
1197	2024-04-11	11	4	April    	2	2024	2025-11-03 20:25:50
1198	2024-04-12	12	4	April    	2	2024	2025-11-03 20:25:50
1199	2024-04-13	13	4	April    	2	2024	2025-11-03 20:25:50
1200	2024-04-14	14	4	April    	2	2024	2025-11-03 20:25:50
1201	2024-04-15	15	4	April    	2	2024	2025-11-03 20:25:50
1202	2024-04-16	16	4	April    	2	2024	2025-11-03 20:25:50
1203	2024-04-17	17	4	April    	2	2024	2025-11-03 20:25:50
1204	2024-04-18	18	4	April    	2	2024	2025-11-03 20:25:50
1205	2024-04-19	19	4	April    	2	2024	2025-11-03 20:25:50
1206	2024-04-20	20	4	April    	2	2024	2025-11-03 20:25:50
1207	2024-04-21	21	4	April    	2	2024	2025-11-03 20:25:50
1208	2024-04-22	22	4	April    	2	2024	2025-11-03 20:25:50
1209	2024-04-23	23	4	April    	2	2024	2025-11-03 20:25:50
1210	2024-04-24	24	4	April    	2	2024	2025-11-03 20:25:50
1211	2024-04-25	25	4	April    	2	2024	2025-11-03 20:25:50
1212	2024-04-26	26	4	April    	2	2024	2025-11-03 20:25:50
1213	2024-04-27	27	4	April    	2	2024	2025-11-03 20:25:50
1214	2024-04-28	28	4	April    	2	2024	2025-11-03 20:25:50
1215	2024-04-29	29	4	April    	2	2024	2025-11-03 20:25:50
1216	2024-04-30	30	4	April    	2	2024	2025-11-03 20:25:50
1217	2024-05-01	1	5	May      	2	2024	2025-11-03 20:25:50
1218	2024-05-02	2	5	May      	2	2024	2025-11-03 20:25:50
1219	2024-05-03	3	5	May      	2	2024	2025-11-03 20:25:50
1220	2024-05-04	4	5	May      	2	2024	2025-11-03 20:25:50
1221	2024-05-05	5	5	May      	2	2024	2025-11-03 20:25:50
1222	2024-05-06	6	5	May      	2	2024	2025-11-03 20:25:50
1223	2024-05-07	7	5	May      	2	2024	2025-11-03 20:25:50
1224	2024-05-08	8	5	May      	2	2024	2025-11-03 20:25:50
1225	2024-05-09	9	5	May      	2	2024	2025-11-03 20:25:50
1226	2024-05-10	10	5	May      	2	2024	2025-11-03 20:25:50
1227	2024-05-11	11	5	May      	2	2024	2025-11-03 20:25:50
1228	2024-05-12	12	5	May      	2	2024	2025-11-03 20:25:50
1229	2024-05-13	13	5	May      	2	2024	2025-11-03 20:25:50
1230	2024-05-14	14	5	May      	2	2024	2025-11-03 20:25:50
1231	2024-05-15	15	5	May      	2	2024	2025-11-03 20:25:50
1232	2024-05-16	16	5	May      	2	2024	2025-11-03 20:25:50
1233	2024-05-17	17	5	May      	2	2024	2025-11-03 20:25:50
1234	2024-05-18	18	5	May      	2	2024	2025-11-03 20:25:50
1235	2024-05-19	19	5	May      	2	2024	2025-11-03 20:25:50
1236	2024-05-20	20	5	May      	2	2024	2025-11-03 20:25:50
1237	2024-05-21	21	5	May      	2	2024	2025-11-03 20:25:50
1238	2024-05-22	22	5	May      	2	2024	2025-11-03 20:25:50
1239	2024-05-23	23	5	May      	2	2024	2025-11-03 20:25:50
1240	2024-05-24	24	5	May      	2	2024	2025-11-03 20:25:50
1241	2024-05-25	25	5	May      	2	2024	2025-11-03 20:25:50
1242	2024-05-26	26	5	May      	2	2024	2025-11-03 20:25:50
1243	2024-05-27	27	5	May      	2	2024	2025-11-03 20:25:50
1244	2024-05-28	28	5	May      	2	2024	2025-11-03 20:25:50
1245	2024-05-29	29	5	May      	2	2024	2025-11-03 20:25:50
1246	2024-05-30	30	5	May      	2	2024	2025-11-03 20:25:50
1247	2024-05-31	31	5	May      	2	2024	2025-11-03 20:25:50
1248	2024-06-01	1	6	June     	2	2024	2025-11-03 20:25:50
1249	2024-06-02	2	6	June     	2	2024	2025-11-03 20:25:50
1250	2024-06-03	3	6	June     	2	2024	2025-11-03 20:25:50
1251	2024-06-04	4	6	June     	2	2024	2025-11-03 20:25:50
1252	2024-06-05	5	6	June     	2	2024	2025-11-03 20:25:50
1253	2024-06-06	6	6	June     	2	2024	2025-11-03 20:25:50
1254	2024-06-07	7	6	June     	2	2024	2025-11-03 20:25:50
1255	2024-06-08	8	6	June     	2	2024	2025-11-03 20:25:50
1256	2024-06-09	9	6	June     	2	2024	2025-11-03 20:25:50
1257	2024-06-10	10	6	June     	2	2024	2025-11-03 20:25:50
1258	2024-06-11	11	6	June     	2	2024	2025-11-03 20:25:50
1259	2024-06-12	12	6	June     	2	2024	2025-11-03 20:25:50
1260	2024-06-13	13	6	June     	2	2024	2025-11-03 20:25:50
1261	2024-06-14	14	6	June     	2	2024	2025-11-03 20:25:50
1262	2024-06-15	15	6	June     	2	2024	2025-11-03 20:25:50
1263	2024-06-16	16	6	June     	2	2024	2025-11-03 20:25:50
1264	2024-06-17	17	6	June     	2	2024	2025-11-03 20:25:50
1265	2024-06-18	18	6	June     	2	2024	2025-11-03 20:25:50
1266	2024-06-19	19	6	June     	2	2024	2025-11-03 20:25:50
1267	2024-06-20	20	6	June     	2	2024	2025-11-03 20:25:50
1268	2024-06-21	21	6	June     	2	2024	2025-11-03 20:25:50
1269	2024-06-22	22	6	June     	2	2024	2025-11-03 20:25:50
1270	2024-06-23	23	6	June     	2	2024	2025-11-03 20:25:50
1271	2024-06-24	24	6	June     	2	2024	2025-11-03 20:25:50
1272	2024-06-25	25	6	June     	2	2024	2025-11-03 20:25:50
1273	2024-06-26	26	6	June     	2	2024	2025-11-03 20:25:50
1274	2024-06-27	27	6	June     	2	2024	2025-11-03 20:25:50
1275	2024-06-28	28	6	June     	2	2024	2025-11-03 20:25:50
1276	2024-06-29	29	6	June     	2	2024	2025-11-03 20:25:50
1277	2024-06-30	30	6	June     	2	2024	2025-11-03 20:25:50
1278	2024-07-01	1	7	July     	3	2024	2025-11-03 20:25:50
1279	2024-07-02	2	7	July     	3	2024	2025-11-03 20:25:50
1280	2024-07-03	3	7	July     	3	2024	2025-11-03 20:25:50
1281	2024-07-04	4	7	July     	3	2024	2025-11-03 20:25:50
1282	2024-07-05	5	7	July     	3	2024	2025-11-03 20:25:50
1283	2024-07-06	6	7	July     	3	2024	2025-11-03 20:25:50
1284	2024-07-07	7	7	July     	3	2024	2025-11-03 20:25:50
1285	2024-07-08	8	7	July     	3	2024	2025-11-03 20:25:50
1286	2024-07-09	9	7	July     	3	2024	2025-11-03 20:25:50
1287	2024-07-10	10	7	July     	3	2024	2025-11-03 20:25:50
1288	2024-07-11	11	7	July     	3	2024	2025-11-03 20:25:50
1289	2024-07-12	12	7	July     	3	2024	2025-11-03 20:25:50
1290	2024-07-13	13	7	July     	3	2024	2025-11-03 20:25:50
1291	2024-07-14	14	7	July     	3	2024	2025-11-03 20:25:50
1292	2024-07-15	15	7	July     	3	2024	2025-11-03 20:25:50
1293	2024-07-16	16	7	July     	3	2024	2025-11-03 20:25:50
1294	2024-07-17	17	7	July     	3	2024	2025-11-03 20:25:50
1295	2024-07-18	18	7	July     	3	2024	2025-11-03 20:25:50
1296	2024-07-19	19	7	July     	3	2024	2025-11-03 20:25:50
1297	2024-07-20	20	7	July     	3	2024	2025-11-03 20:25:50
1298	2024-07-21	21	7	July     	3	2024	2025-11-03 20:25:50
1299	2024-07-22	22	7	July     	3	2024	2025-11-03 20:25:50
1300	2024-07-23	23	7	July     	3	2024	2025-11-03 20:25:50
1301	2024-07-24	24	7	July     	3	2024	2025-11-03 20:25:50
1302	2024-07-25	25	7	July     	3	2024	2025-11-03 20:25:50
1303	2024-07-26	26	7	July     	3	2024	2025-11-03 20:25:50
1304	2024-07-27	27	7	July     	3	2024	2025-11-03 20:25:50
1305	2024-07-28	28	7	July     	3	2024	2025-11-03 20:25:50
1306	2024-07-29	29	7	July     	3	2024	2025-11-03 20:25:50
1307	2024-07-30	30	7	July     	3	2024	2025-11-03 20:25:50
1308	2024-07-31	31	7	July     	3	2024	2025-11-03 20:25:50
1309	2024-08-01	1	8	August   	3	2024	2025-11-03 20:25:50
1310	2024-08-02	2	8	August   	3	2024	2025-11-03 20:25:50
1311	2024-08-03	3	8	August   	3	2024	2025-11-03 20:25:50
1312	2024-08-04	4	8	August   	3	2024	2025-11-03 20:25:50
1313	2024-08-05	5	8	August   	3	2024	2025-11-03 20:25:50
1314	2024-08-06	6	8	August   	3	2024	2025-11-03 20:25:50
1315	2024-08-07	7	8	August   	3	2024	2025-11-03 20:25:50
1316	2024-08-08	8	8	August   	3	2024	2025-11-03 20:25:50
1317	2024-08-09	9	8	August   	3	2024	2025-11-03 20:25:50
1318	2024-08-10	10	8	August   	3	2024	2025-11-03 20:25:50
1319	2024-08-11	11	8	August   	3	2024	2025-11-03 20:25:50
1320	2024-08-12	12	8	August   	3	2024	2025-11-03 20:25:50
1321	2024-08-13	13	8	August   	3	2024	2025-11-03 20:25:50
1322	2024-08-14	14	8	August   	3	2024	2025-11-03 20:25:50
1323	2024-08-15	15	8	August   	3	2024	2025-11-03 20:25:50
1324	2024-08-16	16	8	August   	3	2024	2025-11-03 20:25:50
1325	2024-08-17	17	8	August   	3	2024	2025-11-03 20:25:50
1326	2024-08-18	18	8	August   	3	2024	2025-11-03 20:25:50
1327	2024-08-19	19	8	August   	3	2024	2025-11-03 20:25:50
1328	2024-08-20	20	8	August   	3	2024	2025-11-03 20:25:50
1329	2024-08-21	21	8	August   	3	2024	2025-11-03 20:25:50
1330	2024-08-22	22	8	August   	3	2024	2025-11-03 20:25:50
1331	2024-08-23	23	8	August   	3	2024	2025-11-03 20:25:50
1332	2024-08-24	24	8	August   	3	2024	2025-11-03 20:25:50
1333	2024-08-25	25	8	August   	3	2024	2025-11-03 20:25:50
1334	2024-08-26	26	8	August   	3	2024	2025-11-03 20:25:50
1335	2024-08-27	27	8	August   	3	2024	2025-11-03 20:25:50
1336	2024-08-28	28	8	August   	3	2024	2025-11-03 20:25:50
1337	2024-08-29	29	8	August   	3	2024	2025-11-03 20:25:50
1338	2024-08-30	30	8	August   	3	2024	2025-11-03 20:25:50
1339	2024-08-31	31	8	August   	3	2024	2025-11-03 20:25:50
1340	2024-09-01	1	9	September	3	2024	2025-11-03 20:25:50
1341	2024-09-02	2	9	September	3	2024	2025-11-03 20:25:50
1342	2024-09-03	3	9	September	3	2024	2025-11-03 20:25:50
1343	2024-09-04	4	9	September	3	2024	2025-11-03 20:25:50
1344	2024-09-05	5	9	September	3	2024	2025-11-03 20:25:50
1345	2024-09-06	6	9	September	3	2024	2025-11-03 20:25:50
1346	2024-09-07	7	9	September	3	2024	2025-11-03 20:25:50
1347	2024-09-08	8	9	September	3	2024	2025-11-03 20:25:50
1348	2024-09-09	9	9	September	3	2024	2025-11-03 20:25:50
1349	2024-09-10	10	9	September	3	2024	2025-11-03 20:25:50
1350	2024-09-11	11	9	September	3	2024	2025-11-03 20:25:50
1351	2024-09-12	12	9	September	3	2024	2025-11-03 20:25:50
1352	2024-09-13	13	9	September	3	2024	2025-11-03 20:25:50
1353	2024-09-14	14	9	September	3	2024	2025-11-03 20:25:50
1354	2024-09-15	15	9	September	3	2024	2025-11-03 20:25:50
1355	2024-09-16	16	9	September	3	2024	2025-11-03 20:25:50
1356	2024-09-17	17	9	September	3	2024	2025-11-03 20:25:50
1357	2024-09-18	18	9	September	3	2024	2025-11-03 20:25:50
1358	2024-09-19	19	9	September	3	2024	2025-11-03 20:25:50
1359	2024-09-20	20	9	September	3	2024	2025-11-03 20:25:50
1360	2024-09-21	21	9	September	3	2024	2025-11-03 20:25:50
1361	2024-09-22	22	9	September	3	2024	2025-11-03 20:25:50
1362	2024-09-23	23	9	September	3	2024	2025-11-03 20:25:50
1363	2024-09-24	24	9	September	3	2024	2025-11-03 20:25:50
1364	2024-09-25	25	9	September	3	2024	2025-11-03 20:25:50
1365	2024-09-26	26	9	September	3	2024	2025-11-03 20:25:50
1366	2024-09-27	27	9	September	3	2024	2025-11-03 20:25:50
1367	2024-09-28	28	9	September	3	2024	2025-11-03 20:25:50
1368	2024-09-29	29	9	September	3	2024	2025-11-03 20:25:50
1369	2024-09-30	30	9	September	3	2024	2025-11-03 20:25:50
1370	2024-10-01	1	10	October  	4	2024	2025-11-03 20:25:50
1371	2024-10-02	2	10	October  	4	2024	2025-11-03 20:25:50
1372	2024-10-03	3	10	October  	4	2024	2025-11-03 20:25:50
1373	2024-10-04	4	10	October  	4	2024	2025-11-03 20:25:50
1374	2024-10-05	5	10	October  	4	2024	2025-11-03 20:25:50
1375	2024-10-06	6	10	October  	4	2024	2025-11-03 20:25:50
1376	2024-10-07	7	10	October  	4	2024	2025-11-03 20:25:50
1377	2024-10-08	8	10	October  	4	2024	2025-11-03 20:25:50
1378	2024-10-09	9	10	October  	4	2024	2025-11-03 20:25:50
1379	2024-10-10	10	10	October  	4	2024	2025-11-03 20:25:50
1380	2024-10-11	11	10	October  	4	2024	2025-11-03 20:25:50
1381	2024-10-12	12	10	October  	4	2024	2025-11-03 20:25:50
1382	2024-10-13	13	10	October  	4	2024	2025-11-03 20:25:50
1383	2024-10-14	14	10	October  	4	2024	2025-11-03 20:25:50
1384	2024-10-15	15	10	October  	4	2024	2025-11-03 20:25:50
1385	2024-10-16	16	10	October  	4	2024	2025-11-03 20:25:50
1386	2024-10-17	17	10	October  	4	2024	2025-11-03 20:25:50
1387	2024-10-18	18	10	October  	4	2024	2025-11-03 20:25:50
1388	2024-10-19	19	10	October  	4	2024	2025-11-03 20:25:50
1389	2024-10-20	20	10	October  	4	2024	2025-11-03 20:25:50
1390	2024-10-21	21	10	October  	4	2024	2025-11-03 20:25:50
1391	2024-10-22	22	10	October  	4	2024	2025-11-03 20:25:50
1392	2024-10-23	23	10	October  	4	2024	2025-11-03 20:25:50
1393	2024-10-24	24	10	October  	4	2024	2025-11-03 20:25:50
1394	2024-10-25	25	10	October  	4	2024	2025-11-03 20:25:50
1395	2024-10-26	26	10	October  	4	2024	2025-11-03 20:25:50
1396	2024-10-27	27	10	October  	4	2024	2025-11-03 20:25:50
1397	2024-10-28	28	10	October  	4	2024	2025-11-03 20:25:50
1398	2024-10-29	29	10	October  	4	2024	2025-11-03 20:25:50
1399	2024-10-30	30	10	October  	4	2024	2025-11-03 20:25:50
1400	2024-10-31	31	10	October  	4	2024	2025-11-03 20:25:50
1401	2024-11-01	1	11	November 	4	2024	2025-11-03 20:25:50
1402	2024-11-02	2	11	November 	4	2024	2025-11-03 20:25:50
1403	2024-11-03	3	11	November 	4	2024	2025-11-03 20:25:50
1404	2024-11-04	4	11	November 	4	2024	2025-11-03 20:25:50
1405	2024-11-05	5	11	November 	4	2024	2025-11-03 20:25:50
1406	2024-11-06	6	11	November 	4	2024	2025-11-03 20:25:50
1407	2024-11-07	7	11	November 	4	2024	2025-11-03 20:25:50
1408	2024-11-08	8	11	November 	4	2024	2025-11-03 20:25:50
1409	2024-11-09	9	11	November 	4	2024	2025-11-03 20:25:50
1410	2024-11-10	10	11	November 	4	2024	2025-11-03 20:25:50
1411	2024-11-11	11	11	November 	4	2024	2025-11-03 20:25:50
1412	2024-11-12	12	11	November 	4	2024	2025-11-03 20:25:50
1413	2024-11-13	13	11	November 	4	2024	2025-11-03 20:25:50
1414	2024-11-14	14	11	November 	4	2024	2025-11-03 20:25:50
1415	2024-11-15	15	11	November 	4	2024	2025-11-03 20:25:50
1416	2024-11-16	16	11	November 	4	2024	2025-11-03 20:25:50
1417	2024-11-17	17	11	November 	4	2024	2025-11-03 20:25:50
1418	2024-11-18	18	11	November 	4	2024	2025-11-03 20:25:50
1419	2024-11-19	19	11	November 	4	2024	2025-11-03 20:25:50
1420	2024-11-20	20	11	November 	4	2024	2025-11-03 20:25:50
1421	2024-11-21	21	11	November 	4	2024	2025-11-03 20:25:50
1422	2024-11-22	22	11	November 	4	2024	2025-11-03 20:25:50
1423	2024-11-23	23	11	November 	4	2024	2025-11-03 20:25:50
1424	2024-11-24	24	11	November 	4	2024	2025-11-03 20:25:50
1425	2024-11-25	25	11	November 	4	2024	2025-11-03 20:25:50
1426	2024-11-26	26	11	November 	4	2024	2025-11-03 20:25:50
1427	2024-11-27	27	11	November 	4	2024	2025-11-03 20:25:50
1428	2024-11-28	28	11	November 	4	2024	2025-11-03 20:25:50
1429	2024-11-29	29	11	November 	4	2024	2025-11-03 20:25:50
1430	2024-11-30	30	11	November 	4	2024	2025-11-03 20:25:50
1431	2024-12-01	1	12	December 	4	2024	2025-11-03 20:25:50
1432	2024-12-02	2	12	December 	4	2024	2025-11-03 20:25:50
1433	2024-12-03	3	12	December 	4	2024	2025-11-03 20:25:50
1434	2024-12-04	4	12	December 	4	2024	2025-11-03 20:25:50
1435	2024-12-05	5	12	December 	4	2024	2025-11-03 20:25:50
1436	2024-12-06	6	12	December 	4	2024	2025-11-03 20:25:50
1437	2024-12-07	7	12	December 	4	2024	2025-11-03 20:25:50
1438	2024-12-08	8	12	December 	4	2024	2025-11-03 20:25:50
1439	2024-12-09	9	12	December 	4	2024	2025-11-03 20:25:50
1440	2024-12-10	10	12	December 	4	2024	2025-11-03 20:25:50
1441	2024-12-11	11	12	December 	4	2024	2025-11-03 20:25:50
1442	2024-12-12	12	12	December 	4	2024	2025-11-03 20:25:50
1443	2024-12-13	13	12	December 	4	2024	2025-11-03 20:25:50
1444	2024-12-14	14	12	December 	4	2024	2025-11-03 20:25:50
1445	2024-12-15	15	12	December 	4	2024	2025-11-03 20:25:50
1446	2024-12-16	16	12	December 	4	2024	2025-11-03 20:25:50
1447	2024-12-17	17	12	December 	4	2024	2025-11-03 20:25:50
1448	2024-12-18	18	12	December 	4	2024	2025-11-03 20:25:50
1449	2024-12-19	19	12	December 	4	2024	2025-11-03 20:25:50
1450	2024-12-20	20	12	December 	4	2024	2025-11-03 20:25:50
1451	2024-12-21	21	12	December 	4	2024	2025-11-03 20:25:50
1452	2024-12-22	22	12	December 	4	2024	2025-11-03 20:25:50
1453	2024-12-23	23	12	December 	4	2024	2025-11-03 20:25:50
1454	2024-12-24	24	12	December 	4	2024	2025-11-03 20:25:50
1455	2024-12-25	25	12	December 	4	2024	2025-11-03 20:25:50
1456	2024-12-26	26	12	December 	4	2024	2025-11-03 20:25:50
1457	2024-12-27	27	12	December 	4	2024	2025-11-03 20:25:50
1458	2024-12-28	28	12	December 	4	2024	2025-11-03 20:25:50
1459	2024-12-29	29	12	December 	4	2024	2025-11-03 20:25:50
1460	2024-12-30	30	12	December 	4	2024	2025-11-03 20:25:50
1461	2024-12-31	31	12	December 	4	2024	2025-11-03 20:25:50
1462	2025-01-01	1	1	January  	1	2025	2025-11-03 20:25:50
1463	2025-01-02	2	1	January  	1	2025	2025-11-03 20:25:50
1464	2025-01-03	3	1	January  	1	2025	2025-11-03 20:25:50
1465	2025-01-04	4	1	January  	1	2025	2025-11-03 20:25:50
1466	2025-01-05	5	1	January  	1	2025	2025-11-03 20:25:50
1467	2025-01-06	6	1	January  	1	2025	2025-11-03 20:25:50
1468	2025-01-07	7	1	January  	1	2025	2025-11-03 20:25:50
1469	2025-01-08	8	1	January  	1	2025	2025-11-03 20:25:50
1470	2025-01-09	9	1	January  	1	2025	2025-11-03 20:25:50
1471	2025-01-10	10	1	January  	1	2025	2025-11-03 20:25:50
1472	2025-01-11	11	1	January  	1	2025	2025-11-03 20:25:50
1473	2025-01-12	12	1	January  	1	2025	2025-11-03 20:25:50
1474	2025-01-13	13	1	January  	1	2025	2025-11-03 20:25:50
1475	2025-01-14	14	1	January  	1	2025	2025-11-03 20:25:50
1476	2025-01-15	15	1	January  	1	2025	2025-11-03 20:25:50
1477	2025-01-16	16	1	January  	1	2025	2025-11-03 20:25:50
1478	2025-01-17	17	1	January  	1	2025	2025-11-03 20:25:50
1479	2025-01-18	18	1	January  	1	2025	2025-11-03 20:25:50
1480	2025-01-19	19	1	January  	1	2025	2025-11-03 20:25:50
1481	2025-01-20	20	1	January  	1	2025	2025-11-03 20:25:50
1482	2025-01-21	21	1	January  	1	2025	2025-11-03 20:25:50
1483	2025-01-22	22	1	January  	1	2025	2025-11-03 20:25:50
1484	2025-01-23	23	1	January  	1	2025	2025-11-03 20:25:50
1485	2025-01-24	24	1	January  	1	2025	2025-11-03 20:25:50
1486	2025-01-25	25	1	January  	1	2025	2025-11-03 20:25:50
1487	2025-01-26	26	1	January  	1	2025	2025-11-03 20:25:50
1488	2025-01-27	27	1	January  	1	2025	2025-11-03 20:25:50
1489	2025-01-28	28	1	January  	1	2025	2025-11-03 20:25:50
1490	2025-01-29	29	1	January  	1	2025	2025-11-03 20:25:50
1491	2025-01-30	30	1	January  	1	2025	2025-11-03 20:25:50
1492	2025-01-31	31	1	January  	1	2025	2025-11-03 20:25:50
1493	2025-02-01	1	2	February 	1	2025	2025-11-03 20:25:50
1494	2025-02-02	2	2	February 	1	2025	2025-11-03 20:25:50
1495	2025-02-03	3	2	February 	1	2025	2025-11-03 20:25:50
1496	2025-02-04	4	2	February 	1	2025	2025-11-03 20:25:50
1497	2025-02-05	5	2	February 	1	2025	2025-11-03 20:25:50
1498	2025-02-06	6	2	February 	1	2025	2025-11-03 20:25:50
1499	2025-02-07	7	2	February 	1	2025	2025-11-03 20:25:50
1500	2025-02-08	8	2	February 	1	2025	2025-11-03 20:25:50
1501	2025-02-09	9	2	February 	1	2025	2025-11-03 20:25:50
1502	2025-02-10	10	2	February 	1	2025	2025-11-03 20:25:50
1503	2025-02-11	11	2	February 	1	2025	2025-11-03 20:25:50
1504	2025-02-12	12	2	February 	1	2025	2025-11-03 20:25:50
1505	2025-02-13	13	2	February 	1	2025	2025-11-03 20:25:50
1506	2025-02-14	14	2	February 	1	2025	2025-11-03 20:25:50
1507	2025-02-15	15	2	February 	1	2025	2025-11-03 20:25:50
1508	2025-02-16	16	2	February 	1	2025	2025-11-03 20:25:50
1509	2025-02-17	17	2	February 	1	2025	2025-11-03 20:25:50
1510	2025-02-18	18	2	February 	1	2025	2025-11-03 20:25:50
1511	2025-02-19	19	2	February 	1	2025	2025-11-03 20:25:50
1512	2025-02-20	20	2	February 	1	2025	2025-11-03 20:25:50
1513	2025-02-21	21	2	February 	1	2025	2025-11-03 20:25:50
1514	2025-02-22	22	2	February 	1	2025	2025-11-03 20:25:50
1515	2025-02-23	23	2	February 	1	2025	2025-11-03 20:25:50
1516	2025-02-24	24	2	February 	1	2025	2025-11-03 20:25:50
1517	2025-02-25	25	2	February 	1	2025	2025-11-03 20:25:50
1518	2025-02-26	26	2	February 	1	2025	2025-11-03 20:25:50
1519	2025-02-27	27	2	February 	1	2025	2025-11-03 20:25:50
1520	2025-02-28	28	2	February 	1	2025	2025-11-03 20:25:50
1521	2025-03-01	1	3	March    	1	2025	2025-11-03 20:25:50
1522	2025-03-02	2	3	March    	1	2025	2025-11-03 20:25:50
1523	2025-03-03	3	3	March    	1	2025	2025-11-03 20:25:50
1524	2025-03-04	4	3	March    	1	2025	2025-11-03 20:25:50
1525	2025-03-05	5	3	March    	1	2025	2025-11-03 20:25:50
1526	2025-03-06	6	3	March    	1	2025	2025-11-03 20:25:50
1527	2025-03-07	7	3	March    	1	2025	2025-11-03 20:25:50
1528	2025-03-08	8	3	March    	1	2025	2025-11-03 20:25:50
1529	2025-03-09	9	3	March    	1	2025	2025-11-03 20:25:50
1530	2025-03-10	10	3	March    	1	2025	2025-11-03 20:25:50
1531	2025-03-11	11	3	March    	1	2025	2025-11-03 20:25:50
1532	2025-03-12	12	3	March    	1	2025	2025-11-03 20:25:50
1533	2025-03-13	13	3	March    	1	2025	2025-11-03 20:25:50
1534	2025-03-14	14	3	March    	1	2025	2025-11-03 20:25:50
1535	2025-03-15	15	3	March    	1	2025	2025-11-03 20:25:50
1536	2025-03-16	16	3	March    	1	2025	2025-11-03 20:25:50
1537	2025-03-17	17	3	March    	1	2025	2025-11-03 20:25:50
1538	2025-03-18	18	3	March    	1	2025	2025-11-03 20:25:50
1539	2025-03-19	19	3	March    	1	2025	2025-11-03 20:25:50
1540	2025-03-20	20	3	March    	1	2025	2025-11-03 20:25:50
1541	2025-03-21	21	3	March    	1	2025	2025-11-03 20:25:50
1542	2025-03-22	22	3	March    	1	2025	2025-11-03 20:25:50
1543	2025-03-23	23	3	March    	1	2025	2025-11-03 20:25:50
1544	2025-03-24	24	3	March    	1	2025	2025-11-03 20:25:50
1545	2025-03-25	25	3	March    	1	2025	2025-11-03 20:25:50
1546	2025-03-26	26	3	March    	1	2025	2025-11-03 20:25:50
1547	2025-03-27	27	3	March    	1	2025	2025-11-03 20:25:50
1548	2025-03-28	28	3	March    	1	2025	2025-11-03 20:25:50
1549	2025-03-29	29	3	March    	1	2025	2025-11-03 20:25:50
1550	2025-03-30	30	3	March    	1	2025	2025-11-03 20:25:50
1551	2025-03-31	31	3	March    	1	2025	2025-11-03 20:25:50
1552	2025-04-01	1	4	April    	2	2025	2025-11-03 20:25:50
1553	2025-04-02	2	4	April    	2	2025	2025-11-03 20:25:50
1554	2025-04-03	3	4	April    	2	2025	2025-11-03 20:25:50
1555	2025-04-04	4	4	April    	2	2025	2025-11-03 20:25:50
1556	2025-04-05	5	4	April    	2	2025	2025-11-03 20:25:50
1557	2025-04-06	6	4	April    	2	2025	2025-11-03 20:25:50
1558	2025-04-07	7	4	April    	2	2025	2025-11-03 20:25:50
1559	2025-04-08	8	4	April    	2	2025	2025-11-03 20:25:50
1560	2025-04-09	9	4	April    	2	2025	2025-11-03 20:25:50
1561	2025-04-10	10	4	April    	2	2025	2025-11-03 20:25:50
1562	2025-04-11	11	4	April    	2	2025	2025-11-03 20:25:50
1563	2025-04-12	12	4	April    	2	2025	2025-11-03 20:25:50
1564	2025-04-13	13	4	April    	2	2025	2025-11-03 20:25:50
1565	2025-04-14	14	4	April    	2	2025	2025-11-03 20:25:50
1566	2025-04-15	15	4	April    	2	2025	2025-11-03 20:25:50
1567	2025-04-16	16	4	April    	2	2025	2025-11-03 20:25:50
1568	2025-04-17	17	4	April    	2	2025	2025-11-03 20:25:50
1569	2025-04-18	18	4	April    	2	2025	2025-11-03 20:25:50
1570	2025-04-19	19	4	April    	2	2025	2025-11-03 20:25:50
1571	2025-04-20	20	4	April    	2	2025	2025-11-03 20:25:50
1572	2025-04-21	21	4	April    	2	2025	2025-11-03 20:25:50
1573	2025-04-22	22	4	April    	2	2025	2025-11-03 20:25:50
1574	2025-04-23	23	4	April    	2	2025	2025-11-03 20:25:50
1575	2025-04-24	24	4	April    	2	2025	2025-11-03 20:25:50
1576	2025-04-25	25	4	April    	2	2025	2025-11-03 20:25:50
1577	2025-04-26	26	4	April    	2	2025	2025-11-03 20:25:50
1578	2025-04-27	27	4	April    	2	2025	2025-11-03 20:25:50
1579	2025-04-28	28	4	April    	2	2025	2025-11-03 20:25:50
1580	2025-04-29	29	4	April    	2	2025	2025-11-03 20:25:50
1581	2025-04-30	30	4	April    	2	2025	2025-11-03 20:25:50
1582	2025-05-01	1	5	May      	2	2025	2025-11-03 20:25:50
1583	2025-05-02	2	5	May      	2	2025	2025-11-03 20:25:50
1584	2025-05-03	3	5	May      	2	2025	2025-11-03 20:25:50
1585	2025-05-04	4	5	May      	2	2025	2025-11-03 20:25:50
1586	2025-05-05	5	5	May      	2	2025	2025-11-03 20:25:50
1587	2025-05-06	6	5	May      	2	2025	2025-11-03 20:25:50
1588	2025-05-07	7	5	May      	2	2025	2025-11-03 20:25:50
1589	2025-05-08	8	5	May      	2	2025	2025-11-03 20:25:50
1590	2025-05-09	9	5	May      	2	2025	2025-11-03 20:25:50
1591	2025-05-10	10	5	May      	2	2025	2025-11-03 20:25:50
1592	2025-05-11	11	5	May      	2	2025	2025-11-03 20:25:50
1593	2025-05-12	12	5	May      	2	2025	2025-11-03 20:25:50
1594	2025-05-13	13	5	May      	2	2025	2025-11-03 20:25:50
1595	2025-05-14	14	5	May      	2	2025	2025-11-03 20:25:50
1596	2025-05-15	15	5	May      	2	2025	2025-11-03 20:25:50
1597	2025-05-16	16	5	May      	2	2025	2025-11-03 20:25:50
1598	2025-05-17	17	5	May      	2	2025	2025-11-03 20:25:50
1599	2025-05-18	18	5	May      	2	2025	2025-11-03 20:25:50
1600	2025-05-19	19	5	May      	2	2025	2025-11-03 20:25:50
1601	2025-05-20	20	5	May      	2	2025	2025-11-03 20:25:50
1602	2025-05-21	21	5	May      	2	2025	2025-11-03 20:25:50
1603	2025-05-22	22	5	May      	2	2025	2025-11-03 20:25:50
1604	2025-05-23	23	5	May      	2	2025	2025-11-03 20:25:50
1605	2025-05-24	24	5	May      	2	2025	2025-11-03 20:25:50
1606	2025-05-25	25	5	May      	2	2025	2025-11-03 20:25:50
1607	2025-05-26	26	5	May      	2	2025	2025-11-03 20:25:50
1608	2025-05-27	27	5	May      	2	2025	2025-11-03 20:25:50
1609	2025-05-28	28	5	May      	2	2025	2025-11-03 20:25:50
1610	2025-05-29	29	5	May      	2	2025	2025-11-03 20:25:50
1611	2025-05-30	30	5	May      	2	2025	2025-11-03 20:25:50
1612	2025-05-31	31	5	May      	2	2025	2025-11-03 20:25:50
1613	2025-06-01	1	6	June     	2	2025	2025-11-03 20:25:50
1614	2025-06-02	2	6	June     	2	2025	2025-11-03 20:25:50
1615	2025-06-03	3	6	June     	2	2025	2025-11-03 20:25:50
1616	2025-06-04	4	6	June     	2	2025	2025-11-03 20:25:50
1617	2025-06-05	5	6	June     	2	2025	2025-11-03 20:25:50
1618	2025-06-06	6	6	June     	2	2025	2025-11-03 20:25:50
1619	2025-06-07	7	6	June     	2	2025	2025-11-03 20:25:50
1620	2025-06-08	8	6	June     	2	2025	2025-11-03 20:25:50
1621	2025-06-09	9	6	June     	2	2025	2025-11-03 20:25:50
1622	2025-06-10	10	6	June     	2	2025	2025-11-03 20:25:50
1623	2025-06-11	11	6	June     	2	2025	2025-11-03 20:25:50
1624	2025-06-12	12	6	June     	2	2025	2025-11-03 20:25:50
1625	2025-06-13	13	6	June     	2	2025	2025-11-03 20:25:50
1626	2025-06-14	14	6	June     	2	2025	2025-11-03 20:25:50
1627	2025-06-15	15	6	June     	2	2025	2025-11-03 20:25:50
1628	2025-06-16	16	6	June     	2	2025	2025-11-03 20:25:50
1629	2025-06-17	17	6	June     	2	2025	2025-11-03 20:25:50
1630	2025-06-18	18	6	June     	2	2025	2025-11-03 20:25:50
1631	2025-06-19	19	6	June     	2	2025	2025-11-03 20:25:50
1632	2025-06-20	20	6	June     	2	2025	2025-11-03 20:25:50
1633	2025-06-21	21	6	June     	2	2025	2025-11-03 20:25:50
1634	2025-06-22	22	6	June     	2	2025	2025-11-03 20:25:50
1635	2025-06-23	23	6	June     	2	2025	2025-11-03 20:25:50
1636	2025-06-24	24	6	June     	2	2025	2025-11-03 20:25:50
1637	2025-06-25	25	6	June     	2	2025	2025-11-03 20:25:50
1638	2025-06-26	26	6	June     	2	2025	2025-11-03 20:25:50
1639	2025-06-27	27	6	June     	2	2025	2025-11-03 20:25:50
1640	2025-06-28	28	6	June     	2	2025	2025-11-03 20:25:50
1641	2025-06-29	29	6	June     	2	2025	2025-11-03 20:25:50
1642	2025-06-30	30	6	June     	2	2025	2025-11-03 20:25:50
1643	2025-07-01	1	7	July     	3	2025	2025-11-03 20:25:50
1644	2025-07-02	2	7	July     	3	2025	2025-11-03 20:25:50
1645	2025-07-03	3	7	July     	3	2025	2025-11-03 20:25:50
1646	2025-07-04	4	7	July     	3	2025	2025-11-03 20:25:50
1647	2025-07-05	5	7	July     	3	2025	2025-11-03 20:25:50
1648	2025-07-06	6	7	July     	3	2025	2025-11-03 20:25:50
1649	2025-07-07	7	7	July     	3	2025	2025-11-03 20:25:50
1650	2025-07-08	8	7	July     	3	2025	2025-11-03 20:25:50
1651	2025-07-09	9	7	July     	3	2025	2025-11-03 20:25:50
1652	2025-07-10	10	7	July     	3	2025	2025-11-03 20:25:50
1653	2025-07-11	11	7	July     	3	2025	2025-11-03 20:25:50
1654	2025-07-12	12	7	July     	3	2025	2025-11-03 20:25:50
1655	2025-07-13	13	7	July     	3	2025	2025-11-03 20:25:50
1656	2025-07-14	14	7	July     	3	2025	2025-11-03 20:25:50
1657	2025-07-15	15	7	July     	3	2025	2025-11-03 20:25:50
1658	2025-07-16	16	7	July     	3	2025	2025-11-03 20:25:50
1659	2025-07-17	17	7	July     	3	2025	2025-11-03 20:25:50
1660	2025-07-18	18	7	July     	3	2025	2025-11-03 20:25:50
1661	2025-07-19	19	7	July     	3	2025	2025-11-03 20:25:50
1662	2025-07-20	20	7	July     	3	2025	2025-11-03 20:25:50
1663	2025-07-21	21	7	July     	3	2025	2025-11-03 20:25:50
1664	2025-07-22	22	7	July     	3	2025	2025-11-03 20:25:50
1665	2025-07-23	23	7	July     	3	2025	2025-11-03 20:25:50
1666	2025-07-24	24	7	July     	3	2025	2025-11-03 20:25:50
1667	2025-07-25	25	7	July     	3	2025	2025-11-03 20:25:50
1668	2025-07-26	26	7	July     	3	2025	2025-11-03 20:25:50
1669	2025-07-27	27	7	July     	3	2025	2025-11-03 20:25:50
1670	2025-07-28	28	7	July     	3	2025	2025-11-03 20:25:50
1671	2025-07-29	29	7	July     	3	2025	2025-11-03 20:25:50
1672	2025-07-30	30	7	July     	3	2025	2025-11-03 20:25:50
1673	2025-07-31	31	7	July     	3	2025	2025-11-03 20:25:50
1674	2025-08-01	1	8	August   	3	2025	2025-11-03 20:25:50
1675	2025-08-02	2	8	August   	3	2025	2025-11-03 20:25:50
1676	2025-08-03	3	8	August   	3	2025	2025-11-03 20:25:50
1677	2025-08-04	4	8	August   	3	2025	2025-11-03 20:25:50
1678	2025-08-05	5	8	August   	3	2025	2025-11-03 20:25:50
1679	2025-08-06	6	8	August   	3	2025	2025-11-03 20:25:50
1680	2025-08-07	7	8	August   	3	2025	2025-11-03 20:25:50
1681	2025-08-08	8	8	August   	3	2025	2025-11-03 20:25:50
1682	2025-08-09	9	8	August   	3	2025	2025-11-03 20:25:50
1683	2025-08-10	10	8	August   	3	2025	2025-11-03 20:25:50
1684	2025-08-11	11	8	August   	3	2025	2025-11-03 20:25:50
1685	2025-08-12	12	8	August   	3	2025	2025-11-03 20:25:50
1686	2025-08-13	13	8	August   	3	2025	2025-11-03 20:25:50
1687	2025-08-14	14	8	August   	3	2025	2025-11-03 20:25:50
1688	2025-08-15	15	8	August   	3	2025	2025-11-03 20:25:50
1689	2025-08-16	16	8	August   	3	2025	2025-11-03 20:25:50
1690	2025-08-17	17	8	August   	3	2025	2025-11-03 20:25:50
1691	2025-08-18	18	8	August   	3	2025	2025-11-03 20:25:50
1692	2025-08-19	19	8	August   	3	2025	2025-11-03 20:25:50
1693	2025-08-20	20	8	August   	3	2025	2025-11-03 20:25:50
1694	2025-08-21	21	8	August   	3	2025	2025-11-03 20:25:50
1695	2025-08-22	22	8	August   	3	2025	2025-11-03 20:25:50
1696	2025-08-23	23	8	August   	3	2025	2025-11-03 20:25:50
1697	2025-08-24	24	8	August   	3	2025	2025-11-03 20:25:50
1698	2025-08-25	25	8	August   	3	2025	2025-11-03 20:25:50
1699	2025-08-26	26	8	August   	3	2025	2025-11-03 20:25:50
1700	2025-08-27	27	8	August   	3	2025	2025-11-03 20:25:50
1701	2025-08-28	28	8	August   	3	2025	2025-11-03 20:25:50
1702	2025-08-29	29	8	August   	3	2025	2025-11-03 20:25:50
1703	2025-08-30	30	8	August   	3	2025	2025-11-03 20:25:50
1704	2025-08-31	31	8	August   	3	2025	2025-11-03 20:25:50
1705	2025-09-01	1	9	September	3	2025	2025-11-03 20:25:50
1706	2025-09-02	2	9	September	3	2025	2025-11-03 20:25:50
1707	2025-09-03	3	9	September	3	2025	2025-11-03 20:25:50
1708	2025-09-04	4	9	September	3	2025	2025-11-03 20:25:50
1709	2025-09-05	5	9	September	3	2025	2025-11-03 20:25:50
1710	2025-09-06	6	9	September	3	2025	2025-11-03 20:25:50
1711	2025-09-07	7	9	September	3	2025	2025-11-03 20:25:50
1712	2025-09-08	8	9	September	3	2025	2025-11-03 20:25:50
1713	2025-09-09	9	9	September	3	2025	2025-11-03 20:25:50
1714	2025-09-10	10	9	September	3	2025	2025-11-03 20:25:50
1715	2025-09-11	11	9	September	3	2025	2025-11-03 20:25:50
1716	2025-09-12	12	9	September	3	2025	2025-11-03 20:25:50
1717	2025-09-13	13	9	September	3	2025	2025-11-03 20:25:50
1718	2025-09-14	14	9	September	3	2025	2025-11-03 20:25:50
1719	2025-09-15	15	9	September	3	2025	2025-11-03 20:25:50
1720	2025-09-16	16	9	September	3	2025	2025-11-03 20:25:50
1721	2025-09-17	17	9	September	3	2025	2025-11-03 20:25:50
1722	2025-09-18	18	9	September	3	2025	2025-11-03 20:25:50
1723	2025-09-19	19	9	September	3	2025	2025-11-03 20:25:50
1724	2025-09-20	20	9	September	3	2025	2025-11-03 20:25:50
1725	2025-09-21	21	9	September	3	2025	2025-11-03 20:25:50
1726	2025-09-22	22	9	September	3	2025	2025-11-03 20:25:50
1727	2025-09-23	23	9	September	3	2025	2025-11-03 20:25:50
1728	2025-09-24	24	9	September	3	2025	2025-11-03 20:25:50
1729	2025-09-25	25	9	September	3	2025	2025-11-03 20:25:50
1730	2025-09-26	26	9	September	3	2025	2025-11-03 20:25:50
1731	2025-09-27	27	9	September	3	2025	2025-11-03 20:25:50
1732	2025-09-28	28	9	September	3	2025	2025-11-03 20:25:50
1733	2025-09-29	29	9	September	3	2025	2025-11-03 20:25:50
1734	2025-09-30	30	9	September	3	2025	2025-11-03 20:25:50
1735	2025-10-01	1	10	October  	4	2025	2025-11-03 20:25:50
1736	2025-10-02	2	10	October  	4	2025	2025-11-03 20:25:50
1737	2025-10-03	3	10	October  	4	2025	2025-11-03 20:25:50
1738	2025-10-04	4	10	October  	4	2025	2025-11-03 20:25:50
1739	2025-10-05	5	10	October  	4	2025	2025-11-03 20:25:50
1740	2025-10-06	6	10	October  	4	2025	2025-11-03 20:25:50
1741	2025-10-07	7	10	October  	4	2025	2025-11-03 20:25:50
1742	2025-10-08	8	10	October  	4	2025	2025-11-03 20:25:50
1743	2025-10-09	9	10	October  	4	2025	2025-11-03 20:25:50
1744	2025-10-10	10	10	October  	4	2025	2025-11-03 20:25:50
1745	2025-10-11	11	10	October  	4	2025	2025-11-03 20:25:50
1746	2025-10-12	12	10	October  	4	2025	2025-11-03 20:25:50
1747	2025-10-13	13	10	October  	4	2025	2025-11-03 20:25:50
1748	2025-10-14	14	10	October  	4	2025	2025-11-03 20:25:50
1749	2025-10-15	15	10	October  	4	2025	2025-11-03 20:25:50
1750	2025-10-16	16	10	October  	4	2025	2025-11-03 20:25:50
1751	2025-10-17	17	10	October  	4	2025	2025-11-03 20:25:50
1752	2025-10-18	18	10	October  	4	2025	2025-11-03 20:25:50
1753	2025-10-19	19	10	October  	4	2025	2025-11-03 20:25:50
1754	2025-10-20	20	10	October  	4	2025	2025-11-03 20:25:50
1755	2025-10-21	21	10	October  	4	2025	2025-11-03 20:25:50
1756	2025-10-22	22	10	October  	4	2025	2025-11-03 20:25:50
1757	2025-10-23	23	10	October  	4	2025	2025-11-03 20:25:50
1758	2025-10-24	24	10	October  	4	2025	2025-11-03 20:25:50
1759	2025-10-25	25	10	October  	4	2025	2025-11-03 20:25:50
1760	2025-10-26	26	10	October  	4	2025	2025-11-03 20:25:50
1761	2025-10-27	27	10	October  	4	2025	2025-11-03 20:25:50
1762	2025-10-28	28	10	October  	4	2025	2025-11-03 20:25:50
1763	2025-10-29	29	10	October  	4	2025	2025-11-03 20:25:50
1764	2025-10-30	30	10	October  	4	2025	2025-11-03 20:25:50
1765	2025-10-31	31	10	October  	4	2025	2025-11-03 20:25:50
1766	2025-11-01	1	11	November 	4	2025	2025-11-03 20:25:50
1767	2025-11-02	2	11	November 	4	2025	2025-11-03 20:25:50
1768	2025-11-03	3	11	November 	4	2025	2025-11-03 20:25:50
1769	2025-11-04	4	11	November 	4	2025	2025-11-03 20:25:50
1770	2025-11-05	5	11	November 	4	2025	2025-11-03 20:25:50
1771	2025-11-06	6	11	November 	4	2025	2025-11-03 20:25:50
1772	2025-11-07	7	11	November 	4	2025	2025-11-03 20:25:50
1773	2025-11-08	8	11	November 	4	2025	2025-11-03 20:25:50
1774	2025-11-09	9	11	November 	4	2025	2025-11-03 20:25:50
1775	2025-11-10	10	11	November 	4	2025	2025-11-03 20:25:50
1776	2025-11-11	11	11	November 	4	2025	2025-11-03 20:25:50
1777	2025-11-12	12	11	November 	4	2025	2025-11-03 20:25:50
1778	2025-11-13	13	11	November 	4	2025	2025-11-03 20:25:50
1779	2025-11-14	14	11	November 	4	2025	2025-11-03 20:25:50
1780	2025-11-15	15	11	November 	4	2025	2025-11-03 20:25:50
1781	2025-11-16	16	11	November 	4	2025	2025-11-03 20:25:50
1782	2025-11-17	17	11	November 	4	2025	2025-11-03 20:25:50
1783	2025-11-18	18	11	November 	4	2025	2025-11-03 20:25:50
1784	2025-11-19	19	11	November 	4	2025	2025-11-03 20:25:50
1785	2025-11-20	20	11	November 	4	2025	2025-11-03 20:25:50
1786	2025-11-21	21	11	November 	4	2025	2025-11-03 20:25:50
1787	2025-11-22	22	11	November 	4	2025	2025-11-03 20:25:50
1788	2025-11-23	23	11	November 	4	2025	2025-11-03 20:25:50
1789	2025-11-24	24	11	November 	4	2025	2025-11-03 20:25:50
1790	2025-11-25	25	11	November 	4	2025	2025-11-03 20:25:50
1791	2025-11-26	26	11	November 	4	2025	2025-11-03 20:25:50
1792	2025-11-27	27	11	November 	4	2025	2025-11-03 20:25:50
1793	2025-11-28	28	11	November 	4	2025	2025-11-03 20:25:50
1794	2025-11-29	29	11	November 	4	2025	2025-11-03 20:25:50
1795	2025-11-30	30	11	November 	4	2025	2025-11-03 20:25:50
1796	2025-12-01	1	12	December 	4	2025	2025-11-03 20:25:50
1797	2025-12-02	2	12	December 	4	2025	2025-11-03 20:25:50
1798	2025-12-03	3	12	December 	4	2025	2025-11-03 20:25:50
1799	2025-12-04	4	12	December 	4	2025	2025-11-03 20:25:50
1800	2025-12-05	5	12	December 	4	2025	2025-11-03 20:25:50
1801	2025-12-06	6	12	December 	4	2025	2025-11-03 20:25:50
1802	2025-12-07	7	12	December 	4	2025	2025-11-03 20:25:50
1803	2025-12-08	8	12	December 	4	2025	2025-11-03 20:25:50
1804	2025-12-09	9	12	December 	4	2025	2025-11-03 20:25:50
1805	2025-12-10	10	12	December 	4	2025	2025-11-03 20:25:50
1806	2025-12-11	11	12	December 	4	2025	2025-11-03 20:25:50
1807	2025-12-12	12	12	December 	4	2025	2025-11-03 20:25:50
1808	2025-12-13	13	12	December 	4	2025	2025-11-03 20:25:50
1809	2025-12-14	14	12	December 	4	2025	2025-11-03 20:25:50
1810	2025-12-15	15	12	December 	4	2025	2025-11-03 20:25:50
1811	2025-12-16	16	12	December 	4	2025	2025-11-03 20:25:50
1812	2025-12-17	17	12	December 	4	2025	2025-11-03 20:25:50
1813	2025-12-18	18	12	December 	4	2025	2025-11-03 20:25:50
1814	2025-12-19	19	12	December 	4	2025	2025-11-03 20:25:50
1815	2025-12-20	20	12	December 	4	2025	2025-11-03 20:25:50
1816	2025-12-21	21	12	December 	4	2025	2025-11-03 20:25:50
1817	2025-12-22	22	12	December 	4	2025	2025-11-03 20:25:50
1818	2025-12-23	23	12	December 	4	2025	2025-11-03 20:25:50
1819	2025-12-24	24	12	December 	4	2025	2025-11-03 20:25:50
1820	2025-12-25	25	12	December 	4	2025	2025-11-03 20:25:50
1821	2025-12-26	26	12	December 	4	2025	2025-11-03 20:25:50
1822	2025-12-27	27	12	December 	4	2025	2025-11-03 20:25:50
1823	2025-12-28	28	12	December 	4	2025	2025-11-03 20:25:50
1824	2025-12-29	29	12	December 	4	2025	2025-11-03 20:25:50
1825	2025-12-30	30	12	December 	4	2025	2025-11-03 20:25:50
1826	2025-12-31	31	12	December 	4	2025	2025-11-03 20:25:50
1827	2026-01-01	1	1	January  	1	2026	2025-11-03 20:25:50
1828	2026-01-02	2	1	January  	1	2026	2025-11-03 20:25:50
1829	2026-01-03	3	1	January  	1	2026	2025-11-03 20:25:50
1830	2026-01-04	4	1	January  	1	2026	2025-11-03 20:25:50
1831	2026-01-05	5	1	January  	1	2026	2025-11-03 20:25:50
1832	2026-01-06	6	1	January  	1	2026	2025-11-03 20:25:50
1833	2026-01-07	7	1	January  	1	2026	2025-11-03 20:25:50
1834	2026-01-08	8	1	January  	1	2026	2025-11-03 20:25:50
1835	2026-01-09	9	1	January  	1	2026	2025-11-03 20:25:50
1836	2026-01-10	10	1	January  	1	2026	2025-11-03 20:25:50
1837	2026-01-11	11	1	January  	1	2026	2025-11-03 20:25:50
1838	2026-01-12	12	1	January  	1	2026	2025-11-03 20:25:50
1839	2026-01-13	13	1	January  	1	2026	2025-11-03 20:25:50
1840	2026-01-14	14	1	January  	1	2026	2025-11-03 20:25:50
1841	2026-01-15	15	1	January  	1	2026	2025-11-03 20:25:50
1842	2026-01-16	16	1	January  	1	2026	2025-11-03 20:25:50
1843	2026-01-17	17	1	January  	1	2026	2025-11-03 20:25:50
1844	2026-01-18	18	1	January  	1	2026	2025-11-03 20:25:50
1845	2026-01-19	19	1	January  	1	2026	2025-11-03 20:25:50
1846	2026-01-20	20	1	January  	1	2026	2025-11-03 20:25:50
1847	2026-01-21	21	1	January  	1	2026	2025-11-03 20:25:50
1848	2026-01-22	22	1	January  	1	2026	2025-11-03 20:25:50
1849	2026-01-23	23	1	January  	1	2026	2025-11-03 20:25:50
1850	2026-01-24	24	1	January  	1	2026	2025-11-03 20:25:50
1851	2026-01-25	25	1	January  	1	2026	2025-11-03 20:25:50
1852	2026-01-26	26	1	January  	1	2026	2025-11-03 20:25:50
1853	2026-01-27	27	1	January  	1	2026	2025-11-03 20:25:50
1854	2026-01-28	28	1	January  	1	2026	2025-11-03 20:25:50
1855	2026-01-29	29	1	January  	1	2026	2025-11-03 20:25:50
1856	2026-01-30	30	1	January  	1	2026	2025-11-03 20:25:50
1857	2026-01-31	31	1	January  	1	2026	2025-11-03 20:25:50
1858	2026-02-01	1	2	February 	1	2026	2025-11-03 20:25:50
1859	2026-02-02	2	2	February 	1	2026	2025-11-03 20:25:50
1860	2026-02-03	3	2	February 	1	2026	2025-11-03 20:25:50
1861	2026-02-04	4	2	February 	1	2026	2025-11-03 20:25:50
1862	2026-02-05	5	2	February 	1	2026	2025-11-03 20:25:50
1863	2026-02-06	6	2	February 	1	2026	2025-11-03 20:25:50
1864	2026-02-07	7	2	February 	1	2026	2025-11-03 20:25:50
1865	2026-02-08	8	2	February 	1	2026	2025-11-03 20:25:50
1866	2026-02-09	9	2	February 	1	2026	2025-11-03 20:25:50
1867	2026-02-10	10	2	February 	1	2026	2025-11-03 20:25:50
1868	2026-02-11	11	2	February 	1	2026	2025-11-03 20:25:50
1869	2026-02-12	12	2	February 	1	2026	2025-11-03 20:25:50
1870	2026-02-13	13	2	February 	1	2026	2025-11-03 20:25:50
1871	2026-02-14	14	2	February 	1	2026	2025-11-03 20:25:50
1872	2026-02-15	15	2	February 	1	2026	2025-11-03 20:25:50
1873	2026-02-16	16	2	February 	1	2026	2025-11-03 20:25:50
1874	2026-02-17	17	2	February 	1	2026	2025-11-03 20:25:50
1875	2026-02-18	18	2	February 	1	2026	2025-11-03 20:25:50
1876	2026-02-19	19	2	February 	1	2026	2025-11-03 20:25:50
1877	2026-02-20	20	2	February 	1	2026	2025-11-03 20:25:50
1878	2026-02-21	21	2	February 	1	2026	2025-11-03 20:25:50
1879	2026-02-22	22	2	February 	1	2026	2025-11-03 20:25:50
1880	2026-02-23	23	2	February 	1	2026	2025-11-03 20:25:50
1881	2026-02-24	24	2	February 	1	2026	2025-11-03 20:25:50
1882	2026-02-25	25	2	February 	1	2026	2025-11-03 20:25:50
1883	2026-02-26	26	2	February 	1	2026	2025-11-03 20:25:50
1884	2026-02-27	27	2	February 	1	2026	2025-11-03 20:25:50
1885	2026-02-28	28	2	February 	1	2026	2025-11-03 20:25:50
1886	2026-03-01	1	3	March    	1	2026	2025-11-03 20:25:50
1887	2026-03-02	2	3	March    	1	2026	2025-11-03 20:25:50
1888	2026-03-03	3	3	March    	1	2026	2025-11-03 20:25:50
1889	2026-03-04	4	3	March    	1	2026	2025-11-03 20:25:50
1890	2026-03-05	5	3	March    	1	2026	2025-11-03 20:25:50
1891	2026-03-06	6	3	March    	1	2026	2025-11-03 20:25:50
1892	2026-03-07	7	3	March    	1	2026	2025-11-03 20:25:50
1893	2026-03-08	8	3	March    	1	2026	2025-11-03 20:25:50
1894	2026-03-09	9	3	March    	1	2026	2025-11-03 20:25:50
1895	2026-03-10	10	3	March    	1	2026	2025-11-03 20:25:50
1896	2026-03-11	11	3	March    	1	2026	2025-11-03 20:25:50
1897	2026-03-12	12	3	March    	1	2026	2025-11-03 20:25:50
1898	2026-03-13	13	3	March    	1	2026	2025-11-03 20:25:50
1899	2026-03-14	14	3	March    	1	2026	2025-11-03 20:25:50
1900	2026-03-15	15	3	March    	1	2026	2025-11-03 20:25:50
1901	2026-03-16	16	3	March    	1	2026	2025-11-03 20:25:50
1902	2026-03-17	17	3	March    	1	2026	2025-11-03 20:25:50
1903	2026-03-18	18	3	March    	1	2026	2025-11-03 20:25:50
1904	2026-03-19	19	3	March    	1	2026	2025-11-03 20:25:50
1905	2026-03-20	20	3	March    	1	2026	2025-11-03 20:25:50
1906	2026-03-21	21	3	March    	1	2026	2025-11-03 20:25:50
1907	2026-03-22	22	3	March    	1	2026	2025-11-03 20:25:50
1908	2026-03-23	23	3	March    	1	2026	2025-11-03 20:25:50
1909	2026-03-24	24	3	March    	1	2026	2025-11-03 20:25:50
1910	2026-03-25	25	3	March    	1	2026	2025-11-03 20:25:50
1911	2026-03-26	26	3	March    	1	2026	2025-11-03 20:25:50
1912	2026-03-27	27	3	March    	1	2026	2025-11-03 20:25:50
1913	2026-03-28	28	3	March    	1	2026	2025-11-03 20:25:50
1914	2026-03-29	29	3	March    	1	2026	2025-11-03 20:25:50
1915	2026-03-30	30	3	March    	1	2026	2025-11-03 20:25:50
1916	2026-03-31	31	3	March    	1	2026	2025-11-03 20:25:50
1917	2026-04-01	1	4	April    	2	2026	2025-11-03 20:25:50
1918	2026-04-02	2	4	April    	2	2026	2025-11-03 20:25:50
1919	2026-04-03	3	4	April    	2	2026	2025-11-03 20:25:50
1920	2026-04-04	4	4	April    	2	2026	2025-11-03 20:25:50
1921	2026-04-05	5	4	April    	2	2026	2025-11-03 20:25:50
1922	2026-04-06	6	4	April    	2	2026	2025-11-03 20:25:50
1923	2026-04-07	7	4	April    	2	2026	2025-11-03 20:25:50
1924	2026-04-08	8	4	April    	2	2026	2025-11-03 20:25:50
1925	2026-04-09	9	4	April    	2	2026	2025-11-03 20:25:50
1926	2026-04-10	10	4	April    	2	2026	2025-11-03 20:25:50
1927	2026-04-11	11	4	April    	2	2026	2025-11-03 20:25:50
1928	2026-04-12	12	4	April    	2	2026	2025-11-03 20:25:50
1929	2026-04-13	13	4	April    	2	2026	2025-11-03 20:25:50
1930	2026-04-14	14	4	April    	2	2026	2025-11-03 20:25:50
1931	2026-04-15	15	4	April    	2	2026	2025-11-03 20:25:50
1932	2026-04-16	16	4	April    	2	2026	2025-11-03 20:25:50
1933	2026-04-17	17	4	April    	2	2026	2025-11-03 20:25:50
1934	2026-04-18	18	4	April    	2	2026	2025-11-03 20:25:50
1935	2026-04-19	19	4	April    	2	2026	2025-11-03 20:25:50
1936	2026-04-20	20	4	April    	2	2026	2025-11-03 20:25:50
1937	2026-04-21	21	4	April    	2	2026	2025-11-03 20:25:50
1938	2026-04-22	22	4	April    	2	2026	2025-11-03 20:25:50
1939	2026-04-23	23	4	April    	2	2026	2025-11-03 20:25:50
1940	2026-04-24	24	4	April    	2	2026	2025-11-03 20:25:50
1941	2026-04-25	25	4	April    	2	2026	2025-11-03 20:25:50
1942	2026-04-26	26	4	April    	2	2026	2025-11-03 20:25:50
1943	2026-04-27	27	4	April    	2	2026	2025-11-03 20:25:50
1944	2026-04-28	28	4	April    	2	2026	2025-11-03 20:25:50
1945	2026-04-29	29	4	April    	2	2026	2025-11-03 20:25:50
1946	2026-04-30	30	4	April    	2	2026	2025-11-03 20:25:50
1947	2026-05-01	1	5	May      	2	2026	2025-11-03 20:25:50
1948	2026-05-02	2	5	May      	2	2026	2025-11-03 20:25:50
1949	2026-05-03	3	5	May      	2	2026	2025-11-03 20:25:50
1950	2026-05-04	4	5	May      	2	2026	2025-11-03 20:25:50
1951	2026-05-05	5	5	May      	2	2026	2025-11-03 20:25:50
1952	2026-05-06	6	5	May      	2	2026	2025-11-03 20:25:50
1953	2026-05-07	7	5	May      	2	2026	2025-11-03 20:25:50
1954	2026-05-08	8	5	May      	2	2026	2025-11-03 20:25:50
1955	2026-05-09	9	5	May      	2	2026	2025-11-03 20:25:50
1956	2026-05-10	10	5	May      	2	2026	2025-11-03 20:25:50
1957	2026-05-11	11	5	May      	2	2026	2025-11-03 20:25:50
1958	2026-05-12	12	5	May      	2	2026	2025-11-03 20:25:50
1959	2026-05-13	13	5	May      	2	2026	2025-11-03 20:25:50
1960	2026-05-14	14	5	May      	2	2026	2025-11-03 20:25:50
1961	2026-05-15	15	5	May      	2	2026	2025-11-03 20:25:50
1962	2026-05-16	16	5	May      	2	2026	2025-11-03 20:25:50
1963	2026-05-17	17	5	May      	2	2026	2025-11-03 20:25:50
1964	2026-05-18	18	5	May      	2	2026	2025-11-03 20:25:50
1965	2026-05-19	19	5	May      	2	2026	2025-11-03 20:25:50
1966	2026-05-20	20	5	May      	2	2026	2025-11-03 20:25:50
1967	2026-05-21	21	5	May      	2	2026	2025-11-03 20:25:50
1968	2026-05-22	22	5	May      	2	2026	2025-11-03 20:25:50
1969	2026-05-23	23	5	May      	2	2026	2025-11-03 20:25:50
1970	2026-05-24	24	5	May      	2	2026	2025-11-03 20:25:50
1971	2026-05-25	25	5	May      	2	2026	2025-11-03 20:25:50
1972	2026-05-26	26	5	May      	2	2026	2025-11-03 20:25:50
1973	2026-05-27	27	5	May      	2	2026	2025-11-03 20:25:50
1974	2026-05-28	28	5	May      	2	2026	2025-11-03 20:25:50
1975	2026-05-29	29	5	May      	2	2026	2025-11-03 20:25:50
1976	2026-05-30	30	5	May      	2	2026	2025-11-03 20:25:50
1977	2026-05-31	31	5	May      	2	2026	2025-11-03 20:25:50
1978	2026-06-01	1	6	June     	2	2026	2025-11-03 20:25:50
1979	2026-06-02	2	6	June     	2	2026	2025-11-03 20:25:50
1980	2026-06-03	3	6	June     	2	2026	2025-11-03 20:25:50
1981	2026-06-04	4	6	June     	2	2026	2025-11-03 20:25:50
1982	2026-06-05	5	6	June     	2	2026	2025-11-03 20:25:50
1983	2026-06-06	6	6	June     	2	2026	2025-11-03 20:25:50
1984	2026-06-07	7	6	June     	2	2026	2025-11-03 20:25:50
1985	2026-06-08	8	6	June     	2	2026	2025-11-03 20:25:50
1986	2026-06-09	9	6	June     	2	2026	2025-11-03 20:25:50
1987	2026-06-10	10	6	June     	2	2026	2025-11-03 20:25:50
1988	2026-06-11	11	6	June     	2	2026	2025-11-03 20:25:50
1989	2026-06-12	12	6	June     	2	2026	2025-11-03 20:25:50
1990	2026-06-13	13	6	June     	2	2026	2025-11-03 20:25:50
1991	2026-06-14	14	6	June     	2	2026	2025-11-03 20:25:50
1992	2026-06-15	15	6	June     	2	2026	2025-11-03 20:25:50
1993	2026-06-16	16	6	June     	2	2026	2025-11-03 20:25:50
1994	2026-06-17	17	6	June     	2	2026	2025-11-03 20:25:50
1995	2026-06-18	18	6	June     	2	2026	2025-11-03 20:25:50
1996	2026-06-19	19	6	June     	2	2026	2025-11-03 20:25:50
1997	2026-06-20	20	6	June     	2	2026	2025-11-03 20:25:50
1998	2026-06-21	21	6	June     	2	2026	2025-11-03 20:25:50
1999	2026-06-22	22	6	June     	2	2026	2025-11-03 20:25:50
2000	2026-06-23	23	6	June     	2	2026	2025-11-03 20:25:50
2001	2026-06-24	24	6	June     	2	2026	2025-11-03 20:25:50
2002	2026-06-25	25	6	June     	2	2026	2025-11-03 20:25:50
2003	2026-06-26	26	6	June     	2	2026	2025-11-03 20:25:50
2004	2026-06-27	27	6	June     	2	2026	2025-11-03 20:25:50
2005	2026-06-28	28	6	June     	2	2026	2025-11-03 20:25:50
2006	2026-06-29	29	6	June     	2	2026	2025-11-03 20:25:50
2007	2026-06-30	30	6	June     	2	2026	2025-11-03 20:25:50
2008	2026-07-01	1	7	July     	3	2026	2025-11-03 20:25:50
2009	2026-07-02	2	7	July     	3	2026	2025-11-03 20:25:50
2010	2026-07-03	3	7	July     	3	2026	2025-11-03 20:25:50
2011	2026-07-04	4	7	July     	3	2026	2025-11-03 20:25:50
2012	2026-07-05	5	7	July     	3	2026	2025-11-03 20:25:50
2013	2026-07-06	6	7	July     	3	2026	2025-11-03 20:25:50
2014	2026-07-07	7	7	July     	3	2026	2025-11-03 20:25:50
2015	2026-07-08	8	7	July     	3	2026	2025-11-03 20:25:50
2016	2026-07-09	9	7	July     	3	2026	2025-11-03 20:25:50
2017	2026-07-10	10	7	July     	3	2026	2025-11-03 20:25:50
2018	2026-07-11	11	7	July     	3	2026	2025-11-03 20:25:50
2019	2026-07-12	12	7	July     	3	2026	2025-11-03 20:25:50
2020	2026-07-13	13	7	July     	3	2026	2025-11-03 20:25:50
2021	2026-07-14	14	7	July     	3	2026	2025-11-03 20:25:50
2022	2026-07-15	15	7	July     	3	2026	2025-11-03 20:25:50
2023	2026-07-16	16	7	July     	3	2026	2025-11-03 20:25:50
2024	2026-07-17	17	7	July     	3	2026	2025-11-03 20:25:50
2025	2026-07-18	18	7	July     	3	2026	2025-11-03 20:25:50
2026	2026-07-19	19	7	July     	3	2026	2025-11-03 20:25:50
2027	2026-07-20	20	7	July     	3	2026	2025-11-03 20:25:50
2028	2026-07-21	21	7	July     	3	2026	2025-11-03 20:25:50
2029	2026-07-22	22	7	July     	3	2026	2025-11-03 20:25:50
2030	2026-07-23	23	7	July     	3	2026	2025-11-03 20:25:50
2031	2026-07-24	24	7	July     	3	2026	2025-11-03 20:25:50
2032	2026-07-25	25	7	July     	3	2026	2025-11-03 20:25:50
2033	2026-07-26	26	7	July     	3	2026	2025-11-03 20:25:50
2034	2026-07-27	27	7	July     	3	2026	2025-11-03 20:25:50
2035	2026-07-28	28	7	July     	3	2026	2025-11-03 20:25:50
2036	2026-07-29	29	7	July     	3	2026	2025-11-03 20:25:50
2037	2026-07-30	30	7	July     	3	2026	2025-11-03 20:25:50
2038	2026-07-31	31	7	July     	3	2026	2025-11-03 20:25:50
2039	2026-08-01	1	8	August   	3	2026	2025-11-03 20:25:50
2040	2026-08-02	2	8	August   	3	2026	2025-11-03 20:25:50
2041	2026-08-03	3	8	August   	3	2026	2025-11-03 20:25:50
2042	2026-08-04	4	8	August   	3	2026	2025-11-03 20:25:50
2043	2026-08-05	5	8	August   	3	2026	2025-11-03 20:25:50
2044	2026-08-06	6	8	August   	3	2026	2025-11-03 20:25:50
2045	2026-08-07	7	8	August   	3	2026	2025-11-03 20:25:50
2046	2026-08-08	8	8	August   	3	2026	2025-11-03 20:25:50
2047	2026-08-09	9	8	August   	3	2026	2025-11-03 20:25:50
2048	2026-08-10	10	8	August   	3	2026	2025-11-03 20:25:50
2049	2026-08-11	11	8	August   	3	2026	2025-11-03 20:25:50
2050	2026-08-12	12	8	August   	3	2026	2025-11-03 20:25:50
2051	2026-08-13	13	8	August   	3	2026	2025-11-03 20:25:50
2052	2026-08-14	14	8	August   	3	2026	2025-11-03 20:25:50
2053	2026-08-15	15	8	August   	3	2026	2025-11-03 20:25:50
2054	2026-08-16	16	8	August   	3	2026	2025-11-03 20:25:50
2055	2026-08-17	17	8	August   	3	2026	2025-11-03 20:25:50
2056	2026-08-18	18	8	August   	3	2026	2025-11-03 20:25:50
2057	2026-08-19	19	8	August   	3	2026	2025-11-03 20:25:50
2058	2026-08-20	20	8	August   	3	2026	2025-11-03 20:25:50
2059	2026-08-21	21	8	August   	3	2026	2025-11-03 20:25:50
2060	2026-08-22	22	8	August   	3	2026	2025-11-03 20:25:50
2061	2026-08-23	23	8	August   	3	2026	2025-11-03 20:25:50
2062	2026-08-24	24	8	August   	3	2026	2025-11-03 20:25:50
2063	2026-08-25	25	8	August   	3	2026	2025-11-03 20:25:50
2064	2026-08-26	26	8	August   	3	2026	2025-11-03 20:25:50
2065	2026-08-27	27	8	August   	3	2026	2025-11-03 20:25:50
2066	2026-08-28	28	8	August   	3	2026	2025-11-03 20:25:50
2067	2026-08-29	29	8	August   	3	2026	2025-11-03 20:25:50
2068	2026-08-30	30	8	August   	3	2026	2025-11-03 20:25:50
2069	2026-08-31	31	8	August   	3	2026	2025-11-03 20:25:50
2070	2026-09-01	1	9	September	3	2026	2025-11-03 20:25:50
2071	2026-09-02	2	9	September	3	2026	2025-11-03 20:25:50
2072	2026-09-03	3	9	September	3	2026	2025-11-03 20:25:50
2073	2026-09-04	4	9	September	3	2026	2025-11-03 20:25:50
2074	2026-09-05	5	9	September	3	2026	2025-11-03 20:25:50
2075	2026-09-06	6	9	September	3	2026	2025-11-03 20:25:50
2076	2026-09-07	7	9	September	3	2026	2025-11-03 20:25:50
2077	2026-09-08	8	9	September	3	2026	2025-11-03 20:25:50
2078	2026-09-09	9	9	September	3	2026	2025-11-03 20:25:50
2079	2026-09-10	10	9	September	3	2026	2025-11-03 20:25:50
2080	2026-09-11	11	9	September	3	2026	2025-11-03 20:25:50
2081	2026-09-12	12	9	September	3	2026	2025-11-03 20:25:50
2082	2026-09-13	13	9	September	3	2026	2025-11-03 20:25:50
2083	2026-09-14	14	9	September	3	2026	2025-11-03 20:25:50
2084	2026-09-15	15	9	September	3	2026	2025-11-03 20:25:50
2085	2026-09-16	16	9	September	3	2026	2025-11-03 20:25:50
2086	2026-09-17	17	9	September	3	2026	2025-11-03 20:25:50
2087	2026-09-18	18	9	September	3	2026	2025-11-03 20:25:50
2088	2026-09-19	19	9	September	3	2026	2025-11-03 20:25:50
2089	2026-09-20	20	9	September	3	2026	2025-11-03 20:25:50
2090	2026-09-21	21	9	September	3	2026	2025-11-03 20:25:50
2091	2026-09-22	22	9	September	3	2026	2025-11-03 20:25:50
2092	2026-09-23	23	9	September	3	2026	2025-11-03 20:25:50
2093	2026-09-24	24	9	September	3	2026	2025-11-03 20:25:50
2094	2026-09-25	25	9	September	3	2026	2025-11-03 20:25:50
2095	2026-09-26	26	9	September	3	2026	2025-11-03 20:25:50
2096	2026-09-27	27	9	September	3	2026	2025-11-03 20:25:50
2097	2026-09-28	28	9	September	3	2026	2025-11-03 20:25:50
2098	2026-09-29	29	9	September	3	2026	2025-11-03 20:25:50
2099	2026-09-30	30	9	September	3	2026	2025-11-03 20:25:50
2100	2026-10-01	1	10	October  	4	2026	2025-11-03 20:25:50
2101	2026-10-02	2	10	October  	4	2026	2025-11-03 20:25:50
2102	2026-10-03	3	10	October  	4	2026	2025-11-03 20:25:50
2103	2026-10-04	4	10	October  	4	2026	2025-11-03 20:25:50
2104	2026-10-05	5	10	October  	4	2026	2025-11-03 20:25:50
2105	2026-10-06	6	10	October  	4	2026	2025-11-03 20:25:50
2106	2026-10-07	7	10	October  	4	2026	2025-11-03 20:25:50
2107	2026-10-08	8	10	October  	4	2026	2025-11-03 20:25:50
2108	2026-10-09	9	10	October  	4	2026	2025-11-03 20:25:50
2109	2026-10-10	10	10	October  	4	2026	2025-11-03 20:25:50
2110	2026-10-11	11	10	October  	4	2026	2025-11-03 20:25:50
2111	2026-10-12	12	10	October  	4	2026	2025-11-03 20:25:50
2112	2026-10-13	13	10	October  	4	2026	2025-11-03 20:25:50
2113	2026-10-14	14	10	October  	4	2026	2025-11-03 20:25:50
2114	2026-10-15	15	10	October  	4	2026	2025-11-03 20:25:50
2115	2026-10-16	16	10	October  	4	2026	2025-11-03 20:25:50
2116	2026-10-17	17	10	October  	4	2026	2025-11-03 20:25:50
2117	2026-10-18	18	10	October  	4	2026	2025-11-03 20:25:50
2118	2026-10-19	19	10	October  	4	2026	2025-11-03 20:25:50
2119	2026-10-20	20	10	October  	4	2026	2025-11-03 20:25:50
2120	2026-10-21	21	10	October  	4	2026	2025-11-03 20:25:50
2121	2026-10-22	22	10	October  	4	2026	2025-11-03 20:25:50
2122	2026-10-23	23	10	October  	4	2026	2025-11-03 20:25:50
2123	2026-10-24	24	10	October  	4	2026	2025-11-03 20:25:50
2124	2026-10-25	25	10	October  	4	2026	2025-11-03 20:25:50
2125	2026-10-26	26	10	October  	4	2026	2025-11-03 20:25:50
2126	2026-10-27	27	10	October  	4	2026	2025-11-03 20:25:50
2127	2026-10-28	28	10	October  	4	2026	2025-11-03 20:25:50
2128	2026-10-29	29	10	October  	4	2026	2025-11-03 20:25:50
2129	2026-10-30	30	10	October  	4	2026	2025-11-03 20:25:50
2130	2026-10-31	31	10	October  	4	2026	2025-11-03 20:25:50
2131	2026-11-01	1	11	November 	4	2026	2025-11-03 20:25:50
2132	2026-11-02	2	11	November 	4	2026	2025-11-03 20:25:50
2133	2026-11-03	3	11	November 	4	2026	2025-11-03 20:25:50
2134	2026-11-04	4	11	November 	4	2026	2025-11-03 20:25:50
2135	2026-11-05	5	11	November 	4	2026	2025-11-03 20:25:50
2136	2026-11-06	6	11	November 	4	2026	2025-11-03 20:25:50
2137	2026-11-07	7	11	November 	4	2026	2025-11-03 20:25:50
2138	2026-11-08	8	11	November 	4	2026	2025-11-03 20:25:50
2139	2026-11-09	9	11	November 	4	2026	2025-11-03 20:25:50
2140	2026-11-10	10	11	November 	4	2026	2025-11-03 20:25:50
2141	2026-11-11	11	11	November 	4	2026	2025-11-03 20:25:50
2142	2026-11-12	12	11	November 	4	2026	2025-11-03 20:25:50
2143	2026-11-13	13	11	November 	4	2026	2025-11-03 20:25:50
2144	2026-11-14	14	11	November 	4	2026	2025-11-03 20:25:50
2145	2026-11-15	15	11	November 	4	2026	2025-11-03 20:25:50
2146	2026-11-16	16	11	November 	4	2026	2025-11-03 20:25:50
2147	2026-11-17	17	11	November 	4	2026	2025-11-03 20:25:50
2148	2026-11-18	18	11	November 	4	2026	2025-11-03 20:25:50
2149	2026-11-19	19	11	November 	4	2026	2025-11-03 20:25:50
2150	2026-11-20	20	11	November 	4	2026	2025-11-03 20:25:50
2151	2026-11-21	21	11	November 	4	2026	2025-11-03 20:25:50
2152	2026-11-22	22	11	November 	4	2026	2025-11-03 20:25:50
2153	2026-11-23	23	11	November 	4	2026	2025-11-03 20:25:50
2154	2026-11-24	24	11	November 	4	2026	2025-11-03 20:25:50
2155	2026-11-25	25	11	November 	4	2026	2025-11-03 20:25:50
2156	2026-11-26	26	11	November 	4	2026	2025-11-03 20:25:50
2157	2026-11-27	27	11	November 	4	2026	2025-11-03 20:25:50
2158	2026-11-28	28	11	November 	4	2026	2025-11-03 20:25:50
2159	2026-11-29	29	11	November 	4	2026	2025-11-03 20:25:50
2160	2026-11-30	30	11	November 	4	2026	2025-11-03 20:25:50
2161	2026-12-01	1	12	December 	4	2026	2025-11-03 20:25:50
2162	2026-12-02	2	12	December 	4	2026	2025-11-03 20:25:50
2163	2026-12-03	3	12	December 	4	2026	2025-11-03 20:25:50
2164	2026-12-04	4	12	December 	4	2026	2025-11-03 20:25:50
2165	2026-12-05	5	12	December 	4	2026	2025-11-03 20:25:50
2166	2026-12-06	6	12	December 	4	2026	2025-11-03 20:25:50
2167	2026-12-07	7	12	December 	4	2026	2025-11-03 20:25:50
2168	2026-12-08	8	12	December 	4	2026	2025-11-03 20:25:50
2169	2026-12-09	9	12	December 	4	2026	2025-11-03 20:25:50
2170	2026-12-10	10	12	December 	4	2026	2025-11-03 20:25:50
2171	2026-12-11	11	12	December 	4	2026	2025-11-03 20:25:50
2172	2026-12-12	12	12	December 	4	2026	2025-11-03 20:25:50
2173	2026-12-13	13	12	December 	4	2026	2025-11-03 20:25:50
2174	2026-12-14	14	12	December 	4	2026	2025-11-03 20:25:50
2175	2026-12-15	15	12	December 	4	2026	2025-11-03 20:25:50
2176	2026-12-16	16	12	December 	4	2026	2025-11-03 20:25:50
2177	2026-12-17	17	12	December 	4	2026	2025-11-03 20:25:50
2178	2026-12-18	18	12	December 	4	2026	2025-11-03 20:25:50
2179	2026-12-19	19	12	December 	4	2026	2025-11-03 20:25:50
2180	2026-12-20	20	12	December 	4	2026	2025-11-03 20:25:50
2181	2026-12-21	21	12	December 	4	2026	2025-11-03 20:25:50
2182	2026-12-22	22	12	December 	4	2026	2025-11-03 20:25:50
2183	2026-12-23	23	12	December 	4	2026	2025-11-03 20:25:50
2184	2026-12-24	24	12	December 	4	2026	2025-11-03 20:25:50
2185	2026-12-25	25	12	December 	4	2026	2025-11-03 20:25:50
2186	2026-12-26	26	12	December 	4	2026	2025-11-03 20:25:50
2187	2026-12-27	27	12	December 	4	2026	2025-11-03 20:25:50
2188	2026-12-28	28	12	December 	4	2026	2025-11-03 20:25:50
2189	2026-12-29	29	12	December 	4	2026	2025-11-03 20:25:50
2190	2026-12-30	30	12	December 	4	2026	2025-11-03 20:25:50
2191	2026-12-31	31	12	December 	4	2026	2025-11-03 20:25:50
2192	2027-01-01	1	1	January  	1	2027	2025-11-03 20:25:50
2193	2027-01-02	2	1	January  	1	2027	2025-11-03 20:25:50
2194	2027-01-03	3	1	January  	1	2027	2025-11-03 20:25:50
2195	2027-01-04	4	1	January  	1	2027	2025-11-03 20:25:50
2196	2027-01-05	5	1	January  	1	2027	2025-11-03 20:25:50
2197	2027-01-06	6	1	January  	1	2027	2025-11-03 20:25:50
2198	2027-01-07	7	1	January  	1	2027	2025-11-03 20:25:50
2199	2027-01-08	8	1	January  	1	2027	2025-11-03 20:25:50
2200	2027-01-09	9	1	January  	1	2027	2025-11-03 20:25:50
2201	2027-01-10	10	1	January  	1	2027	2025-11-03 20:25:50
2202	2027-01-11	11	1	January  	1	2027	2025-11-03 20:25:50
2203	2027-01-12	12	1	January  	1	2027	2025-11-03 20:25:50
2204	2027-01-13	13	1	January  	1	2027	2025-11-03 20:25:50
2205	2027-01-14	14	1	January  	1	2027	2025-11-03 20:25:50
2206	2027-01-15	15	1	January  	1	2027	2025-11-03 20:25:50
2207	2027-01-16	16	1	January  	1	2027	2025-11-03 20:25:50
2208	2027-01-17	17	1	January  	1	2027	2025-11-03 20:25:50
2209	2027-01-18	18	1	January  	1	2027	2025-11-03 20:25:50
2210	2027-01-19	19	1	January  	1	2027	2025-11-03 20:25:50
2211	2027-01-20	20	1	January  	1	2027	2025-11-03 20:25:50
2212	2027-01-21	21	1	January  	1	2027	2025-11-03 20:25:50
2213	2027-01-22	22	1	January  	1	2027	2025-11-03 20:25:50
2214	2027-01-23	23	1	January  	1	2027	2025-11-03 20:25:50
2215	2027-01-24	24	1	January  	1	2027	2025-11-03 20:25:50
2216	2027-01-25	25	1	January  	1	2027	2025-11-03 20:25:50
2217	2027-01-26	26	1	January  	1	2027	2025-11-03 20:25:50
2218	2027-01-27	27	1	January  	1	2027	2025-11-03 20:25:50
2219	2027-01-28	28	1	January  	1	2027	2025-11-03 20:25:50
2220	2027-01-29	29	1	January  	1	2027	2025-11-03 20:25:50
2221	2027-01-30	30	1	January  	1	2027	2025-11-03 20:25:50
2222	2027-01-31	31	1	January  	1	2027	2025-11-03 20:25:50
2223	2027-02-01	1	2	February 	1	2027	2025-11-03 20:25:50
2224	2027-02-02	2	2	February 	1	2027	2025-11-03 20:25:50
2225	2027-02-03	3	2	February 	1	2027	2025-11-03 20:25:50
2226	2027-02-04	4	2	February 	1	2027	2025-11-03 20:25:50
2227	2027-02-05	5	2	February 	1	2027	2025-11-03 20:25:50
2228	2027-02-06	6	2	February 	1	2027	2025-11-03 20:25:50
2229	2027-02-07	7	2	February 	1	2027	2025-11-03 20:25:50
2230	2027-02-08	8	2	February 	1	2027	2025-11-03 20:25:50
2231	2027-02-09	9	2	February 	1	2027	2025-11-03 20:25:50
2232	2027-02-10	10	2	February 	1	2027	2025-11-03 20:25:50
2233	2027-02-11	11	2	February 	1	2027	2025-11-03 20:25:50
2234	2027-02-12	12	2	February 	1	2027	2025-11-03 20:25:50
2235	2027-02-13	13	2	February 	1	2027	2025-11-03 20:25:50
2236	2027-02-14	14	2	February 	1	2027	2025-11-03 20:25:50
2237	2027-02-15	15	2	February 	1	2027	2025-11-03 20:25:50
2238	2027-02-16	16	2	February 	1	2027	2025-11-03 20:25:50
2239	2027-02-17	17	2	February 	1	2027	2025-11-03 20:25:50
2240	2027-02-18	18	2	February 	1	2027	2025-11-03 20:25:50
2241	2027-02-19	19	2	February 	1	2027	2025-11-03 20:25:50
2242	2027-02-20	20	2	February 	1	2027	2025-11-03 20:25:50
2243	2027-02-21	21	2	February 	1	2027	2025-11-03 20:25:50
2244	2027-02-22	22	2	February 	1	2027	2025-11-03 20:25:50
2245	2027-02-23	23	2	February 	1	2027	2025-11-03 20:25:50
2246	2027-02-24	24	2	February 	1	2027	2025-11-03 20:25:50
2247	2027-02-25	25	2	February 	1	2027	2025-11-03 20:25:50
2248	2027-02-26	26	2	February 	1	2027	2025-11-03 20:25:50
2249	2027-02-27	27	2	February 	1	2027	2025-11-03 20:25:50
2250	2027-02-28	28	2	February 	1	2027	2025-11-03 20:25:50
2251	2027-03-01	1	3	March    	1	2027	2025-11-03 20:25:50
2252	2027-03-02	2	3	March    	1	2027	2025-11-03 20:25:50
2253	2027-03-03	3	3	March    	1	2027	2025-11-03 20:25:50
2254	2027-03-04	4	3	March    	1	2027	2025-11-03 20:25:50
2255	2027-03-05	5	3	March    	1	2027	2025-11-03 20:25:50
2256	2027-03-06	6	3	March    	1	2027	2025-11-03 20:25:50
2257	2027-03-07	7	3	March    	1	2027	2025-11-03 20:25:50
2258	2027-03-08	8	3	March    	1	2027	2025-11-03 20:25:50
2259	2027-03-09	9	3	March    	1	2027	2025-11-03 20:25:50
2260	2027-03-10	10	3	March    	1	2027	2025-11-03 20:25:50
2261	2027-03-11	11	3	March    	1	2027	2025-11-03 20:25:50
2262	2027-03-12	12	3	March    	1	2027	2025-11-03 20:25:50
2263	2027-03-13	13	3	March    	1	2027	2025-11-03 20:25:50
2264	2027-03-14	14	3	March    	1	2027	2025-11-03 20:25:50
2265	2027-03-15	15	3	March    	1	2027	2025-11-03 20:25:50
2266	2027-03-16	16	3	March    	1	2027	2025-11-03 20:25:50
2267	2027-03-17	17	3	March    	1	2027	2025-11-03 20:25:50
2268	2027-03-18	18	3	March    	1	2027	2025-11-03 20:25:50
2269	2027-03-19	19	3	March    	1	2027	2025-11-03 20:25:50
2270	2027-03-20	20	3	March    	1	2027	2025-11-03 20:25:50
2271	2027-03-21	21	3	March    	1	2027	2025-11-03 20:25:50
2272	2027-03-22	22	3	March    	1	2027	2025-11-03 20:25:50
2273	2027-03-23	23	3	March    	1	2027	2025-11-03 20:25:50
2274	2027-03-24	24	3	March    	1	2027	2025-11-03 20:25:50
2275	2027-03-25	25	3	March    	1	2027	2025-11-03 20:25:50
2276	2027-03-26	26	3	March    	1	2027	2025-11-03 20:25:50
2277	2027-03-27	27	3	March    	1	2027	2025-11-03 20:25:50
2278	2027-03-28	28	3	March    	1	2027	2025-11-03 20:25:50
2279	2027-03-29	29	3	March    	1	2027	2025-11-03 20:25:50
2280	2027-03-30	30	3	March    	1	2027	2025-11-03 20:25:50
2281	2027-03-31	31	3	March    	1	2027	2025-11-03 20:25:50
2282	2027-04-01	1	4	April    	2	2027	2025-11-03 20:25:50
2283	2027-04-02	2	4	April    	2	2027	2025-11-03 20:25:50
2284	2027-04-03	3	4	April    	2	2027	2025-11-03 20:25:50
2285	2027-04-04	4	4	April    	2	2027	2025-11-03 20:25:50
2286	2027-04-05	5	4	April    	2	2027	2025-11-03 20:25:50
2287	2027-04-06	6	4	April    	2	2027	2025-11-03 20:25:50
2288	2027-04-07	7	4	April    	2	2027	2025-11-03 20:25:50
2289	2027-04-08	8	4	April    	2	2027	2025-11-03 20:25:50
2290	2027-04-09	9	4	April    	2	2027	2025-11-03 20:25:50
2291	2027-04-10	10	4	April    	2	2027	2025-11-03 20:25:50
2292	2027-04-11	11	4	April    	2	2027	2025-11-03 20:25:50
2293	2027-04-12	12	4	April    	2	2027	2025-11-03 20:25:50
2294	2027-04-13	13	4	April    	2	2027	2025-11-03 20:25:50
2295	2027-04-14	14	4	April    	2	2027	2025-11-03 20:25:50
2296	2027-04-15	15	4	April    	2	2027	2025-11-03 20:25:50
2297	2027-04-16	16	4	April    	2	2027	2025-11-03 20:25:50
2298	2027-04-17	17	4	April    	2	2027	2025-11-03 20:25:50
2299	2027-04-18	18	4	April    	2	2027	2025-11-03 20:25:50
2300	2027-04-19	19	4	April    	2	2027	2025-11-03 20:25:50
2301	2027-04-20	20	4	April    	2	2027	2025-11-03 20:25:50
2302	2027-04-21	21	4	April    	2	2027	2025-11-03 20:25:50
2303	2027-04-22	22	4	April    	2	2027	2025-11-03 20:25:50
2304	2027-04-23	23	4	April    	2	2027	2025-11-03 20:25:50
2305	2027-04-24	24	4	April    	2	2027	2025-11-03 20:25:50
2306	2027-04-25	25	4	April    	2	2027	2025-11-03 20:25:50
2307	2027-04-26	26	4	April    	2	2027	2025-11-03 20:25:50
2308	2027-04-27	27	4	April    	2	2027	2025-11-03 20:25:50
2309	2027-04-28	28	4	April    	2	2027	2025-11-03 20:25:50
2310	2027-04-29	29	4	April    	2	2027	2025-11-03 20:25:50
2311	2027-04-30	30	4	April    	2	2027	2025-11-03 20:25:50
2312	2027-05-01	1	5	May      	2	2027	2025-11-03 20:25:50
2313	2027-05-02	2	5	May      	2	2027	2025-11-03 20:25:50
2314	2027-05-03	3	5	May      	2	2027	2025-11-03 20:25:50
2315	2027-05-04	4	5	May      	2	2027	2025-11-03 20:25:50
2316	2027-05-05	5	5	May      	2	2027	2025-11-03 20:25:50
2317	2027-05-06	6	5	May      	2	2027	2025-11-03 20:25:50
2318	2027-05-07	7	5	May      	2	2027	2025-11-03 20:25:50
2319	2027-05-08	8	5	May      	2	2027	2025-11-03 20:25:50
2320	2027-05-09	9	5	May      	2	2027	2025-11-03 20:25:50
2321	2027-05-10	10	5	May      	2	2027	2025-11-03 20:25:50
2322	2027-05-11	11	5	May      	2	2027	2025-11-03 20:25:50
2323	2027-05-12	12	5	May      	2	2027	2025-11-03 20:25:50
2324	2027-05-13	13	5	May      	2	2027	2025-11-03 20:25:50
2325	2027-05-14	14	5	May      	2	2027	2025-11-03 20:25:50
2326	2027-05-15	15	5	May      	2	2027	2025-11-03 20:25:50
2327	2027-05-16	16	5	May      	2	2027	2025-11-03 20:25:50
2328	2027-05-17	17	5	May      	2	2027	2025-11-03 20:25:50
2329	2027-05-18	18	5	May      	2	2027	2025-11-03 20:25:50
2330	2027-05-19	19	5	May      	2	2027	2025-11-03 20:25:50
2331	2027-05-20	20	5	May      	2	2027	2025-11-03 20:25:50
2332	2027-05-21	21	5	May      	2	2027	2025-11-03 20:25:50
2333	2027-05-22	22	5	May      	2	2027	2025-11-03 20:25:50
2334	2027-05-23	23	5	May      	2	2027	2025-11-03 20:25:50
2335	2027-05-24	24	5	May      	2	2027	2025-11-03 20:25:50
2336	2027-05-25	25	5	May      	2	2027	2025-11-03 20:25:50
2337	2027-05-26	26	5	May      	2	2027	2025-11-03 20:25:50
2338	2027-05-27	27	5	May      	2	2027	2025-11-03 20:25:50
2339	2027-05-28	28	5	May      	2	2027	2025-11-03 20:25:50
2340	2027-05-29	29	5	May      	2	2027	2025-11-03 20:25:50
2341	2027-05-30	30	5	May      	2	2027	2025-11-03 20:25:50
2342	2027-05-31	31	5	May      	2	2027	2025-11-03 20:25:50
2343	2027-06-01	1	6	June     	2	2027	2025-11-03 20:25:50
2344	2027-06-02	2	6	June     	2	2027	2025-11-03 20:25:50
2345	2027-06-03	3	6	June     	2	2027	2025-11-03 20:25:50
2346	2027-06-04	4	6	June     	2	2027	2025-11-03 20:25:50
2347	2027-06-05	5	6	June     	2	2027	2025-11-03 20:25:50
2348	2027-06-06	6	6	June     	2	2027	2025-11-03 20:25:50
2349	2027-06-07	7	6	June     	2	2027	2025-11-03 20:25:50
2350	2027-06-08	8	6	June     	2	2027	2025-11-03 20:25:50
2351	2027-06-09	9	6	June     	2	2027	2025-11-03 20:25:50
2352	2027-06-10	10	6	June     	2	2027	2025-11-03 20:25:50
2353	2027-06-11	11	6	June     	2	2027	2025-11-03 20:25:50
2354	2027-06-12	12	6	June     	2	2027	2025-11-03 20:25:50
2355	2027-06-13	13	6	June     	2	2027	2025-11-03 20:25:50
2356	2027-06-14	14	6	June     	2	2027	2025-11-03 20:25:50
2357	2027-06-15	15	6	June     	2	2027	2025-11-03 20:25:50
2358	2027-06-16	16	6	June     	2	2027	2025-11-03 20:25:50
2359	2027-06-17	17	6	June     	2	2027	2025-11-03 20:25:50
2360	2027-06-18	18	6	June     	2	2027	2025-11-03 20:25:50
2361	2027-06-19	19	6	June     	2	2027	2025-11-03 20:25:50
2362	2027-06-20	20	6	June     	2	2027	2025-11-03 20:25:50
2363	2027-06-21	21	6	June     	2	2027	2025-11-03 20:25:50
2364	2027-06-22	22	6	June     	2	2027	2025-11-03 20:25:50
2365	2027-06-23	23	6	June     	2	2027	2025-11-03 20:25:50
2366	2027-06-24	24	6	June     	2	2027	2025-11-03 20:25:50
2367	2027-06-25	25	6	June     	2	2027	2025-11-03 20:25:50
2368	2027-06-26	26	6	June     	2	2027	2025-11-03 20:25:50
2369	2027-06-27	27	6	June     	2	2027	2025-11-03 20:25:50
2370	2027-06-28	28	6	June     	2	2027	2025-11-03 20:25:50
2371	2027-06-29	29	6	June     	2	2027	2025-11-03 20:25:50
2372	2027-06-30	30	6	June     	2	2027	2025-11-03 20:25:50
2373	2027-07-01	1	7	July     	3	2027	2025-11-03 20:25:50
2374	2027-07-02	2	7	July     	3	2027	2025-11-03 20:25:50
2375	2027-07-03	3	7	July     	3	2027	2025-11-03 20:25:50
2376	2027-07-04	4	7	July     	3	2027	2025-11-03 20:25:50
2377	2027-07-05	5	7	July     	3	2027	2025-11-03 20:25:50
2378	2027-07-06	6	7	July     	3	2027	2025-11-03 20:25:50
2379	2027-07-07	7	7	July     	3	2027	2025-11-03 20:25:50
2380	2027-07-08	8	7	July     	3	2027	2025-11-03 20:25:50
2381	2027-07-09	9	7	July     	3	2027	2025-11-03 20:25:50
2382	2027-07-10	10	7	July     	3	2027	2025-11-03 20:25:50
2383	2027-07-11	11	7	July     	3	2027	2025-11-03 20:25:50
2384	2027-07-12	12	7	July     	3	2027	2025-11-03 20:25:50
2385	2027-07-13	13	7	July     	3	2027	2025-11-03 20:25:50
2386	2027-07-14	14	7	July     	3	2027	2025-11-03 20:25:50
2387	2027-07-15	15	7	July     	3	2027	2025-11-03 20:25:50
2388	2027-07-16	16	7	July     	3	2027	2025-11-03 20:25:50
2389	2027-07-17	17	7	July     	3	2027	2025-11-03 20:25:50
2390	2027-07-18	18	7	July     	3	2027	2025-11-03 20:25:50
2391	2027-07-19	19	7	July     	3	2027	2025-11-03 20:25:50
2392	2027-07-20	20	7	July     	3	2027	2025-11-03 20:25:50
2393	2027-07-21	21	7	July     	3	2027	2025-11-03 20:25:50
2394	2027-07-22	22	7	July     	3	2027	2025-11-03 20:25:50
2395	2027-07-23	23	7	July     	3	2027	2025-11-03 20:25:50
2396	2027-07-24	24	7	July     	3	2027	2025-11-03 20:25:50
2397	2027-07-25	25	7	July     	3	2027	2025-11-03 20:25:50
2398	2027-07-26	26	7	July     	3	2027	2025-11-03 20:25:50
2399	2027-07-27	27	7	July     	3	2027	2025-11-03 20:25:50
2400	2027-07-28	28	7	July     	3	2027	2025-11-03 20:25:50
2401	2027-07-29	29	7	July     	3	2027	2025-11-03 20:25:50
2402	2027-07-30	30	7	July     	3	2027	2025-11-03 20:25:50
2403	2027-07-31	31	7	July     	3	2027	2025-11-03 20:25:50
2404	2027-08-01	1	8	August   	3	2027	2025-11-03 20:25:50
2405	2027-08-02	2	8	August   	3	2027	2025-11-03 20:25:50
2406	2027-08-03	3	8	August   	3	2027	2025-11-03 20:25:50
2407	2027-08-04	4	8	August   	3	2027	2025-11-03 20:25:50
2408	2027-08-05	5	8	August   	3	2027	2025-11-03 20:25:50
2409	2027-08-06	6	8	August   	3	2027	2025-11-03 20:25:50
2410	2027-08-07	7	8	August   	3	2027	2025-11-03 20:25:50
2411	2027-08-08	8	8	August   	3	2027	2025-11-03 20:25:50
2412	2027-08-09	9	8	August   	3	2027	2025-11-03 20:25:50
2413	2027-08-10	10	8	August   	3	2027	2025-11-03 20:25:50
2414	2027-08-11	11	8	August   	3	2027	2025-11-03 20:25:50
2415	2027-08-12	12	8	August   	3	2027	2025-11-03 20:25:50
2416	2027-08-13	13	8	August   	3	2027	2025-11-03 20:25:50
2417	2027-08-14	14	8	August   	3	2027	2025-11-03 20:25:50
2418	2027-08-15	15	8	August   	3	2027	2025-11-03 20:25:50
2419	2027-08-16	16	8	August   	3	2027	2025-11-03 20:25:50
2420	2027-08-17	17	8	August   	3	2027	2025-11-03 20:25:50
2421	2027-08-18	18	8	August   	3	2027	2025-11-03 20:25:50
2422	2027-08-19	19	8	August   	3	2027	2025-11-03 20:25:50
2423	2027-08-20	20	8	August   	3	2027	2025-11-03 20:25:50
2424	2027-08-21	21	8	August   	3	2027	2025-11-03 20:25:50
2425	2027-08-22	22	8	August   	3	2027	2025-11-03 20:25:50
2426	2027-08-23	23	8	August   	3	2027	2025-11-03 20:25:50
2427	2027-08-24	24	8	August   	3	2027	2025-11-03 20:25:50
2428	2027-08-25	25	8	August   	3	2027	2025-11-03 20:25:50
2429	2027-08-26	26	8	August   	3	2027	2025-11-03 20:25:50
2430	2027-08-27	27	8	August   	3	2027	2025-11-03 20:25:50
2431	2027-08-28	28	8	August   	3	2027	2025-11-03 20:25:50
2432	2027-08-29	29	8	August   	3	2027	2025-11-03 20:25:50
2433	2027-08-30	30	8	August   	3	2027	2025-11-03 20:25:50
2434	2027-08-31	31	8	August   	3	2027	2025-11-03 20:25:50
2435	2027-09-01	1	9	September	3	2027	2025-11-03 20:25:50
2436	2027-09-02	2	9	September	3	2027	2025-11-03 20:25:50
2437	2027-09-03	3	9	September	3	2027	2025-11-03 20:25:50
2438	2027-09-04	4	9	September	3	2027	2025-11-03 20:25:50
2439	2027-09-05	5	9	September	3	2027	2025-11-03 20:25:50
2440	2027-09-06	6	9	September	3	2027	2025-11-03 20:25:50
2441	2027-09-07	7	9	September	3	2027	2025-11-03 20:25:50
2442	2027-09-08	8	9	September	3	2027	2025-11-03 20:25:50
2443	2027-09-09	9	9	September	3	2027	2025-11-03 20:25:50
2444	2027-09-10	10	9	September	3	2027	2025-11-03 20:25:50
2445	2027-09-11	11	9	September	3	2027	2025-11-03 20:25:50
2446	2027-09-12	12	9	September	3	2027	2025-11-03 20:25:50
2447	2027-09-13	13	9	September	3	2027	2025-11-03 20:25:50
2448	2027-09-14	14	9	September	3	2027	2025-11-03 20:25:50
2449	2027-09-15	15	9	September	3	2027	2025-11-03 20:25:50
2450	2027-09-16	16	9	September	3	2027	2025-11-03 20:25:50
2451	2027-09-17	17	9	September	3	2027	2025-11-03 20:25:50
2452	2027-09-18	18	9	September	3	2027	2025-11-03 20:25:50
2453	2027-09-19	19	9	September	3	2027	2025-11-03 20:25:50
2454	2027-09-20	20	9	September	3	2027	2025-11-03 20:25:50
2455	2027-09-21	21	9	September	3	2027	2025-11-03 20:25:50
2456	2027-09-22	22	9	September	3	2027	2025-11-03 20:25:50
2457	2027-09-23	23	9	September	3	2027	2025-11-03 20:25:50
2458	2027-09-24	24	9	September	3	2027	2025-11-03 20:25:50
2459	2027-09-25	25	9	September	3	2027	2025-11-03 20:25:50
2460	2027-09-26	26	9	September	3	2027	2025-11-03 20:25:50
2461	2027-09-27	27	9	September	3	2027	2025-11-03 20:25:50
2462	2027-09-28	28	9	September	3	2027	2025-11-03 20:25:50
2463	2027-09-29	29	9	September	3	2027	2025-11-03 20:25:50
2464	2027-09-30	30	9	September	3	2027	2025-11-03 20:25:50
2465	2027-10-01	1	10	October  	4	2027	2025-11-03 20:25:50
2466	2027-10-02	2	10	October  	4	2027	2025-11-03 20:25:50
2467	2027-10-03	3	10	October  	4	2027	2025-11-03 20:25:50
2468	2027-10-04	4	10	October  	4	2027	2025-11-03 20:25:50
2469	2027-10-05	5	10	October  	4	2027	2025-11-03 20:25:50
2470	2027-10-06	6	10	October  	4	2027	2025-11-03 20:25:50
2471	2027-10-07	7	10	October  	4	2027	2025-11-03 20:25:50
2472	2027-10-08	8	10	October  	4	2027	2025-11-03 20:25:50
2473	2027-10-09	9	10	October  	4	2027	2025-11-03 20:25:50
2474	2027-10-10	10	10	October  	4	2027	2025-11-03 20:25:50
2475	2027-10-11	11	10	October  	4	2027	2025-11-03 20:25:50
2476	2027-10-12	12	10	October  	4	2027	2025-11-03 20:25:50
2477	2027-10-13	13	10	October  	4	2027	2025-11-03 20:25:50
2478	2027-10-14	14	10	October  	4	2027	2025-11-03 20:25:50
2479	2027-10-15	15	10	October  	4	2027	2025-11-03 20:25:50
2480	2027-10-16	16	10	October  	4	2027	2025-11-03 20:25:50
2481	2027-10-17	17	10	October  	4	2027	2025-11-03 20:25:50
2482	2027-10-18	18	10	October  	4	2027	2025-11-03 20:25:50
2483	2027-10-19	19	10	October  	4	2027	2025-11-03 20:25:50
2484	2027-10-20	20	10	October  	4	2027	2025-11-03 20:25:50
2485	2027-10-21	21	10	October  	4	2027	2025-11-03 20:25:50
2486	2027-10-22	22	10	October  	4	2027	2025-11-03 20:25:50
2487	2027-10-23	23	10	October  	4	2027	2025-11-03 20:25:50
2488	2027-10-24	24	10	October  	4	2027	2025-11-03 20:25:50
2489	2027-10-25	25	10	October  	4	2027	2025-11-03 20:25:50
2490	2027-10-26	26	10	October  	4	2027	2025-11-03 20:25:50
2491	2027-10-27	27	10	October  	4	2027	2025-11-03 20:25:50
2492	2027-10-28	28	10	October  	4	2027	2025-11-03 20:25:50
2493	2027-10-29	29	10	October  	4	2027	2025-11-03 20:25:50
2494	2027-10-30	30	10	October  	4	2027	2025-11-03 20:25:50
2495	2027-10-31	31	10	October  	4	2027	2025-11-03 20:25:50
2496	2027-11-01	1	11	November 	4	2027	2025-11-03 20:25:50
2497	2027-11-02	2	11	November 	4	2027	2025-11-03 20:25:50
2498	2027-11-03	3	11	November 	4	2027	2025-11-03 20:25:50
2499	2027-11-04	4	11	November 	4	2027	2025-11-03 20:25:50
2500	2027-11-05	5	11	November 	4	2027	2025-11-03 20:25:50
2501	2027-11-06	6	11	November 	4	2027	2025-11-03 20:25:50
2502	2027-11-07	7	11	November 	4	2027	2025-11-03 20:25:50
2503	2027-11-08	8	11	November 	4	2027	2025-11-03 20:25:50
2504	2027-11-09	9	11	November 	4	2027	2025-11-03 20:25:50
2505	2027-11-10	10	11	November 	4	2027	2025-11-03 20:25:50
2506	2027-11-11	11	11	November 	4	2027	2025-11-03 20:25:50
2507	2027-11-12	12	11	November 	4	2027	2025-11-03 20:25:50
2508	2027-11-13	13	11	November 	4	2027	2025-11-03 20:25:50
2509	2027-11-14	14	11	November 	4	2027	2025-11-03 20:25:50
2510	2027-11-15	15	11	November 	4	2027	2025-11-03 20:25:50
2511	2027-11-16	16	11	November 	4	2027	2025-11-03 20:25:50
2512	2027-11-17	17	11	November 	4	2027	2025-11-03 20:25:50
2513	2027-11-18	18	11	November 	4	2027	2025-11-03 20:25:50
2514	2027-11-19	19	11	November 	4	2027	2025-11-03 20:25:50
2515	2027-11-20	20	11	November 	4	2027	2025-11-03 20:25:50
2516	2027-11-21	21	11	November 	4	2027	2025-11-03 20:25:50
2517	2027-11-22	22	11	November 	4	2027	2025-11-03 20:25:50
2518	2027-11-23	23	11	November 	4	2027	2025-11-03 20:25:50
2519	2027-11-24	24	11	November 	4	2027	2025-11-03 20:25:50
2520	2027-11-25	25	11	November 	4	2027	2025-11-03 20:25:50
2521	2027-11-26	26	11	November 	4	2027	2025-11-03 20:25:50
2522	2027-11-27	27	11	November 	4	2027	2025-11-03 20:25:50
2523	2027-11-28	28	11	November 	4	2027	2025-11-03 20:25:50
2524	2027-11-29	29	11	November 	4	2027	2025-11-03 20:25:50
2525	2027-11-30	30	11	November 	4	2027	2025-11-03 20:25:50
2526	2027-12-01	1	12	December 	4	2027	2025-11-03 20:25:50
2527	2027-12-02	2	12	December 	4	2027	2025-11-03 20:25:50
2528	2027-12-03	3	12	December 	4	2027	2025-11-03 20:25:50
2529	2027-12-04	4	12	December 	4	2027	2025-11-03 20:25:50
2530	2027-12-05	5	12	December 	4	2027	2025-11-03 20:25:50
2531	2027-12-06	6	12	December 	4	2027	2025-11-03 20:25:50
2532	2027-12-07	7	12	December 	4	2027	2025-11-03 20:25:50
2533	2027-12-08	8	12	December 	4	2027	2025-11-03 20:25:50
2534	2027-12-09	9	12	December 	4	2027	2025-11-03 20:25:50
2535	2027-12-10	10	12	December 	4	2027	2025-11-03 20:25:50
2536	2027-12-11	11	12	December 	4	2027	2025-11-03 20:25:50
2537	2027-12-12	12	12	December 	4	2027	2025-11-03 20:25:50
2538	2027-12-13	13	12	December 	4	2027	2025-11-03 20:25:50
2539	2027-12-14	14	12	December 	4	2027	2025-11-03 20:25:50
2540	2027-12-15	15	12	December 	4	2027	2025-11-03 20:25:50
2541	2027-12-16	16	12	December 	4	2027	2025-11-03 20:25:50
2542	2027-12-17	17	12	December 	4	2027	2025-11-03 20:25:50
2543	2027-12-18	18	12	December 	4	2027	2025-11-03 20:25:50
2544	2027-12-19	19	12	December 	4	2027	2025-11-03 20:25:50
2545	2027-12-20	20	12	December 	4	2027	2025-11-03 20:25:50
2546	2027-12-21	21	12	December 	4	2027	2025-11-03 20:25:50
2547	2027-12-22	22	12	December 	4	2027	2025-11-03 20:25:50
2548	2027-12-23	23	12	December 	4	2027	2025-11-03 20:25:50
2549	2027-12-24	24	12	December 	4	2027	2025-11-03 20:25:50
2550	2027-12-25	25	12	December 	4	2027	2025-11-03 20:25:50
2551	2027-12-26	26	12	December 	4	2027	2025-11-03 20:25:50
2552	2027-12-27	27	12	December 	4	2027	2025-11-03 20:25:50
2553	2027-12-28	28	12	December 	4	2027	2025-11-03 20:25:50
2554	2027-12-29	29	12	December 	4	2027	2025-11-03 20:25:50
2555	2027-12-30	30	12	December 	4	2027	2025-11-03 20:25:50
2556	2027-12-31	31	12	December 	4	2027	2025-11-03 20:25:50
2557	2028-01-01	1	1	January  	1	2028	2025-11-03 20:25:50
2558	2028-01-02	2	1	January  	1	2028	2025-11-03 20:25:50
2559	2028-01-03	3	1	January  	1	2028	2025-11-03 20:25:50
2560	2028-01-04	4	1	January  	1	2028	2025-11-03 20:25:50
2561	2028-01-05	5	1	January  	1	2028	2025-11-03 20:25:50
2562	2028-01-06	6	1	January  	1	2028	2025-11-03 20:25:50
2563	2028-01-07	7	1	January  	1	2028	2025-11-03 20:25:50
2564	2028-01-08	8	1	January  	1	2028	2025-11-03 20:25:50
2565	2028-01-09	9	1	January  	1	2028	2025-11-03 20:25:50
2566	2028-01-10	10	1	January  	1	2028	2025-11-03 20:25:50
2567	2028-01-11	11	1	January  	1	2028	2025-11-03 20:25:50
2568	2028-01-12	12	1	January  	1	2028	2025-11-03 20:25:50
2569	2028-01-13	13	1	January  	1	2028	2025-11-03 20:25:50
2570	2028-01-14	14	1	January  	1	2028	2025-11-03 20:25:50
2571	2028-01-15	15	1	January  	1	2028	2025-11-03 20:25:50
2572	2028-01-16	16	1	January  	1	2028	2025-11-03 20:25:50
2573	2028-01-17	17	1	January  	1	2028	2025-11-03 20:25:50
2574	2028-01-18	18	1	January  	1	2028	2025-11-03 20:25:50
2575	2028-01-19	19	1	January  	1	2028	2025-11-03 20:25:50
2576	2028-01-20	20	1	January  	1	2028	2025-11-03 20:25:50
2577	2028-01-21	21	1	January  	1	2028	2025-11-03 20:25:50
2578	2028-01-22	22	1	January  	1	2028	2025-11-03 20:25:50
2579	2028-01-23	23	1	January  	1	2028	2025-11-03 20:25:50
2580	2028-01-24	24	1	January  	1	2028	2025-11-03 20:25:50
2581	2028-01-25	25	1	January  	1	2028	2025-11-03 20:25:50
2582	2028-01-26	26	1	January  	1	2028	2025-11-03 20:25:50
2583	2028-01-27	27	1	January  	1	2028	2025-11-03 20:25:50
2584	2028-01-28	28	1	January  	1	2028	2025-11-03 20:25:50
2585	2028-01-29	29	1	January  	1	2028	2025-11-03 20:25:50
2586	2028-01-30	30	1	January  	1	2028	2025-11-03 20:25:50
2587	2028-01-31	31	1	January  	1	2028	2025-11-03 20:25:50
2588	2028-02-01	1	2	February 	1	2028	2025-11-03 20:25:50
2589	2028-02-02	2	2	February 	1	2028	2025-11-03 20:25:50
2590	2028-02-03	3	2	February 	1	2028	2025-11-03 20:25:50
2591	2028-02-04	4	2	February 	1	2028	2025-11-03 20:25:50
2592	2028-02-05	5	2	February 	1	2028	2025-11-03 20:25:50
2593	2028-02-06	6	2	February 	1	2028	2025-11-03 20:25:50
2594	2028-02-07	7	2	February 	1	2028	2025-11-03 20:25:50
2595	2028-02-08	8	2	February 	1	2028	2025-11-03 20:25:50
2596	2028-02-09	9	2	February 	1	2028	2025-11-03 20:25:50
2597	2028-02-10	10	2	February 	1	2028	2025-11-03 20:25:50
2598	2028-02-11	11	2	February 	1	2028	2025-11-03 20:25:50
2599	2028-02-12	12	2	February 	1	2028	2025-11-03 20:25:50
2600	2028-02-13	13	2	February 	1	2028	2025-11-03 20:25:50
2601	2028-02-14	14	2	February 	1	2028	2025-11-03 20:25:50
2602	2028-02-15	15	2	February 	1	2028	2025-11-03 20:25:50
2603	2028-02-16	16	2	February 	1	2028	2025-11-03 20:25:50
2604	2028-02-17	17	2	February 	1	2028	2025-11-03 20:25:50
2605	2028-02-18	18	2	February 	1	2028	2025-11-03 20:25:50
2606	2028-02-19	19	2	February 	1	2028	2025-11-03 20:25:50
2607	2028-02-20	20	2	February 	1	2028	2025-11-03 20:25:50
2608	2028-02-21	21	2	February 	1	2028	2025-11-03 20:25:50
2609	2028-02-22	22	2	February 	1	2028	2025-11-03 20:25:50
2610	2028-02-23	23	2	February 	1	2028	2025-11-03 20:25:50
2611	2028-02-24	24	2	February 	1	2028	2025-11-03 20:25:50
2612	2028-02-25	25	2	February 	1	2028	2025-11-03 20:25:50
2613	2028-02-26	26	2	February 	1	2028	2025-11-03 20:25:50
2614	2028-02-27	27	2	February 	1	2028	2025-11-03 20:25:50
2615	2028-02-28	28	2	February 	1	2028	2025-11-03 20:25:50
2616	2028-02-29	29	2	February 	1	2028	2025-11-03 20:25:50
2617	2028-03-01	1	3	March    	1	2028	2025-11-03 20:25:50
2618	2028-03-02	2	3	March    	1	2028	2025-11-03 20:25:50
2619	2028-03-03	3	3	March    	1	2028	2025-11-03 20:25:50
2620	2028-03-04	4	3	March    	1	2028	2025-11-03 20:25:50
2621	2028-03-05	5	3	March    	1	2028	2025-11-03 20:25:50
2622	2028-03-06	6	3	March    	1	2028	2025-11-03 20:25:50
2623	2028-03-07	7	3	March    	1	2028	2025-11-03 20:25:50
2624	2028-03-08	8	3	March    	1	2028	2025-11-03 20:25:50
2625	2028-03-09	9	3	March    	1	2028	2025-11-03 20:25:50
2626	2028-03-10	10	3	March    	1	2028	2025-11-03 20:25:50
2627	2028-03-11	11	3	March    	1	2028	2025-11-03 20:25:50
2628	2028-03-12	12	3	March    	1	2028	2025-11-03 20:25:50
2629	2028-03-13	13	3	March    	1	2028	2025-11-03 20:25:50
2630	2028-03-14	14	3	March    	1	2028	2025-11-03 20:25:50
2631	2028-03-15	15	3	March    	1	2028	2025-11-03 20:25:50
2632	2028-03-16	16	3	March    	1	2028	2025-11-03 20:25:50
2633	2028-03-17	17	3	March    	1	2028	2025-11-03 20:25:50
2634	2028-03-18	18	3	March    	1	2028	2025-11-03 20:25:50
2635	2028-03-19	19	3	March    	1	2028	2025-11-03 20:25:50
2636	2028-03-20	20	3	March    	1	2028	2025-11-03 20:25:50
2637	2028-03-21	21	3	March    	1	2028	2025-11-03 20:25:50
2638	2028-03-22	22	3	March    	1	2028	2025-11-03 20:25:50
2639	2028-03-23	23	3	March    	1	2028	2025-11-03 20:25:50
2640	2028-03-24	24	3	March    	1	2028	2025-11-03 20:25:50
2641	2028-03-25	25	3	March    	1	2028	2025-11-03 20:25:50
2642	2028-03-26	26	3	March    	1	2028	2025-11-03 20:25:50
2643	2028-03-27	27	3	March    	1	2028	2025-11-03 20:25:50
2644	2028-03-28	28	3	March    	1	2028	2025-11-03 20:25:50
2645	2028-03-29	29	3	March    	1	2028	2025-11-03 20:25:50
2646	2028-03-30	30	3	March    	1	2028	2025-11-03 20:25:50
2647	2028-03-31	31	3	March    	1	2028	2025-11-03 20:25:50
2648	2028-04-01	1	4	April    	2	2028	2025-11-03 20:25:50
2649	2028-04-02	2	4	April    	2	2028	2025-11-03 20:25:50
2650	2028-04-03	3	4	April    	2	2028	2025-11-03 20:25:50
2651	2028-04-04	4	4	April    	2	2028	2025-11-03 20:25:50
2652	2028-04-05	5	4	April    	2	2028	2025-11-03 20:25:50
2653	2028-04-06	6	4	April    	2	2028	2025-11-03 20:25:50
2654	2028-04-07	7	4	April    	2	2028	2025-11-03 20:25:50
2655	2028-04-08	8	4	April    	2	2028	2025-11-03 20:25:50
2656	2028-04-09	9	4	April    	2	2028	2025-11-03 20:25:50
2657	2028-04-10	10	4	April    	2	2028	2025-11-03 20:25:50
2658	2028-04-11	11	4	April    	2	2028	2025-11-03 20:25:50
2659	2028-04-12	12	4	April    	2	2028	2025-11-03 20:25:50
2660	2028-04-13	13	4	April    	2	2028	2025-11-03 20:25:50
2661	2028-04-14	14	4	April    	2	2028	2025-11-03 20:25:50
2662	2028-04-15	15	4	April    	2	2028	2025-11-03 20:25:50
2663	2028-04-16	16	4	April    	2	2028	2025-11-03 20:25:50
2664	2028-04-17	17	4	April    	2	2028	2025-11-03 20:25:50
2665	2028-04-18	18	4	April    	2	2028	2025-11-03 20:25:50
2666	2028-04-19	19	4	April    	2	2028	2025-11-03 20:25:50
2667	2028-04-20	20	4	April    	2	2028	2025-11-03 20:25:50
2668	2028-04-21	21	4	April    	2	2028	2025-11-03 20:25:50
2669	2028-04-22	22	4	April    	2	2028	2025-11-03 20:25:50
2670	2028-04-23	23	4	April    	2	2028	2025-11-03 20:25:50
2671	2028-04-24	24	4	April    	2	2028	2025-11-03 20:25:50
2672	2028-04-25	25	4	April    	2	2028	2025-11-03 20:25:50
2673	2028-04-26	26	4	April    	2	2028	2025-11-03 20:25:50
2674	2028-04-27	27	4	April    	2	2028	2025-11-03 20:25:50
2675	2028-04-28	28	4	April    	2	2028	2025-11-03 20:25:50
2676	2028-04-29	29	4	April    	2	2028	2025-11-03 20:25:50
2677	2028-04-30	30	4	April    	2	2028	2025-11-03 20:25:50
2678	2028-05-01	1	5	May      	2	2028	2025-11-03 20:25:50
2679	2028-05-02	2	5	May      	2	2028	2025-11-03 20:25:50
2680	2028-05-03	3	5	May      	2	2028	2025-11-03 20:25:50
2681	2028-05-04	4	5	May      	2	2028	2025-11-03 20:25:50
2682	2028-05-05	5	5	May      	2	2028	2025-11-03 20:25:50
2683	2028-05-06	6	5	May      	2	2028	2025-11-03 20:25:50
2684	2028-05-07	7	5	May      	2	2028	2025-11-03 20:25:50
2685	2028-05-08	8	5	May      	2	2028	2025-11-03 20:25:50
2686	2028-05-09	9	5	May      	2	2028	2025-11-03 20:25:50
2687	2028-05-10	10	5	May      	2	2028	2025-11-03 20:25:50
2688	2028-05-11	11	5	May      	2	2028	2025-11-03 20:25:50
2689	2028-05-12	12	5	May      	2	2028	2025-11-03 20:25:50
2690	2028-05-13	13	5	May      	2	2028	2025-11-03 20:25:50
2691	2028-05-14	14	5	May      	2	2028	2025-11-03 20:25:50
2692	2028-05-15	15	5	May      	2	2028	2025-11-03 20:25:50
2693	2028-05-16	16	5	May      	2	2028	2025-11-03 20:25:50
2694	2028-05-17	17	5	May      	2	2028	2025-11-03 20:25:50
2695	2028-05-18	18	5	May      	2	2028	2025-11-03 20:25:50
2696	2028-05-19	19	5	May      	2	2028	2025-11-03 20:25:50
2697	2028-05-20	20	5	May      	2	2028	2025-11-03 20:25:50
2698	2028-05-21	21	5	May      	2	2028	2025-11-03 20:25:50
2699	2028-05-22	22	5	May      	2	2028	2025-11-03 20:25:50
2700	2028-05-23	23	5	May      	2	2028	2025-11-03 20:25:50
2701	2028-05-24	24	5	May      	2	2028	2025-11-03 20:25:50
2702	2028-05-25	25	5	May      	2	2028	2025-11-03 20:25:50
2703	2028-05-26	26	5	May      	2	2028	2025-11-03 20:25:50
2704	2028-05-27	27	5	May      	2	2028	2025-11-03 20:25:50
2705	2028-05-28	28	5	May      	2	2028	2025-11-03 20:25:50
2706	2028-05-29	29	5	May      	2	2028	2025-11-03 20:25:50
2707	2028-05-30	30	5	May      	2	2028	2025-11-03 20:25:50
2708	2028-05-31	31	5	May      	2	2028	2025-11-03 20:25:50
2709	2028-06-01	1	6	June     	2	2028	2025-11-03 20:25:50
2710	2028-06-02	2	6	June     	2	2028	2025-11-03 20:25:50
2711	2028-06-03	3	6	June     	2	2028	2025-11-03 20:25:50
2712	2028-06-04	4	6	June     	2	2028	2025-11-03 20:25:50
2713	2028-06-05	5	6	June     	2	2028	2025-11-03 20:25:50
2714	2028-06-06	6	6	June     	2	2028	2025-11-03 20:25:50
2715	2028-06-07	7	6	June     	2	2028	2025-11-03 20:25:50
2716	2028-06-08	8	6	June     	2	2028	2025-11-03 20:25:50
2717	2028-06-09	9	6	June     	2	2028	2025-11-03 20:25:50
2718	2028-06-10	10	6	June     	2	2028	2025-11-03 20:25:50
2719	2028-06-11	11	6	June     	2	2028	2025-11-03 20:25:50
2720	2028-06-12	12	6	June     	2	2028	2025-11-03 20:25:50
2721	2028-06-13	13	6	June     	2	2028	2025-11-03 20:25:50
2722	2028-06-14	14	6	June     	2	2028	2025-11-03 20:25:50
2723	2028-06-15	15	6	June     	2	2028	2025-11-03 20:25:50
2724	2028-06-16	16	6	June     	2	2028	2025-11-03 20:25:50
2725	2028-06-17	17	6	June     	2	2028	2025-11-03 20:25:50
2726	2028-06-18	18	6	June     	2	2028	2025-11-03 20:25:50
2727	2028-06-19	19	6	June     	2	2028	2025-11-03 20:25:50
2728	2028-06-20	20	6	June     	2	2028	2025-11-03 20:25:50
2729	2028-06-21	21	6	June     	2	2028	2025-11-03 20:25:50
2730	2028-06-22	22	6	June     	2	2028	2025-11-03 20:25:50
2731	2028-06-23	23	6	June     	2	2028	2025-11-03 20:25:50
2732	2028-06-24	24	6	June     	2	2028	2025-11-03 20:25:50
2733	2028-06-25	25	6	June     	2	2028	2025-11-03 20:25:50
2734	2028-06-26	26	6	June     	2	2028	2025-11-03 20:25:50
2735	2028-06-27	27	6	June     	2	2028	2025-11-03 20:25:50
2736	2028-06-28	28	6	June     	2	2028	2025-11-03 20:25:50
2737	2028-06-29	29	6	June     	2	2028	2025-11-03 20:25:50
2738	2028-06-30	30	6	June     	2	2028	2025-11-03 20:25:50
2739	2028-07-01	1	7	July     	3	2028	2025-11-03 20:25:50
2740	2028-07-02	2	7	July     	3	2028	2025-11-03 20:25:50
2741	2028-07-03	3	7	July     	3	2028	2025-11-03 20:25:50
2742	2028-07-04	4	7	July     	3	2028	2025-11-03 20:25:50
2743	2028-07-05	5	7	July     	3	2028	2025-11-03 20:25:50
2744	2028-07-06	6	7	July     	3	2028	2025-11-03 20:25:50
2745	2028-07-07	7	7	July     	3	2028	2025-11-03 20:25:50
2746	2028-07-08	8	7	July     	3	2028	2025-11-03 20:25:50
2747	2028-07-09	9	7	July     	3	2028	2025-11-03 20:25:50
2748	2028-07-10	10	7	July     	3	2028	2025-11-03 20:25:50
2749	2028-07-11	11	7	July     	3	2028	2025-11-03 20:25:50
2750	2028-07-12	12	7	July     	3	2028	2025-11-03 20:25:50
2751	2028-07-13	13	7	July     	3	2028	2025-11-03 20:25:50
2752	2028-07-14	14	7	July     	3	2028	2025-11-03 20:25:50
2753	2028-07-15	15	7	July     	3	2028	2025-11-03 20:25:50
2754	2028-07-16	16	7	July     	3	2028	2025-11-03 20:25:50
2755	2028-07-17	17	7	July     	3	2028	2025-11-03 20:25:50
2756	2028-07-18	18	7	July     	3	2028	2025-11-03 20:25:50
2757	2028-07-19	19	7	July     	3	2028	2025-11-03 20:25:50
2758	2028-07-20	20	7	July     	3	2028	2025-11-03 20:25:50
2759	2028-07-21	21	7	July     	3	2028	2025-11-03 20:25:50
2760	2028-07-22	22	7	July     	3	2028	2025-11-03 20:25:50
2761	2028-07-23	23	7	July     	3	2028	2025-11-03 20:25:50
2762	2028-07-24	24	7	July     	3	2028	2025-11-03 20:25:50
2763	2028-07-25	25	7	July     	3	2028	2025-11-03 20:25:50
2764	2028-07-26	26	7	July     	3	2028	2025-11-03 20:25:50
2765	2028-07-27	27	7	July     	3	2028	2025-11-03 20:25:50
2766	2028-07-28	28	7	July     	3	2028	2025-11-03 20:25:50
2767	2028-07-29	29	7	July     	3	2028	2025-11-03 20:25:50
2768	2028-07-30	30	7	July     	3	2028	2025-11-03 20:25:50
2769	2028-07-31	31	7	July     	3	2028	2025-11-03 20:25:50
2770	2028-08-01	1	8	August   	3	2028	2025-11-03 20:25:50
2771	2028-08-02	2	8	August   	3	2028	2025-11-03 20:25:50
2772	2028-08-03	3	8	August   	3	2028	2025-11-03 20:25:50
2773	2028-08-04	4	8	August   	3	2028	2025-11-03 20:25:50
2774	2028-08-05	5	8	August   	3	2028	2025-11-03 20:25:50
2775	2028-08-06	6	8	August   	3	2028	2025-11-03 20:25:50
2776	2028-08-07	7	8	August   	3	2028	2025-11-03 20:25:50
2777	2028-08-08	8	8	August   	3	2028	2025-11-03 20:25:50
2778	2028-08-09	9	8	August   	3	2028	2025-11-03 20:25:50
2779	2028-08-10	10	8	August   	3	2028	2025-11-03 20:25:50
2780	2028-08-11	11	8	August   	3	2028	2025-11-03 20:25:50
2781	2028-08-12	12	8	August   	3	2028	2025-11-03 20:25:50
2782	2028-08-13	13	8	August   	3	2028	2025-11-03 20:25:50
2783	2028-08-14	14	8	August   	3	2028	2025-11-03 20:25:50
2784	2028-08-15	15	8	August   	3	2028	2025-11-03 20:25:50
2785	2028-08-16	16	8	August   	3	2028	2025-11-03 20:25:50
2786	2028-08-17	17	8	August   	3	2028	2025-11-03 20:25:50
2787	2028-08-18	18	8	August   	3	2028	2025-11-03 20:25:50
2788	2028-08-19	19	8	August   	3	2028	2025-11-03 20:25:50
2789	2028-08-20	20	8	August   	3	2028	2025-11-03 20:25:50
2790	2028-08-21	21	8	August   	3	2028	2025-11-03 20:25:50
2791	2028-08-22	22	8	August   	3	2028	2025-11-03 20:25:50
2792	2028-08-23	23	8	August   	3	2028	2025-11-03 20:25:50
2793	2028-08-24	24	8	August   	3	2028	2025-11-03 20:25:50
2794	2028-08-25	25	8	August   	3	2028	2025-11-03 20:25:50
2795	2028-08-26	26	8	August   	3	2028	2025-11-03 20:25:50
2796	2028-08-27	27	8	August   	3	2028	2025-11-03 20:25:50
2797	2028-08-28	28	8	August   	3	2028	2025-11-03 20:25:50
2798	2028-08-29	29	8	August   	3	2028	2025-11-03 20:25:50
2799	2028-08-30	30	8	August   	3	2028	2025-11-03 20:25:50
2800	2028-08-31	31	8	August   	3	2028	2025-11-03 20:25:50
2801	2028-09-01	1	9	September	3	2028	2025-11-03 20:25:50
2802	2028-09-02	2	9	September	3	2028	2025-11-03 20:25:50
2803	2028-09-03	3	9	September	3	2028	2025-11-03 20:25:50
2804	2028-09-04	4	9	September	3	2028	2025-11-03 20:25:50
2805	2028-09-05	5	9	September	3	2028	2025-11-03 20:25:50
2806	2028-09-06	6	9	September	3	2028	2025-11-03 20:25:50
2807	2028-09-07	7	9	September	3	2028	2025-11-03 20:25:50
2808	2028-09-08	8	9	September	3	2028	2025-11-03 20:25:50
2809	2028-09-09	9	9	September	3	2028	2025-11-03 20:25:50
2810	2028-09-10	10	9	September	3	2028	2025-11-03 20:25:50
2811	2028-09-11	11	9	September	3	2028	2025-11-03 20:25:50
2812	2028-09-12	12	9	September	3	2028	2025-11-03 20:25:50
2813	2028-09-13	13	9	September	3	2028	2025-11-03 20:25:50
2814	2028-09-14	14	9	September	3	2028	2025-11-03 20:25:50
2815	2028-09-15	15	9	September	3	2028	2025-11-03 20:25:50
2816	2028-09-16	16	9	September	3	2028	2025-11-03 20:25:50
2817	2028-09-17	17	9	September	3	2028	2025-11-03 20:25:50
2818	2028-09-18	18	9	September	3	2028	2025-11-03 20:25:50
2819	2028-09-19	19	9	September	3	2028	2025-11-03 20:25:50
2820	2028-09-20	20	9	September	3	2028	2025-11-03 20:25:50
2821	2028-09-21	21	9	September	3	2028	2025-11-03 20:25:50
2822	2028-09-22	22	9	September	3	2028	2025-11-03 20:25:50
2823	2028-09-23	23	9	September	3	2028	2025-11-03 20:25:50
2824	2028-09-24	24	9	September	3	2028	2025-11-03 20:25:50
2825	2028-09-25	25	9	September	3	2028	2025-11-03 20:25:50
2826	2028-09-26	26	9	September	3	2028	2025-11-03 20:25:50
2827	2028-09-27	27	9	September	3	2028	2025-11-03 20:25:50
2828	2028-09-28	28	9	September	3	2028	2025-11-03 20:25:50
2829	2028-09-29	29	9	September	3	2028	2025-11-03 20:25:50
2830	2028-09-30	30	9	September	3	2028	2025-11-03 20:25:50
2831	2028-10-01	1	10	October  	4	2028	2025-11-03 20:25:50
2832	2028-10-02	2	10	October  	4	2028	2025-11-03 20:25:50
2833	2028-10-03	3	10	October  	4	2028	2025-11-03 20:25:50
2834	2028-10-04	4	10	October  	4	2028	2025-11-03 20:25:50
2835	2028-10-05	5	10	October  	4	2028	2025-11-03 20:25:50
2836	2028-10-06	6	10	October  	4	2028	2025-11-03 20:25:50
2837	2028-10-07	7	10	October  	4	2028	2025-11-03 20:25:50
2838	2028-10-08	8	10	October  	4	2028	2025-11-03 20:25:50
2839	2028-10-09	9	10	October  	4	2028	2025-11-03 20:25:50
2840	2028-10-10	10	10	October  	4	2028	2025-11-03 20:25:50
2841	2028-10-11	11	10	October  	4	2028	2025-11-03 20:25:50
2842	2028-10-12	12	10	October  	4	2028	2025-11-03 20:25:50
2843	2028-10-13	13	10	October  	4	2028	2025-11-03 20:25:50
2844	2028-10-14	14	10	October  	4	2028	2025-11-03 20:25:50
2845	2028-10-15	15	10	October  	4	2028	2025-11-03 20:25:50
2846	2028-10-16	16	10	October  	4	2028	2025-11-03 20:25:50
2847	2028-10-17	17	10	October  	4	2028	2025-11-03 20:25:50
2848	2028-10-18	18	10	October  	4	2028	2025-11-03 20:25:50
2849	2028-10-19	19	10	October  	4	2028	2025-11-03 20:25:50
2850	2028-10-20	20	10	October  	4	2028	2025-11-03 20:25:50
2851	2028-10-21	21	10	October  	4	2028	2025-11-03 20:25:50
2852	2028-10-22	22	10	October  	4	2028	2025-11-03 20:25:50
2853	2028-10-23	23	10	October  	4	2028	2025-11-03 20:25:50
2854	2028-10-24	24	10	October  	4	2028	2025-11-03 20:25:50
2855	2028-10-25	25	10	October  	4	2028	2025-11-03 20:25:50
2856	2028-10-26	26	10	October  	4	2028	2025-11-03 20:25:50
2857	2028-10-27	27	10	October  	4	2028	2025-11-03 20:25:50
2858	2028-10-28	28	10	October  	4	2028	2025-11-03 20:25:50
2859	2028-10-29	29	10	October  	4	2028	2025-11-03 20:25:50
2860	2028-10-30	30	10	October  	4	2028	2025-11-03 20:25:50
2861	2028-10-31	31	10	October  	4	2028	2025-11-03 20:25:50
2862	2028-11-01	1	11	November 	4	2028	2025-11-03 20:25:50
2863	2028-11-02	2	11	November 	4	2028	2025-11-03 20:25:50
2864	2028-11-03	3	11	November 	4	2028	2025-11-03 20:25:50
2865	2028-11-04	4	11	November 	4	2028	2025-11-03 20:25:50
2866	2028-11-05	5	11	November 	4	2028	2025-11-03 20:25:50
2867	2028-11-06	6	11	November 	4	2028	2025-11-03 20:25:50
2868	2028-11-07	7	11	November 	4	2028	2025-11-03 20:25:50
2869	2028-11-08	8	11	November 	4	2028	2025-11-03 20:25:50
2870	2028-11-09	9	11	November 	4	2028	2025-11-03 20:25:50
2871	2028-11-10	10	11	November 	4	2028	2025-11-03 20:25:50
2872	2028-11-11	11	11	November 	4	2028	2025-11-03 20:25:50
2873	2028-11-12	12	11	November 	4	2028	2025-11-03 20:25:50
2874	2028-11-13	13	11	November 	4	2028	2025-11-03 20:25:50
2875	2028-11-14	14	11	November 	4	2028	2025-11-03 20:25:50
2876	2028-11-15	15	11	November 	4	2028	2025-11-03 20:25:50
2877	2028-11-16	16	11	November 	4	2028	2025-11-03 20:25:50
2878	2028-11-17	17	11	November 	4	2028	2025-11-03 20:25:50
2879	2028-11-18	18	11	November 	4	2028	2025-11-03 20:25:50
2880	2028-11-19	19	11	November 	4	2028	2025-11-03 20:25:50
2881	2028-11-20	20	11	November 	4	2028	2025-11-03 20:25:50
2882	2028-11-21	21	11	November 	4	2028	2025-11-03 20:25:50
2883	2028-11-22	22	11	November 	4	2028	2025-11-03 20:25:50
2884	2028-11-23	23	11	November 	4	2028	2025-11-03 20:25:50
2885	2028-11-24	24	11	November 	4	2028	2025-11-03 20:25:50
2886	2028-11-25	25	11	November 	4	2028	2025-11-03 20:25:50
2887	2028-11-26	26	11	November 	4	2028	2025-11-03 20:25:50
2888	2028-11-27	27	11	November 	4	2028	2025-11-03 20:25:50
2889	2028-11-28	28	11	November 	4	2028	2025-11-03 20:25:50
2890	2028-11-29	29	11	November 	4	2028	2025-11-03 20:25:50
2891	2028-11-30	30	11	November 	4	2028	2025-11-03 20:25:50
2892	2028-12-01	1	12	December 	4	2028	2025-11-03 20:25:50
2893	2028-12-02	2	12	December 	4	2028	2025-11-03 20:25:50
2894	2028-12-03	3	12	December 	4	2028	2025-11-03 20:25:50
2895	2028-12-04	4	12	December 	4	2028	2025-11-03 20:25:50
2896	2028-12-05	5	12	December 	4	2028	2025-11-03 20:25:50
2897	2028-12-06	6	12	December 	4	2028	2025-11-03 20:25:50
2898	2028-12-07	7	12	December 	4	2028	2025-11-03 20:25:50
2899	2028-12-08	8	12	December 	4	2028	2025-11-03 20:25:50
2900	2028-12-09	9	12	December 	4	2028	2025-11-03 20:25:50
2901	2028-12-10	10	12	December 	4	2028	2025-11-03 20:25:50
2902	2028-12-11	11	12	December 	4	2028	2025-11-03 20:25:50
2903	2028-12-12	12	12	December 	4	2028	2025-11-03 20:25:50
2904	2028-12-13	13	12	December 	4	2028	2025-11-03 20:25:50
2905	2028-12-14	14	12	December 	4	2028	2025-11-03 20:25:50
2906	2028-12-15	15	12	December 	4	2028	2025-11-03 20:25:50
2907	2028-12-16	16	12	December 	4	2028	2025-11-03 20:25:50
2908	2028-12-17	17	12	December 	4	2028	2025-11-03 20:25:50
2909	2028-12-18	18	12	December 	4	2028	2025-11-03 20:25:50
2910	2028-12-19	19	12	December 	4	2028	2025-11-03 20:25:50
2911	2028-12-20	20	12	December 	4	2028	2025-11-03 20:25:50
2912	2028-12-21	21	12	December 	4	2028	2025-11-03 20:25:50
2913	2028-12-22	22	12	December 	4	2028	2025-11-03 20:25:50
2914	2028-12-23	23	12	December 	4	2028	2025-11-03 20:25:50
2915	2028-12-24	24	12	December 	4	2028	2025-11-03 20:25:50
2916	2028-12-25	25	12	December 	4	2028	2025-11-03 20:25:50
2917	2028-12-26	26	12	December 	4	2028	2025-11-03 20:25:50
2918	2028-12-27	27	12	December 	4	2028	2025-11-03 20:25:50
2919	2028-12-28	28	12	December 	4	2028	2025-11-03 20:25:50
2920	2028-12-29	29	12	December 	4	2028	2025-11-03 20:25:50
2921	2028-12-30	30	12	December 	4	2028	2025-11-03 20:25:50
2922	2028-12-31	31	12	December 	4	2028	2025-11-03 20:25:50
2923	2029-01-01	1	1	January  	1	2029	2025-11-03 20:25:50
2924	2029-01-02	2	1	January  	1	2029	2025-11-03 20:25:50
2925	2029-01-03	3	1	January  	1	2029	2025-11-03 20:25:50
2926	2029-01-04	4	1	January  	1	2029	2025-11-03 20:25:50
2927	2029-01-05	5	1	January  	1	2029	2025-11-03 20:25:50
2928	2029-01-06	6	1	January  	1	2029	2025-11-03 20:25:50
2929	2029-01-07	7	1	January  	1	2029	2025-11-03 20:25:50
2930	2029-01-08	8	1	January  	1	2029	2025-11-03 20:25:50
2931	2029-01-09	9	1	January  	1	2029	2025-11-03 20:25:50
2932	2029-01-10	10	1	January  	1	2029	2025-11-03 20:25:50
2933	2029-01-11	11	1	January  	1	2029	2025-11-03 20:25:50
2934	2029-01-12	12	1	January  	1	2029	2025-11-03 20:25:50
2935	2029-01-13	13	1	January  	1	2029	2025-11-03 20:25:50
2936	2029-01-14	14	1	January  	1	2029	2025-11-03 20:25:50
2937	2029-01-15	15	1	January  	1	2029	2025-11-03 20:25:50
2938	2029-01-16	16	1	January  	1	2029	2025-11-03 20:25:50
2939	2029-01-17	17	1	January  	1	2029	2025-11-03 20:25:50
2940	2029-01-18	18	1	January  	1	2029	2025-11-03 20:25:50
2941	2029-01-19	19	1	January  	1	2029	2025-11-03 20:25:50
2942	2029-01-20	20	1	January  	1	2029	2025-11-03 20:25:50
2943	2029-01-21	21	1	January  	1	2029	2025-11-03 20:25:50
2944	2029-01-22	22	1	January  	1	2029	2025-11-03 20:25:50
2945	2029-01-23	23	1	January  	1	2029	2025-11-03 20:25:50
2946	2029-01-24	24	1	January  	1	2029	2025-11-03 20:25:50
2947	2029-01-25	25	1	January  	1	2029	2025-11-03 20:25:50
2948	2029-01-26	26	1	January  	1	2029	2025-11-03 20:25:50
2949	2029-01-27	27	1	January  	1	2029	2025-11-03 20:25:50
2950	2029-01-28	28	1	January  	1	2029	2025-11-03 20:25:50
2951	2029-01-29	29	1	January  	1	2029	2025-11-03 20:25:50
2952	2029-01-30	30	1	January  	1	2029	2025-11-03 20:25:50
2953	2029-01-31	31	1	January  	1	2029	2025-11-03 20:25:50
2954	2029-02-01	1	2	February 	1	2029	2025-11-03 20:25:50
2955	2029-02-02	2	2	February 	1	2029	2025-11-03 20:25:50
2956	2029-02-03	3	2	February 	1	2029	2025-11-03 20:25:50
2957	2029-02-04	4	2	February 	1	2029	2025-11-03 20:25:50
2958	2029-02-05	5	2	February 	1	2029	2025-11-03 20:25:50
2959	2029-02-06	6	2	February 	1	2029	2025-11-03 20:25:50
2960	2029-02-07	7	2	February 	1	2029	2025-11-03 20:25:50
2961	2029-02-08	8	2	February 	1	2029	2025-11-03 20:25:50
2962	2029-02-09	9	2	February 	1	2029	2025-11-03 20:25:50
2963	2029-02-10	10	2	February 	1	2029	2025-11-03 20:25:50
2964	2029-02-11	11	2	February 	1	2029	2025-11-03 20:25:50
2965	2029-02-12	12	2	February 	1	2029	2025-11-03 20:25:50
2966	2029-02-13	13	2	February 	1	2029	2025-11-03 20:25:50
2967	2029-02-14	14	2	February 	1	2029	2025-11-03 20:25:50
2968	2029-02-15	15	2	February 	1	2029	2025-11-03 20:25:50
2969	2029-02-16	16	2	February 	1	2029	2025-11-03 20:25:50
2970	2029-02-17	17	2	February 	1	2029	2025-11-03 20:25:50
2971	2029-02-18	18	2	February 	1	2029	2025-11-03 20:25:50
2972	2029-02-19	19	2	February 	1	2029	2025-11-03 20:25:50
2973	2029-02-20	20	2	February 	1	2029	2025-11-03 20:25:50
2974	2029-02-21	21	2	February 	1	2029	2025-11-03 20:25:50
2975	2029-02-22	22	2	February 	1	2029	2025-11-03 20:25:50
2976	2029-02-23	23	2	February 	1	2029	2025-11-03 20:25:50
2977	2029-02-24	24	2	February 	1	2029	2025-11-03 20:25:50
2978	2029-02-25	25	2	February 	1	2029	2025-11-03 20:25:50
2979	2029-02-26	26	2	February 	1	2029	2025-11-03 20:25:50
2980	2029-02-27	27	2	February 	1	2029	2025-11-03 20:25:50
2981	2029-02-28	28	2	February 	1	2029	2025-11-03 20:25:50
2982	2029-03-01	1	3	March    	1	2029	2025-11-03 20:25:50
2983	2029-03-02	2	3	March    	1	2029	2025-11-03 20:25:50
2984	2029-03-03	3	3	March    	1	2029	2025-11-03 20:25:50
2985	2029-03-04	4	3	March    	1	2029	2025-11-03 20:25:50
2986	2029-03-05	5	3	March    	1	2029	2025-11-03 20:25:50
2987	2029-03-06	6	3	March    	1	2029	2025-11-03 20:25:50
2988	2029-03-07	7	3	March    	1	2029	2025-11-03 20:25:50
2989	2029-03-08	8	3	March    	1	2029	2025-11-03 20:25:50
2990	2029-03-09	9	3	March    	1	2029	2025-11-03 20:25:50
2991	2029-03-10	10	3	March    	1	2029	2025-11-03 20:25:50
2992	2029-03-11	11	3	March    	1	2029	2025-11-03 20:25:50
2993	2029-03-12	12	3	March    	1	2029	2025-11-03 20:25:50
2994	2029-03-13	13	3	March    	1	2029	2025-11-03 20:25:50
2995	2029-03-14	14	3	March    	1	2029	2025-11-03 20:25:50
2996	2029-03-15	15	3	March    	1	2029	2025-11-03 20:25:50
2997	2029-03-16	16	3	March    	1	2029	2025-11-03 20:25:50
2998	2029-03-17	17	3	March    	1	2029	2025-11-03 20:25:50
2999	2029-03-18	18	3	March    	1	2029	2025-11-03 20:25:50
3000	2029-03-19	19	3	March    	1	2029	2025-11-03 20:25:50
3001	2029-03-20	20	3	March    	1	2029	2025-11-03 20:25:50
3002	2029-03-21	21	3	March    	1	2029	2025-11-03 20:25:50
3003	2029-03-22	22	3	March    	1	2029	2025-11-03 20:25:50
3004	2029-03-23	23	3	March    	1	2029	2025-11-03 20:25:50
3005	2029-03-24	24	3	March    	1	2029	2025-11-03 20:25:50
3006	2029-03-25	25	3	March    	1	2029	2025-11-03 20:25:50
3007	2029-03-26	26	3	March    	1	2029	2025-11-03 20:25:50
3008	2029-03-27	27	3	March    	1	2029	2025-11-03 20:25:50
3009	2029-03-28	28	3	March    	1	2029	2025-11-03 20:25:50
3010	2029-03-29	29	3	March    	1	2029	2025-11-03 20:25:50
3011	2029-03-30	30	3	March    	1	2029	2025-11-03 20:25:50
3012	2029-03-31	31	3	March    	1	2029	2025-11-03 20:25:50
3013	2029-04-01	1	4	April    	2	2029	2025-11-03 20:25:50
3014	2029-04-02	2	4	April    	2	2029	2025-11-03 20:25:50
3015	2029-04-03	3	4	April    	2	2029	2025-11-03 20:25:50
3016	2029-04-04	4	4	April    	2	2029	2025-11-03 20:25:50
3017	2029-04-05	5	4	April    	2	2029	2025-11-03 20:25:50
3018	2029-04-06	6	4	April    	2	2029	2025-11-03 20:25:50
3019	2029-04-07	7	4	April    	2	2029	2025-11-03 20:25:50
3020	2029-04-08	8	4	April    	2	2029	2025-11-03 20:25:50
3021	2029-04-09	9	4	April    	2	2029	2025-11-03 20:25:50
3022	2029-04-10	10	4	April    	2	2029	2025-11-03 20:25:50
3023	2029-04-11	11	4	April    	2	2029	2025-11-03 20:25:50
3024	2029-04-12	12	4	April    	2	2029	2025-11-03 20:25:50
3025	2029-04-13	13	4	April    	2	2029	2025-11-03 20:25:50
3026	2029-04-14	14	4	April    	2	2029	2025-11-03 20:25:50
3027	2029-04-15	15	4	April    	2	2029	2025-11-03 20:25:50
3028	2029-04-16	16	4	April    	2	2029	2025-11-03 20:25:50
3029	2029-04-17	17	4	April    	2	2029	2025-11-03 20:25:50
3030	2029-04-18	18	4	April    	2	2029	2025-11-03 20:25:50
3031	2029-04-19	19	4	April    	2	2029	2025-11-03 20:25:50
3032	2029-04-20	20	4	April    	2	2029	2025-11-03 20:25:50
3033	2029-04-21	21	4	April    	2	2029	2025-11-03 20:25:50
3034	2029-04-22	22	4	April    	2	2029	2025-11-03 20:25:50
3035	2029-04-23	23	4	April    	2	2029	2025-11-03 20:25:50
3036	2029-04-24	24	4	April    	2	2029	2025-11-03 20:25:50
3037	2029-04-25	25	4	April    	2	2029	2025-11-03 20:25:50
3038	2029-04-26	26	4	April    	2	2029	2025-11-03 20:25:50
3039	2029-04-27	27	4	April    	2	2029	2025-11-03 20:25:50
3040	2029-04-28	28	4	April    	2	2029	2025-11-03 20:25:50
3041	2029-04-29	29	4	April    	2	2029	2025-11-03 20:25:50
3042	2029-04-30	30	4	April    	2	2029	2025-11-03 20:25:50
3043	2029-05-01	1	5	May      	2	2029	2025-11-03 20:25:50
3044	2029-05-02	2	5	May      	2	2029	2025-11-03 20:25:50
3045	2029-05-03	3	5	May      	2	2029	2025-11-03 20:25:50
3046	2029-05-04	4	5	May      	2	2029	2025-11-03 20:25:50
3047	2029-05-05	5	5	May      	2	2029	2025-11-03 20:25:50
3048	2029-05-06	6	5	May      	2	2029	2025-11-03 20:25:50
3049	2029-05-07	7	5	May      	2	2029	2025-11-03 20:25:50
3050	2029-05-08	8	5	May      	2	2029	2025-11-03 20:25:50
3051	2029-05-09	9	5	May      	2	2029	2025-11-03 20:25:50
3052	2029-05-10	10	5	May      	2	2029	2025-11-03 20:25:50
3053	2029-05-11	11	5	May      	2	2029	2025-11-03 20:25:50
3054	2029-05-12	12	5	May      	2	2029	2025-11-03 20:25:50
3055	2029-05-13	13	5	May      	2	2029	2025-11-03 20:25:50
3056	2029-05-14	14	5	May      	2	2029	2025-11-03 20:25:50
3057	2029-05-15	15	5	May      	2	2029	2025-11-03 20:25:50
3058	2029-05-16	16	5	May      	2	2029	2025-11-03 20:25:50
3059	2029-05-17	17	5	May      	2	2029	2025-11-03 20:25:50
3060	2029-05-18	18	5	May      	2	2029	2025-11-03 20:25:50
3061	2029-05-19	19	5	May      	2	2029	2025-11-03 20:25:50
3062	2029-05-20	20	5	May      	2	2029	2025-11-03 20:25:50
3063	2029-05-21	21	5	May      	2	2029	2025-11-03 20:25:50
3064	2029-05-22	22	5	May      	2	2029	2025-11-03 20:25:50
3065	2029-05-23	23	5	May      	2	2029	2025-11-03 20:25:50
3066	2029-05-24	24	5	May      	2	2029	2025-11-03 20:25:50
3067	2029-05-25	25	5	May      	2	2029	2025-11-03 20:25:50
3068	2029-05-26	26	5	May      	2	2029	2025-11-03 20:25:50
3069	2029-05-27	27	5	May      	2	2029	2025-11-03 20:25:50
3070	2029-05-28	28	5	May      	2	2029	2025-11-03 20:25:50
3071	2029-05-29	29	5	May      	2	2029	2025-11-03 20:25:50
3072	2029-05-30	30	5	May      	2	2029	2025-11-03 20:25:50
3073	2029-05-31	31	5	May      	2	2029	2025-11-03 20:25:50
3074	2029-06-01	1	6	June     	2	2029	2025-11-03 20:25:50
3075	2029-06-02	2	6	June     	2	2029	2025-11-03 20:25:50
3076	2029-06-03	3	6	June     	2	2029	2025-11-03 20:25:50
3077	2029-06-04	4	6	June     	2	2029	2025-11-03 20:25:50
3078	2029-06-05	5	6	June     	2	2029	2025-11-03 20:25:50
3079	2029-06-06	6	6	June     	2	2029	2025-11-03 20:25:50
3080	2029-06-07	7	6	June     	2	2029	2025-11-03 20:25:50
3081	2029-06-08	8	6	June     	2	2029	2025-11-03 20:25:50
3082	2029-06-09	9	6	June     	2	2029	2025-11-03 20:25:50
3083	2029-06-10	10	6	June     	2	2029	2025-11-03 20:25:50
3084	2029-06-11	11	6	June     	2	2029	2025-11-03 20:25:50
3085	2029-06-12	12	6	June     	2	2029	2025-11-03 20:25:50
3086	2029-06-13	13	6	June     	2	2029	2025-11-03 20:25:50
3087	2029-06-14	14	6	June     	2	2029	2025-11-03 20:25:50
3088	2029-06-15	15	6	June     	2	2029	2025-11-03 20:25:50
3089	2029-06-16	16	6	June     	2	2029	2025-11-03 20:25:50
3090	2029-06-17	17	6	June     	2	2029	2025-11-03 20:25:50
3091	2029-06-18	18	6	June     	2	2029	2025-11-03 20:25:50
3092	2029-06-19	19	6	June     	2	2029	2025-11-03 20:25:50
3093	2029-06-20	20	6	June     	2	2029	2025-11-03 20:25:50
3094	2029-06-21	21	6	June     	2	2029	2025-11-03 20:25:50
3095	2029-06-22	22	6	June     	2	2029	2025-11-03 20:25:50
3096	2029-06-23	23	6	June     	2	2029	2025-11-03 20:25:50
3097	2029-06-24	24	6	June     	2	2029	2025-11-03 20:25:50
3098	2029-06-25	25	6	June     	2	2029	2025-11-03 20:25:50
3099	2029-06-26	26	6	June     	2	2029	2025-11-03 20:25:50
3100	2029-06-27	27	6	June     	2	2029	2025-11-03 20:25:50
3101	2029-06-28	28	6	June     	2	2029	2025-11-03 20:25:50
3102	2029-06-29	29	6	June     	2	2029	2025-11-03 20:25:50
3103	2029-06-30	30	6	June     	2	2029	2025-11-03 20:25:50
3104	2029-07-01	1	7	July     	3	2029	2025-11-03 20:25:50
3105	2029-07-02	2	7	July     	3	2029	2025-11-03 20:25:50
3106	2029-07-03	3	7	July     	3	2029	2025-11-03 20:25:50
3107	2029-07-04	4	7	July     	3	2029	2025-11-03 20:25:50
3108	2029-07-05	5	7	July     	3	2029	2025-11-03 20:25:50
3109	2029-07-06	6	7	July     	3	2029	2025-11-03 20:25:50
3110	2029-07-07	7	7	July     	3	2029	2025-11-03 20:25:50
3111	2029-07-08	8	7	July     	3	2029	2025-11-03 20:25:50
3112	2029-07-09	9	7	July     	3	2029	2025-11-03 20:25:50
3113	2029-07-10	10	7	July     	3	2029	2025-11-03 20:25:50
3114	2029-07-11	11	7	July     	3	2029	2025-11-03 20:25:50
3115	2029-07-12	12	7	July     	3	2029	2025-11-03 20:25:50
3116	2029-07-13	13	7	July     	3	2029	2025-11-03 20:25:50
3117	2029-07-14	14	7	July     	3	2029	2025-11-03 20:25:50
3118	2029-07-15	15	7	July     	3	2029	2025-11-03 20:25:50
3119	2029-07-16	16	7	July     	3	2029	2025-11-03 20:25:50
3120	2029-07-17	17	7	July     	3	2029	2025-11-03 20:25:50
3121	2029-07-18	18	7	July     	3	2029	2025-11-03 20:25:50
3122	2029-07-19	19	7	July     	3	2029	2025-11-03 20:25:50
3123	2029-07-20	20	7	July     	3	2029	2025-11-03 20:25:50
3124	2029-07-21	21	7	July     	3	2029	2025-11-03 20:25:50
3125	2029-07-22	22	7	July     	3	2029	2025-11-03 20:25:50
3126	2029-07-23	23	7	July     	3	2029	2025-11-03 20:25:50
3127	2029-07-24	24	7	July     	3	2029	2025-11-03 20:25:50
3128	2029-07-25	25	7	July     	3	2029	2025-11-03 20:25:50
3129	2029-07-26	26	7	July     	3	2029	2025-11-03 20:25:50
3130	2029-07-27	27	7	July     	3	2029	2025-11-03 20:25:50
3131	2029-07-28	28	7	July     	3	2029	2025-11-03 20:25:50
3132	2029-07-29	29	7	July     	3	2029	2025-11-03 20:25:50
3133	2029-07-30	30	7	July     	3	2029	2025-11-03 20:25:50
3134	2029-07-31	31	7	July     	3	2029	2025-11-03 20:25:50
3135	2029-08-01	1	8	August   	3	2029	2025-11-03 20:25:50
3136	2029-08-02	2	8	August   	3	2029	2025-11-03 20:25:50
3137	2029-08-03	3	8	August   	3	2029	2025-11-03 20:25:50
3138	2029-08-04	4	8	August   	3	2029	2025-11-03 20:25:50
3139	2029-08-05	5	8	August   	3	2029	2025-11-03 20:25:50
3140	2029-08-06	6	8	August   	3	2029	2025-11-03 20:25:50
3141	2029-08-07	7	8	August   	3	2029	2025-11-03 20:25:50
3142	2029-08-08	8	8	August   	3	2029	2025-11-03 20:25:50
3143	2029-08-09	9	8	August   	3	2029	2025-11-03 20:25:50
3144	2029-08-10	10	8	August   	3	2029	2025-11-03 20:25:50
3145	2029-08-11	11	8	August   	3	2029	2025-11-03 20:25:50
3146	2029-08-12	12	8	August   	3	2029	2025-11-03 20:25:50
3147	2029-08-13	13	8	August   	3	2029	2025-11-03 20:25:50
3148	2029-08-14	14	8	August   	3	2029	2025-11-03 20:25:50
3149	2029-08-15	15	8	August   	3	2029	2025-11-03 20:25:50
3150	2029-08-16	16	8	August   	3	2029	2025-11-03 20:25:50
3151	2029-08-17	17	8	August   	3	2029	2025-11-03 20:25:50
3152	2029-08-18	18	8	August   	3	2029	2025-11-03 20:25:50
3153	2029-08-19	19	8	August   	3	2029	2025-11-03 20:25:50
3154	2029-08-20	20	8	August   	3	2029	2025-11-03 20:25:50
3155	2029-08-21	21	8	August   	3	2029	2025-11-03 20:25:50
3156	2029-08-22	22	8	August   	3	2029	2025-11-03 20:25:50
3157	2029-08-23	23	8	August   	3	2029	2025-11-03 20:25:50
3158	2029-08-24	24	8	August   	3	2029	2025-11-03 20:25:50
3159	2029-08-25	25	8	August   	3	2029	2025-11-03 20:25:50
3160	2029-08-26	26	8	August   	3	2029	2025-11-03 20:25:50
3161	2029-08-27	27	8	August   	3	2029	2025-11-03 20:25:50
3162	2029-08-28	28	8	August   	3	2029	2025-11-03 20:25:50
3163	2029-08-29	29	8	August   	3	2029	2025-11-03 20:25:50
3164	2029-08-30	30	8	August   	3	2029	2025-11-03 20:25:50
3165	2029-08-31	31	8	August   	3	2029	2025-11-03 20:25:50
3166	2029-09-01	1	9	September	3	2029	2025-11-03 20:25:50
3167	2029-09-02	2	9	September	3	2029	2025-11-03 20:25:50
3168	2029-09-03	3	9	September	3	2029	2025-11-03 20:25:50
3169	2029-09-04	4	9	September	3	2029	2025-11-03 20:25:50
3170	2029-09-05	5	9	September	3	2029	2025-11-03 20:25:50
3171	2029-09-06	6	9	September	3	2029	2025-11-03 20:25:50
3172	2029-09-07	7	9	September	3	2029	2025-11-03 20:25:50
3173	2029-09-08	8	9	September	3	2029	2025-11-03 20:25:50
3174	2029-09-09	9	9	September	3	2029	2025-11-03 20:25:50
3175	2029-09-10	10	9	September	3	2029	2025-11-03 20:25:50
3176	2029-09-11	11	9	September	3	2029	2025-11-03 20:25:50
3177	2029-09-12	12	9	September	3	2029	2025-11-03 20:25:50
3178	2029-09-13	13	9	September	3	2029	2025-11-03 20:25:50
3179	2029-09-14	14	9	September	3	2029	2025-11-03 20:25:50
3180	2029-09-15	15	9	September	3	2029	2025-11-03 20:25:50
3181	2029-09-16	16	9	September	3	2029	2025-11-03 20:25:50
3182	2029-09-17	17	9	September	3	2029	2025-11-03 20:25:50
3183	2029-09-18	18	9	September	3	2029	2025-11-03 20:25:50
3184	2029-09-19	19	9	September	3	2029	2025-11-03 20:25:50
3185	2029-09-20	20	9	September	3	2029	2025-11-03 20:25:50
3186	2029-09-21	21	9	September	3	2029	2025-11-03 20:25:50
3187	2029-09-22	22	9	September	3	2029	2025-11-03 20:25:50
3188	2029-09-23	23	9	September	3	2029	2025-11-03 20:25:50
3189	2029-09-24	24	9	September	3	2029	2025-11-03 20:25:50
3190	2029-09-25	25	9	September	3	2029	2025-11-03 20:25:50
3191	2029-09-26	26	9	September	3	2029	2025-11-03 20:25:50
3192	2029-09-27	27	9	September	3	2029	2025-11-03 20:25:50
3193	2029-09-28	28	9	September	3	2029	2025-11-03 20:25:50
3194	2029-09-29	29	9	September	3	2029	2025-11-03 20:25:50
3195	2029-09-30	30	9	September	3	2029	2025-11-03 20:25:50
3196	2029-10-01	1	10	October  	4	2029	2025-11-03 20:25:50
3197	2029-10-02	2	10	October  	4	2029	2025-11-03 20:25:50
3198	2029-10-03	3	10	October  	4	2029	2025-11-03 20:25:50
3199	2029-10-04	4	10	October  	4	2029	2025-11-03 20:25:50
3200	2029-10-05	5	10	October  	4	2029	2025-11-03 20:25:50
3201	2029-10-06	6	10	October  	4	2029	2025-11-03 20:25:50
3202	2029-10-07	7	10	October  	4	2029	2025-11-03 20:25:50
3203	2029-10-08	8	10	October  	4	2029	2025-11-03 20:25:50
3204	2029-10-09	9	10	October  	4	2029	2025-11-03 20:25:50
3205	2029-10-10	10	10	October  	4	2029	2025-11-03 20:25:50
3206	2029-10-11	11	10	October  	4	2029	2025-11-03 20:25:50
3207	2029-10-12	12	10	October  	4	2029	2025-11-03 20:25:50
3208	2029-10-13	13	10	October  	4	2029	2025-11-03 20:25:50
3209	2029-10-14	14	10	October  	4	2029	2025-11-03 20:25:50
3210	2029-10-15	15	10	October  	4	2029	2025-11-03 20:25:50
3211	2029-10-16	16	10	October  	4	2029	2025-11-03 20:25:50
3212	2029-10-17	17	10	October  	4	2029	2025-11-03 20:25:50
3213	2029-10-18	18	10	October  	4	2029	2025-11-03 20:25:50
3214	2029-10-19	19	10	October  	4	2029	2025-11-03 20:25:50
3215	2029-10-20	20	10	October  	4	2029	2025-11-03 20:25:50
3216	2029-10-21	21	10	October  	4	2029	2025-11-03 20:25:50
3217	2029-10-22	22	10	October  	4	2029	2025-11-03 20:25:50
3218	2029-10-23	23	10	October  	4	2029	2025-11-03 20:25:50
3219	2029-10-24	24	10	October  	4	2029	2025-11-03 20:25:50
3220	2029-10-25	25	10	October  	4	2029	2025-11-03 20:25:50
3221	2029-10-26	26	10	October  	4	2029	2025-11-03 20:25:50
3222	2029-10-27	27	10	October  	4	2029	2025-11-03 20:25:50
3223	2029-10-28	28	10	October  	4	2029	2025-11-03 20:25:50
3224	2029-10-29	29	10	October  	4	2029	2025-11-03 20:25:50
3225	2029-10-30	30	10	October  	4	2029	2025-11-03 20:25:50
3226	2029-10-31	31	10	October  	4	2029	2025-11-03 20:25:50
3227	2029-11-01	1	11	November 	4	2029	2025-11-03 20:25:50
3228	2029-11-02	2	11	November 	4	2029	2025-11-03 20:25:50
3229	2029-11-03	3	11	November 	4	2029	2025-11-03 20:25:50
3230	2029-11-04	4	11	November 	4	2029	2025-11-03 20:25:50
3231	2029-11-05	5	11	November 	4	2029	2025-11-03 20:25:50
3232	2029-11-06	6	11	November 	4	2029	2025-11-03 20:25:50
3233	2029-11-07	7	11	November 	4	2029	2025-11-03 20:25:50
3234	2029-11-08	8	11	November 	4	2029	2025-11-03 20:25:50
3235	2029-11-09	9	11	November 	4	2029	2025-11-03 20:25:50
3236	2029-11-10	10	11	November 	4	2029	2025-11-03 20:25:50
3237	2029-11-11	11	11	November 	4	2029	2025-11-03 20:25:50
3238	2029-11-12	12	11	November 	4	2029	2025-11-03 20:25:50
3239	2029-11-13	13	11	November 	4	2029	2025-11-03 20:25:50
3240	2029-11-14	14	11	November 	4	2029	2025-11-03 20:25:50
3241	2029-11-15	15	11	November 	4	2029	2025-11-03 20:25:50
3242	2029-11-16	16	11	November 	4	2029	2025-11-03 20:25:50
3243	2029-11-17	17	11	November 	4	2029	2025-11-03 20:25:50
3244	2029-11-18	18	11	November 	4	2029	2025-11-03 20:25:50
3245	2029-11-19	19	11	November 	4	2029	2025-11-03 20:25:50
3246	2029-11-20	20	11	November 	4	2029	2025-11-03 20:25:50
3247	2029-11-21	21	11	November 	4	2029	2025-11-03 20:25:50
3248	2029-11-22	22	11	November 	4	2029	2025-11-03 20:25:50
3249	2029-11-23	23	11	November 	4	2029	2025-11-03 20:25:50
3250	2029-11-24	24	11	November 	4	2029	2025-11-03 20:25:50
3251	2029-11-25	25	11	November 	4	2029	2025-11-03 20:25:50
3252	2029-11-26	26	11	November 	4	2029	2025-11-03 20:25:50
3253	2029-11-27	27	11	November 	4	2029	2025-11-03 20:25:50
3254	2029-11-28	28	11	November 	4	2029	2025-11-03 20:25:50
3255	2029-11-29	29	11	November 	4	2029	2025-11-03 20:25:50
3256	2029-11-30	30	11	November 	4	2029	2025-11-03 20:25:50
3257	2029-12-01	1	12	December 	4	2029	2025-11-03 20:25:50
3258	2029-12-02	2	12	December 	4	2029	2025-11-03 20:25:50
3259	2029-12-03	3	12	December 	4	2029	2025-11-03 20:25:50
3260	2029-12-04	4	12	December 	4	2029	2025-11-03 20:25:50
3261	2029-12-05	5	12	December 	4	2029	2025-11-03 20:25:50
3262	2029-12-06	6	12	December 	4	2029	2025-11-03 20:25:50
3263	2029-12-07	7	12	December 	4	2029	2025-11-03 20:25:50
3264	2029-12-08	8	12	December 	4	2029	2025-11-03 20:25:50
3265	2029-12-09	9	12	December 	4	2029	2025-11-03 20:25:50
3266	2029-12-10	10	12	December 	4	2029	2025-11-03 20:25:50
3267	2029-12-11	11	12	December 	4	2029	2025-11-03 20:25:50
3268	2029-12-12	12	12	December 	4	2029	2025-11-03 20:25:50
3269	2029-12-13	13	12	December 	4	2029	2025-11-03 20:25:50
3270	2029-12-14	14	12	December 	4	2029	2025-11-03 20:25:50
3271	2029-12-15	15	12	December 	4	2029	2025-11-03 20:25:50
3272	2029-12-16	16	12	December 	4	2029	2025-11-03 20:25:50
3273	2029-12-17	17	12	December 	4	2029	2025-11-03 20:25:50
3274	2029-12-18	18	12	December 	4	2029	2025-11-03 20:25:50
3275	2029-12-19	19	12	December 	4	2029	2025-11-03 20:25:50
3276	2029-12-20	20	12	December 	4	2029	2025-11-03 20:25:50
3277	2029-12-21	21	12	December 	4	2029	2025-11-03 20:25:50
3278	2029-12-22	22	12	December 	4	2029	2025-11-03 20:25:50
3279	2029-12-23	23	12	December 	4	2029	2025-11-03 20:25:50
3280	2029-12-24	24	12	December 	4	2029	2025-11-03 20:25:50
3281	2029-12-25	25	12	December 	4	2029	2025-11-03 20:25:50
3282	2029-12-26	26	12	December 	4	2029	2025-11-03 20:25:50
3283	2029-12-27	27	12	December 	4	2029	2025-11-03 20:25:50
3284	2029-12-28	28	12	December 	4	2029	2025-11-03 20:25:50
3285	2029-12-29	29	12	December 	4	2029	2025-11-03 20:25:50
3286	2029-12-30	30	12	December 	4	2029	2025-11-03 20:25:50
3287	2029-12-31	31	12	December 	4	2029	2025-11-03 20:25:50
3288	2030-01-01	1	1	January  	1	2030	2025-11-03 20:25:50
3289	2030-01-02	2	1	January  	1	2030	2025-11-03 20:25:50
3290	2030-01-03	3	1	January  	1	2030	2025-11-03 20:25:50
3291	2030-01-04	4	1	January  	1	2030	2025-11-03 20:25:50
3292	2030-01-05	5	1	January  	1	2030	2025-11-03 20:25:50
3293	2030-01-06	6	1	January  	1	2030	2025-11-03 20:25:50
3294	2030-01-07	7	1	January  	1	2030	2025-11-03 20:25:50
3295	2030-01-08	8	1	January  	1	2030	2025-11-03 20:25:50
3296	2030-01-09	9	1	January  	1	2030	2025-11-03 20:25:50
3297	2030-01-10	10	1	January  	1	2030	2025-11-03 20:25:50
3298	2030-01-11	11	1	January  	1	2030	2025-11-03 20:25:50
3299	2030-01-12	12	1	January  	1	2030	2025-11-03 20:25:50
3300	2030-01-13	13	1	January  	1	2030	2025-11-03 20:25:50
3301	2030-01-14	14	1	January  	1	2030	2025-11-03 20:25:50
3302	2030-01-15	15	1	January  	1	2030	2025-11-03 20:25:50
3303	2030-01-16	16	1	January  	1	2030	2025-11-03 20:25:50
3304	2030-01-17	17	1	January  	1	2030	2025-11-03 20:25:50
3305	2030-01-18	18	1	January  	1	2030	2025-11-03 20:25:50
3306	2030-01-19	19	1	January  	1	2030	2025-11-03 20:25:50
3307	2030-01-20	20	1	January  	1	2030	2025-11-03 20:25:50
3308	2030-01-21	21	1	January  	1	2030	2025-11-03 20:25:50
3309	2030-01-22	22	1	January  	1	2030	2025-11-03 20:25:50
3310	2030-01-23	23	1	January  	1	2030	2025-11-03 20:25:50
3311	2030-01-24	24	1	January  	1	2030	2025-11-03 20:25:50
3312	2030-01-25	25	1	January  	1	2030	2025-11-03 20:25:50
3313	2030-01-26	26	1	January  	1	2030	2025-11-03 20:25:50
3314	2030-01-27	27	1	January  	1	2030	2025-11-03 20:25:50
3315	2030-01-28	28	1	January  	1	2030	2025-11-03 20:25:50
3316	2030-01-29	29	1	January  	1	2030	2025-11-03 20:25:50
3317	2030-01-30	30	1	January  	1	2030	2025-11-03 20:25:50
3318	2030-01-31	31	1	January  	1	2030	2025-11-03 20:25:50
3319	2030-02-01	1	2	February 	1	2030	2025-11-03 20:25:50
3320	2030-02-02	2	2	February 	1	2030	2025-11-03 20:25:50
3321	2030-02-03	3	2	February 	1	2030	2025-11-03 20:25:50
3322	2030-02-04	4	2	February 	1	2030	2025-11-03 20:25:50
3323	2030-02-05	5	2	February 	1	2030	2025-11-03 20:25:50
3324	2030-02-06	6	2	February 	1	2030	2025-11-03 20:25:50
3325	2030-02-07	7	2	February 	1	2030	2025-11-03 20:25:50
3326	2030-02-08	8	2	February 	1	2030	2025-11-03 20:25:50
3327	2030-02-09	9	2	February 	1	2030	2025-11-03 20:25:50
3328	2030-02-10	10	2	February 	1	2030	2025-11-03 20:25:50
3329	2030-02-11	11	2	February 	1	2030	2025-11-03 20:25:50
3330	2030-02-12	12	2	February 	1	2030	2025-11-03 20:25:50
3331	2030-02-13	13	2	February 	1	2030	2025-11-03 20:25:50
3332	2030-02-14	14	2	February 	1	2030	2025-11-03 20:25:50
3333	2030-02-15	15	2	February 	1	2030	2025-11-03 20:25:50
3334	2030-02-16	16	2	February 	1	2030	2025-11-03 20:25:50
3335	2030-02-17	17	2	February 	1	2030	2025-11-03 20:25:50
3336	2030-02-18	18	2	February 	1	2030	2025-11-03 20:25:50
3337	2030-02-19	19	2	February 	1	2030	2025-11-03 20:25:50
3338	2030-02-20	20	2	February 	1	2030	2025-11-03 20:25:50
3339	2030-02-21	21	2	February 	1	2030	2025-11-03 20:25:50
3340	2030-02-22	22	2	February 	1	2030	2025-11-03 20:25:50
3341	2030-02-23	23	2	February 	1	2030	2025-11-03 20:25:50
3342	2030-02-24	24	2	February 	1	2030	2025-11-03 20:25:50
3343	2030-02-25	25	2	February 	1	2030	2025-11-03 20:25:50
3344	2030-02-26	26	2	February 	1	2030	2025-11-03 20:25:50
3345	2030-02-27	27	2	February 	1	2030	2025-11-03 20:25:50
3346	2030-02-28	28	2	February 	1	2030	2025-11-03 20:25:50
3347	2030-03-01	1	3	March    	1	2030	2025-11-03 20:25:50
3348	2030-03-02	2	3	March    	1	2030	2025-11-03 20:25:50
3349	2030-03-03	3	3	March    	1	2030	2025-11-03 20:25:50
3350	2030-03-04	4	3	March    	1	2030	2025-11-03 20:25:50
3351	2030-03-05	5	3	March    	1	2030	2025-11-03 20:25:50
3352	2030-03-06	6	3	March    	1	2030	2025-11-03 20:25:50
3353	2030-03-07	7	3	March    	1	2030	2025-11-03 20:25:50
3354	2030-03-08	8	3	March    	1	2030	2025-11-03 20:25:50
3355	2030-03-09	9	3	March    	1	2030	2025-11-03 20:25:50
3356	2030-03-10	10	3	March    	1	2030	2025-11-03 20:25:50
3357	2030-03-11	11	3	March    	1	2030	2025-11-03 20:25:50
3358	2030-03-12	12	3	March    	1	2030	2025-11-03 20:25:50
3359	2030-03-13	13	3	March    	1	2030	2025-11-03 20:25:50
3360	2030-03-14	14	3	March    	1	2030	2025-11-03 20:25:50
3361	2030-03-15	15	3	March    	1	2030	2025-11-03 20:25:50
3362	2030-03-16	16	3	March    	1	2030	2025-11-03 20:25:50
3363	2030-03-17	17	3	March    	1	2030	2025-11-03 20:25:50
3364	2030-03-18	18	3	March    	1	2030	2025-11-03 20:25:50
3365	2030-03-19	19	3	March    	1	2030	2025-11-03 20:25:50
3366	2030-03-20	20	3	March    	1	2030	2025-11-03 20:25:50
3367	2030-03-21	21	3	March    	1	2030	2025-11-03 20:25:50
3368	2030-03-22	22	3	March    	1	2030	2025-11-03 20:25:50
3369	2030-03-23	23	3	March    	1	2030	2025-11-03 20:25:50
3370	2030-03-24	24	3	March    	1	2030	2025-11-03 20:25:50
3371	2030-03-25	25	3	March    	1	2030	2025-11-03 20:25:50
3372	2030-03-26	26	3	March    	1	2030	2025-11-03 20:25:50
3373	2030-03-27	27	3	March    	1	2030	2025-11-03 20:25:50
3374	2030-03-28	28	3	March    	1	2030	2025-11-03 20:25:50
3375	2030-03-29	29	3	March    	1	2030	2025-11-03 20:25:50
3376	2030-03-30	30	3	March    	1	2030	2025-11-03 20:25:50
3377	2030-03-31	31	3	March    	1	2030	2025-11-03 20:25:50
3378	2030-04-01	1	4	April    	2	2030	2025-11-03 20:25:50
3379	2030-04-02	2	4	April    	2	2030	2025-11-03 20:25:50
3380	2030-04-03	3	4	April    	2	2030	2025-11-03 20:25:50
3381	2030-04-04	4	4	April    	2	2030	2025-11-03 20:25:50
3382	2030-04-05	5	4	April    	2	2030	2025-11-03 20:25:50
3383	2030-04-06	6	4	April    	2	2030	2025-11-03 20:25:50
3384	2030-04-07	7	4	April    	2	2030	2025-11-03 20:25:50
3385	2030-04-08	8	4	April    	2	2030	2025-11-03 20:25:50
3386	2030-04-09	9	4	April    	2	2030	2025-11-03 20:25:50
3387	2030-04-10	10	4	April    	2	2030	2025-11-03 20:25:50
3388	2030-04-11	11	4	April    	2	2030	2025-11-03 20:25:50
3389	2030-04-12	12	4	April    	2	2030	2025-11-03 20:25:50
3390	2030-04-13	13	4	April    	2	2030	2025-11-03 20:25:50
3391	2030-04-14	14	4	April    	2	2030	2025-11-03 20:25:50
3392	2030-04-15	15	4	April    	2	2030	2025-11-03 20:25:50
3393	2030-04-16	16	4	April    	2	2030	2025-11-03 20:25:50
3394	2030-04-17	17	4	April    	2	2030	2025-11-03 20:25:50
3395	2030-04-18	18	4	April    	2	2030	2025-11-03 20:25:50
3396	2030-04-19	19	4	April    	2	2030	2025-11-03 20:25:50
3397	2030-04-20	20	4	April    	2	2030	2025-11-03 20:25:50
3398	2030-04-21	21	4	April    	2	2030	2025-11-03 20:25:50
3399	2030-04-22	22	4	April    	2	2030	2025-11-03 20:25:50
3400	2030-04-23	23	4	April    	2	2030	2025-11-03 20:25:50
3401	2030-04-24	24	4	April    	2	2030	2025-11-03 20:25:50
3402	2030-04-25	25	4	April    	2	2030	2025-11-03 20:25:50
3403	2030-04-26	26	4	April    	2	2030	2025-11-03 20:25:50
3404	2030-04-27	27	4	April    	2	2030	2025-11-03 20:25:50
3405	2030-04-28	28	4	April    	2	2030	2025-11-03 20:25:50
3406	2030-04-29	29	4	April    	2	2030	2025-11-03 20:25:50
3407	2030-04-30	30	4	April    	2	2030	2025-11-03 20:25:50
3408	2030-05-01	1	5	May      	2	2030	2025-11-03 20:25:50
3409	2030-05-02	2	5	May      	2	2030	2025-11-03 20:25:50
3410	2030-05-03	3	5	May      	2	2030	2025-11-03 20:25:50
3411	2030-05-04	4	5	May      	2	2030	2025-11-03 20:25:50
3412	2030-05-05	5	5	May      	2	2030	2025-11-03 20:25:50
3413	2030-05-06	6	5	May      	2	2030	2025-11-03 20:25:50
3414	2030-05-07	7	5	May      	2	2030	2025-11-03 20:25:50
3415	2030-05-08	8	5	May      	2	2030	2025-11-03 20:25:50
3416	2030-05-09	9	5	May      	2	2030	2025-11-03 20:25:50
3417	2030-05-10	10	5	May      	2	2030	2025-11-03 20:25:50
3418	2030-05-11	11	5	May      	2	2030	2025-11-03 20:25:50
3419	2030-05-12	12	5	May      	2	2030	2025-11-03 20:25:50
3420	2030-05-13	13	5	May      	2	2030	2025-11-03 20:25:50
3421	2030-05-14	14	5	May      	2	2030	2025-11-03 20:25:50
3422	2030-05-15	15	5	May      	2	2030	2025-11-03 20:25:50
3423	2030-05-16	16	5	May      	2	2030	2025-11-03 20:25:50
3424	2030-05-17	17	5	May      	2	2030	2025-11-03 20:25:50
3425	2030-05-18	18	5	May      	2	2030	2025-11-03 20:25:50
3426	2030-05-19	19	5	May      	2	2030	2025-11-03 20:25:50
3427	2030-05-20	20	5	May      	2	2030	2025-11-03 20:25:50
3428	2030-05-21	21	5	May      	2	2030	2025-11-03 20:25:50
3429	2030-05-22	22	5	May      	2	2030	2025-11-03 20:25:50
3430	2030-05-23	23	5	May      	2	2030	2025-11-03 20:25:50
3431	2030-05-24	24	5	May      	2	2030	2025-11-03 20:25:50
3432	2030-05-25	25	5	May      	2	2030	2025-11-03 20:25:50
3433	2030-05-26	26	5	May      	2	2030	2025-11-03 20:25:50
3434	2030-05-27	27	5	May      	2	2030	2025-11-03 20:25:50
3435	2030-05-28	28	5	May      	2	2030	2025-11-03 20:25:50
3436	2030-05-29	29	5	May      	2	2030	2025-11-03 20:25:50
3437	2030-05-30	30	5	May      	2	2030	2025-11-03 20:25:50
3438	2030-05-31	31	5	May      	2	2030	2025-11-03 20:25:50
3439	2030-06-01	1	6	June     	2	2030	2025-11-03 20:25:50
3440	2030-06-02	2	6	June     	2	2030	2025-11-03 20:25:50
3441	2030-06-03	3	6	June     	2	2030	2025-11-03 20:25:50
3442	2030-06-04	4	6	June     	2	2030	2025-11-03 20:25:50
3443	2030-06-05	5	6	June     	2	2030	2025-11-03 20:25:50
3444	2030-06-06	6	6	June     	2	2030	2025-11-03 20:25:50
3445	2030-06-07	7	6	June     	2	2030	2025-11-03 20:25:50
3446	2030-06-08	8	6	June     	2	2030	2025-11-03 20:25:50
3447	2030-06-09	9	6	June     	2	2030	2025-11-03 20:25:50
3448	2030-06-10	10	6	June     	2	2030	2025-11-03 20:25:50
3449	2030-06-11	11	6	June     	2	2030	2025-11-03 20:25:50
3450	2030-06-12	12	6	June     	2	2030	2025-11-03 20:25:50
3451	2030-06-13	13	6	June     	2	2030	2025-11-03 20:25:50
3452	2030-06-14	14	6	June     	2	2030	2025-11-03 20:25:50
3453	2030-06-15	15	6	June     	2	2030	2025-11-03 20:25:50
3454	2030-06-16	16	6	June     	2	2030	2025-11-03 20:25:50
3455	2030-06-17	17	6	June     	2	2030	2025-11-03 20:25:50
3456	2030-06-18	18	6	June     	2	2030	2025-11-03 20:25:50
3457	2030-06-19	19	6	June     	2	2030	2025-11-03 20:25:50
3458	2030-06-20	20	6	June     	2	2030	2025-11-03 20:25:50
3459	2030-06-21	21	6	June     	2	2030	2025-11-03 20:25:50
3460	2030-06-22	22	6	June     	2	2030	2025-11-03 20:25:50
3461	2030-06-23	23	6	June     	2	2030	2025-11-03 20:25:50
3462	2030-06-24	24	6	June     	2	2030	2025-11-03 20:25:50
3463	2030-06-25	25	6	June     	2	2030	2025-11-03 20:25:50
3464	2030-06-26	26	6	June     	2	2030	2025-11-03 20:25:50
3465	2030-06-27	27	6	June     	2	2030	2025-11-03 20:25:50
3466	2030-06-28	28	6	June     	2	2030	2025-11-03 20:25:50
3467	2030-06-29	29	6	June     	2	2030	2025-11-03 20:25:50
3468	2030-06-30	30	6	June     	2	2030	2025-11-03 20:25:50
3469	2030-07-01	1	7	July     	3	2030	2025-11-03 20:25:50
3470	2030-07-02	2	7	July     	3	2030	2025-11-03 20:25:50
3471	2030-07-03	3	7	July     	3	2030	2025-11-03 20:25:50
3472	2030-07-04	4	7	July     	3	2030	2025-11-03 20:25:50
3473	2030-07-05	5	7	July     	3	2030	2025-11-03 20:25:50
3474	2030-07-06	6	7	July     	3	2030	2025-11-03 20:25:50
3475	2030-07-07	7	7	July     	3	2030	2025-11-03 20:25:50
3476	2030-07-08	8	7	July     	3	2030	2025-11-03 20:25:50
3477	2030-07-09	9	7	July     	3	2030	2025-11-03 20:25:50
3478	2030-07-10	10	7	July     	3	2030	2025-11-03 20:25:50
3479	2030-07-11	11	7	July     	3	2030	2025-11-03 20:25:50
3480	2030-07-12	12	7	July     	3	2030	2025-11-03 20:25:50
3481	2030-07-13	13	7	July     	3	2030	2025-11-03 20:25:50
3482	2030-07-14	14	7	July     	3	2030	2025-11-03 20:25:50
3483	2030-07-15	15	7	July     	3	2030	2025-11-03 20:25:50
3484	2030-07-16	16	7	July     	3	2030	2025-11-03 20:25:50
3485	2030-07-17	17	7	July     	3	2030	2025-11-03 20:25:50
3486	2030-07-18	18	7	July     	3	2030	2025-11-03 20:25:50
3487	2030-07-19	19	7	July     	3	2030	2025-11-03 20:25:50
3488	2030-07-20	20	7	July     	3	2030	2025-11-03 20:25:50
3489	2030-07-21	21	7	July     	3	2030	2025-11-03 20:25:50
3490	2030-07-22	22	7	July     	3	2030	2025-11-03 20:25:50
3491	2030-07-23	23	7	July     	3	2030	2025-11-03 20:25:50
3492	2030-07-24	24	7	July     	3	2030	2025-11-03 20:25:50
3493	2030-07-25	25	7	July     	3	2030	2025-11-03 20:25:50
3494	2030-07-26	26	7	July     	3	2030	2025-11-03 20:25:50
3495	2030-07-27	27	7	July     	3	2030	2025-11-03 20:25:50
3496	2030-07-28	28	7	July     	3	2030	2025-11-03 20:25:50
3497	2030-07-29	29	7	July     	3	2030	2025-11-03 20:25:50
3498	2030-07-30	30	7	July     	3	2030	2025-11-03 20:25:50
3499	2030-07-31	31	7	July     	3	2030	2025-11-03 20:25:50
3500	2030-08-01	1	8	August   	3	2030	2025-11-03 20:25:50
3501	2030-08-02	2	8	August   	3	2030	2025-11-03 20:25:50
3502	2030-08-03	3	8	August   	3	2030	2025-11-03 20:25:50
3503	2030-08-04	4	8	August   	3	2030	2025-11-03 20:25:50
3504	2030-08-05	5	8	August   	3	2030	2025-11-03 20:25:50
3505	2030-08-06	6	8	August   	3	2030	2025-11-03 20:25:50
3506	2030-08-07	7	8	August   	3	2030	2025-11-03 20:25:50
3507	2030-08-08	8	8	August   	3	2030	2025-11-03 20:25:50
3508	2030-08-09	9	8	August   	3	2030	2025-11-03 20:25:50
3509	2030-08-10	10	8	August   	3	2030	2025-11-03 20:25:50
3510	2030-08-11	11	8	August   	3	2030	2025-11-03 20:25:50
3511	2030-08-12	12	8	August   	3	2030	2025-11-03 20:25:50
3512	2030-08-13	13	8	August   	3	2030	2025-11-03 20:25:50
3513	2030-08-14	14	8	August   	3	2030	2025-11-03 20:25:50
3514	2030-08-15	15	8	August   	3	2030	2025-11-03 20:25:50
3515	2030-08-16	16	8	August   	3	2030	2025-11-03 20:25:50
3516	2030-08-17	17	8	August   	3	2030	2025-11-03 20:25:50
3517	2030-08-18	18	8	August   	3	2030	2025-11-03 20:25:50
3518	2030-08-19	19	8	August   	3	2030	2025-11-03 20:25:50
3519	2030-08-20	20	8	August   	3	2030	2025-11-03 20:25:50
3520	2030-08-21	21	8	August   	3	2030	2025-11-03 20:25:50
3521	2030-08-22	22	8	August   	3	2030	2025-11-03 20:25:50
3522	2030-08-23	23	8	August   	3	2030	2025-11-03 20:25:50
3523	2030-08-24	24	8	August   	3	2030	2025-11-03 20:25:50
3524	2030-08-25	25	8	August   	3	2030	2025-11-03 20:25:50
3525	2030-08-26	26	8	August   	3	2030	2025-11-03 20:25:50
3526	2030-08-27	27	8	August   	3	2030	2025-11-03 20:25:50
3527	2030-08-28	28	8	August   	3	2030	2025-11-03 20:25:50
3528	2030-08-29	29	8	August   	3	2030	2025-11-03 20:25:50
3529	2030-08-30	30	8	August   	3	2030	2025-11-03 20:25:50
3530	2030-08-31	31	8	August   	3	2030	2025-11-03 20:25:50
3531	2030-09-01	1	9	September	3	2030	2025-11-03 20:25:50
3532	2030-09-02	2	9	September	3	2030	2025-11-03 20:25:50
3533	2030-09-03	3	9	September	3	2030	2025-11-03 20:25:50
3534	2030-09-04	4	9	September	3	2030	2025-11-03 20:25:50
3535	2030-09-05	5	9	September	3	2030	2025-11-03 20:25:50
3536	2030-09-06	6	9	September	3	2030	2025-11-03 20:25:50
3537	2030-09-07	7	9	September	3	2030	2025-11-03 20:25:50
3538	2030-09-08	8	9	September	3	2030	2025-11-03 20:25:50
3539	2030-09-09	9	9	September	3	2030	2025-11-03 20:25:50
3540	2030-09-10	10	9	September	3	2030	2025-11-03 20:25:50
3541	2030-09-11	11	9	September	3	2030	2025-11-03 20:25:50
3542	2030-09-12	12	9	September	3	2030	2025-11-03 20:25:50
3543	2030-09-13	13	9	September	3	2030	2025-11-03 20:25:50
3544	2030-09-14	14	9	September	3	2030	2025-11-03 20:25:50
3545	2030-09-15	15	9	September	3	2030	2025-11-03 20:25:50
3546	2030-09-16	16	9	September	3	2030	2025-11-03 20:25:50
3547	2030-09-17	17	9	September	3	2030	2025-11-03 20:25:50
3548	2030-09-18	18	9	September	3	2030	2025-11-03 20:25:50
3549	2030-09-19	19	9	September	3	2030	2025-11-03 20:25:50
3550	2030-09-20	20	9	September	3	2030	2025-11-03 20:25:50
3551	2030-09-21	21	9	September	3	2030	2025-11-03 20:25:50
3552	2030-09-22	22	9	September	3	2030	2025-11-03 20:25:50
3553	2030-09-23	23	9	September	3	2030	2025-11-03 20:25:50
3554	2030-09-24	24	9	September	3	2030	2025-11-03 20:25:50
3555	2030-09-25	25	9	September	3	2030	2025-11-03 20:25:50
3556	2030-09-26	26	9	September	3	2030	2025-11-03 20:25:50
3557	2030-09-27	27	9	September	3	2030	2025-11-03 20:25:50
3558	2030-09-28	28	9	September	3	2030	2025-11-03 20:25:50
3559	2030-09-29	29	9	September	3	2030	2025-11-03 20:25:50
3560	2030-09-30	30	9	September	3	2030	2025-11-03 20:25:50
3561	2030-10-01	1	10	October  	4	2030	2025-11-03 20:25:50
3562	2030-10-02	2	10	October  	4	2030	2025-11-03 20:25:50
3563	2030-10-03	3	10	October  	4	2030	2025-11-03 20:25:50
3564	2030-10-04	4	10	October  	4	2030	2025-11-03 20:25:50
3565	2030-10-05	5	10	October  	4	2030	2025-11-03 20:25:50
3566	2030-10-06	6	10	October  	4	2030	2025-11-03 20:25:50
3567	2030-10-07	7	10	October  	4	2030	2025-11-03 20:25:50
3568	2030-10-08	8	10	October  	4	2030	2025-11-03 20:25:50
3569	2030-10-09	9	10	October  	4	2030	2025-11-03 20:25:50
3570	2030-10-10	10	10	October  	4	2030	2025-11-03 20:25:50
3571	2030-10-11	11	10	October  	4	2030	2025-11-03 20:25:50
3572	2030-10-12	12	10	October  	4	2030	2025-11-03 20:25:50
3573	2030-10-13	13	10	October  	4	2030	2025-11-03 20:25:50
3574	2030-10-14	14	10	October  	4	2030	2025-11-03 20:25:50
3575	2030-10-15	15	10	October  	4	2030	2025-11-03 20:25:50
3576	2030-10-16	16	10	October  	4	2030	2025-11-03 20:25:50
3577	2030-10-17	17	10	October  	4	2030	2025-11-03 20:25:50
3578	2030-10-18	18	10	October  	4	2030	2025-11-03 20:25:50
3579	2030-10-19	19	10	October  	4	2030	2025-11-03 20:25:50
3580	2030-10-20	20	10	October  	4	2030	2025-11-03 20:25:50
3581	2030-10-21	21	10	October  	4	2030	2025-11-03 20:25:50
3582	2030-10-22	22	10	October  	4	2030	2025-11-03 20:25:50
3583	2030-10-23	23	10	October  	4	2030	2025-11-03 20:25:50
3584	2030-10-24	24	10	October  	4	2030	2025-11-03 20:25:50
3585	2030-10-25	25	10	October  	4	2030	2025-11-03 20:25:50
3586	2030-10-26	26	10	October  	4	2030	2025-11-03 20:25:50
3587	2030-10-27	27	10	October  	4	2030	2025-11-03 20:25:50
3588	2030-10-28	28	10	October  	4	2030	2025-11-03 20:25:50
3589	2030-10-29	29	10	October  	4	2030	2025-11-03 20:25:50
3590	2030-10-30	30	10	October  	4	2030	2025-11-03 20:25:50
3591	2030-10-31	31	10	October  	4	2030	2025-11-03 20:25:50
3592	2030-11-01	1	11	November 	4	2030	2025-11-03 20:25:50
3593	2030-11-02	2	11	November 	4	2030	2025-11-03 20:25:50
3594	2030-11-03	3	11	November 	4	2030	2025-11-03 20:25:50
3595	2030-11-04	4	11	November 	4	2030	2025-11-03 20:25:50
3596	2030-11-05	5	11	November 	4	2030	2025-11-03 20:25:50
3597	2030-11-06	6	11	November 	4	2030	2025-11-03 20:25:50
3598	2030-11-07	7	11	November 	4	2030	2025-11-03 20:25:50
3599	2030-11-08	8	11	November 	4	2030	2025-11-03 20:25:50
3600	2030-11-09	9	11	November 	4	2030	2025-11-03 20:25:50
3601	2030-11-10	10	11	November 	4	2030	2025-11-03 20:25:50
3602	2030-11-11	11	11	November 	4	2030	2025-11-03 20:25:50
3603	2030-11-12	12	11	November 	4	2030	2025-11-03 20:25:50
3604	2030-11-13	13	11	November 	4	2030	2025-11-03 20:25:50
3605	2030-11-14	14	11	November 	4	2030	2025-11-03 20:25:50
3606	2030-11-15	15	11	November 	4	2030	2025-11-03 20:25:50
3607	2030-11-16	16	11	November 	4	2030	2025-11-03 20:25:50
3608	2030-11-17	17	11	November 	4	2030	2025-11-03 20:25:50
3609	2030-11-18	18	11	November 	4	2030	2025-11-03 20:25:50
3610	2030-11-19	19	11	November 	4	2030	2025-11-03 20:25:50
3611	2030-11-20	20	11	November 	4	2030	2025-11-03 20:25:50
3612	2030-11-21	21	11	November 	4	2030	2025-11-03 20:25:50
3613	2030-11-22	22	11	November 	4	2030	2025-11-03 20:25:50
3614	2030-11-23	23	11	November 	4	2030	2025-11-03 20:25:50
3615	2030-11-24	24	11	November 	4	2030	2025-11-03 20:25:50
3616	2030-11-25	25	11	November 	4	2030	2025-11-03 20:25:50
3617	2030-11-26	26	11	November 	4	2030	2025-11-03 20:25:50
3618	2030-11-27	27	11	November 	4	2030	2025-11-03 20:25:50
3619	2030-11-28	28	11	November 	4	2030	2025-11-03 20:25:50
3620	2030-11-29	29	11	November 	4	2030	2025-11-03 20:25:50
3621	2030-11-30	30	11	November 	4	2030	2025-11-03 20:25:50
3622	2030-12-01	1	12	December 	4	2030	2025-11-03 20:25:50
3623	2030-12-02	2	12	December 	4	2030	2025-11-03 20:25:50
3624	2030-12-03	3	12	December 	4	2030	2025-11-03 20:25:50
3625	2030-12-04	4	12	December 	4	2030	2025-11-03 20:25:50
3626	2030-12-05	5	12	December 	4	2030	2025-11-03 20:25:50
3627	2030-12-06	6	12	December 	4	2030	2025-11-03 20:25:50
3628	2030-12-07	7	12	December 	4	2030	2025-11-03 20:25:50
3629	2030-12-08	8	12	December 	4	2030	2025-11-03 20:25:50
3630	2030-12-09	9	12	December 	4	2030	2025-11-03 20:25:50
3631	2030-12-10	10	12	December 	4	2030	2025-11-03 20:25:50
3632	2030-12-11	11	12	December 	4	2030	2025-11-03 20:25:50
3633	2030-12-12	12	12	December 	4	2030	2025-11-03 20:25:50
3634	2030-12-13	13	12	December 	4	2030	2025-11-03 20:25:50
3635	2030-12-14	14	12	December 	4	2030	2025-11-03 20:25:50
3636	2030-12-15	15	12	December 	4	2030	2025-11-03 20:25:50
3637	2030-12-16	16	12	December 	4	2030	2025-11-03 20:25:50
3638	2030-12-17	17	12	December 	4	2030	2025-11-03 20:25:50
3639	2030-12-18	18	12	December 	4	2030	2025-11-03 20:25:50
3640	2030-12-19	19	12	December 	4	2030	2025-11-03 20:25:50
3641	2030-12-20	20	12	December 	4	2030	2025-11-03 20:25:50
3642	2030-12-21	21	12	December 	4	2030	2025-11-03 20:25:50
3643	2030-12-22	22	12	December 	4	2030	2025-11-03 20:25:50
3644	2030-12-23	23	12	December 	4	2030	2025-11-03 20:25:50
3645	2030-12-24	24	12	December 	4	2030	2025-11-03 20:25:50
3646	2030-12-25	25	12	December 	4	2030	2025-11-03 20:25:50
3647	2030-12-26	26	12	December 	4	2030	2025-11-03 20:25:50
3648	2030-12-27	27	12	December 	4	2030	2025-11-03 20:25:50
3649	2030-12-28	28	12	December 	4	2030	2025-11-03 20:25:50
3650	2030-12-29	29	12	December 	4	2030	2025-11-03 20:25:50
3651	2030-12-30	30	12	December 	4	2030	2025-11-03 20:25:50
3652	2030-12-31	31	12	December 	4	2030	2025-11-03 20:25:50
\.


--
-- Data for Name: ft_airquality_measurement; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.ft_airquality_measurement (airquality_measurement_id, day_id, sk_location, sk_device, sk_parameter, recordedvalue, dataquality, datavolumekb, alert_exceeded_flag, tempdaymin, tempdaymax, tempdayavg, precipmm, pressure, windspeed, windgusts, etl_load_timestamp) FROM stdin;
1	731	1	1	3	29.4431	4	49	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
2	731	1	1	18	16.5147	5	32	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
3	731	1	1	5	21.9087	2	45	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
4	731	1	1	23	11.4056	3	35	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
5	731	1	1	19	53.5366	1	90	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
6	731	1	1	30	95.2878	5	12	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
7	731	2	2	21	10.9105	5	84	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
8	731	2	2	3	29.9928	2	85	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
9	731	2	2	25	76.1904	3	80	f	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
10	731	2	2	27	215.0312	4	79	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
11	731	2	2	27	215.0312	4	79	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
12	731	2	2	27	215.0312	4	79	t	10.5	14.3	12.2	5.6	1010.3	8.4	20.0	2025-11-03 20:25:50
\.


--
-- Data for Name: ft_service_event; Type: TABLE DATA; Schema: dwh_047; Owner: -
--

COPY dwh_047.ft_service_event (service_event_id, day_id, sk_location, sk_device, sk_servicetype, sk_technician_role, servicecost, durationminutes, servicequality, underqualified_flag, expired_certification_flag, etl_load_timestamp) FROM stdin;
1	739	1	1	3	226	198	71	4	f	f	2025-11-03 20:25:50
2	739	1	1	3	225	198	71	4	f	f	2025-11-03 20:25:50
3	754	1	1	4	387	95	93	5	f	f	2025-11-03 20:25:50
4	758	1	1	4	430	193	91	4	f	f	2025-11-03 20:25:50
5	758	1	1	4	428	193	91	4	f	f	2025-11-03 20:25:50
6	758	1	1	4	427	193	91	4	f	f	2025-11-03 20:25:50
7	758	1	1	4	429	193	91	4	f	f	2025-11-03 20:25:50
8	794	1	1	3	145	188	69	1	t	f	2025-11-03 20:25:50
9	794	1	1	3	147	188	69	1	t	f	2025-11-03 20:25:50
10	794	1	1	3	146	188	69	1	f	f	2025-11-03 20:25:50
11	794	1	1	3	144	188	69	1	f	f	2025-11-03 20:25:50
12	800	1	1	22	215	191	108	5	f	f	2025-11-03 20:25:50
13	815	1	1	16	267	173	135	4	f	f	2025-11-03 20:25:50
14	825	1	1	22	124	182	70	5	f	f	2025-11-03 20:25:50
15	837	1	1	8	401	276	131	5	f	f	2025-11-03 20:25:50
16	854	1	1	24	48	158	165	5	f	f	2025-11-03 20:25:50
17	854	1	1	24	47	158	165	5	t	f	2025-11-03 20:25:50
18	882	1	1	21	60	107	117	3	t	f	2025-11-03 20:25:50
19	882	1	1	21	61	107	117	3	f	f	2025-11-03 20:25:50
\.


--
-- Name: dim_device_sk_device_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.dim_device_sk_device_seq', 627, true);


--
-- Name: dim_location_sk_location_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.dim_location_sk_location_seq', 627, true);


--
-- Name: dim_parameter_sk_parameter_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.dim_parameter_sk_parameter_seq', 30, true);


--
-- Name: dim_servicetype_sk_servicetype_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.dim_servicetype_sk_servicetype_seq', 24, true);


--
-- Name: dim_technician_role_scd2_sk_technician_role_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.dim_technician_role_scd2_sk_technician_role_seq', 484, true);


--
-- Name: ft_airquality_measurement_airquality_measurement_id_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.ft_airquality_measurement_airquality_measurement_id_seq', 12, true);


--
-- Name: ft_service_event_service_event_id_seq; Type: SEQUENCE SET; Schema: dwh_047; Owner: -
--

SELECT pg_catalog.setval('dwh_047.ft_service_event_service_event_id_seq', 19, true);


--
-- Name: dim_device dim_device_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_device
    ADD CONSTRAINT dim_device_pkey PRIMARY KEY (sk_device);


--
-- Name: dim_location dim_location_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_location
    ADD CONSTRAINT dim_location_pkey PRIMARY KEY (sk_location);


--
-- Name: dim_parameter dim_parameter_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_parameter
    ADD CONSTRAINT dim_parameter_pkey PRIMARY KEY (sk_parameter);


--
-- Name: dim_servicetype dim_servicetype_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_servicetype
    ADD CONSTRAINT dim_servicetype_pkey PRIMARY KEY (sk_servicetype);


--
-- Name: dim_technician_role_scd2 dim_technician_role_scd2_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_technician_role_scd2
    ADD CONSTRAINT dim_technician_role_scd2_pkey PRIMARY KEY (sk_technician_role);


--
-- Name: dim_timeday dim_timeday_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_timeday
    ADD CONSTRAINT dim_timeday_pkey PRIMARY KEY (id);


--
-- Name: ft_airquality_measurement ft_airquality_measurement_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement
    ADD CONSTRAINT ft_airquality_measurement_pkey PRIMARY KEY (airquality_measurement_id);


--
-- Name: ft_service_event ft_service_event_pkey; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT ft_service_event_pkey PRIMARY KEY (service_event_id);


--
-- Name: dim_device uq_dim_device_bk; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_device
    ADD CONSTRAINT uq_dim_device_bk UNIQUE (sensordevice_id);


--
-- Name: dim_location uq_dim_location_bk; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_location
    ADD CONSTRAINT uq_dim_location_bk UNIQUE (sensordevice_id);


--
-- Name: dim_parameter uq_dim_parameter_bk; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_parameter
    ADD CONSTRAINT uq_dim_parameter_bk UNIQUE (tb_param_id);


--
-- Name: dim_servicetype uq_dim_servicetype_bk; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_servicetype
    ADD CONSTRAINT uq_dim_servicetype_bk UNIQUE (tb_servicetype_id);


--
-- Name: dim_technician_role_scd2 ux_techrole_bk_timerange; Type: CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.dim_technician_role_scd2
    ADD CONSTRAINT ux_techrole_bk_timerange UNIQUE (badgenumber, effective_from, effective_to);


--
-- Name: ix_ft_airquality_measurement_day; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_airquality_measurement_day ON dwh_047.ft_airquality_measurement USING btree (day_id);


--
-- Name: ix_ft_airquality_measurement_device; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_airquality_measurement_device ON dwh_047.ft_airquality_measurement USING btree (sk_device);


--
-- Name: ix_ft_airquality_measurement_location; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_airquality_measurement_location ON dwh_047.ft_airquality_measurement USING btree (sk_location);


--
-- Name: ix_ft_airquality_measurement_param; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_airquality_measurement_param ON dwh_047.ft_airquality_measurement USING btree (sk_parameter);


--
-- Name: ix_ft_service_event_day; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_service_event_day ON dwh_047.ft_service_event USING btree (day_id);


--
-- Name: ix_ft_service_event_device; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_service_event_device ON dwh_047.ft_service_event USING btree (sk_device);


--
-- Name: ix_ft_service_event_location; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_service_event_location ON dwh_047.ft_service_event USING btree (sk_location);


--
-- Name: ix_ft_service_event_role; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_service_event_role ON dwh_047.ft_service_event USING btree (sk_technician_role);


--
-- Name: ix_ft_service_event_type; Type: INDEX; Schema: dwh_047; Owner: -
--

CREATE INDEX ix_ft_service_event_type ON dwh_047.ft_service_event USING btree (sk_servicetype);


--
-- Name: ft_airquality_measurement fk_airquality_measurement_day; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement
    ADD CONSTRAINT fk_airquality_measurement_day FOREIGN KEY (day_id) REFERENCES dwh_047.dim_timeday(id);


--
-- Name: ft_airquality_measurement fk_airquality_measurement_device; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement
    ADD CONSTRAINT fk_airquality_measurement_device FOREIGN KEY (sk_device) REFERENCES dwh_047.dim_device(sk_device);


--
-- Name: ft_airquality_measurement fk_airquality_measurement_location; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement
    ADD CONSTRAINT fk_airquality_measurement_location FOREIGN KEY (sk_location) REFERENCES dwh_047.dim_location(sk_location);


--
-- Name: ft_airquality_measurement fk_airquality_measurement_param; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_airquality_measurement
    ADD CONSTRAINT fk_airquality_measurement_param FOREIGN KEY (sk_parameter) REFERENCES dwh_047.dim_parameter(sk_parameter);


--
-- Name: ft_service_event fk_service_event_day; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT fk_service_event_day FOREIGN KEY (day_id) REFERENCES dwh_047.dim_timeday(id);


--
-- Name: ft_service_event fk_service_event_device; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT fk_service_event_device FOREIGN KEY (sk_device) REFERENCES dwh_047.dim_device(sk_device);


--
-- Name: ft_service_event fk_service_event_location; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT fk_service_event_location FOREIGN KEY (sk_location) REFERENCES dwh_047.dim_location(sk_location);


--
-- Name: ft_service_event fk_service_event_role; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT fk_service_event_role FOREIGN KEY (sk_technician_role) REFERENCES dwh_047.dim_technician_role_scd2(sk_technician_role);


--
-- Name: ft_service_event fk_service_event_type; Type: FK CONSTRAINT; Schema: dwh_047; Owner: -
--

ALTER TABLE ONLY dwh_047.ft_service_event
    ADD CONSTRAINT fk_service_event_type FOREIGN KEY (sk_servicetype) REFERENCES dwh_047.dim_servicetype(sk_servicetype);


--
-- PostgreSQL database dump complete
--


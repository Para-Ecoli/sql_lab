--
-- openGauss database dump
--

SET statement_timeout = 0;
SET xmloption = content;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET session_replication_role = replica;
SET client_min_messages = warning;
SET enable_dump_trigger_definer = on;

--
-- Name: BEHAVIORCOMPAT; Type: BEHAVIORCOMPAT; Schema: -; Owner: 
--

SET behavior_compat_options = '';


SET search_path = public;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: c444; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE c444 (
    "c#" character varying(5) NOT NULL,
    cname character varying(60),
    period smallint,
    credit real,
    teacher character varying(40)
)
WITH (orientation=row, compression=no);


ALTER TABLE public.c444 OWNER TO admin;

--
-- Name: s444; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE s444 (
    "s#" character varying(8) NOT NULL,
    sname character varying(40),
    sex character varying(3),
    bdate timestamp(0) without time zone,
    height real,
    dorm character varying(40)
)
WITH (orientation=row, compression=no);


ALTER TABLE public.s444 OWNER TO admin;

--
-- Name: sc444; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE sc444 (
    "s#" character varying(8) NOT NULL,
    "c#" character varying(5) NOT NULL,
    grade real
)
WITH (orientation=row, compression=no);


ALTER TABLE public.sc444 OWNER TO admin;

--
-- Data for Name: c444; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.c444 ("c#", cname, period, credit, teacher) FROM stdin;
CS-01	数据结构	60	3	张军
CS-02	计算机组成原理	80	4	王亚伟
CS-04	人工智能	40	2	李蕾
CS-05	深度学习	40	2	崔昀
EE-01	信号与系统	60	3	张明
EE-02	数字逻辑电路	100	5	胡海东
EE-03	光电子学与光子学	40	2	石韬
\.
;

--
-- Data for Name: s444; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.s444 ("s#", sname, sex, bdate, height, dorm) FROM stdin;
01032010	王涛	男	2003-04-05 00:00:00	1.72000003	东 6 舍 221
01032023	孙文	男	2004-06-10 00:00:00	1.79999995	东 6 舍 221
01032001	张晓梅	女	2003-11-17 00:00:00	1.58000004	东 1 舍 312
01032005	刘静	女	2003-01-10 00:00:00	1.63	东 1 舍 312
01032112	董喆	男	2003-02-20 00:00:00	1.71000004	东 6 舍 221
03031011	王倩	女	2004-12-20 00:00:00	1.65999997	东 2 舍 104
03031014	赵思扬	男	2002-06-06 00:00:00	1.85000002	东 18 舍 421
03031051	周剑	男	2002-05-08 00:00:00	1.67999995	东 18 舍 422
03031009	田菲	女	2003-08-11 00:00:00	1.60000002	东 2 舍 104
03031033	蔡明明	男	2003-03-12 00:00:00	1.75	东 18 舍 423
03031056	曹子衿	女	2005-12-15 00:00:00	1.64999998	东 2 舍 305
\.
;

--
-- Data for Name: sc444; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sc444 ("s#", "c#", grade) FROM stdin;
01032010	CS-01	82
01032010	CS-02	91
01032010	CS-04	83.5
01032001	CS-01	77.5
01032001	CS-02	85
01032001	CS-04	83
01032005	CS-01	62
01032005	CS-02	77
01032005	CS-04	82
01032023	CS-01	55
01032023	CS-02	81
01032023	CS-04	76
01032112	CS-01	88
01032112	CS-02	91.5
01032112	CS-04	86
01032112	CS-05	\N
03031033	EE-01	93
03031033	EE-02	89
03031009	EE-01	88
03031009	EE-02	78.5
03031011	EE-01	91
03031011	EE-02	86
03031051	EE-01	78
03031051	EE-02	58
03031014	EE-01	79
03031014	EE-02	71
\.
;

--
-- Name: c444_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE c444
    ADD CONSTRAINT c444_pkey PRIMARY KEY  ("c#");


--
-- Name: s444_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE s444
    ADD CONSTRAINT s444_pkey PRIMARY KEY  ("s#");


--
-- Name: sc444_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE sc444
    ADD CONSTRAINT sc444_pkey PRIMARY KEY  ("s#", "c#");


--
-- Name: sc444_c#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE sc444
    ADD CONSTRAINT "sc444_c#_fkey" FOREIGN KEY ("c#") REFERENCES c444("c#");


--
-- Name: sc444_s#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE sc444
    ADD CONSTRAINT "sc444_s#_fkey" FOREIGN KEY ("s#") REFERENCES s444("s#");


--
-- Name: public; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM admin;
GRANT CREATE,USAGE ON SCHEMA public TO admin;
GRANT USAGE ON SCHEMA public TO PUBLIC;


--
-- openGauss database dump complete
--


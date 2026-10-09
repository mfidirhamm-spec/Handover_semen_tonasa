--
-- PostgreSQL database dump
--

\restrict F2gNAiTdL6zSopK2bTumspePKaq3KQpjqCuziT3E6XvueiY24r86yJCsQ7yBfiF

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: asset_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_history (
    id integer NOT NULL,
    asset_id integer,
    field_changed character varying(255),
    old_value text,
    new_value text,
    changed_by integer,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.asset_history OWNER TO postgres;

--
-- Name: asset_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asset_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asset_history_id_seq OWNER TO postgres;

--
-- Name: asset_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asset_history_id_seq OWNED BY public.asset_history.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    asset_number character varying(255) NOT NULL,
    equipment_number character varying(255),
    name character varying(255) NOT NULL,
    category_id integer,
    location character varying(255),
    location_grup character varying(255),
    cum_acq_value double precision,
    end_book_value double precision,
    specification text,
    function_status character varying(50),
    performance_status character varying(50),
    added_date date DEFAULT CURRENT_DATE,
    is_deleted integer DEFAULT 0,
    deleted_at timestamp without time zone,
    deleted_by integer,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rejection_reason text,
    status_approval character varying(50) DEFAULT 'Pending'::character varying,
    photo_proof text,
    change_reason text,
    land_area character varying(255),
    CONSTRAINT assets_function_status_check CHECK (((function_status)::text = ANY ((ARRAY['Baik'::character varying, 'Rusak'::character varying, 'Mutasi'::character varying, 'Tidak Ada Fisik'::character varying])::text[]))),
    CONSTRAINT assets_performance_status_check CHECK (((performance_status)::text = ANY ((ARRAY['Optimal'::character varying, 'Tidak Optimal'::character varying])::text[])))
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assets_id_seq OWNER TO postgres;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.password_resets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_resets_id_seq OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_resets_id_seq OWNED BY public.password_resets.id;


--
-- Name: user_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_history (
    id integer NOT NULL,
    user_id integer,
    field_changed character varying(255),
    old_value text,
    new_value text,
    changed_by integer,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_history OWNER TO postgres;

--
-- Name: user_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_history_id_seq OWNER TO postgres;

--
-- Name: user_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_history_id_seq OWNED BY public.user_history.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    password_hash text,
    role character varying(50),
    is_deleted integer DEFAULT 0,
    deleted_at timestamp without time zone,
    deleted_by integer,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'operator'::character varying, 'karyawan'::character varying, 'admin_utama'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: asset_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_history ALTER COLUMN id SET DEFAULT nextval('public.asset_history_id_seq'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: password_resets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN id SET DEFAULT nextval('public.password_resets_id_seq'::regclass);


--
-- Name: user_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_history ALTER COLUMN id SET DEFAULT nextval('public.user_history_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: asset_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_history (id, asset_id, field_changed, old_value, new_value, changed_by, changed_at) FROM stdin;
93	138	status_approval	Pending	Approved	1	2026-06-24 15:51:43.399449
94	137	status_approval	Pending	Approved	1	2026-06-24 15:51:43.399449
95	141	status_approval	\N	Menunggu persetujuan Admin	12	2026-06-24 16:12:31.85985
96	141	status_approval	Pending	Rejected (Alasan: unggah bukti foto)	1	2026-06-24 16:12:58.45811
97	141	status_approval	Rejected	Pending (Perubahan data oleh operator)	12	2026-06-24 16:13:30.280276
98	141	status_approval	Pending	Approved	1	2026-06-24 16:19:15.588255
99	141	status_approval	Approved	Pending (Perubahan data oleh operator)	12	2026-06-24 16:20:03.300775
100	141	status_approval	Pending	Approved	1	2026-06-24 16:23:30.592604
101	141	status_approval	Approved	Pending (Perubahan data oleh operator)	12	2026-06-24 16:24:52.151389
102	141	status_approval	Pending	Approved	1	2026-06-24 16:25:05.17085
106	140	is_deleted	0	1	1	2026-06-29 09:02:23.171524
107	139	is_deleted	0	1	1	2026-06-29 09:02:30.823867
108	142	status_approval	\N	Menunggu persetujuan Admin	12	2026-06-29 09:10:04.115537
109	142	status_approval	Pending	Approved	1	2026-06-29 09:10:14.442083
110	143	status_approval	\N	Menunggu persetujuan Admin	12	2026-06-29 09:11:30.797006
111	143	status_approval	Pending	Approved	1	2026-06-29 09:11:45.94411
112	143	status_approval	Approved	Pending (Perubahan data oleh operator)	12	2026-06-29 09:12:41.496851
113	143	status_approval	Pending	Rejected (Alasan: sudah ada alat di kantor pusat)	10	2026-06-29 10:08:28.841806
114	153	asset_created	\N	Aset didaftarkan langsung oleh Admin	1	2026-07-14 09:15:07.031496
115	154	asset_created	\N	Aset didaftarkan langsung oleh Admin	1	2026-07-14 14:28:02.204075
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (id, asset_number, equipment_number, name, category_id, location, location_grup, cum_acq_value, end_book_value, specification, function_status, performance_status, added_date, is_deleted, deleted_at, deleted_by, created_by, created_at, rejection_reason, status_approval, photo_proof, change_reason, land_area) FROM stdin;
131	GF-2026-T001	EQ-2026-T001	Lahan Pabrik Utama Tonasa 5	4	Pangkep - Pabrik	Pangkep	\N	\N	Lahan Terbuka	Baik	Optimal	2026-06-24	0	\N	\N	1	2026-06-24 15:50:55.035501	\N	Approved	\N	\N	150000 m2
132	GF-2026-T002	EQ-2026-T002	Tanah Area Kantor Pusat	4	Biringere, Pangkep	Pangkep	\N	\N	Lahan Terbuka	Baik	Optimal	2026-06-24	0	\N	\N	1	2026-06-24 15:50:55.068754	\N	Approved	\N	\N	25000 m2
133	GF-2026-T003	EQ-2026-T003	Lahan Tambang Silika	4	Bulusaraung	Pangkep	\N	\N	Lahan Terbuka	Baik	Optimal	2026-06-24	0	\N	\N	1	2026-06-24 15:50:55.070497	\N	Approved	\N	\N	500000 m2
137	GF-2026-T007	EQ-2026-T007	Lahan Ekspansi Baru Blok C	4	Blok C Pangkep	Pangkep	\N	\N	Lahan Terbuka	Baik	Optimal	2026-06-24	0	\N	\N	1	2026-06-24 15:50:55.0763	\N	Approved	\N	\N	75000 m2
138	GF-2026-T008	EQ-2026-T008	Tanah Hibah Desa Biringere	4	Biringere	Pangkep	\N	\N	Lahan Terbuka	Baik	Optimal	2026-06-24	0	\N	\N	1	2026-06-24 15:50:55.077205	\N	Approved	\N	\N	12500 m2
140	GF-2026-T010	EQ-2026-T010	Tanah Area Kantin Lama	4	Kantin Pusat	tonasa 2/3	\N	\N	Lahan Terbuka	Mutasi	Tidak Optimal	2026-06-24	1	2026-06-29 09:02:23.171524	1	1	2026-06-24 15:50:55.078743	\N	Approved	/uploads/1782291634811-294389921.jpeg	mau hitung ulang	1500 m2
139	GF-2026-T009	EQ-2026-T009	Lahan Bekas Gudang Lama	4	Area Gudang B	Pangkep	\N	\N	Lahan Terbuka	Mutasi	Tidak Optimal	2026-06-24	1	2026-06-29 09:02:30.823867	1	1	2026-06-24 15:50:55.078133	\N	Approved	\N	\N	8000 m2
142	GF-2026-081	EQ-2026-081	tanah kosong lahan	4	lahan kosong di kecamatan bungoro	tonasa 2/3	\N	\N	aset yang perlu di kelola untuk pembangunan	Baik	Tidak Optimal	2026-06-29	0	\N	\N	12	2026-06-29 09:10:04.070828	\N	Approved	/uploads/1782699004067-726039643.jpeg	\N	120000 m2
143	GF-2026-091	EQ-2026-091	mobil buldozer	1	di lahan tanah kosong	tonasa biringkassi	\N	\N	aset nya cukup untuk penggunaan 2 tahun	Baik	Tidak Optimal	2026-06-29	0	\N	\N	12	2026-06-29 09:11:30.769871	sudah ada alat di kantor pusat	Rejected	/uploads/1782699090767-840320904.jpeg	Mutasi ke di lahan tanah kosong	\N
147	TEST-001	EQ-TEST	Test Asset	1	Loc	Grup	\N	\N	Spec	Baik	Optimal	2026-07-14	0	\N	\N	1	2026-07-14 08:41:12.273583	\N	Approved	\N	\N	\N
149	TEST-003	\N	Tanah Test	1	\N	\N	\N	\N	\N	\N	\N	2026-07-14	0	\N	\N	\N	2026-07-14 08:43:52.459409	\N	Pending	\N	\N	12.5 m2
150	TEST-004	\N	Tanah Test 2	1	\N	\N	\N	\N	\N	\N	\N	2026-07-14	0	\N	\N	\N	2026-07-14 08:44:31.983932	\N	Pending	\N	\N	12.5 m2
141	GF-2026-101	EQ-2026-101	mobil	3	parkiran	tonasa 2/3	\N	\N	mobil dinas	Baik	Optimal	2026-06-24	0	\N	\N	12	2026-06-24 16:12:31.838896	\N	Approved	/uploads/1782292998538-352942559.jpeg	Mutasi: ada kepentingan kantor pusat	\N
153	GF-2026-011	EQ-2026-011	mobil dinas	3	basement	tonasa 3	\N	\N	mobil dinas	Baik	Optimal	2026-07-14	0	\N	\N	1	2026-07-14 09:15:07.015556	\N	Approved	/uploads/1783995307013-392582582.webp	Mutasi ke basement	\N
154	123	123	lahan golf	4	Biringere, Bungoro, Pangkajene Dan Kepulauan, Sulawesi Selatan		\N	\N		Baik	Optimal	2026-07-14	0	\N	\N	1	2026-07-14 14:28:02.137866	\N	Approved	/uploads/1784014082132-231317695.webp	\N	12500.5
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
2	Bangunan
3	Kendaraan
4	Tanah
5	Aset Tak Berwujud
6	Perlengkapan
1	Mesin dan Peralatan
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (id, email, token, created_at, expires_at) FROM stdin;
1	irfanjamal.fbs@gmail.com	9fb709306ecd7f7df479b38313a62a46076acb59357e97bf9c2a9ccd4ffa163e	2026-07-14 12:58:29.203846	2026-07-14 06:58:29.201
\.


--
-- Data for Name: user_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_history (id, user_id, field_changed, old_value, new_value, changed_by, changed_at) FROM stdin;
1	12	user_created	\N	Pendaftaran mandiri sebagai akun User	12	2026-06-23 10:32:56.989278
4	9	is_deleted	0	1	1	2026-07-14 13:13:23.363114
5	5	is_deleted	0	1	1	2026-07-14 13:39:10.566678
6	5	is_deleted	1	0	1	2026-07-14 13:39:25.759321
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password_hash, role, is_deleted, deleted_at, deleted_by) FROM stdin;
1	Admin Utama	admin@contoh.com	$2b$10$fol/BUWKTVnisl8N5DArguwcwOij6QDS6rje8rh.n31jARyBwVjjy	admin_utama	0	\N	\N
2	Admin Divisi 1	admin1@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	admin	0	\N	\N
3	Karyawan Lapangan 1	user1@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	karyawan	0	\N	\N
4	Admin Divisi 2	admin2@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	admin	0	\N	\N
6	Admin Divisi 3	admin3@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	admin	0	\N	\N
7	Karyawan Lapangan 3	user3@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	karyawan	0	\N	\N
8	Admin Divisi 4	admin4@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	admin	0	\N	\N
10	Admin Divisi 5	admin5@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	admin	0	\N	\N
11	Karyawan Lapangan 5	user5@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	karyawan	0	\N	\N
12	irfan jamal p	irfan@gmail.com	$2b$10$LbqXW9olGMG6Cl2RJff6J.mK9s5X4CfWaxIR4FwvnsDV28r34UN6W	operator	0	\N	\N
9	Karyawan Lapangan 4	user4@contoh.com_deleted_1784009603357	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	karyawan	1	2026-07-14 13:13:23.357796	\N
5	Karyawan Lapangan 2	user2@contoh.com	$2b$10$yVOyffUcbOT6JrB2vKK8w.xZEMHedaAtbi78bEmkopCsuAsvbkHIG	karyawan	0	\N	\N
\.


--
-- Name: asset_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asset_history_id_seq', 115, true);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assets_id_seq', 154, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- Name: password_resets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_resets_id_seq', 1, true);


--
-- Name: user_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_history_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: asset_history asset_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_history
    ADD CONSTRAINT asset_history_pkey PRIMARY KEY (id);


--
-- Name: assets assets_asset_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_asset_number_key UNIQUE (asset_number);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: user_history user_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_history
    ADD CONSTRAINT user_history_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: asset_history asset_history_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_history
    ADD CONSTRAINT asset_history_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.assets(id);


--
-- Name: asset_history asset_history_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_history
    ADD CONSTRAINT asset_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(id);


--
-- Name: assets assets_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: assets assets_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: user_history user_history_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_history
    ADD CONSTRAINT user_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(id);


--
-- Name: user_history user_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_history
    ADD CONSTRAINT user_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict F2gNAiTdL6zSopK2bTumspePKaq3KQpjqCuziT3E6XvueiY24r86yJCsQ7yBfiF


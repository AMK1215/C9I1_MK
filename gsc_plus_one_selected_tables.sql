--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.10.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.10.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_types; Type: TABLE; Schema: public; Owner: amk
--

CREATE TABLE public.game_types (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    name_mm character varying(255) NOT NULL,
    img character varying(255) DEFAULT 'default.png'::character varying NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    "order" character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.game_types OWNER TO amk;

--
-- Name: game_types_id_seq; Type: SEQUENCE; Schema: public; Owner: amk
--

CREATE SEQUENCE public.game_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_types_id_seq OWNER TO amk;

--
-- Name: game_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amk
--

ALTER SEQUENCE public.game_types_id_seq OWNED BY public.game_types.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: amk
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    provider character varying(255) NOT NULL,
    currency character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    provider_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_code character varying(255) NOT NULL,
    product_name character varying(255) NOT NULL,
    game_type character varying(255) NOT NULL,
    product_title character varying(255) NOT NULL,
    short_name character varying(255),
    "order" integer DEFAULT 0 NOT NULL,
    game_list_status boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.products OWNER TO amk;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: amk
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO amk;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amk
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: game_types id; Type: DEFAULT; Schema: public; Owner: amk
--

ALTER TABLE ONLY public.game_types ALTER COLUMN id SET DEFAULT nextval('public.game_types_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: amk
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: game_types; Type: TABLE DATA; Schema: public; Owner: amk
--

COPY public.game_types (id, code, name, name_mm, img, status, "order", created_at, updated_at) FROM stdin;
1	SLOT	Slot	Slot	default.png	1	1	2025-05-21 06:11:36	2025-05-21 06:11:36
2	LIVE_CASINO	Live Casino	Live Casino	default.png	1	2	2025-05-21 06:11:36	2025-05-21 06:11:36
3	SPORT_BOOK	Sport Book	Sport Book	default.png	1	3	2025-05-21 06:11:36	2025-05-21 06:11:36
4	VIRTUAL_SPORT	Virtual Sport	Virtual Sport	default.png	1	4	2025-05-21 06:11:36	2025-05-21 06:11:36
5	LOTTERY	Lottery	Lottery	default.png	1	5	2025-05-21 06:11:36	2025-05-21 06:11:36
6	QIPAI	Qipai	Qipai	default.png	1	6	2025-05-21 06:11:36	2025-05-21 06:11:36
7	P2P	P2P	P2P	default.png	1	7	2025-05-21 06:11:36	2025-05-21 06:11:36
8	FISHING	Fishing	Fishing	default.png	1	8	2025-05-21 06:11:36	2025-05-21 06:11:36
9	COCK_FIGHTING	Cock Fighting	Cock Fighting	default.png	1	9	2025-05-21 06:11:36	2025-05-21 06:11:36
10	BONUS	Bonus	Bonus	default.png	1	10	2025-05-21 06:11:36	2025-05-21 06:11:36
11	ESPORT	ESport	ESport	default.png	1	11	2025-05-21 06:11:36	2025-05-21 06:11:36
12	POKER	Poker	Poker	default.png	1	12	2025-05-21 06:11:36	2025-05-21 06:11:36
13	OTHERS	Others	Others	default.png	1	13	2025-05-21 06:11:36	2025-05-21 06:11:36
14	LIVE_CASINO_PREMIUM	Live Casino Premium	Live Casino Premium	default.png	1	14	2025-05-21 06:11:36	2025-05-21 06:11:36
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: amk
--

COPY public.products (id, provider, currency, status, provider_id, product_id, product_code, product_name, game_type, product_title, short_name, "order", game_list_status, created_at, updated_at) FROM stdin;
1	SBO	IDR2	ACTIVATED	2	52	1012	sbo	SPORT_BOOK	SBO	\N	1	t	2025-05-21 06:11:36	2025-05-21 06:11:36
2	Yee Bet	IDR	ACTIVATED	3	9	1016	yee_bet	LIVE_CASINO	YeeBet	\N	2	t	2025-05-21 06:11:36	2025-05-21 06:11:36
3	GMAG	IDR	ACTIVATED	4	10	1011	play_tech	SLOT	PlayTech	\N	3	t	2025-05-21 06:11:36	2025-05-21 06:11:36
4	GMAG	IDR	ACTIVATED	4	11	1011	play_tech	LIVE_CASINO	PlayTech	\N	4	t	2025-05-21 06:11:36	2025-05-21 06:11:36
5	Joker	IDR	ACTIVATED	5	183	1225	joker	SLOT	Joker	\N	5	t	2025-05-21 06:11:36	2025-05-21 06:11:36
6	Joker	IDR	ACTIVATED	5	184	1225	joker	OTHER	Joker	\N	6	t	2025-05-21 06:11:36	2025-05-21 06:11:36
7	Joker	IDR	ACTIVATED	5	185	1225	joker	FISHING	Joker	\N	7	t	2025-05-21 06:11:36	2025-05-21 06:11:36
8	SA Gaming	IDR	ACTIVATED	8	116	1185	sa_gaming	LIVE_CASINO	SA Gaming	\N	8	t	2025-05-21 06:11:36	2025-05-21 06:11:36
9	SpadeGaming	CNY	ACTIVATED	10	178	1221	spadegaming	SLOT	SpadeGaming	\N	9	t	2025-05-21 06:11:36	2025-05-21 06:11:36
10	SpadeGaming	CNY	ACTIVATED	10	179	1221	spadegaming	FISHING	SpadeGaming	\N	10	t	2025-05-21 06:11:36	2025-05-21 06:11:36
11	Live22	IDR	ACTIVATED	11	72	1018	live_22	SLOT	Live22	\N	11	t	2025-05-21 06:11:36	2025-05-21 06:11:36
12	WMCasino	CNY	ACTIVATED	17	7	1020	wm_casino	LIVE_CASINO	WMCasino	\N	12	t	2025-05-21 06:11:36	2025-05-21 06:11:36
13	Habanero	IDR	ACTIVATED	18	153	1197	habanero	SLOT	Habanero	\N	13	t	2025-05-21 06:11:36	2025-05-21 06:11:36
14	WBet	IDR2	ACTIVATED	19	64	1040	wbet	SPORT_BOOK	WBet	\N	14	t	2025-05-21 06:11:36	2025-05-21 06:11:36
15	AWC	IDR	ACTIVATED	23	34	1139	fastspin	SLOT	FASTSPIN	\N	15	t	2025-05-21 06:11:36	2025-05-21 06:11:36
16	AWC	IDR	ACTIVATED	23	35	1139	fastspin	FISHING	FASTSPIN	\N	16	t	2025-05-21 06:11:36	2025-05-21 06:11:36
17	AWC	IDR	ACTIVATED	23	29	1022	sexy_gaming	LIVE_CASINO	SexyGaming	\N	17	t	2025-05-21 06:11:36	2025-05-21 06:11:36
18	AWC	IDR	ACTIVATED	23	33	1033	sv388cockfighting	COCK_FIGHTING	SV388	\N	18	t	2025-05-21 06:11:36	2025-05-21 06:11:36
19	IBC	IDR2	ACTIVATED	30	43	1046	saba	SPORT_BOOK	Saba	\N	19	t	2025-05-21 06:11:36	2025-05-21 06:11:36
20	PG Soft	IDR2	ACTIVATED	31	4	1007	pg_soft	SLOT	PGSoft	\N	20	t	2025-05-21 06:11:36	2025-05-21 06:11:36
21	PragmaticPlay	IDR	ACTIVATED	32	136	1006	pragmatic_play	LIVE_CASINO_PREMIUM	PragmaticPlay	\N	21	t	2025-05-21 06:11:36	2025-05-21 06:11:36
22	PragmaticPlay	IDR	ACTIVATED	32	85	1006	pragmatic_play	VIRTUAL_SPORT	PragmaticPlay	\N	22	t	2025-05-21 06:11:36	2025-05-21 06:11:36
23	PragmaticPlay	IDR	ACTIVATED	32	50	1006	pragmatic_play	SLOT	PragmaticPlay	\N	23	t	2025-05-21 06:11:36	2025-05-21 06:11:36
24	PragmaticPlay	IDR	ACTIVATED	32	49	1006	pragmatic_play	LIVE_CASINO	PragmaticPlay	\N	24	t	2025-05-21 06:11:36	2025-05-21 06:11:36
25	Dream Gaming	IDR	ACTIVATED	33	51	1052	dream_gaming	LIVE_CASINO	Dream Gaming	\N	25	t	2025-05-21 06:11:36	2025-05-21 06:11:36
26	BigGaming	IDR2	ACTIVATED	34	68	1004	big_gaming	LIVE_CASINO	BigGaming	\N	26	t	2025-05-21 06:11:36	2025-05-21 06:11:36
27	BigGaming	IDR2	ACTIVATED	34	69	1004	big_gaming	FISHING	BigGaming	\N	27	t	2025-05-21 06:11:36	2025-05-21 06:11:36
28	EVOPLAY	IDR	ACTIVATED	38	63	1049	evoplay	SLOT	EvoPlay	\N	28	t	2025-05-21 06:11:36	2025-05-21 06:11:36
29	JDB	IDR	ACTIVATED	41	57	1085	jdb	SLOT	JDB	\N	29	t	2025-05-21 06:11:36	2025-05-21 06:11:36
30	JDB	IDR	ACTIVATED	41	58	1085	jdb	FISHING	JDB	\N	30	t	2025-05-21 06:11:36	2025-05-21 06:11:36
31	JDB	IDR	ACTIVATED	41	132	1085	jdb	OTHER	JDB	\N	31	t	2025-05-21 06:11:36	2025-05-21 06:11:36
32	PlayStar	IDR	ACTIVATED	42	37	1050	playstar	SLOT	PlayStar	\N	32	t	2025-05-21 06:11:36	2025-05-21 06:11:36
33	CT855	MYR	ACTIVATED	43	3	1038	king855	LIVE_CASINO	CT855	\N	33	t	2025-05-21 06:11:36	2025-05-21 06:11:36
34	CQ9	IDR	ACTIVATED	47	47	1009	cq9	SLOT	CQ9	\N	34	t	2025-05-21 06:11:36	2025-05-21 06:11:36
35	CQ9	IDR	ACTIVATED	47	48	1009	cq9	FISHING	CQ9	\N	35	t	2025-05-21 06:11:36	2025-05-21 06:11:36
36	Jili	IDR	ACTIVATED	48	6	1091	jili_tcg	SLOT	JiLi	\N	36	t	2025-05-21 06:11:36	2025-05-21 06:11:36
37	Jili	IDR	ACTIVATED	48	28	1091	jili_tcg	FISHING	JiLi	\N	37	t	2025-05-21 06:11:36	2025-05-21 06:11:36
38	Jili	IDR	ACTIVATED	48	110	1091	jili_tcg	LIVE_CASINO	JiLi	\N	38	t	2025-05-21 06:11:36	2025-05-21 06:11:36
39	Jili	IDR	ACTIVATED	48	115	1091	jili_tcg	POKER	JiLi	\N	39	t	2025-05-21 06:11:36	2025-05-21 06:11:36
40	MrSlotty	IDR	ACTIVATED	49	5	1058	bgaming	SLOT	BGaming	\N	40	t	2025-05-21 06:11:36	2025-05-21 06:11:36
41	MrSlotty	IDR	ACTIVATED	49	13	1070	booongo	SLOT	Booongo	\N	41	t	2025-05-21 06:11:36	2025-05-21 06:11:36
42	MrSlotty	IDR	ACTIVATED	49	21	1062	fazi	SLOT	Fazi	\N	42	t	2025-05-21 06:11:36	2025-05-21 06:11:36
43	MrSlotty	IDR	ACTIVATED	49	16	1098	felix	SLOT	Felix	\N	43	t	2025-05-21 06:11:36	2025-05-21 06:11:36
44	MrSlotty	IDR	ACTIVATED	49	14	1097	funtagaming	SLOT	Funta	\N	44	t	2025-05-21 06:11:36	2025-05-21 06:11:36
45	MrSlotty	IDR	ACTIVATED	49	124	1097	funtagaming	FISHING	Funta	\N	45	t	2025-05-21 06:11:36	2025-05-21 06:11:36
46	MrSlotty	IDR	ACTIVATED	49	15	1111	gamingworld	SLOT	GamingWorld	\N	46	t	2025-05-21 06:11:36	2025-05-21 06:11:36
47	MrSlotty	IDR	ACTIVATED	49	8	1102	kagaming	SLOT	KAGaming	\N	47	t	2025-05-21 06:11:36	2025-05-21 06:11:36
48	MrSlotty	IDR	ACTIVATED	49	17	1065	kiron	SLOT	Kiron	\N	48	t	2025-05-21 06:11:36	2025-05-21 06:11:36
49	MrSlotty	IDR	ACTIVATED	49	18	1055	mrslotty	SLOT	MrSlotty	\N	49	t	2025-05-21 06:11:36	2025-05-21 06:11:36
50	MrSlotty	IDR	ACTIVATED	49	19	1064	netgame	SLOT	NetGame	\N	50	t	2025-05-21 06:11:36	2025-05-21 06:11:36
51	MrSlotty	IDR	ACTIVATED	49	129	1064	netgame	FISHING	NetGame	\N	51	t	2025-05-21 06:11:36	2025-05-21 06:11:36
52	MrSlotty	IDR	ACTIVATED	49	20	1067	redrake	SLOT	RedRake	\N	52	t	2025-05-21 06:11:36	2025-05-21 06:11:36
53	MrSlotty	IDR	ACTIVATED	49	26	1060	volt_entertainment	SLOT	Volt Entertainment	\N	53	t	2025-05-21 06:11:36	2025-05-21 06:11:36
54	MrSlotty	IDR	ACTIVATED	49	23	1101	zeusplay	SLOT	ZeusPlay	\N	54	t	2025-05-21 06:11:36	2025-05-21 06:11:36
55	PlayAce	IDR2	ACTIVATED	50	154	1203	playace	SLOT	PlayAce	\N	55	t	2025-05-21 06:11:36	2025-05-21 06:11:36
56	PlayAce	IDR2	ACTIVATED	50	155	1203	playace	LIVE_CASINO	PlayAce	\N	56	t	2025-05-21 06:11:36	2025-05-21 06:11:36
57	BoomingGames	IDR	ACTIVATED	68	114	1115	booming_games	SLOT	Booming Games	\N	57	t	2025-05-21 06:11:36	2025-05-21 06:11:36
58	Spribe	IDR	ACTIVATED	92	1	1138	spribe	OTHER	Spribe	\N	58	t	2025-05-21 06:11:36	2025-05-21 06:11:36
59	WOW GAMING	IDR	ACTIVATED	101	39	1148	wow_gaming	POKER	WOW Gaming	\N	59	t	2025-05-21 06:11:36	2025-05-21 06:11:36
60	WOW GAMING	IDR	ACTIVATED	101	40	1148	wow_gaming	SLOT	WOW Gaming	\N	60	t	2025-05-21 06:11:36	2025-05-21 06:11:36
61	WOW GAMING	IDR	ACTIVATED	101	82	1148	wow_gaming	P2P	WOW Gaming	\N	61	t	2025-05-21 06:11:36	2025-05-21 06:11:36
62	AI Live Casino	IDR	ACTIVATED	102	41	1149	ai_live_casino	LIVE_CASINO	AI Live Casino	\N	62	t	2025-05-21 06:11:36	2025-05-21 06:11:36
63	AI Live Casino	IDR	ACTIVATED	102	42	1149	ai_live_casino	POKER	AI Live Casino	\N	63	t	2025-05-21 06:11:36	2025-05-21 06:11:36
64	HACKSAW	IDR	ACTIVATED	105	65	1153	hacksaw	SLOT	Hacksaw	\N	64	t	2025-05-21 06:11:36	2025-05-21 06:11:36
65	HACKSAW	IDR	ACTIVATED	105	128	1153	hacksaw	OTHER	Hacksaw	\N	65	t	2025-05-21 06:11:36	2025-05-21 06:11:36
66	BIGPOT	IDR	ACTIVATED	106	71	1154	bigpot	SLOT	BIGPOT	\N	66	t	2025-05-21 06:11:36	2025-05-21 06:11:36
67	IMoon	IDR	ACTIVATED	109	74	1157	imoon	OTHER	IMoon	\N	67	t	2025-05-21 06:11:36	2025-05-21 06:11:36
68	EPICWIN	IDR	ACTIVATED	112	75	1160	epicwin	SLOT	EpicWin	\N	68	t	2025-05-21 06:11:36	2025-05-21 06:11:36
69	Fachai	IDR	ACTIVATED	113	80	1079	fachai	SLOT	FaChai	\N	69	t	2025-05-21 06:11:36	2025-05-21 06:11:36
70	Fachai	IDR	ACTIVATED	113	81	1079	fachai	FISHING	FaChai	\N	70	t	2025-05-21 06:11:36	2025-05-21 06:11:36
71	N2	IDR	ACTIVATED	115	84	1163	novomatic	SLOT	NOVOMatic	\N	71	t	2025-05-21 06:11:36	2025-05-21 06:11:36
72	N2	IDR	ACTIVATED	115	83	1162	octoplay	SLOT	OCTOPlay	\N	72	t	2025-05-21 06:11:36	2025-05-21 06:11:36
73	DIGITAIN	IDR	ACTIVATED	116	91	1164	digitain	SPORT_BOOK	Digitain	\N	73	t	2025-05-21 06:11:36	2025-05-21 06:11:36
74	Aviatrix	IDR	ACTIVATED	117	90	1165	aviatrix	OTHER	Aviatrix	\N	74	t	2025-05-21 06:11:36	2025-05-21 06:11:36
75	SmartSoft	IDR	ACTIVATED	118	92	1170	smartsoft	SLOT	SmartSoft	\N	75	t	2025-05-21 06:11:36	2025-05-21 06:11:36
76	WorldEntertainment	CNY	ACTIVATED	120	97	1172	world_entertainment	SLOT	World Entertainment	\N	76	t	2025-05-21 06:11:36	2025-05-21 06:11:36
77	WorldEntertainment	CNY	ACTIVATED	120	113	1172	world_entertainment	SPORT_BOOK	World Entertainment	\N	77	t	2025-05-21 06:11:36	2025-05-21 06:11:36
78	WorldEntertainment	CNY	ACTIVATED	120	96	1172	world_entertainment	VIRTUAL_SPORT	World Entertainment	\N	78	t	2025-05-21 06:11:36	2025-05-21 06:11:36
79	WorldEntertainment	CNY	ACTIVATED	120	95	1172	world_entertainment	LIVE_CASINO	World Entertainment	\N	79	t	2025-05-21 06:11:36	2025-05-21 06:11:36
80	FB Sports	IDR	ACTIVATED	123	109	1183	fb_sports	SPORT_BOOK	FB Sports	\N	80	t	2025-05-21 06:11:36	2025-05-21 06:11:36
81	Rich88	IDR2	ACTIVATED	124	112	1184	rich88	SLOT	RiCH88	\N	81	t	2025-05-21 06:11:36	2025-05-21 06:11:36
82	CT855(K0)	IDR	ACTIVATED	126	133	1191	king855_k0	LIVE_CASINO	King855	\N	82	t	2025-05-21 06:11:36	2025-05-21 06:11:36
83	AmigoGaming	IDR	ACTIVATED	127	134	1192	amigogaming	SLOT	AmigoGaming	\N	83	t	2025-05-21 06:11:36	2025-05-21 06:11:36
84	FBGames	IDR	ACTIVATED	128	135	1193	fbgames	LIVE_CASINO	FBGames	\N	84	t	2025-05-21 06:11:36	2025-05-21 06:11:36
85	astar	IDR	ACTIVATED	137	175	1220	astar	LIVE_CASINO	Astar	\N	85	t	2025-05-21 06:11:36	2025-05-21 06:11:36
86	astar	IDR	ACTIVATED	137	176	1220	astar	OTHER	Astar	\N	86	t	2025-05-21 06:11:36	2025-05-21 06:11:36
87	astar	IDR	ACTIVATED	137	177	1220	astar	POKER	Astar	\N	87	t	2025-05-21 06:11:36	2025-05-21 06:11:36
\.


--
-- Name: game_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amk
--

SELECT pg_catalog.setval('public.game_types_id_seq', 14, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amk
--

SELECT pg_catalog.setval('public.products_id_seq', 87, true);


--
-- Name: game_types game_types_pkey; Type: CONSTRAINT; Schema: public; Owner: amk
--

ALTER TABLE ONLY public.game_types
    ADD CONSTRAINT game_types_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: amk
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


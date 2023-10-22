--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-10-21 19:18:07

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

--
-- TOC entry 7 (class 2615 OID 16398)
-- Name: general; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA general;


ALTER SCHEMA general OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16462)
-- Name: booking_notes; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.booking_notes (
    date_of_notes timestamp without time zone,
    details_of_notes text,
    booking_notes_id integer NOT NULL,
    booking_id integer NOT NULL
);


ALTER TABLE general.booking_notes OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16429)
-- Name: bookings; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.bookings (
    date_booked timestamp without time zone,
    date_of_event timestamp without time zone,
    other_details text,
    booking_taken_by_staff_id integer NOT NULL,
    customer_id integer NOT NULL,
    booking_id integer NOT NULL
);


ALTER TABLE general.bookings OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16421)
-- Name: customers; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.customers (
    customer_details text,
    customer_id integer NOT NULL
);


ALTER TABLE general.customers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16514)
-- Name: meals; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.meals (
    date_of_meal text,
    other_details text,
    meal_id integer NOT NULL
);


ALTER TABLE general.meals OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16588)
-- Name: menu_changes; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.menu_changes (
    change_id integer NOT NULL,
    menu_id integer NOT NULL,
    booking_id integer NOT NULL,
    change_details text
);


ALTER TABLE general.menu_changes OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16509)
-- Name: menu_meal; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.menu_meal (
    menu_id integer NOT NULL,
    meal_id integer NOT NULL
);


ALTER TABLE general.menu_meal OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16489)
-- Name: menus; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.menus (
    menu_name character varying,
    other_details text,
    menu_id integer NOT NULL
);


ALTER TABLE general.menus OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16486)
-- Name: menus_booked; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.menus_booked (
    menu_id integer NOT NULL,
    booking_id integer NOT NULL
);


ALTER TABLE general.menus_booked OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16437)
-- Name: staff; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.staff (
    first_name character varying,
    last_name character varying,
    role character varying,
    other_details text,
    staff_id integer NOT NULL
);


ALTER TABLE general.staff OWNER TO postgres;

--
-- TOC entry 3385 (class 0 OID 16462)
-- Dependencies: 219
-- Data for Name: booking_notes; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.booking_notes (date_of_notes, details_of_notes, booking_notes_id, booking_id) FROM stdin;
\N	no salt	1	1
\N	no sugar	3	3
\N	no salt	2	2
\N	please be in separate containers	4	7
\.


--
-- TOC entry 3383 (class 0 OID 16429)
-- Dependencies: 217
-- Data for Name: bookings; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.bookings (date_booked, date_of_event, other_details, booking_taken_by_staff_id, customer_id, booking_id) FROM stdin;
2023-05-11 12:30:11	\N	\N	2	1	1
2023-05-11 12:32:17	\N	\N	1	2	2
2023-05-11 12:50:02	\N	\N	3	4	4
2023-05-11 12:55:37	\N	\N	2	5	5
2023-05-12 12:39:42	\N	\N	3	2	6
2023-05-12 12:47:24	\N	\N	1	3	8
2023-05-13 12:41:11	\N	\N	2	2	9
2023-05-14 12:32:13	\N	\N	3	5	10
2023-05-11 08:35:42	\N	\N	2	3	3
2023-05-12 21:40:10	\N	\N	1	1	7
\.


--
-- TOC entry 3382 (class 0 OID 16421)
-- Dependencies: 216
-- Data for Name: customers; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.customers (customer_details, customer_id) FROM stdin;
ali	1
mohamad	3
shahab	5
fateme	2
helia	4
\.


--
-- TOC entry 3389 (class 0 OID 16514)
-- Dependencies: 223
-- Data for Name: meals; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.meals (date_of_meal, other_details, meal_id) FROM stdin;
breakfast	Italian	1
lunch	Italian	6
breakfast	English	2
lunch	English	3
lunch	Mexican	4
lunch	Chinese	5
dinner	Italian	7
dinner	English	8
\.


--
-- TOC entry 3390 (class 0 OID 16588)
-- Dependencies: 224
-- Data for Name: menu_changes; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.menu_changes (change_id, menu_id, booking_id, change_details) FROM stdin;
\.


--
-- TOC entry 3388 (class 0 OID 16509)
-- Dependencies: 222
-- Data for Name: menu_meal; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.menu_meal (menu_id, meal_id) FROM stdin;
1	1
1	2
2	3
2	4
2	5
2	6
3	7
3	8
4	4
4	5
\.


--
-- TOC entry 3387 (class 0 OID 16489)
-- Dependencies: 221
-- Data for Name: menus; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.menus (menu_name, other_details, menu_id) FROM stdin;
breakfast	\N	1
lunch	\N	2
dinner	\N	3
hot luch	\N	4
\.


--
-- TOC entry 3386 (class 0 OID 16486)
-- Dependencies: 220
-- Data for Name: menus_booked; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.menus_booked (menu_id, booking_id) FROM stdin;
2	1
2	2
1	3
2	4
2	5
2	6
3	7
2	8
2	9
2	10
\.


--
-- TOC entry 3384 (class 0 OID 16437)
-- Dependencies: 218
-- Data for Name: staff; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.staff (first_name, last_name, role, other_details, staff_id) FROM stdin;
nahid	kamali	recipient	\N	3
sepehr	arazi	recipient	\N	1
hamid	maleki	recipient	\N	2
\.


--
-- TOC entry 3223 (class 2606 OID 16563)
-- Name: booking_notes booking_notes_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.booking_notes
    ADD CONSTRAINT booking_notes_pk PRIMARY KEY (booking_notes_id);


--
-- TOC entry 3219 (class 2606 OID 16547)
-- Name: bookings bookings_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.bookings
    ADD CONSTRAINT bookings_pk PRIMARY KEY (booking_id);


--
-- TOC entry 3217 (class 2606 OID 16533)
-- Name: customers customers_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.customers
    ADD CONSTRAINT customers_pk PRIMARY KEY (customer_id);


--
-- TOC entry 3229 (class 2606 OID 16577)
-- Name: meals meals_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.meals
    ADD CONSTRAINT meals_pk PRIMARY KEY (meal_id);


--
-- TOC entry 3231 (class 2606 OID 16594)
-- Name: menu_changes menu_changes_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menu_changes
    ADD CONSTRAINT menu_changes_pk PRIMARY KEY (change_id);


--
-- TOC entry 3225 (class 2606 OID 16551)
-- Name: menus_booked menus_booked_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menus_booked
    ADD CONSTRAINT menus_booked_pk PRIMARY KEY (menu_id, booking_id);


--
-- TOC entry 3227 (class 2606 OID 16549)
-- Name: menus menus_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menus
    ADD CONSTRAINT menus_pk PRIMARY KEY (menu_id);


--
-- TOC entry 3221 (class 2606 OID 16535)
-- Name: staff staff_pk; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (staff_id);


--
-- TOC entry 3234 (class 2606 OID 16564)
-- Name: booking_notes booking_notes_fk; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.booking_notes
    ADD CONSTRAINT booking_notes_fk FOREIGN KEY (booking_id) REFERENCES general.bookings(booking_id);


--
-- TOC entry 3232 (class 2606 OID 16536)
-- Name: bookings bookings_fk; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.bookings
    ADD CONSTRAINT bookings_fk FOREIGN KEY (customer_id) REFERENCES general.customers(customer_id);


--
-- TOC entry 3233 (class 2606 OID 16541)
-- Name: bookings bookings_fk_1; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.bookings
    ADD CONSTRAINT bookings_fk_1 FOREIGN KEY (booking_taken_by_staff_id) REFERENCES general.staff(staff_id);


--
-- TOC entry 3239 (class 2606 OID 16595)
-- Name: menu_changes menu_changes_fk; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menu_changes
    ADD CONSTRAINT menu_changes_fk FOREIGN KEY (menu_id, booking_id) REFERENCES general.menus_booked(menu_id, booking_id);


--
-- TOC entry 3237 (class 2606 OID 16578)
-- Name: menu_meal menu_meal_fk; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menu_meal
    ADD CONSTRAINT menu_meal_fk FOREIGN KEY (menu_id) REFERENCES general.menus(menu_id);


--
-- TOC entry 3238 (class 2606 OID 16583)
-- Name: menu_meal menu_meal_fk_1; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menu_meal
    ADD CONSTRAINT menu_meal_fk_1 FOREIGN KEY (meal_id) REFERENCES general.meals(meal_id);


--
-- TOC entry 3235 (class 2606 OID 16552)
-- Name: menus_booked menus_booked_fk; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menus_booked
    ADD CONSTRAINT menus_booked_fk FOREIGN KEY (booking_id) REFERENCES general.bookings(booking_id);


--
-- TOC entry 3236 (class 2606 OID 16557)
-- Name: menus_booked menus_booked_fk_1; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.menus_booked
    ADD CONSTRAINT menus_booked_fk_1 FOREIGN KEY (menu_id) REFERENCES general.menus(menu_id);


-- Completed on 2023-10-21 19:18:08

--
-- PostgreSQL database dump complete
--

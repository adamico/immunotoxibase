--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assessments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assessments (
    id integer NOT NULL,
    reference_id integer,
    molecule_id integer,
    measure_id integer,
    species_id integer,
    condition character varying(255),
    effet character varying(255),
    level character varying(255),
    evolution integer,
    old_id integer,
    maj timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer
);


--
-- Name: assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assessments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assessments_id_seq OWNED BY assessments.id;


--
-- Name: measures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE measures (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    lft integer,
    rgt integer,
    depth integer,
    parent_id integer,
    old_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: measures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE measures_id_seq OWNED BY measures.id;


--
-- Name: references; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "references" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    source character varying(255),
    url character varying(255),
    old_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: references_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: references_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE references_id_seq OWNED BY "references".id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sections (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    picture_file_name character varying(255),
    picture_content_type character varying(255),
    picture_file_size integer,
    picture_updated_at timestamp without time zone,
    lft integer,
    rgt integer,
    depth integer,
    parent_id integer,
    maj timestamp without time zone,
    old_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying(255)
);


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sections_id_seq OWNED BY sections.id;


--
-- Name: species; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE species (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    old_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: species_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE species_id_seq OWNED BY species.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assessments ALTER COLUMN id SET DEFAULT nextval('assessments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY measures ALTER COLUMN id SET DEFAULT nextval('measures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "references" ALTER COLUMN id SET DEFAULT nextval('references_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections ALTER COLUMN id SET DEFAULT nextval('sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY species ALTER COLUMN id SET DEFAULT nextval('species_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assessments
    ADD CONSTRAINT assessments_pkey PRIMARY KEY (id);


--
-- Name: measures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_pkey PRIMARY KEY (id);


--
-- Name: references_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "references"
    ADD CONSTRAINT references_pkey PRIMARY KEY (id);


--
-- Name: sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: species_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY species
    ADD CONSTRAINT species_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_assessments_on_measure_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_measure_id ON assessments USING btree (measure_id);


--
-- Name: index_assessments_on_molecule_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_molecule_id ON assessments USING btree (molecule_id);


--
-- Name: index_assessments_on_reference_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_reference_id ON assessments USING btree (reference_id);


--
-- Name: index_assessments_on_species_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_species_id ON assessments USING btree (species_id);


--
-- Name: index_measures_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_measures_on_name ON measures USING btree (name);


--
-- Name: index_measures_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_measures_on_parent_id ON measures USING btree (parent_id);


--
-- Name: index_references_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_references_on_name ON "references" USING btree (name);


--
-- Name: index_sections_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_sections_on_name ON sections USING btree (name);


--
-- Name: index_sections_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sections_on_parent_id ON sections USING btree (parent_id);


--
-- Name: index_sections_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_sections_on_slug ON sections USING btree (slug);


--
-- Name: index_species_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_species_on_name ON species USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120424124000');

INSERT INTO schema_migrations (version) VALUES ('20120424124149');

INSERT INTO schema_migrations (version) VALUES ('20120425131536');

INSERT INTO schema_migrations (version) VALUES ('20120426144008');

INSERT INTO schema_migrations (version) VALUES ('20120426144145');

INSERT INTO schema_migrations (version) VALUES ('20120426145036');

INSERT INTO schema_migrations (version) VALUES ('20120523135844');

INSERT INTO schema_migrations (version) VALUES ('20120616122927');

INSERT INTO schema_migrations (version) VALUES ('20120618102656');
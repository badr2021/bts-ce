#!/bin/bash
#
#Create schemas
#
#
#set -e
psql -v ON_ERROR_STOP=1 --username "bodastage" -d bts  <<-EOSQL
	CREATE SCHEMA network_audit
		AUTHORIZATION bodastage;

		
-- Table: network_audit.audit_category

-- DROP TABLE network_audit.audit_category;

CREATE TABLE network_audit.audit_category
(
    pk bigint NOT NULL,
    created_by bigint NOT NULL,
    date_created timestamp without time zone,
    date_modified timestamp without time zone,
    in_built boolean,
    modified_by bigint NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    notes text COLLATE pg_catalog."default",
    parent_pk bigint,
    CONSTRAINT audit_category_pkey PRIMARY KEY (pk)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE network_audit.audit_category
    OWNER to bodastage;
	
-- ----------------------------------------------------------

-- Table: network_audit.audit_rule

-- DROP TABLE network_audit.audit_rule;

CREATE TABLE network_audit.audit_rule
(
    pk bigint NOT NULL,
    category_pk bigint,
    created_by bigint NOT NULL,
    date_created timestamp without time zone,
    date_modified timestamp without time zone,
    first_run_date timestamp without time zone,
    in_built boolean,
    last_run_date timestamp without time zone,
    modified_by bigint NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    notes text COLLATE pg_catalog."default",
    sql text COLLATE pg_catalog."default",
    table_name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT audit_rule_pkey PRIMARY KEY (pk),
    CONSTRAINT fkhse278w7dyn857i6wjbn5jx71 FOREIGN KEY (category_pk)
        REFERENCES network_audit.audit_category (pk) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE network_audit.audit_rule
    OWNER to bodastage;
	
-- ------------------------
CREATE SEQUENCE network_audit.seq_audit_category
    INCREMENT 1
    START 3
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE network_audit.seq_audit_category
    OWNER TO bodastage;
	
-- -------------------------
CREATE SEQUENCE network_audit.seq_audit_rule
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE network_audit.seq_audit_rule
    OWNER TO bodastage;
EOSQL
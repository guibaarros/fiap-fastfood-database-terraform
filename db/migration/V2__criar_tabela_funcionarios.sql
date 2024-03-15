CREATE SEQUENCE IF NOT EXISTS public.tb_employee_employee_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.tb_employee
(
    employee_id bigint NOT NULL DEFAULT nextval('tb_employee_employee_id_seq'::regclass),
    cpf bigint,
    created_at timestamp(6) without time zone NOT NULL,
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT tb_employee_pkey PRIMARY KEY (employee_id)
);

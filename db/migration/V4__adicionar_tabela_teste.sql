CREATE SEQUENCE IF NOT EXISTS public.tb_teste_teste_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.tb_teste
(
    teste_id bigint NOT NULL DEFAULT nextval('tb_teste_teste_id_seq'::regclass),
    teste_bigint bigint,
    CONSTRAINT tb_employee_pkey PRIMARY KEY (teste_id)
);

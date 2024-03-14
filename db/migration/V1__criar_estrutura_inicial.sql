-- CREATE SEQUENCES

CREATE SEQUENCE IF NOT EXISTS public.tb_client_client_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS public.tb_order_order_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS public.tb_product_image_product_image_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS public.tb_product_product_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

-- CREATE TABLES

CREATE TABLE IF NOT EXISTS public.tb_client
(
    client_id bigint NOT NULL DEFAULT nextval('tb_client_client_id_seq'::regclass),
    cpf bigint,
    created_at timestamp(6) without time zone NOT NULL,
    email character varying(255) COLLATE pg_catalog."default",
    last_visit date NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT tb_client_pkey PRIMARY KEY (client_id)
);

CREATE TABLE IF NOT EXISTS public.tb_order
(
    order_id bigint NOT NULL DEFAULT nextval('tb_order_order_id_seq'::regclass),
    created_at timestamp(6) without time zone NOT NULL,
    finished_at timestamp(6) without time zone,
    "number" integer,
    payment_status character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status character varying(255) COLLATE pg_catalog."default" NOT NULL,
    total_amount numeric(38,2),
    updated_at timestamp(6) without time zone,
    payment_status_updated_at timestamp(6) without time zone,
    payment_qr_code_data character varying(255) COLLATE pg_catalog."default",
    external_id bigint,
    client_id bigint,
    CONSTRAINT tb_order_pkey PRIMARY KEY (order_id),
    CONSTRAINT tk_tb_order_client FOREIGN KEY (client_id)
        REFERENCES public.tb_client (client_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT tb_order_payment_status_check CHECK (payment_status::text = ANY (ARRAY['AWAITING_PAYMENT'::character varying, 'PAID'::character varying, 'CANCELLED'::character varying]::text[])),
    CONSTRAINT tb_order_status_check CHECK (status::text = ANY (ARRAY['AWAITING_PAYMENT'::character varying, 'AWAITING_PREPARATION'::character varying, 'PREPARING'::character varying, 'READY'::character varying, 'RECEIVED'::character varying::text, 'FINISHED'::character varying, 'CANCELLED'::character varying]::text[]))
);

CREATE TABLE IF NOT EXISTS public.tb_product
(
    product_id bigint NOT NULL DEFAULT nextval('tb_product_product_id_seq'::regclass),
    category character varying(255) COLLATE pg_catalog."default",
    created_at timestamp(6) without time zone NOT NULL,
    description character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    price numeric(38,2),
    CONSTRAINT tb_product_pkey PRIMARY KEY (product_id),
    CONSTRAINT tb_product_category_check CHECK (category::text = ANY (ARRAY['SNACK'::character varying, 'SIDE'::character varying, 'DRINK'::character varying, 'DESSERT'::character varying]::text[]))
);

CREATE TABLE IF NOT EXISTS public.tb_order_products
(
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    CONSTRAINT fk_tb_order_products_order FOREIGN KEY (order_id)
        REFERENCES public.tb_order (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_tb_order_products_product FOREIGN KEY (product_id)
        REFERENCES public.tb_product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.tb_product_image
(
    product_image_id bigint NOT NULL DEFAULT nextval('tb_product_image_product_image_id_seq'::regclass),
    content_type character varying(255) COLLATE pg_catalog."default",
    image oid,
    name character varying(255) COLLATE pg_catalog."default",
    size bigint,
    product_id bigint,
    CONSTRAINT tb_product_image_pkey PRIMARY KEY (product_image_id),
    CONSTRAINT fk_tb_product_image_product_id FOREIGN KEY (product_id)
        REFERENCES public.tb_product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
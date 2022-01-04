--DROP TABLE IF EXISTS public."products";
--DROP TYPE IF EXISTS public."currency_type";
--TRUNCATE TABLE public."products";
CREATE TYPE public."currency_type" AS ENUM ('euro', 'dollar', 'grivna', 'ruble');
CREATE TABLE public."products"(
	"prod_name" VARCHAR(100) NOT NULL UNIQUE,
	"price" NUMERIC(15,2) CHECK("price">=0),
	"currency" currency_type,
	"manufacture_date" DATE CHECK("manufacture_date"<current_date),
	"is_valid" BOOLEAN,
	"count" NUMERIC(4,0) CHECK("count"<=1000)
);
INSERT INTO public."products"("prod_name","price","currency","manufacture_date","is_valid","count")
VALUES ('table',12,'dollar','2019-04-20',true,1000)
      ,('knife',1,'euro','2020-05-10',true,10);
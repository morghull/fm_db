DROP TABLE "users";
CREATE TABLE "users"(
   "id" bigserial PRIMARY KEY,
   "first_name" varchar(64) NOT NULL CHECK("first_name"!=''),
   "last_name" varchar(64) NOT NULL CHECK("last_name"!=''),
   "email" varchar(64) NOT NULL CHECK("email"!='') UNIQUE,
   "is_male" BOOLEAN NOT NULL,
   "birthday" DATE NOT NULL CHECK("birthday"<CURRENT_DATE),
   "height" NUMERIC(3,2) NOT NULL CHECK(height between 1 and 2.5)
);

INSERT INTO "users" ("first_name","last_name","email","is_male","birthday","height")
VALUES
('Elonchik','Musk','musk4@gmail.com',true,'2001-06-28',1.88),
('Elon','Musk','musk7@gmail.com',false,'1941-06-28',1.68);
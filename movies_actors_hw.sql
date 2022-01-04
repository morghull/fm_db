--DROP TABLE "genres";
CREATE TABLE "genres"(
   "id" SERIAL PRIMARY KEY,
   "name" VARCHAR(50) NOT NULL CHECK("name"!='') UNIQUE
);

--DROP TABLE "countries";
CREATE TABLE "countries"(
   "id" SERIAL PRIMARY KEY,
   "name" VARCHAR(50) NOT NULL CHECK("name"!='') UNIQUE
);

--DROP TABLE "film_directors";
CREATE TABLE "film_directors" (
   "id" SERIAL PRIMARY KEY,
   "name" VARCHAR(100) NOT NULL CHECK("name"!='') UNIQUE,
   "country_id" INT REFERENCES "countries"("id")
);

--DROP TABLE "films";
CREATE TABLE "films" (
   "id" SERIAL PRIMARY KEY,
   "title" VARCHAR(100) NOT NULL CHECK("title"!='') UNIQUE,
   "yearCreate" INT NOT NULL CHECK("yearCreate" BETWEEN 1900 AND 2100)
);

--DROP TABLE "genre_to_films";
CREATE TABLE "genre_to_films" (
   "id" SERIAL PRIMARY KEY,
   "genre_id" INT REFERENCES "genres"("id"),
   "film_id" INT REFERENCES "films"("id"),
   CONSTRAINT "genre_in_film_unique" UNIQUE("genre_id","film_id")
);

--DROP TABLE "countries_to_films";
CREATE TABLE "countries_to_films"(
   "id" SERIAL PRIMARY KEY,
   "country_id" INT REFERENCES "countries"("id"),
   "film_id" INT REFERENCES "films"("id"),
   CONSTRAINT "country_in_film_unique" UNIQUE("country_id","film_id")
);

--DROP TABLE "actors";
CREATE TABLE "actors" (
   "id" SERIAL PRIMARY KEY,
   "name" VARCHAR(50) NOT NULL CHECK("name"!='') UNIQUE,
   "gender" VARCHAR(20) NOT NULL CHECK("gender" IN ('male','female'))
);

--DROP TABLE "actors_to_films";
CREATE TABLE "actors_to_films" (
   "id" SERIAL PRIMARY KEY,
   "actor_id" INT REFERENCES "actors"("id"),
   "film_id" INT REFERENCES "films"("id"),
   CONSTRAINT "actor_in_film_unique" UNIQUE("actor_id","film_id")
);

---BLOCK WITH DATA -----------------------------------------
INSERT INTO "genres"("name") 
   VALUES
      ('Thriller'),
      ('Comedy'),
      ('Action'),
      ('Drama'),
      ('Fantasy'),
      ('Horror'),
      ('Crime'),
      ('Mystery'),
      ('Adventure');

INSERT INTO "countries"("name") 
   VALUES
      ('United States'),
      ('New Zealand'),
      ('Germany'),
      ('France'),
      ('Great Britain'),
      ('Italy');

INSERT INTO "film_directors" ("name","country_id")
   VALUES
      ('Christopher Jonathan James Nolan',(SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1)),
      ('Peter Robert Jackson',(SELECT "id" FROM "countries" WHERE "name"='New Zealand' LIMIT 1)),
      ('Luc Paul Maurice Besson',(SELECT "id" FROM "countries" WHERE "name"='France' LIMIT 1)),
      ('George Walton Lucas, Jr.',(SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1)),
      ('Steven Allan Spielberg',(SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1));

INSERT INTO "films"("title","yearCreate")
   VALUES('Interstellar','2014'),
      ('The Lord of the Rings: The Fellowship of the Ring','2001'),
      ('The Lord of the Rings: The Return of the King','2003'),
      ('Léon','1994'),
      ('Star Wars Episode I: The Phantom Menace','1999'),
      ('Jurassic Park','1993');

INSERT INTO "genre_to_films"("genre_id","film_id")
   VALUES
      (
         (SELECT "id" FROM "genres" WHERE "name"='Fantasy' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Drama' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Fantasy' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Adventure' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Drama' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Fantasy' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Adventure' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Drama' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Crime' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Action' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Drama' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Fantasy' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Star Wars Episode I: The Phantom Menace' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Adventure' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Star Wars Episode I: The Phantom Menace' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Fantasy' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Jurassic Park' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "genres" WHERE "name"='Adventure' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Jurassic Park' LIMIT 1)
      );

INSERT INTO "countries_to_films"("country_id","film_id")
   VALUES
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='Great Britain' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='New Zealand' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='New Zealand' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='France' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Star Wars Episode I: The Phantom Menace' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "countries" WHERE "name"='United States' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Jurassic Park' LIMIT 1)
      );

INSERT INTO "actors"("name","gender")
   VALUES
      ('Matthew David McConaughey','male'),
      ('Anne (Annie) Jacqueline Hathaway','female'),
      ('Elijah Wood','male'),
      ('Sir Ian Murray McKellen','male'),
      ('Jean Reno','male'),
      ('Natalie Portman','female'),
      ('Ewan Gordon McGregor','male'),
      ('Jeffrey Lynn Goldblum','male');

INSERT INTO "actors_to_films"("actor_id","film_id")
   VALUES
      (
         (SELECT "id" FROM "actors" WHERE "name"='Matthew David McConaughey' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Anne (Annie) Jacqueline Hathaway' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Interstellar' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Elijah Wood' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Sir Ian Murray McKellen' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Fellowship of the Ring' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Elijah Wood' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Sir Ian Murray McKellen' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='The Lord of the Rings: The Return of the King' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Jean Reno' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Natalie Portman' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Léon' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Ewan Gordon McGregor' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Star Wars Episode I: The Phantom Menace' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Natalie Portman' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Star Wars Episode I: The Phantom Menace' LIMIT 1)
      ),
      (
         (SELECT "id" FROM "actors" WHERE "name"='Jeffrey Lynn Goldblum' LIMIT 1),
         (SELECT "id" FROM "films" WHERE "title"='Jurassic Park' LIMIT 1)
      );

DROP TABLE "messages";
CREATE TABLE "messages"(
   "id" SERIAL PRIMARY KEY,
   "uuid" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
   "body" VARCHAR(2048) NOT NULL CHECK ("body"!=''),
   "author" VARCHAR(256) NOT NULL CHECK ("author"!=''),
   "createdAt" TIMESTAMP NOT NULL DEFAULT current_timestamp,
   "isRead" BOOLEAN NOT NULL DEFAULT false
);

INSERT INTO "messages"("author","body") VALUES 
('Elon Musk','message 1'),
('Elon Musk','message 2'),
('Elon Musk','message 1');
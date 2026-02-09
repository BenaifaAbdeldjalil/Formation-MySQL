-- 1. Créer notre première base
CREATE DATABASE formation;
USE formation;

-- 2. Créer une table très simple
CREATE TABLE personnes (
    nom VARCHAR(50),
    age INT
);

-- 3. Première insertion
INSERT INTO personnes (nom, age) VALUES ('Jean', 25);

-- 4. Première lecture
SELECT * FROM personnes;

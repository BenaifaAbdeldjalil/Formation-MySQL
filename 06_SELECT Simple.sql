-- 1. Tout voir
SELECT * FROM clients;

-- 2. Colonnes spécifiques
SELECT nom, prenom, ville FROM clients;

-- 3. Avec alias (renommage)
SELECT 
    nom AS "Nom de famille",
    prenom AS "Prénom",
    ville AS "Ville"
FROM clients;


--4.2 WHERE (Conditions)

-- 1. Condition simple
SELECT * FROM clients WHERE ville = 'Paris';

-- 2. Multiple conditions
SELECT * FROM clients WHERE ville = 'Paris' AND nom LIKE 'D%';

-- 3. Opérateurs
SELECT * FROM produits WHERE prix > 100;
SELECT * FROM produits WHERE prix BETWEEN 50 AND 200;
SELECT * FROM clients WHERE ville IN ('Paris', 'Lyon');

-- 4. LIKE (recherche)
SELECT * FROM clients WHERE nom LIKE 'M%';      -- Commence par M
SELECT * FROM clients WHERE nom LIKE '%er%';    -- Contient "er"
SELECT * FROM clients WHERE nom LIKE '_e%';     -- 2e lettre = e



---4.3 ORDER BY et LIMIT

-- 1. Trier
SELECT * FROM clients ORDER BY nom ASC;    -- A à Z
SELECT * FROM produits ORDER BY prix DESC; -- Cher → Pas cher

-- 2. Trier sur plusieurs colonnes
SELECT * FROM clients ORDER BY ville, nom;

-- 3. Limiter résultats
SELECT * FROM clients LIMIT 3;                    -- 3 premiers
SELECT * FROM clients LIMIT 2, 3;                 -- 3 résultats à partir du 3ème

-- 1. COUNT - Compter
SELECT COUNT(*) FROM clients;                    -- Total clients
SELECT COUNT(*) FROM clients WHERE ville = 'Paris';  -- Clients Paris
SELECT COUNT(DISTINCT ville) FROM clients;       -- Villes différentes

-- 2. SUM - Somme
SELECT SUM(prix) FROM produits;                  -- Valeur totale produits
SELECT SUM(prix * quantite) FROM commandes c     -- Chiffre d'affaires
JOIN produits p ON c.produit_id = p.id;

-- 3. AVG - Moyenne
SELECT AVG(prix) FROM produits;                  -- Prix moyen

-- 4. MIN/MAX
SELECT MIN(prix) FROM produits;                  -- Produit moins cher
SELECT MAX(prix) FROM produits;                  -- Produit plus cher

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


-- 1. Grouper par ville
SELECT ville, COUNT(*) AS nb_clients
FROM clients
GROUP BY ville
ORDER BY nb_clients DESC;

-- 2. Grouper par catégorie
SELECT 
    categorie,
    COUNT(*) AS nb_produits,
    AVG(prix) AS prix_moyen,
    SUM(prix) AS valeur_totale
FROM produits
GROUP BY categorie;

-- 3. HAVING (filtre sur les groupes)
SELECT 
    ville,
    COUNT(*) AS nb_clients
FROM clients
GROUP BY ville
HAVING COUNT(*) >= 2;  -- Villes avec 2+ clients

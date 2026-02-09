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

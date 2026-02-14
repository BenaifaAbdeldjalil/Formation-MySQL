-- =====================================================
-- VERSION AVANCÉE : FONCTIONS ANALYTIQUES (WINDOW)
-- =====================================================


-- =====================================================
-- 1️⃣ RANK() : Classer les produits par prix
-- =====================================================

SELECT 
    nom,
    categorie,
    prix,
    RANK() OVER (ORDER BY prix DESC) AS classement_prix
FROM produits;
-- RANK() classe les produits du plus cher au moins cher
-- Les égalités donnent le même rang


-- =====================================================
-- 2️⃣ DENSE_RANK() : Classement sans "trou"
-- =====================================================

SELECT 
    nom,
    prix,
    DENSE_RANK() OVER (ORDER BY prix DESC) AS classement_dense
FROM produits;
-- DENSE_RANK() évite les sauts dans le classement


-- =====================================================
-- 3️⃣ ROW_NUMBER() : Numéro unique par ligne
-- =====================================================

SELECT 
    nom,
    categorie,
    ROW_NUMBER() OVER (PARTITION BY categorie ORDER BY prix DESC) AS numero
FROM produits;
-- PARTITION BY categorie → redémarre le compteur par catégorie
-- ROW_NUMBER() donne un numéro unique


-- =====================================================
-- 4️⃣ SUM() OVER() : Total des ventes par produit
-- =====================================================

SELECT 
    c.produit_id,
    p.nom,
    c.quantite,
    SUM(c.quantite) OVER (PARTITION BY c.produit_id) AS total_par_produit
FROM commandes c
JOIN produits p ON c.produit_id = p.id;
-- SUM() OVER() calcule le total sans GROUP BY
-- Chaque ligne garde son détail


-- =====================================================
-- 5️⃣ AVG() OVER() : Prix moyen par catégorie
-- =====================================================

SELECT 
    nom,
    categorie,
    prix,
    AVG(prix) OVER (PARTITION BY categorie) AS moyenne_categorie
FROM produits;
-- Calcule la moyenne par catégorie
-- Sans regrouper les lignes


-- =====================================================
-- 6️⃣ Comparer au prix moyen (analyse avancée)
-- =====================================================

SELECT 
    nom,
    categorie,
    prix,
    AVG(prix) OVER (PARTITION BY categorie) AS moyenne_cat,
    prix - AVG(prix) OVER (PARTITION BY categorie) AS difference
FROM produits;
-- Compare chaque produit à la moyenne de sa catégorie


-- =====================================================
-- 7️⃣ Total cumulatif des ventes (running total)
-- =====================================================

SELECT 
    date_commande,
    SUM(quantite) OVER (ORDER BY date_commande) AS cumul_ventes
FROM commandes;
-- Total progressif dans le temps


-- =====================================================
-- 8️⃣ Classement des clients par nombre de commandes
-- =====================================================

SELECT 
    client_id,
    COUNT(*) AS total_commandes,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS classement_client
FROM commandes
GROUP BY client_id;
-- Classe les clients selon leur activité


-- =====================================================
-- 9️⃣ LAG() : Voir la commande précédente
-- =====================================================

SELECT 
    date_commande,
    quantite,
    LAG(quantite) OVER (ORDER BY date_commande) AS quantite_precedente
FROM commandes;
-- LAG() permet de voir la ligne précédente


-- =====================================================
-- 🔟 LEAD() : Voir la commande suivante
-- =====================================================

SELECT 
    date_commande,
    quantite,
    LEAD(quantite) OVER (ORDER BY date_commande) AS quantite_suivante
FROM commandes;
-- LEAD() permet de voir la ligne suivante


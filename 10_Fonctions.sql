-- ==========================================
-- PLUS D'EXEMPLES : TEXTE / NOMBRE / DATE
-- ==========================================

-- =====================================================
-- 1️⃣ FONCTIONS DE TEXTE
-- =====================================================

-- Mettre les prénoms en maj
SELECT upper(prenom) AS prenom_maj
FROM clients;
-- upper() transforme le texte en maj


-- Mettre les prénoms en minuscule
SELECT LOWER(prenom) AS prenom_minuscule
FROM clients;
-- LOWER() transforme le texte en minuscule


-- Supprimer les espaces au début et à la fin
SELECT TRIM(nom) AS nom_sans_espace
FROM clients;
-- TRIM() enlève les espaces inutiles

-- Extraire les 3 premières lettres du nom
SELECT SUBSTRING(nom, 1, 4) AS debut_nom
FROM clients;
-- SUBSTRING(texte, position, longueur)

-- Remplacer "Paris" par "Lyon"
SELECT REPLACE(ville, 'Paris', 'Lyon') AS nouvelle_ville
FROM clients;
-- REPLACE(texte, ancien, nouveau)

-- Concaténer nom + prénom
SELECT CONCAT(nom, ' ', prenom) AS nom_complet
FROM clients;

SELECT CONCAT(nom, ' - ', prenom) AS nom_complet
FROM clients;
-- CONCAT() assemble plusieurs textes


-- =====================================================
-- 2️⃣ FONCTIONS DE NOMBRE
-- =====================================================

-- Arrondir vers le haut
SELECT CEIL(prix) AS prix_superieur
FROM produits;
-- CEIL() arrondit au nombre entier supérieur

-- Arrondir vers le bas
SELECT FLOOR(prix) AS prix_inferieur
FROM produits;
-- FLOOR() arrondit au nombre entier inférieur

-- Arrondir à 2 décimales
SELECT ROUND(prix, 2) AS prix_arrondi
FROM produits;
-- ROUND(nombre, decimales)

-- Valeur absolue
SELECT ABS(-25) AS valeur_absolue;
-- ABS() retourne la valeur positive

-- Tronquer sans arrondir
SELECT TRUNCATE(prix, 1) AS prix_tronque
FROM produits;
-- TRUNCATE(nombre, decimales)

-- Compter le nombre total de commandes
SELECT COUNT(*) AS total_commandes
FROM commandes;
-- COUNT() compte le nombre de lignes

-- Calculer la somme totale
SELECT SUM(prix) AS total_prix
FROM produits;
-- SUM() additionne les valeurs

-- Calculer la moyenne
SELECT AVG(prix) AS moyenne_prix
FROM produits;
-- AVG() calcule la moyenne

-- Trouver le prix minimum
SELECT MIN(prix) AS prix_minimum
FROM produits;
-- MIN() retourne la plus petite valeur

-- Trouver le prix maximum
SELECT MAX(prix) AS prix_maximum
FROM produits;
-- MAX() retourne la plus grande valeur

-- =====================================================
-- 3️⃣ FONCTIONS DE DATE
-- =====================================================
/* 
1️⃣ DATE
Format : YYYY-MM-DD
Stocke uniquement la date (année, mois, jour)
Exemple : 2026-02-22
📌 Utilisé pour : date de naissance, date de commande, etc.

2️⃣ TIME
Format : HH:MM:SS
Stocke uniquement l’heure
Exemple : 14:35:20
📌 Utilisé pour : durée, heure précise d’un événement.

3️⃣ DATETIME
Format : YYYY-MM-DD HH:MM:SS
Combine date + heure
Exemple : 2026-02-22 14:35:20
📌 Valeur fixe (ne change pas selon le fuseau horaire).

4️⃣ TIMESTAMP
Format : YYYY-MM-DD HH:MM:SS
Stocke date + heure
🔥 Se met automatiquement à jour si configuré
Dépend du fuseau horaire du serveur
*/

-- Date et heure actuelles
SELECT NOW();
-- NOW() retourne la date et l'heure actuelles

-- Date actuelle seulement
SELECT CURDATE();
-- CURDATE() retourne la date actuelle

-- Heure actuelle seulement
SELECT CURTIME();
-- CURTIME() retourne l'heure actuelle

-- Ajouter 7 jours à la date de commande
SELECT 
    date_commande,
    DATE_ADD(date_commande, INTERVAL 7 DAY) AS livraison_prevue
FROM commandes;
-- DATE_ADD() ajoute un intervalle de temps

-- Soustraire 1 mois
SELECT 
    date_commande,
    DATE_SUB(date_commande, INTERVAL 1 MONTH) AS mois_precedent
FROM commandes;
-- DATE_SUB() enlève un intervalle

-- Extraire l'année
SELECT 
    YEAR(date_commande) AS annee
FROM commandes;
-- YEAR() retourne l'année

-- Extraire le mois
SELECT 
    MONTH(date_commande) AS mois
FROM commandes;
-- MONTH() retourne le mois (1-12)

-- Extraire le nom du mois
SELECT 
    MONTHNAME(date_commande) AS nom_mois
FROM commandes;
-- MONTHNAME() retourne le nom du mois

-- Extraire le jour
SELECT 
    DAY(date_commande) AS jour
FROM commandes;
-- DAY() retourne le jour du mois

-- Extraire le jour de la semaine
SELECT 
    DAYNAME(date_commande) AS jour_semaine
FROM commandes;
-- DAYNAME() retourne le nom du jour

-- Différence entre deux dates
SELECT 
    DATEDIFF(NOW(), date_commande) AS jours_ecoules
FROM commandes;
-- DATEDIFF() retourne la différence en jours

-- Compter les commandes par année
SELECT 
    YEAR(date_commande) AS annee,
    COUNT(*) AS total
FROM commandes
GROUP BY YEAR(date_commande)
ORDER BY annee;
-- GROUP BY année

-- =====================================================
-- 4️⃣ EXEMPLE COMPLET (TEXTE + NOMBRE + DATE)
-- =====================================================

-- Total des ventes par année et catégorie
SELECT 
    YEAR(c.date_commande) AS annee,
    p.categorie,
    SUM(p.prix * c.quantite) AS total_ventes
FROM commandes c
JOIN produits p ON c.produit_id = p.id
GROUP BY annee, p.categorie
ORDER BY annee;

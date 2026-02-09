🚀 Formation My - Structure Complète et Organisée
📚 PLAN DE FORMATION STRUCTURÉ
PHASE 1 : LES BASES FONDAMENTALES (Jour 1-3)
PHASE 2 : MANIPULATION DES DONNÉES (Jour 4-6)
PHASE 3 : RELATIONS ET REQUÊTES AVANCÉES (Jour 7-9)
PHASE 4 : OPTIMISATION (Jour 10-11)
PHASE 5 : ADMINISTRATION (Jour 12-14)
📖 PHASE 1 : LES BASES FONDAMENTALES
🎯 Jour 1 : Installation & Premiers Pas
1.1 Installation Windows

-- 1. Télécharger My Installer (my.com)
-- 2. Choisir "Developer Default"
-- 3. Configurer mot de passe root (ex: Root123!)
-- 4. Installer My Workbench (interface graphique)

-- Vérification :
SELECT VERSION();  -- Doit afficher "8.0.x"
SELECT '✅ Installation réussie !' AS message;
1.2 Premier Contact avec 

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
🏗️ Jour 2 : Création de Tables Structurées
2.1 Comprendre les Types de Données

/*
Types NUMÉRIQUES :
- INT : nombre entier (-2M à +2M)
- DECIMAL(10,2) : nombre avec virgule (10 chiffres, 2 décimales)
- TINYINT : petit nombre (0 à 255)

Types TEXTE :
- VARCHAR(100) : texte jusqu'à 100 caractères
- TEXT : texte long (max 65KB)
- CHAR(10) : texte FIXE de 10 caractères

Types DATE :
- DATE : '2024-03-15'
- DATETIME : '2024-03-15 14:30:00'
- TIMESTAMP : timestamp automatique

Types SPÉCIAUX :
- BOOLEAN : TRUE/FALSE
- ENUM('val1','val2') : choix dans liste
*/
2.2 Création de Notre Base "Boutique"

-- ÉTAPE 1 : Créer la base
CREATE DATABASE boutique CHARACTER SET utf8mb4;
USE boutique;

-- ÉTAPE 2 : Table "clients" (SIMPLE version)
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    ville VARCHAR(50) DEFAULT 'Paris'
);

-- ÉTAPE 3 : Table "produits" (SIMPLE version)
CREATE TABLE produits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    categorie VARCHAR(50)
);

-- ÉTAPE 4 : Table "commandes" (SIMPLE version)
CREATE TABLE commandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    produit_id INT,
    quantite INT,
    date_commande DATE
);

-- Vérification
SHOW TABLES;
/*
clients
produits
commandes
*/
✏️ Jour 3 : Insertion de Données Logiques
3.1 Insérer dans "clients"

-- Insérer 5 clients
INSERT INTO clients (nom, prenom, email, ville) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', 'Paris'),
('Martin', 'Sophie', 'sophie.martin@email.com', 'Lyon'),
('Bernard', 'Pierre', 'pierre.bernard@email.com', 'Marseille'),
('Dubois', 'Marie', 'marie.dubois@email.com', 'Paris'),
('Petit', 'Thomas', 'thomas.petit@email.com', 'Lille');

-- Vérifier
SELECT * FROM clients;
3.2 Insérer dans "produits"

-- Insérer 5 produits
INSERT INTO produits (nom, prix, categorie) VALUES
('Ordinateur Portable', 799.99, 'Électronique'),
('Smartphone', 499.99, 'Électronique'),
('Livre ', 29.99, 'Livres'),
('Cafetière', 89.99, 'Maison'),
('Chaise Bureau', 199.99, 'Mobilier');

-- Vérifier
SELECT * FROM produits;
3.3 Insérer dans "commandes" (avec logique)

-- Commandes cohérentes :
-- Client 1 achète Produit 1
-- Client 1 achète Produit 3
-- Client 2 achète Produit 2
-- etc.

INSERT INTO commandes (client_id, produit_id, quantite, date_commande) VALUES
(1, 1, 1, '2024-03-01'),  -- Jean achète un ordinateur
(1, 3, 2, '2024-03-02'),  -- Jean achète 2 livres
(2, 2, 1, '2024-03-03'),  -- Sophie achète un smartphone
(3, 4, 1, '2024-03-04'),  -- Pierre achète une cafetière
(4, 5, 1, '2024-03-05');  -- Marie achète une chaise

-- Vérifier
SELECT * FROM commandes;
🔍 PHASE 2 : MANIPULATION DES DONNÉES
📊 Jour 4 : Consultation (SELECT) Basique
4.1 SELECT Simple

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
4.2 WHERE (Conditions)

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
4.3 ORDER BY et LIMIT

-- 1. Trier
SELECT * FROM clients ORDER BY nom ASC;    -- A à Z
SELECT * FROM produits ORDER BY prix DESC; -- Cher → Pas cher

-- 2. Trier sur plusieurs colonnes
SELECT * FROM clients ORDER BY ville, nom;

-- 3. Limiter résultats
SELECT * FROM clients LIMIT 3;                    -- 3 premiers
SELECT * FROM clients LIMIT 2, 3;                 -- 3 résultats à partir du 3ème
✏️ Jour 5 : Modifications (UPDATE/DELETE)
5.1 UPDATE Simple

-- 1. Modifier une ligne
UPDATE clients SET ville = 'Lyon' WHERE id = 1;

-- 2. Modifier plusieurs colonnes
UPDATE clients 
SET ville = 'Marseille', email = 'nouveau@email.com'
WHERE nom = 'Bernard';

-- 3. Modification avec calcul
UPDATE produits SET prix = prix * 0.9 WHERE categorie = 'Électronique';

-- 4. Toujours vérifier avant !
SELECT * FROM clients WHERE id = 1;  -- Avant
UPDATE clients SET ville = 'Lyon' WHERE id = 1;
SELECT * FROM clients WHERE id = 1;  -- Après
5.2 DELETE

-- 1. Supprimer une ligne
DELETE FROM clients WHERE id = 5;

-- 2. Supprimer avec condition
DELETE FROM commandes WHERE date_commande < '2024-01-01';

-- 3. Attention : toujours un WHERE !
-- ❌ DANGER : DELETE FROM clients;  -- Supprime TOUT

-- 4. TRUNCATE (vider table)
TRUNCATE TABLE logs_anciens;  -- Plus rapide, réinitialise auto_increment
5.3 Gestion des Erreurs Courantes

-- ERREUR : Violation de contrainte
-- Si vous essayez : 
-- DELETE FROM clients WHERE id = 1;
-- Et qu'il y a des commandes pour ce client
-- My refuse pour protéger l'intégrité

-- SOLUTION : Supprimer d'abord les commandes
DELETE FROM commandes WHERE client_id = 1;
DELETE FROM clients WHERE id = 1;
📈 Jour 6 : Agrégations Simples
6.1 Fonctions d'Agrégation

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
6.2 GROUP BY Simple

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
🔗 PHASE 3 : RELATIONS ET REQUÊTES AVANCÉES
🤝 Jour 7 : Jointures (JOIN) - Les Bases
7.1 Pourquoi les Jointures ?

-- Problème : nos commandes montrent des ID, pas des noms
SELECT * FROM commandes;
/*
id | client_id | produit_id | quantite
1  | 1         | 1          | 1
2  | 1         | 3          | 2
*/

-- Solution : JOIN pour avoir les noms
7.2 INNER JOIN (Jointure Interne)

-- 1. Commandes avec noms clients
SELECT 
    c.nom,
    c.prenom,
    cmd.date_commande,
    cmd.quantite
FROM commandes cmd
INNER JOIN clients c ON cmd.client_id = c.id;

-- 2. Commandes avec client ET produit
SELECT 
    cl.nom AS client,
    p.nom AS produit,
    c.quantite,
    p.prix,
    (p.prix * c.quantite) AS total
FROM commandes c
INNER JOIN clients cl ON c.client_id = cl.id
INNER JOIN produits p ON c.produit_id = p.id;
7.3 LEFT JOIN (Jointure Gauche)

-- 1. Tous les clients, même sans commande
SELECT 
    c.nom,
    c.prenom,
    COUNT(cmd.id) AS nb_commandes
FROM clients c
LEFT JOIN commandes cmd ON c.id = cmd.client_id
GROUP BY c.id;

-- 2. Produits jamais commandés
SELECT 
    p.nom,
    p.prix
FROM produits p
LEFT JOIN commandes c ON p.id = c.produit_id
WHERE c.id IS NULL;
7.4 RIGHT JOIN et FULL JOIN

-- RIGHT JOIN (rare) : toutes les commandes, même sans client
SELECT 
    c.nom,
    cmd.id
FROM commandes cmd
RIGHT JOIN clients c ON cmd.client_id = c.id;

-- FULL JOIN (simulé avec UNION)
SELECT * FROM clients c
LEFT JOIN commandes cmd ON c.id = cmd.client_id
UNION
SELECT * FROM clients c
RIGHT JOIN commandes cmd ON c.id = cmd.client_id;
🎯 Jour 8 : Sous-requêtes
8.1 Sous-requêtes dans WHERE

-- Clients qui ont passé commande
SELECT nom, prenom 
FROM clients 
WHERE id IN (
    SELECT DISTINCT client_id 
    FROM commandes
);

-- Produits plus chers que la moyenne
SELECT nom, prix 
FROM produits 
WHERE prix > (
    SELECT AVG(prix) 
    FROM produits
);
8.2 Sous-requêtes dans SELECT

-- Nombre de commandes par client
SELECT 
    nom,
    prenom,
    (SELECT COUNT(*) 
     FROM commandes c 
     WHERE c.client_id = cl.id) AS nb_commandes
FROM clients cl;
8.3 Sous-requêtes dans FROM

-- Statistiques par ville
SELECT 
    ville,
    moyenne_commandes
FROM (
    SELECT 
        c.ville,
        AVG(cmd_count.nb) AS moyenne_commandes
    FROM clients c
    JOIN (
        SELECT client_id, COUNT(*) as nb
        FROM commandes
        GROUP BY client_id
    ) cmd_count ON c.id = cmd_count.client_id
    GROUP BY c.ville
) AS stats_ville
WHERE moyenne_commandes > 1;
⚡ Jour 9 : Optimisation des Requêtes
9.1 EXPLAIN - Analyser une Requête

-- Voir comment My exécute la requête
EXPLAIN SELECT * FROM clients WHERE ville = 'Paris';

/*
Résultat important :
- type : ALL = scanne toute la table (mauvais)
- type : ref = utilise un index (bon)
- rows : nombre de lignes examinées
*/
9.2 Création d'Index

-- 1. Pourquoi des index ?
-- Sans index : My scanne TOUTE la table
-- Avec index : My va directement à la ligne

-- 2. Créer un index simple
CREATE INDEX idx_ville ON clients(ville);

-- 3. Vérifier
EXPLAIN SELECT * FROM clients WHERE ville = 'Paris';
-- Maintenant "type" devrait être "ref" au lieu de "ALL"

-- 4. Index sur plusieurs colonnes
CREATE INDEX idx_nom_ville ON clients(nom, ville);

-- 5. Voir tous les index
SHOW INDEX FROM clients;

-- 6. Supprimer un index
DROP INDEX idx_ville ON clients;
9.3 Index UNIQUE

-- Assure qu'une valeur est unique
CREATE UNIQUE INDEX idx_email_unique ON clients(email);

-- Test
INSERT INTO clients (nom, prenom, email) 
VALUES ('Test', 'Test', 'jean.dupont@email.com');  -- ❌ Erreur : email existe déjà
🏆 PHASE 4 : CONCEPTS AVANCÉS
🔐 Jour 10 : Clés et Contraintes
10.1 Clé Primaire (PRIMARY KEY)

-- 1. Pourquoi une clé primaire ?
-- - Identifie UNIQUEMENT chaque ligne
-- - Ne peut pas être NULL
-- - Améliore les performances

-- 2. Déclaration
CREATE TABLE employes (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Clé primaire
    nom VARCHAR(50),
    email VARCHAR(100)
);

-- 3. Ajouter après création
ALTER TABLE clients ADD PRIMARY KEY (id);

-- 4. Clé primaire composite (2 colonnes)
CREATE TABLE commandes_details (
    commande_id INT,
    produit_id INT,
    quantite INT,
    PRIMARY KEY (commande_id, produit_id)  -- Les deux ensemble sont uniques
);
10.2 Clés Étrangères (FOREIGN KEY)

-- 1. Ajouter des clés étrangères à notre table commandes
ALTER TABLE commandes
ADD FOREIGN KEY (client_id) REFERENCES clients(id)
ON DELETE CASCADE;  -- Si client supprimé, ses commandes aussi

ALTER TABLE commandes
ADD FOREIGN KEY (produit_id) REFERENCES produits(id)
ON DELETE RESTRICT;  -- Empêche suppression produit commandé

-- 2. Tester
-- Essaie de supprimer un client avec commande :
DELETE FROM clients WHERE id = 1;  -- ✅ Fonctionne (CASCADE)

-- Essaie de supprimer un produit commandé :
DELETE FROM produits WHERE id = 1;  -- ❌ Échec (RESTRICT)

-- 3. Voir les contraintes
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'boutique';
10.3 Autres Contraintes

-- 1. NOT NULL
CREATE TABLE personnes (
    nom VARCHAR(50) NOT NULL,  -- Doit avoir une valeur
    age INT NULL               -- Peut être vide (par défaut)
);

-- 2. CHECK (My 8.0+)
CREATE TABLE produits_avances (
    id INT PRIMARY KEY,
    prix DECIMAL(10,2) CHECK (prix > 0),  -- Prix doit être > 0
    stock INT CHECK (stock >= 0)          -- Stock ne peut pas être négatif
);

-- 3. DEFAULT
CREATE TABLE commandes_avances (
    id INT PRIMARY KEY,
    statut VARCHAR(20) DEFAULT 'en_attente',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
                         ON UPDATE CURRENT_TIMESTAMP  -- Auto-mise à jour
);
📊 Jour 11 : Vues et Procédures Simples
11.1 Vues (VIEW) - Tables Virtuelles

-- 1. Créer une vue pour les commandes détaillées
CREATE VIEW vue_commandes_detaillees AS
SELECT 
    c.nom AS client_nom,
    c.prenom AS client_prenom,
    p.nom AS produit_nom,
    p.prix,
    cmd.quantite,
    (p.prix * cmd.quantite) AS total,
    cmd.date_commande
FROM commandes cmd
JOIN clients c ON cmd.client_id = c.id
JOIN produits p ON cmd.produit_id = p.id;

-- 2. Utiliser la vue comme une table
SELECT * FROM vue_commandes_detaillees;
SELECT client_nom, SUM(total) FROM vue_commandes_detaillees GROUP BY client_nom;

-- 3. Voir les vues existantes
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 4. Supprimer une vue
DROP VIEW IF EXISTS vue_commandes_detaillees;
11.2 Procédures Stockées Simples

-- 1. Créer une procédure pour ajouter un client
DELIMITER $$

CREATE PROCEDURE ajouter_client(
    IN p_nom VARCHAR(50),
    IN p_prenom VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_ville VARCHAR(50)
)
BEGIN
    INSERT INTO clients (nom, prenom, email, ville)
    VALUES (p_nom, p_prenom, p_email, p_ville);
    
    SELECT 'Client ajouté avec succès' AS message;
END$$

DELIMITER ;

-- 2. Exécuter la procédure
CALL ajouter_client('Leroy', 'Paul', 'paul@email.com', 'Lyon');

-- 3. Vérifier
SELECT * FROM clients WHERE nom = 'Leroy';

-- 4. Voir les procédures
SHOW PROCEDURE STATUS WHERE Db = 'boutique';
👨‍💼 PHASE 5 : ADMINISTRATION
🔧 Jour 12 : Administration Basique
12.1 Gestion des Utilisateurs

-- 1. Se connecter en tant que root d'abord
-- my -u root -p

-- 2. Créer un utilisateur administrateur
CREATE USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'AdminP@ss123!';

-- 3. Donner tous les droits sur la boutique
GRANT ALL PRIVILEGES ON boutique.* 
TO 'admin_boutique'@'localhost';

-- 4. Créer un utilisateur "lecture seule"
CREATE USER 'consultant'@'localhost' 
IDENTIFIED BY 'Consultant456!';

GRANT SELECT ON boutique.* 
TO 'consultant'@'localhost';

-- 5. Créer un utilisateur pour une table spécifique
CREATE USER 'gestion_clients'@'localhost' 
IDENTIFIED BY 'Clients789!';

GRANT SELECT, INSERT, UPDATE ON boutique.clients 
TO 'gestion_clients'@'localhost';

-- 6. Voir les permissions
SHOW GRANTS FOR 'admin_boutique'@'localhost';

-- 7. Révoquer des permissions
REVOKE DELETE ON boutique.* FROM 'gestion_clients'@'localhost';

-- 8. Supprimer un utilisateur
DROP USER 'consultant'@'localhost';

-- 9. Changer mot de passe
ALTER USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'NouveauP@ss789!';

📈 Jour 13 : Monitoring et Performance
13.1 Voir l'État du Serveur

-- 1. Variables de configuration
SHOW VARIABLES LIKE '%buffer%';
SHOW VARIABLES LIKE '%cache%';

-- 2. Statut du serveur
SHOW STATUS LIKE 'Threads_connected';  -- Connexions actuelles
SHOW STATUS LIKE 'Queries%';           -- Requêtes exécutées

-- 3. Processus en cours
SHOW PROCESSLIST;

-- 4. Taille des bases/tables
SELECT 
    table_schema AS 'Base',
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Taille (MB)'
FROM information_schema.tables
WHERE table_schema = 'boutique'
ORDER BY (data_length + index_length) DESC;

-- 5. Index non utilisés (pour nettoyage)
SELECT 
    object_schema,
    object_name,
    index_name
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE index_name IS NOT NULL
AND count_star = 0  -- Index jamais utilisé
ORDER BY object_schema, object_name;
13.2 Optimisation des Tables

-- 1. Analyser une table (met à jour les statistiques)
ANALYZE TABLE clients;

-- 2. Réparer une table (si corruption)
REPAIR TABLE clients;

-- 3. Optimiser une table (défragmentation)
OPTIMIZE TABLE clients;

-- 4. Vérifier une table
CHECK TABLE clients;

-- 5. Convertir un moteur de table
ALTER TABLE clients ENGINE = InnoDB;
🎓 Jour 14 : Projet Final & Bonnes Pratiques
14.1 Projet : Système de Gestion d'École

-- 1. Création de la base
CREATE DATABASE gestion_ecole CHARACTER SET utf8mb4;
USE gestion_ecole;

-- 2. Table élèves
CREATE TABLE eleves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    classe_id INT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nom (nom),
    INDEX idx_classe (classe_id)
);

-- 3. Table classes
CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE,
    niveau VARCHAR(20),
    professeur_principal VARCHAR(100)
);

-- 4. Table matières
CREATE TABLE matieres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    coefficient INT DEFAULT 1
);

-- 5. Table notes
CREATE TABLE notes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    eleve_id INT NOT NULL,
    matiere_id INT NOT NULL,
    note DECIMAL(4,2) CHECK (note BETWEEN 0 AND 20),
    date_note DATE DEFAULT (CURRENT_DATE),
    commentaire TEXT,
    FOREIGN KEY (eleve_id) REFERENCES eleves(id),
    FOREIGN KEY (matiere_id) REFERENCES matieres(id),
    INDEX idx_eleve (eleve_id),
    INDEX idx_matiere (matiere_id)
);

-- 6. Insertion de données cohérentes
INSERT INTO classes (nom, niveau) VALUES 
('6ème A', '6ème'),
('5ème B', '5ème'),
('4ème A', '4ème');

INSERT INTO eleves (nom, prenom, date_naissance, classe_id) VALUES
('Dupont', 'Jean', '2012-05-15', 1),
('Martin', 'Sophie', '2011-08-22', 2),
('Bernard', 'Pierre', '2010-11-30', 3);

INSERT INTO matieres (nom, coefficient) VALUES
('Mathématiques', 3),
('Français', 2),
('Histoire-Géo', 1);

INSERT INTO notes (eleve_id, matiere_id, note) VALUES
(1, 1, 15.5),
(1, 2, 12.0),
(2, 1, 18.0),
(3, 3, 14.5);

-- 7. Requêtes pratiques
-- Moyenne par élève
SELECT 
    e.nom,
    e.prenom,
    ROUND(AVG(n.note), 2) AS moyenne_generale
FROM eleves e
JOIN notes n ON e.id = n.eleve_id
GROUP BY e.id
ORDER BY moyenne_generale DESC;

-- Moyenne par classe
SELECT 
    c.nom AS classe,
    ROUND(AVG(n.note), 2) AS moyenne_classe
FROM classes c
JOIN eleves e ON c.id = e.classe_id
JOIN notes n ON e.id = n.eleve_id
GROUP BY c.id;

-- Meilleur élève par matière
SELECT 
    m.nom AS matiere,
    e.nom,
    e.prenom,
    MAX(n.note) AS meilleure_note
FROM matieres m
JOIN notes n ON m.id = n.matiere_id
JOIN eleves e ON n.eleve_id = e.id
GROUP BY m.id;
14.2 Checklist des Bonnes Pratiques

-- ✅ TOUJOURS :
-- 1. Utiliser des noms explicites (pas de noms courts)
-- 2. Préfixer les clés étrangères : table_id
-- 3. Utiliser UTF8MB4 pour les caractères spéciaux
-- 4. Ajouter des commentaires aux tables/colonnes
-- 5. Utiliser les contraintes (NOT NULL, CHECK, etc.)

-- ✅ POUR LES PERFORMANCES :
-- 1. Indexer les colonnes utilisées dans WHERE/JOIN
-- 2. Éviter SELECT * (choisir les colonnes nécessaires)
-- 3. Utiliser LIMIT sur les grandes tables
-- 4. Analyser les requêtes avec EXPLAIN

-- ✅ POUR LA SÉCURITÉ :
-- 1. Créer des utilisateurs avec le minimum de permissions
-- 2. Ne jamais utiliser 'root' pour l'application
-- 3. Faire des backups réguliers
-- 4. Hasher les mots de passe (pas en clair!)

-- ✅ POUR LA MAINTENANCE :
-- 1. Documenter la structure de la base
-- 2. Garder un fichier de création (schema.)
-- 3. Versionner la base avec Git
-- 4. Monitorer les performances régulièrement
14.3 Ressources pour Aller Plus Loin

-- 1. Documentation officielle : dev.my.com/doc/
-- 2. My Workbench : Interface graphique gratuite
-- 3. phpMyAdmin : Administration web
-- 4. Cours avancés : 
--    - Réplication My
--    - Partitionnement
--    - Clustering
--    - Optimisation avancée

-- Dernière vérification de nos compétences :
SELECT '🎉 FORMATION TERMINÉE AVEC SUCCÈS !' AS felicitations;
SELECT 'Vous maîtrisez maintenant :' AS competences;
SELECT '- Installation et configuration' AS item
UNION SELECT '- Création de bases/tables'
UNION SELECT '- Insertion/modification données'
UNION SELECT '- Requêtes simples et complexes'
UNION SELECT '- Jointures et agrégations'
UNION SELECT '- Index et optimisation'
UNION SELECT '- Clés et contraintes'
UNION SELECT '- Administration basique'
UNION SELECT '- Bonnes pratiques';
📞 Support et Questions
Problèmes Courants et Solutions :

-- Problème : "Access denied for user"
-- Solution : Vérifier nom utilisateur/mot de passe
-- Commande : my -u root -p

-- Problème : "Table doesn't exist"
-- Solution : Vérifier qu'on est dans la bonne base
-- Commande : USE nom_base; SHOW TABLES;

-- Problème : "Error 1064: Syntax error"
-- Solution : Vérifier les guillemets, virgules, parenthèses
-- Astuce : Copier-coller dans My Workbench pour coloration syntaxique

-- Problème : "Lock wait timeout exceeded"
-- Solution : Une transaction bloque une autre
-- Commande : SHOW PROCESSLIST; KILL id_process;
Pour Pratiquer en Ligne :
 Fiddle : fiddle.com

DB Fiddle : db-fiddle.com

W3Schools  Tryit : w3schools.com//try.asp

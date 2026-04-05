/* =========================================================
   TP COMPLET MYSQL - SHOP TRAINING
   Objectif :
   - Créer une base de données
   - Créer un utilisateur
   - Créer les tables
   - Insérer des données
   - Faire des requêtes
   - Créer des vues
   ========================================================= */

/* =========================================================
   1) CREATION DE LA BASE DE DONNEES
   ========================================================= */
CREATE DATABASE IF NOT EXISTS shop_training;
USE shop_training;

/* =========================================================
   2) CREATION DE L'UTILISATEUR ET DES DROITS
   ========================================================= */
CREATE USER IF NOT EXISTS 'training_user'@'localhost' IDENTIFIED BY 'StrongPass123!';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX
ON shop_training.*
TO 'training_user'@'localhost';

FLUSH PRIVILEGES;

-- Vérification des droits
SHOW GRANTS FOR 'training_user'@'localhost';

/* =========================================================
   3) SUPPRESSION DES TABLES SI ELLES EXISTENT DEJA
   (ordre inverse des dépendances)
   ========================================================= */
DROP TABLE IF EXISTS detail_commandes;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS clients;

/* =========================================================
   4) CREATION DES TABLES
   ========================================================= */

-- Table des clients
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telephone VARCHAR(20),
    ville VARCHAR(100),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des catégories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL UNIQUE
);

-- Table des produits
CREATE TABLE produits (
    produit_id INT AUTO_INCREMENT PRIMARY KEY,
    nom_produit VARCHAR(150) NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id INT,
    CONSTRAINT fk_produits_categories
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Table des commandes
CREATE TABLE commandes (
    commande_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    statut VARCHAR(30) NOT NULL DEFAULT 'en_attente',
    CONSTRAINT fk_commandes_clients
        FOREIGN KEY (client_id) REFERENCES clients(client_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Table du détail des commandes
CREATE TABLE detail_commandes (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_detail_commandes_commandes
        FOREIGN KEY (commande_id) REFERENCES commandes(commande_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_commandes_produits
        FOREIGN KEY (produit_id) REFERENCES produits(produit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* =========================================================
   5) INSERTION DES DONNEES
   ========================================================= */

-- Insertion des catégories
INSERT INTO categories (nom_categorie) VALUES
('Informatique'),
('Téléphonie'),
('Accessoires'),
('Bureautique');

-- Insertion des clients
INSERT INTO clients (nom, prenom, email, telephone, ville) VALUES
('Ben Ali', 'Sami', 'sami@example.com', '0600000001', 'Paris'),
('El Amrani', 'Nadia', 'nadia@example.com', '0600000002', 'Lyon'),
('Dupont', 'Karim', 'karim@example.com', '0600000003', 'Tours'),
('Benaifa', 'Meriem', 'meriem@example.com', '0600000004', 'Marseille');

-- Insertion des produits
INSERT INTO produits (nom_produit, prix, stock, category_id) VALUES
('Clavier mécanique', 59.90, 20, 3),
('Souris sans fil', 25.50, 35, 3),
('Écran 24 pouces', 149.99, 10, 1),
('Smartphone X', 699.00, 8, 2),
('Imprimante laser', 199.90, 6, 4),
('Casque Bluetooth', 89.99, 15, 3);

-- Insertion des commandes
INSERT INTO commandes (client_id, date_commande, statut) VALUES
(1, '2026-04-01', 'validée'),
(2, '2026-04-02', 'validée'),
(1, '2026-04-03', 'en_attente'),
(3, '2026-04-04', 'expédiée');

-- Insertion du détail des commandes
INSERT INTO detail_commandes (commande_id, produit_id, quantite, prix_unitaire) VALUES
(1, 1, 2, 59.90),
(1, 2, 1, 25.50),
(2, 4, 1, 699.00),
(3, 3, 2, 149.99),
(4, 5, 1, 199.90),
(4, 6, 2, 89.99);

/* =========================================================
   6) REQUETES SIMPLES
   ========================================================= */

-- Tous les clients
SELECT * FROM clients;

-- Produits dont le prix est supérieur à 50
SELECT * FROM produits
WHERE prix > 50;

-- Produits triés par prix décroissant
SELECT * FROM produits
ORDER BY prix DESC;

-- Clients habitant à Paris
SELECT * FROM clients
WHERE ville = 'Paris';

-- Produits avec stock faible
SELECT * FROM produits
WHERE stock < 10;

/* =========================================================
   7) JOINTURES
   ========================================================= */

-- Commandes avec les informations client
SELECT c.commande_id, c.date_commande, c.statut,
       cl.nom, cl.prenom
FROM commandes c
JOIN clients cl ON c.client_id = cl.client_id;

-- Détail des commandes avec les produits
SELECT dc.detail_id, dc.commande_id, p.nom_produit, dc.quantite, dc.prix_unitaire
FROM detail_commandes dc
JOIN produits p ON dc.produit_id = p.produit_id;

-- Vue complète des commandes
SELECT c.commande_id, cl.nom, cl.prenom, p.nom_produit,
       dc.quantite, dc.prix_unitaire,
       (dc.quantite * dc.prix_unitaire) AS total_ligne
FROM detail_commandes dc
JOIN commandes c ON dc.commande_id = c.commande_id
JOIN clients cl ON c.client_id = cl.client_id
JOIN produits p ON dc.produit_id = p.produit_id;

/* =========================================================
   8) AGRÉGATIONS
   ========================================================= */

-- Nombre total de clients
SELECT COUNT(*) AS total_clients
FROM clients;

-- Prix moyen des produits
SELECT AVG(prix) AS prix_moyen
FROM produits;

-- Total des ventes par commande
SELECT c.commande_id,
       SUM(dc.quantite * dc.prix_unitaire) AS total_commande
FROM commandes c
JOIN detail_commandes dc ON c.commande_id = dc.commande_id
GROUP BY c.commande_id;

-- Nombre de produits par catégorie
SELECT cat.nom_categorie, COUNT(*) AS nb_produits
FROM categories cat
LEFT JOIN produits p ON cat.category_id = p.category_id
GROUP BY cat.nom_categorie;

-- Total acheté par client
SELECT cl.nom, cl.prenom,
       SUM(dc.quantite * dc.prix_unitaire) AS total_achete
FROM clients cl
JOIN commandes c ON cl.client_id = c.client_id
JOIN detail_commandes dc ON c.commande_id = dc.commande_id
GROUP BY cl.client_id, cl.nom, cl.prenom;

/* =========================================================
   9) REQUETES AVANCEES
   ========================================================= */

-- Clients ayant passé au moins une commande
SELECT DISTINCT cl.*
FROM clients cl
JOIN commandes c ON cl.client_id = c.client_id;

-- Produits jamais commandés
SELECT p.*
FROM produits p
LEFT JOIN detail_commandes dc ON p.produit_id = dc.produit_id
WHERE dc.produit_id IS NULL;

-- Commandes contenant plus d'un produit
SELECT commande_id, COUNT(*) AS nb_lignes
FROM detail_commandes
GROUP BY commande_id
HAVING COUNT(*) > 1;

-- Catégorie la plus vendue
SELECT cat.nom_categorie,
       SUM(dc.quantite) AS quantite_totale
FROM categories cat
JOIN produits p ON cat.category_id = p.category_id
JOIN detail_commandes dc ON p.produit_id = dc.produit_id
GROUP BY cat.nom_categorie
ORDER BY quantite_totale DESC
LIMIT 1;

/* =========================================================
   10) VUES
   ========================================================= */

-- Vue des commandes détaillées
CREATE OR REPLACE VIEW vue_commandes_detaillees AS
SELECT c.commande_id, c.date_commande, c.statut,
       cl.nom, cl.prenom,
       p.nom_produit,
       dc.quantite,
       dc.prix_unitaire,
       (dc.quantite * dc.prix_unitaire) AS total_ligne
FROM detail_commandes dc
JOIN commandes c ON dc.commande_id = c.commande_id
JOIN clients cl ON c.client_id = cl.client_id
JOIN produits p ON dc.produit_id = p.produit_id;

-- Utilisation de la vue
SELECT * FROM vue_commandes_detaillees;

-- Vue des ventes par client
CREATE OR REPLACE VIEW vue_ventes_clients AS
SELECT cl.client_id, cl.nom, cl.prenom,
       SUM(dc.quantite * dc.prix_unitaire) AS total_achats
FROM clients cl
JOIN commandes c ON cl.client_id = c.client_id
JOIN detail_commandes dc ON c.commande_id = dc.commande_id
GROUP BY cl.client_id, cl.nom, cl.prenom;

SELECT * FROM vue_ventes_clients;

/* =========================================================
   11) MISES A JOUR
   ========================================================= */

-- Diminuer le stock d'un produit après vente
UPDATE produits
SET stock = stock - 2
WHERE produit_id = 1;

-- Modifier le statut d'une commande
UPDATE commandes
SET statut = 'expédiée'
WHERE commande_id = 3;

/* =========================================================
   12) SUPPRESSION
   ========================================================= */

-- Supprimer un client
DELETE FROM clients
WHERE client_id = 4;

/* =========================================================
   13) EXERCICE FINAL
   =========================================================
   Créer une requête qui affiche :
   - nom et prénom du client
   - nombre de commandes
   - total dépensé
   - ville
   - statut de la dernière commande
   ========================================================= */
/* =========================================================
   14) TABLE DE LOG POUR LES MISES A JOUR
   ========================================================= */

-- Table de journalisation des modifications sur les produits
CREATE TABLE IF NOT EXISTS produits_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    produit_id INT NOT NULL,
    ancien_nom_produit VARCHAR(150),
    nouveau_nom_produit VARCHAR(150),
    ancien_prix DECIMAL(10,2),
    nouveau_prix DECIMAL(10,2),
    ancien_stock INT,
    nouveau_stock INT,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    operation VARCHAR(20) NOT NULL
);

/* =========================================================
   15) TRIGGER DE LOG SUR LES MISES A JOUR
   ========================================================= */

DELIMITER $$

CREATE TRIGGER trg_produits_after_update
AFTER UPDATE ON produits
FOR EACH ROW
BEGIN
    INSERT INTO produits_log (
        produit_id,
        ancien_nom_produit,
        nouveau_nom_produit,
        ancien_prix,
        nouveau_prix,
        ancien_stock,
        nouveau_stock,
        operation
    )
    VALUES (
        OLD.produit_id,
        OLD.nom_produit,
        NEW.nom_produit,
        OLD.prix,
        NEW.prix,
        OLD.stock,
        NEW.stock,
        'UPDATE'
    );
END$$

DELIMITER ;

/* =========================================================
   16) TEST DU TRIGGER
   ========================================================= */

-- Exemple de mise à jour d'un produit
UPDATE produits
SET prix = 64.90,
    stock = 18
WHERE produit_id = 1;

-- Vérifier le contenu du log
SELECT * FROM produits_log;

/* =========================================================
   17) SOLUTION DE L'EXERCICE FINAL
   Objectif :
   afficher :
   - nom du client
   - prénom
   - nombre de commandes
   - total dépensé
   - ville
   - statut de la dernière commande
   ========================================================= */

SELECT
    cl.client_id,
    cl.nom,
    cl.prenom,
    cl.ville,
    COUNT(DISTINCT c.commande_id) AS nombre_commandes,
    COALESCE(SUM(dc.quantite * dc.prix_unitaire), 0) AS total_depense,
    (
        SELECT c2.statut
        FROM commandes c2
        WHERE c2.client_id = cl.client_id
        ORDER BY c2.date_commande DESC, c2.commande_id DESC
        LIMIT 1
    ) AS statut_derniere_commande
FROM clients cl
LEFT JOIN commandes c
    ON cl.client_id = c.client_id
LEFT JOIN detail_commandes dc
    ON c.commande_id = dc.commande_id
GROUP BY cl.client_id, cl.nom, cl.prenom, cl.ville
ORDER BY total_depense DESC, nombre_commandes DESC;

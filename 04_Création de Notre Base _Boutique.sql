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

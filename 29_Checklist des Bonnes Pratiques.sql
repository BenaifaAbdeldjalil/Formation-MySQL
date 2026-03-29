-- ✅ TOUJOURS :
-- 1. Utiliser des noms explicites (pas de noms courts)
-- 2. Préfixer les clés étrangères : table_id
-- 3. Utiliser UTF8MB4 pour les caractères spéciaux
-- 4. Ajouter des commentaires aux tables/colonnes
-- 1. Ajouter un commentaire sur la colonne id (clé primaire)
ALTER TABLE boutique.clients
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT
COMMENT 'Identifiant unique du client (clé primaire auto-incrémentée)';

-- 2. Ajouter un commentaire sur la colonne nom
ALTER TABLE boutique.clients
MODIFY COLUMN nom VARCHAR(50) DEFAULT NULL
COMMENT 'Nom de famille du client';

-- 3. Ajouter un commentaire sur la colonne prenom
ALTER TABLE boutique.clients
MODIFY COLUMN prenom VARCHAR(50) DEFAULT NULL
COMMENT 'Prénom du client';

-- 4. Ajouter un commentaire sur la colonne email
ALTER TABLE boutique.clients
MODIFY COLUMN email VARCHAR(100) DEFAULT NULL
COMMENT 'Adresse email principale du client (optionnelle)';

-- 5. Ajouter un commentaire sur la colonne ville
ALTER TABLE boutique.clients
MODIFY COLUMN ville VARCHAR(50) DEFAULT 'Paris'
COMMENT 'Ville de résidence du client (par défaut Paris)';

-- 6. (optionnel) Ajouter un commentaire sur la table elle‑même
ALTER TABLE boutique.clients
COMMENT = 'Table des clients du système de vente (boutique)';



-- 5. Utiliser les contraintes (NOT NULL, CHECK, etc.)

-- ✅ POUR LES PERFORMANCES :
-- 1. Indexer les colonnes utilisées dans WHERE/JOIN
-- 2. Éviter SELECT * (choisir les colonnes nécessaires)

SELECT *
FROM boutique.clients;

SELECT id, nom, prenom, email, ville
FROM boutique.clients;

-- 3. Utiliser LIMIT sur les grandes tables


SELECT id, nom, prenom, email, ville
FROM boutique.clients
limit 5;


-- 4. Analyser les requêtes avec EXPLAIN

explain SELECT id, nom, prenom, email, ville
FROM boutique.clients
limit 5;


-- ✅ POUR LA SÉCURITÉ :
-- 1. Créer des utilisateurs avec le minimum de permissions
-- 2. Ne jamais utiliser 'root' pour l'application
-- 3. Faire des backups réguliers
-- 4. Hasher les mots de passe (pas en clair!)

-- ✅ POUR LA MAINTENANCE :
-- 1. Documenter la structure de la base
-- 2. Garder un fichier de création (schema.sql)
-- 3. Versionner la base
-- 4. Monitorer les performances régulièrement

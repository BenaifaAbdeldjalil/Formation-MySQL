

/*
====================================================
MODIFICATIONS AVEC ALTER TABLE
====================================================
*/

-- 1️⃣ Ajouter une colonne telephone dans clients
ALTER TABLE clients
ADD telephone VARCHAR(20);

-- 2️⃣ Modifier la taille du champ nom
ALTER TABLE clients
MODIFY nom VARCHAR(100) NOT NULL;

-- 3️⃣ Ajouter une colonne stock dans produits
ALTER TABLE produits
ADD stock INT DEFAULT 0;

-- 4️⃣ Modifier la précision du prix
ALTER TABLE produits
MODIFY prix DECIMAL(12,2) NOT NULL;

-- 5️⃣ Ajouter contrainte NOT NULL sur quantite
ALTER TABLE commandes
MODIFY quantite INT NOT NULL;


/*
====================================================
RETOUR À L'ÉTAT INITIAL (ANNULER LES ALTER)
====================================================
*/

-- Supprimer colonne telephone
ALTER TABLE clients
DROP COLUMN telephone;

-- Remettre taille originale du nom
ALTER TABLE clients
MODIFY nom VARCHAR(50) NOT NULL;

-- Supprimer colonne stock
ALTER TABLE produits
DROP COLUMN stock;

-- Remettre précision originale du prix
ALTER TABLE produits
MODIFY prix DECIMAL(10,2) NOT NULL;

-- Retirer NOT NULL sur quantite
ALTER TABLE commandes
MODIFY quantite INT;


/*
====================================================
OPTION RADICALE (RETOUR TOTAL)
====================================================
Si tu veux revenir 100% proprement à l’état initial,
tu peux supprimer les tables puis les recréer.
*/

-- DROP TABLE commandes;
-- DROP TABLE produits;
-- DROP TABLE clients;

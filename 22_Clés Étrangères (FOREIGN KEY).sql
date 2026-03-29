/* ==============================================================================
   Relations entre clés primaires et clés étrangères – Histoire pédagogique
   Schéma : boutique
   Tables : clients, commandes, commandes_details, produits
   Objectif :
   - créer ou vérifier les PK si elles n’existent pas,
   - ajouter des FK qui se rattachent à ces PK,
   - tester les règles ON DELETE,
   - voir les contraintes dans INFORMATION_SCHEMA.
================================================================================= */



/* ==============================================================================
   Chapitre 1 — Vérifier / créer les clés primaires (PK)
=================================================================================

   Analyse des tables fournies :
   - `clients` a déjà une PK : PRIMARY KEY (id),
   - `commandes_details` a une PK composée : PRIMARY KEY (commande_id, produit_id),
   - `commandes` et `produits` n’ont pas encore de PK déclarée dans la DDL fournie.

   D’abord, on s’assure que chaque table importante a une clé primaire.
*/

-- 1. Ajouter une clé primaire sur la table commandes
-- (ici id est NULL par défaut dans la DDL, donc on ajuste la colonne id)
ALTER TABLE commandes
MODIFY COLUMN id INT NOT NULL;

ALTER TABLE commandes
ADD PRIMARY KEY (id);

-- 2. Ajouter une clé primaire sur la table produits
ALTER TABLE produits
MODIFY COLUMN id INT NOT NULL;

ALTER TABLE produits
ADD PRIMARY KEY (id);

/* 
   Maintenant :
   - clients.id            → PK de la table clients,
   - produits.id           → PK de la table produits,
   - commandes.id          → PK de la table commandes,
   - commandes_details    → PK (commande_id, produit_id).

   On a des PK “stables” pour créer les FK.
*/



/* ==============================================================================
   Chapitre 2 — Ajouter des clés étrangères
=================================================================================

   On ajoute les FK qui se relient aux PK créées ou déjà existantes.
*/

-- 1. FK de commande.client_id vers clients.id (PK de clients)
ALTER TABLE commandes
ADD FOREIGN KEY (client_id) REFERENCES clients(id)
ON DELETE CASCADE;  -- Si un client est supprimé, ses commandes sont supprimées

-- 2. FK de commande.produit_id vers produits.id (PK de produits)
ALTER TABLE commandes
ADD FOREIGN KEY (produit_id) REFERENCES produits(id)
ON DELETE RESTRICT; -- Empêche la suppression d’un produit commandé

-- 3. FK de commandes_details.commande_id vers commandes.id (PK de commandes)
ALTER TABLE commandes_details
ADD FOREIGN KEY (commande_id) REFERENCES commandes(id)
ON DELETE CASCADE;  -- Si une commande est supprimée, ses lignes de détail aussi

-- 4. FK de commandes_details.produit_id vers produits.id (PK de produits)
ALTER TABLE commandes_details
ADD FOREIGN KEY (produit_id) REFERENCES produits(id)
ON DELETE RESTRICT; -- Empêche la suppression d’un produit avec des détails de commande

/* 
   Ici, chaque FK fait référence à une **colonne PK** :
   - client_id → clients.id,
   - produit_id → produits.id,
   - commande_id → commandes.id.

   On peut donc déjà imaginer un mini schéma de navigation :
   clients → commandes → commandes_details
                             ↑
                             +— produits
*/



/* ==============================================================================
   Chapitre 3 — Tester les comportements des clés étrangères
=================================================================================

   On insère d’abord des données cohérentes, puis on teste les effets de DELETE.
*/

-- 1. Ajouter quelques clients (id, PK déjà définie)
INSERT INTO clients (id, nom, prenom, email, ville) VALUES
(1, 'Dupont', 'Marie', 'marie.dupont@mail.com', 'Paris'),
(2, 'Durand', 'Jean', 'jean.durand@mail.com', 'Lyon');

-- 2. Ajouter des produits (id, PK désormais définie)
INSERT INTO produits (id, nom, prix, categorie) VALUES
(1, 'Téléphone', 399.99, 'Électronique'),
(2, 'Ordinateur', 899.99, 'Informatique'),
(3, 'Clavier', 49.99, 'Accessoires');

-- 3. Ajouter des commandes (FK client_id / produit_id respectées)
INSERT INTO commandes (id, client_id, produit_id, quantite, date_commande) VALUES
(1, 1, 1, 2, '2025-03-01'),
(2, 1, 2, 1, '2025-03-02'),
(3, 2, 1, 1, '2025-03-02');

-- 4. Ajouter des détails de commande (FK commande_id / produit_id respectées)
INSERT INTO commandes_details (commande_id, produit_id, quantite) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1);

/* 
   Maintenant, on teste les contraintes.
*/

-- 1. Tester ON DELETE CASCADE sur la table clients
DELETE FROM clients WHERE id = 1; -- ✅ CASCADE : les commandes et les détails liés sont aussi supprimés

-- 2. Tester ON DELETE RESTRICT sur la table produits
DELETE FROM produits WHERE id = 1; -- ❌ Échoue : RESTRICT bloque la suppression (produit encore référencé)

-- 3. Tester ON DELETE CASCADE sur la table commandes
DELETE FROM commandes WHERE id = 2; -- ✅ CASCADE : les lignes de commandes_details associées sont aussi supprimées



/* ==============================================================================
   Chapitre 4 — Voir les contraintes (PK ↔ FK liés)
=================================================================================

   On vérifie que les FK pointent bien vers les colonnes PK.
*/

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'boutique'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

/* 
   Points à repérer :
   - clients.id (PK) → cible de client_id dans commandes,
   - produits.id (PK) → cible de produit_id dans commandes et commandes_details,
   - commandes.id (PK) → cible de commande_id dans commandes_details.

   On voit clairement la chaîne de dépendance :
   clients ↔ commandes ↔ commandes_details
      ↑                    ↓
      └──────── produits ─┘
*/



/* ==============================================================================
   Chapitre 5 — Résumé : PK existantes vs PK ajoutées
=================================================================================

   Dans ce scénario :
   - `clients` et `commandes_details` ont déjà des PK dans la DDL fournie,
   - `commandes` et `produits` n’ont pas de PK explicite au départ,
     donc on a dû :
        1. modifier les colonnes id pour qu’elles soient NOT NULL,
        2. ajouter une PRIMARY KEY (id).

   C’est seulement après avoir **créé / sécurisé les PK** qu’on a pu :
   - ajouter les FK,
   - appliquer les règles ON DELETE (CASCADE, RESTRICT),
   - tester les suppressions propres et cohérentes.

   En résumé :
   - une FK suppose toujours une colonne d’arrivée **indexée (PK ou UNIQUE)**,
   - si la PK n’existe pas dans la table cible, il faut la créer ou la modifier d’abord.
*/



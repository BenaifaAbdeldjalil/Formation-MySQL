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

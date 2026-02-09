-- 1. Pourquoi des index ?
-- Sans index : MySQL scanne TOUTE la table
-- Avec index : MySQL va directement à la ligne

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

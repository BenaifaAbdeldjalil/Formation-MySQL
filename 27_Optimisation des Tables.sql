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

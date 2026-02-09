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

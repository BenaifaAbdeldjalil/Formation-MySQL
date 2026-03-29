/* ==============================================================================
   Administration MySQL – Diagnostic, performance et maintenance
   Base : boutique
-------------------------------------------------------------------------------
   Objectif :
   - comprendre la configuration serveur,
   - surveiller l’activité,
   - mesurer la taille des objets,
   - repérer les index potentiellement inutiles.
================================================================================= */



/* ==============================================================================
   Chapitre 1 — Lire les variables de configuration
=================================================================================

   On commence par inspecter la configuration mémoire et cache du serveur.
   Cela permet de comprendre comment MySQL utilise ses ressources.
   
   */
   
SHOW VARIABLES LIKE '%buffer%';
-- Affiche toutes les variables de configuration dont le nom contient "buffer"
-- Utile pour voir les réglages mémoire (ex. innodb_buffer_pool_size, sort_buffer_size, read_buffer_size, etc.)

SHOW VARIABLES LIKE '%cache%';
-- Affiche toutes les variables liées au cache MySQL
-- Permet de comprendre comment la mémoire est utilisée pour le cache de requêtes, des tables, etc.

SHOW VARIABLES LIKE '%tmp%';
-- Affiche les variables liées aux tables temporaires
-- Utile pour voir si MySQL utilise beaucoup de tables temporaires sur disque ou en mémoire.

SHOW VARIABLES LIKE '%sort%';
-- Affiche les variables liées aux tris (sort_buffer_size, max_sort_length, etc.)
-- Utile pour analyser les performances des requêtes avec ORDER BY / GROUP BY.




/* ==============================================================================
   Chapitre 2 — Lire le statut du serveur
=================================================================================

   Ensuite, on regarde l’état actuel du serveur MySQL.
   Cela donne une photo rapide de la charge et de l’activité.
*/
SHOW STATUS LIKE 'Threads_connected';
-- Donne le nombre de connexions ouvertes actuellement au serveur
-- Indicateur de charge utilisateur (plus il y a de connexions, plus la charge est élevée).

SHOW STATUS LIKE 'Threads_running';
-- Donne le nombre de requêtes en cours d’exécution en ce moment
-- Permet de voir si le serveur est saturé ou non.

SHOW STATUS LIKE 'Queries%';
-- Affiche des informations sur le nombre de requêtes exécutées (Queries, Questions, Slow_queries, etc.)
-- Permet de surveiller le volume d’activité de la base.

SHOW STATUS LIKE 'Uptime';
-- Affiche depuis combien de temps le serveur MySQL est en fonctionnement (en secondes)
-- Utile pour contextualiser les autres statistiques.

SHOW STATUS LIKE 'Questions';
-- Affiche le nombre total de requêtes envoyées au serveur depuis le démarrage
-- Permet de mesurer la charge globale sur la base.



/* ==============================================================================
   Chapitre 3 — Voir les processus en cours
=================================================================================

   Quand le serveur semble lent, il faut voir ce qu’il exécute réellement.
*/

SHOW PROCESSLIST;
-- Affiche la liste des connexions et des requêtes en cours d’exécution
-- Chaque ligne = une session, avec son utilisateur, sa base, sa requête et son état.
-- Permet de repérer les requêtes lentes ou bloquantes, les connexions inactives, etc.

SHOW FULL PROCESSLIST;
-- Même chose que SHOW PROCESSLIST, mais avec la requête complète (sans troncature)
-- Utile pour bien lire des requêtes longues ou complexes.


/* 4. TAILLE DES TABLES – espace disque utilisé */

SELECT 
    table_schema AS 'Base',           -- Nom de la base de données (ex. 'boutique')
    table_name   AS 'Table',          -- Nom de la table
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Taille (MB)'
    -- Calcule la taille totale de la table (données + index) en Mo, arrondie à 2 décimales
FROM information_schema.tables
WHERE table_schema = 'boutique'      -- Filtre uniquement les tables de la base 'boutique'
ORDER BY (data_length + index_length) DESC;
    -- Tri des tables par taille décroissante : les plus lourdes en premier
    -- Permet rapidement de voir quelles tables consomment le plus d’espace.





/* ==============================================================================
   Chapitre 4 — Mesurer la taille des bases et des tables
=================================================================================

   On veut maintenant savoir quelles tables prennent le plus de place.
*/

SELECT 
    table_schema AS 'Base',
    table_name   AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Taille (MB)'
FROM information_schema.tables
WHERE table_schema = 'boutique'
ORDER BY (data_length + index_length) DESC;

/*
   Ce rapport permet de :
   - identifier les tables les plus volumineuses,
   - comparer taille des données et taille des index,
   - détecter une table anormalement grosse.

   Exercice :
   - comparer la taille des tables `clients`, `commandes`, `produits`,
   - ajouter une colonne INDEX_LENGTH séparée pour analyser l’impact des index.
*/



/* ==============================================================================
   Chapitre 5 — Repérer les index potentiellement inutiles
=================================================================================

   Un index peut être utile... ou totalement jamais utilisé.
   Ici, on cherche les index qui n’ont jamais servi.
*/

SELECT 
    object_schema,                    -- Nom de la base de données
    object_name,                      -- Nom de la table
    index_name                        -- Nom de l’index
FROM performance_schema.table_io_waits_summary_by_index_usage
    -- Cette vue de performance_schema résume l’usage des tables et index
    -- Chaque ligne = une table ou un index, avec des compteurs de lectures/écritures.
WHERE index_name IS NOT NULL         -- On ne garde que les lignes qui correspondent à un index réel
  AND count_star = 0                 -- count_star = 0 → cet index n’a jamais été utilisé
ORDER BY object_schema, object_name; -- Ordonne le résultat par base, puis par table
    -- Permet d’identifier les index candidats à la suppression
    -- car ils prennent de la place sans être utilisés.
*/




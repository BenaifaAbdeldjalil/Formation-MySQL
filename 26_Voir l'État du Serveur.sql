/* ==============================================================================
   Administration MySQL – Diagnostic, performance et maintenance
   Base : boutique
---------------------------------------------------------------------------------
   Objectif :
   - comprendre et vérifier la configuration du serveur,
   - surveiller l’activité et les requêtes en cours,
   - mesurer la taille des tables,
   - contrôler la santé des tables et de leurs index.
================================================================================= */



/* ==============================================================================
   Partie 1 — Opérations sur la table clients (maintenance)
================================================================================= */

/* 1. Analyser la table (mettre à jour les statistiques) */
ANALYZE TABLE clients;
-- Met à jour les statistiques internes de MySQL sur la table clients
-- Améliore la qualité des plans d’exécution des requêtes qui utilisent cette table.

/* 2. Réparer la table (si corruption) */
REPAIR TABLE clients;
-- Tente de corriger une éventuelle corruption de la table clients
-- À utiliser quand CHECK TABLE détecte un problème (ou après un incident).

/* 3. Optimiser la table (défragmentation) */
OPTIMIZE TABLE clients;
-- Compacte la table clients, compacte les index et réduit la fragmentation
-- Utile après une grosse série de DELETE / UPDATE sur cette table.

/* 4. Vérifier la table */
CHECK TABLE clients;
-- Vérifie l’intégrité structurelle de la table clients
-- Indique si la table est OK, corrompue, ou besoin de réparation.

/* 5. Convertir le moteur de table (ex. MyISAM → InnoDB) */
ALTER TABLE clients ENGINE = InnoDB;
-- Convertit la table clients en moteur InnoDB, pour bénéficier de :
-- - transactions,
-- - verrouillage au niveau ligne,
-- - meilleure intégrité des données,
-- - fonctions avancées (rollback, crash recovery, etc.).

/* ==============================================================================
   Partie 2 — configuration
================================================================================= */
/* ==============================================================================
Chapitre 1 — Lire la configuration du serveur
=================================================================================

On commence par inspecter la configuration mémoire, cache, tris, etc.
*/

SHOW VARIABLES LIKE '%buffer%';
-- Affiche toutes les variables de configuration dont le nom contient "buffer"
-- Utile pour voir les réglages mémoire (ex. innodb_buffer_pool_size, sort_buffer_size, etc.).

SHOW VARIABLES LIKE '%cache%';
-- Affiche toutes les variables liées au cache MySQL
-- Permet de comprendre comment la mémoire est utilisée pour le cache de requêtes, des tables, etc.

SHOW VARIABLES LIKE '%tmp%';
-- Affiche les variables liées aux tables et à la gestion des données temporaires
-- Aide à vérifier si MySQL utilise trop de tables temporaires sur disque.

SHOW VARIABLES LIKE '%sort%';
-- Affiche les variables liées aux tris (sort_buffer_size, max_sort_length, etc.)
-- Utile pour analyser les performances des requêtes avec ORDER BY / GROUP BY.

/* ==============================================================================
Chapitre 2 — Lire le statut du serveur
=================================================================================

On regarde l’état actuel du serveur MySQL (charge et activité).
*/

SHOW STATUS LIKE 'Threads_connected';
-- Donne le nombre de connexions ouvertes actuellement au serveur
-- Indicateur de charge utilisateur.

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

SHOW FULL PROCESSLIST;
-- Même chose que SHOW PROCESSLIST, mais avec la requête complète (sans troncature)
-- Utile pour lire des requêtes longues ou complexes.

/* ==============================================================================
Chapitre 4 — Mesurer la taille des bases et des tables
=================================================================================

On veut savoir quelles tables prennent le plus de place.
*/

SELECT
table_schema AS 'Base', -- Nom de la base de données (ex. 'boutique')
table_name AS 'Table', -- Nom de la table
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Taille (MB)'
-- Calcule la taille totale de la table (données + index) en Mo, arrondie à 2 décimales
FROM information_schema.tables
WHERE table_schema = 'boutique' -- Filtre uniquement les tables de la base 'boutique'
ORDER BY (data_length + index_length) DESC;
-- Tri des tables par taille décroissante : les plus lourdes en premier
-- Permet rapidement de voir quelles tables consomment le plus d’espace, ou si certaines sont anormalement volumineuses.

/* ==============================================================================
Chapitre 5 — Repérer les index potentiellement inutiles
=================================================================================

Un index peut être utile... ou totalement jamais utilisé.
Ici, on cherche les index qui n’ont jamais servi.
*/

SELECT
object_schema, -- Nom de la base de données
object_name, -- Nom de la table
index_name -- Nom de l’index
FROM performance_schema.table_io_waits_summary_by_index_usage
-- Vue de performance_schema qui résume l’usage des tables et index
-- Chaque ligne correspond à une table ou un index, avec des compteurs de lectures/écritures.
WHERE index_name IS NOT NULL -- On ne garde que les lignes qui correspondent à un index réel
AND count_star = 0 -- count_star = 0 → cet index n’a jamais été utilisé
ORDER BY object_schema, object_name; -- Ordonne le résultat par base, puis par table
-- Permet d’identifier les index candidats à la suppression
-- car ils prennent de la place sans être utilisés depuis le démarrage du serveur.

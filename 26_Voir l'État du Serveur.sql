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

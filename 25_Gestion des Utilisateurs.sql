/* ==============================================================================
   Administration MySQL : Gestion des utilisateurs, rôles et permissions
   Objectif : expliquer clairement :
   - utilisateur de lecture,
   - utilisateur lecture + écriture,
   - utilisateur limité à une table,
   - groupe de rôles (via GRANT / REVOKE),
   - gestion des permissions (SHOW GRANTS, REVOKE, DROP USER, ALTER USER).
-------------------------------------------------------------------------------
   Tout est basé sur la base de données `boutique`.
================================================================================= */



/* ==============================================================================
   Chapitre 1 — Se connecter en tant que root (prérequis)
=================================================================================

   Avant de créer des utilisateurs, il faut se connecter en tant que superutilisateur.

*/

-- 1. Se connecter en tant que root (dans le terminal MySQL)
-- mysql -u root -p

/* 
   Une fois connecté en tant que root, tu peux :
   - créer des utilisateurs,
   - leur donner des droits,
   - gérer les permissions.

   C’est l’équivalent du rôle superutilisateur dans PostgreSQL.
*/



/* ==============================================================================
   Chapitre 2 — Créer un utilisateur administrateur (lecture + écriture complète)
=================================================================================

   On commence par un utilisateur avec tous les droits sur la base `boutique`.

*/

CREATE USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'AdminP@ss123!';

GRANT ALL PRIVILEGES ON boutique.* 
TO 'admin_boutique'@'localhost';

/* 
   Ce rôle est un **administrateur** :
   - il peut lire, insérer, modifier, supprimer dans toutes les tables de la base `boutique`,
   - c’est un rôle de **lecture + écriture maximale**.

   Attention : ce niveau de privilège est très puissant et doit être réservé à des administrateurs.
*/



/* ==============================================================================
   Chapitre 3 — Créer un utilisateur "lecture seule" (rôle de lecture)
=================================================================================

   Maintenant, on crée un utilisateur qui peut seulement lire les données.

*/

CREATE USER 'consultant'@'localhost' 
IDENTIFIED BY 'Consultant456!';

GRANT SELECT ON boutique.* 
TO 'consultant'@'localhost';

/* 
   Ce rôle est un **rôle de lecture** :
   - il peut exécuter des requêtes SELECT sur toutes les tables de la base `boutique`,
   - il ne peut pas insérer, modifier ou supprimer des données.

   C’est adapté à un analyste métier ou à un utilisateur qui ne doit pas toucher aux données.
*/



/* ==============================================================================
   Chapitre 4 — Créer un utilisateur pour une table spécifique (rôle limité à une table)
=================================================================================

   Maintenant, on crée un utilisateur spécialisé sur une seule table : `clients`.

*/

CREATE USER 'gestion_clients'@'localhost' 
IDENTIFIED BY 'Clients789!';

GRANT SELECT, INSERT, UPDATE ON boutique.clients 
TO 'gestion_clients'@'localhost';

/* 
   Ce rôle est **limité à une seule table** :
   - SELECT : lecture des données de la table `clients`,
   - INSERT : ajout de nouveaux clients,
   - UPDATE : modification des données clients,
   - mais pas DELETE (pour le moment).

   C’est un exemple de rôle de **gestion des clients** ou de **rôle de test**.
*/



/* ==============================================================================
   Chapitre 5 — Voir les permissions (SHOW GRANTS)
=================================================================================

   Pour vérifier les droits d’un utilisateur, tu peux utiliser SHOW GRANTS.

*/

SHOW GRANTS FOR 'admin_boutique'@'localhost';

/* 
   Cette commande affiche :
   - tous les privilèges accordés à l’utilisateur 'admin_boutique',
   - sur quelle base / table il possède des droits.

   C’est utile pour :
   - vérifier les rôles de lecture,
   - vérifier les rôles de lecture + écriture,
   - vérifier les rôles limités à une table.
*/



/* ==============================================================================
   Chapitre 6 — Révoquer des permissions (rôle de lecture + écriture limitée)
=================================================================================

   Parfois, tu veux retirer un droit, par exemple empêcher la suppression.

*/

REVOKE DELETE ON boutique.* FROM 'gestion_clients'@'localhost';

/* 
   Après cette commande, `gestion_clients` peut toujours :
   - lire (SELECT),
   - insérer (INSERT),
   - modifier (UPDATE),
   mais ne peut plus **supprimer** (DELETE).

   Cela transforme le rôle de lecture + écriture en un rôle plus proche de lecture avancée :
   - il écrit, mais ne détruit pas.
*/



/* ==============================================================================
   Chapitre 7 — Supprimer un utilisateur (DROP USER)
=================================================================================

   Quand un utilisateur n’est plus nécessaire, tu le supprimes.

*/

DROP USER 'consultant'@'localhost';

/* 
   L’utilisateur `consultant` est supprimé :
   - il ne peut plus se connecter,
   - il perd tous ses droits.

   C’est une bonne pratique pour garder la base propre.
*/



/* ==============================================================================
   Chapitre 8 — Changer le mot de passe (ALTER USER)
=================================================================================

   Pour renforcer la sécurité, tu peux changer le mot de passe d’un utilisateur.

*/

ALTER USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'NouveauP@ss789!';

/* 
   C’est utile pour :
   - appliquer une politique de rotation des mots de passe,
   - corriger un mot de passe compromis,
   - se conformer aux règles de sécurité.

   Le rôle de l’utilisateur reste le même, seul le mot de passe change.
*/



/* ==============================================================================
   Chapitre 9 — Résumé des rôles
=================================================================================

   En résumé :
   - **rôle de lecture** : seulement SELECT sur une base ou table,
   - **rôle lecture + écriture** : SELECT, INSERT, UPDATE, DELETE (ou limité),
   - **rôle limité à une table** : droits très ciblés sur une seule table,
   - **groupe de rôles** : via GRANT / REVOKE sur les mêmes utilisateurs,
   - **gestion des permissions** : SHOW GRANTS, REVOKE, DROP USER, ALTER USER.

   Tout cela reste basé sur la base de données `boutique` que tu as créée au début,
   et les mêmes règles de sécurité s’appliquent à tous les exercices suivants.
*/

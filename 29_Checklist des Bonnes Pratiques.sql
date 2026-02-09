-- ✅ TOUJOURS :
-- 1. Utiliser des noms explicites (pas de noms courts)
-- 2. Préfixer les clés étrangères : table_id
-- 3. Utiliser UTF8MB4 pour les caractères spéciaux
-- 4. Ajouter des commentaires aux tables/colonnes
-- 5. Utiliser les contraintes (NOT NULL, CHECK, etc.)

-- ✅ POUR LES PERFORMANCES :
-- 1. Indexer les colonnes utilisées dans WHERE/JOIN
-- 2. Éviter SELECT * (choisir les colonnes nécessaires)
-- 3. Utiliser LIMIT sur les grandes tables
-- 4. Analyser les requêtes avec EXPLAIN

-- ✅ POUR LA SÉCURITÉ :
-- 1. Créer des utilisateurs avec le minimum de permissions
-- 2. Ne jamais utiliser 'root' pour l'application
-- 3. Faire des backups réguliers
-- 4. Hasher les mots de passe (pas en clair!)

-- ✅ POUR LA MAINTENANCE :
-- 1. Documenter la structure de la base
-- 2. Garder un fichier de création (schema.sql)
-- 3. Versionner la base avec Git
-- 4. Monitorer les performances régulièrement

-- 1. Se connecter en tant que root d'abord
-- mysql -u root -p

-- 2. Créer un utilisateur administrateur
CREATE USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'AdminP@ss123!';

-- 3. Donner tous les droits sur la boutique
GRANT ALL PRIVILEGES ON boutique.* 
TO 'admin_boutique'@'localhost';

-- 4. Créer un utilisateur "lecture seule"
CREATE USER 'consultant'@'localhost' 
IDENTIFIED BY 'Consultant456!';

GRANT SELECT ON boutique.* 
TO 'consultant'@'localhost';

-- 5. Créer un utilisateur pour une table spécifique
CREATE USER 'gestion_clients'@'localhost' 
IDENTIFIED BY 'Clients789!';

GRANT SELECT, INSERT, UPDATE ON boutique.clients 
TO 'gestion_clients'@'localhost';

-- 6. Voir les permissions
SHOW GRANTS FOR 'admin_boutique'@'localhost';

-- 7. Révoquer des permissions
REVOKE DELETE ON boutique.* FROM 'gestion_clients'@'localhost';

-- 8. Supprimer un utilisateur
DROP USER 'consultant'@'localhost';

-- 9. Changer mot de passe
ALTER USER 'admin_boutique'@'localhost' 
IDENTIFIED BY 'NouveauP@ss789!';

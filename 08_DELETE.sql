
 select * from clients;
 
-- 1. Supprimer une ligne
DELETE FROM clients WHERE id = 5;


 select *  FROM commandes;
-- 2. Supprimer avec condition
DELETE FROM commandes WHERE date_commande < '2024-01-01';

-- 3. Attention : toujours un WHERE !
-- ❌ DANGER : DELETE FROM clients;  -- Supprime TOUT

DELETE FROM clients

-- 4. TRUNCATE (vider table)
TRUNCATE TABLE clients;  -- Plus rapide, réinitialise auto_increment


INSERT INTO boutique.clients
(id, nom, prenom, email, ville)
VALUES(1, 'Dupont', 'Jean', 'jean.dupont@email.com', 'Lyon');
INSERT INTO boutique.clients
(id, nom, prenom, email, ville)
VALUES(2, 'Martin', 'Sophie', 'sophie.martin@email.com', 'Paris');
INSERT INTO boutique.clients
(id, nom, prenom, email, ville)
VALUES(3, 'Bernard', 'Pierre', 'new@email.com', 'Paris');
INSERT INTO boutique.clients
(id, nom, prenom, email, ville)
VALUES(4, 'Dubois', 'Marie', 'marie.dubois@email.com', 'Paris');
INSERT INTO boutique.clients
(id, nom, prenom, email, ville)
VALUES(5, 'Petit', 'Thomas', 'thomas.petit@email.com', 'Paris');

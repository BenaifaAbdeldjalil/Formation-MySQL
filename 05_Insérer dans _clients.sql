-- Insérer 5 clients
INSERT INTO clients (nom, prenom, email, ville) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', 'Paris'),
('Martin', 'Sophie', 'sophie.martin@email.com', 'Lyon'),
('Bernard', 'Pierre', 'pierre.bernard@email.com', 'Marseille'),
('Dubois', 'Marie', 'marie.dubois@email.com', 'Paris'),
('Petit', 'Thomas', 'thomas.petit@email.com', 'Lille');

-- Vérifier
SELECT * FROM clients;

-- Insérer 5 produits
INSERT INTO produits (nom, prix, categorie) VALUES
('Ordinateur Portable', 799.99, 'Électronique'),
('Smartphone', 499.99, 'Électronique'),
('Livre SQL', 29.99, 'Livres'),
('Cafetière', 89.99, 'Maison'),
('Chaise Bureau', 199.99, 'Mobilier');

-- Vérifier
SELECT * FROM produits;

-- Commandes cohérentes :
-- Client 1 achète Produit 1
-- Client 1 achète Produit 3
-- Client 2 achète Produit 2
-- etc.

INSERT INTO commandes (client_id, produit_id, quantite, date_commande) VALUES
(1, 1, 1, '2024-03-01'),  -- Jean achète un ordinateur
(1, 3, 2, '2024-03-02'),  -- Jean achète 2 livres
(2, 2, 1, '2024-03-03'),  -- Sophie achète un smartphone
(3, 4, 1, '2024-03-04'),  -- Pierre achète une cafetière
(4, 5, 1, '2024-03-05');  -- Marie achète une chaise

-- Vérifier
SELECT * FROM commandes;

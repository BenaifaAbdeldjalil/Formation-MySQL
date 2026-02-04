-- 1. Pourquoi une clé primaire ?
-- - Identifie UNIQUEMENT chaque ligne
-- - Ne peut pas être NULL
-- - Améliore les performances

-- 2. Déclaration
CREATE TABLE employes (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Clé primaire
    nom VARCHAR(50),
    email VARCHAR(100)
);

-- 3. Ajouter après création
ALTER TABLE clients ADD PRIMARY KEY (id);

-- 4. Clé primaire composite (2 colonnes)
CREATE TABLE commandes_details (
    commande_id INT,
    produit_id INT,
    quantite INT,
    PRIMARY KEY (commande_id, produit_id)  -- Les deux ensemble sont uniques
);

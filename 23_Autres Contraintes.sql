-- 1. NOT NULL
CREATE TABLE personnes (
    nom VARCHAR(50) NOT NULL,  -- Doit avoir une valeur
    age INT NULL               -- Peut être vide (par défaut)
);

-- 2. CHECK (MySQL 8.0+)
CREATE TABLE produits_avances (
    id INT PRIMARY KEY,
    prix DECIMAL(10,2) CHECK (prix > 0),  -- Prix doit être > 0
    stock INT CHECK (stock >= 0)          -- Stock ne peut pas être négatif
);

-- 3. DEFAULT
CREATE TABLE commandes_avances (
    id INT PRIMARY KEY,
    statut VARCHAR(20) DEFAULT 'en_attente',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
                         ON UPDATE CURRENT_TIMESTAMP  -- Auto-mise à jour
);

/* ==============================================================================
   Contraintes SQL : NOT NULL, CHECK, DEFAULT – Histoire avec tests OK / KO
   Schéma : exemple simple (personnes, produits_avances, commandes_avances)
================================================================================= */



/* ==============================================================================
   Chapitre 1 — Construire une table avec NOT NULL
=================================================================================

   On commence avec une table `personnes` :
   - `nom` est NOT NULL (obligatoire),
   - `age` est NULL (facultatif).
*/

CREATE TABLE personnes (
    nom   VARCHAR(50) NOT NULL,  -- Doit avoir une valeur
    age   INT NULL                -- Peut être NULL
);

/* 
   Exercice 1 : tests NOT NULL (OK / KO)
*/

-- 1. Test OK : insertion correcte (nom rempli, age facultatif)
INSERT INTO personnes (nom, age) VALUES ('Alice', 25);   -- ✅ OK
INSERT INTO personnes (nom) VALUES ('Bob');              -- ✅ OK (age = NULL autorisé)

-- 2. Test KO : tentative de passer un nom NULL (pas autorisé)
INSERT INTO personnes (nom, age) VALUES (NULL, 30);      -- ❌ ERREUR : NOT NULL violé

/* 
   Résultat :
   - les lignes avec un `nom` non vide sont acceptées,
   - les lignes où `nom` est NULL sont rejetées.
*/



/* ==============================================================================
   Chapitre 2 — Construire une table avec CHECK (MySQL 8.0+)
=================================================================================

   On crée une table `produits_avances` avec des règles métier :
   - prix > 0,
   - stock >= 0 (pas de stock négatif).
*/

CREATE TABLE produits_avances (
    id    INT PRIMARY KEY,
    prix  DECIMAL(10,2) CHECK (prix > 0),
    stock INT CHECK (stock >= 0)
);

/* 
   Exercice 2 : tests CHECK (OK / KO)
*/

-- 1. Test OK : données valides
INSERT INTO produits_avances (id, prix, stock) VALUES (1, 19.99, 100);   -- ✅ OK
INSERT INTO produits_avances (id, prix, stock) VALUES (2, 5.00, 0);      -- ✅ OK (stock = 0)
INSERT INTO produits_avances (id, prix, stock) VALUES (3, 100.00, 50);   -- ✅ OK

-- 2. Test KO : prix négatif (pas autorisé)
INSERT INTO produits_avances (id, prix, stock) VALUES (4, -10.00, 10);   -- ❌ KO (prix > 0)

-- 3. Test KO : stock négatif (pas autorisé)
INSERT INTO produits_avances (id, prix, stock) VALUES (5, 25.00, -5);    -- ❌ KO (stock >= 0)

/* 
   Résultat :
   - les lignes qui respectent les règles CHECK sont acceptées,
   - les lignes qui violent CHECK (prix <= 0 ou stock < 0) sont rejetées.
*/



/* ==============================================================================
   Chapitre 3 — Construire une table avec DEFAULT (et mises à jour automatiques)
=================================================================================

   On crée la table `commandes_avances` avec des valeurs par défaut :
   - statut = 'en_attente',
   - date de création = moment de l’INSERT,
   - date de modification = mise à jour automatique au UPDATE.
*/

CREATE TABLE commandes_avances (
    id                 INT PRIMARY KEY,
    statut             VARCHAR(20) DEFAULT 'en_attente',
    date_creation      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                         ON UPDATE CURRENT_TIMESTAMP
);

/* 
   Exercice 3 : tests DEFAULT (OK / KO)
*/

-- 1. Test OK : insertion sans préciser statut ni date
INSERT INTO commandes_avances (id) VALUES (1);   -- ✅ OK
-- Résultat :
--   statut = 'en_attente' (par défaut),
--   date_creation = NOW() (par défaut),
--   date_modification = NOW() (par défaut).

INSERT INTO commandes_avances (id, statut) VALUES (2, 'en_cours');   -- ✅ OK
-- Résultat :
--   statut = 'en_cours',
--   date_creation et date_modification = NOW().

-- 2. Test KO : tentative de mettre un statut NULL si on voulait éviter cela
-- (ici, default est 'en_attente', mais si on change la définition ensuite)
ALTER TABLE commandes_avances
MODIFY COLUMN statut VARCHAR(20) NOT NULL DEFAULT 'en_attente';

INSERT INTO commandes_avances (id, statut) VALUES (3, NULL);   -- ❌ KO (si NOT NULL est ajouté)

/* 
   Résultat :
   - les lignes avec valeurs par défaut correctes sont acceptées,
   - les lignes qui violent une contrainte (par exemple NULL sur une colonne NOT NULL) sont rejetées.
*/



/* ==============================================================================
   Chapitre 4 — Résumé des tests OK / KO
=================================================================================

   En résumé, avec ces tests, on voit :
   - `NOT NULL` :
        - ✅ OK quand la valeur existe,
        - ❌ KO quand la valeur est NULL sur une colonne NOT NULL.
   - `CHECK` (MySQL 8.0+) :
        - ✅ OK quand la règle est respectée,
        - ❌ KO quand la règle n’est pas respectée.
   - `DEFAULT` :
        - ✅ OK quand la valeur par défaut ou une valeur explicite est fournie,
        - ❌ KO si la valeur donnée viole une contrainte (par exemple NULL sur NOT NULL).

   C’est un bon exemple de **contraintes de validation** qui permettent de
   protéger la cohérence des données au niveau de la base de données.
*/

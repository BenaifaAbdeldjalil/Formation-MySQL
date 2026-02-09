/*
=====================================================
SUJET D’EXAMEN – BASES DE DONNÉES SQL
Durée : 2 heures
Notation : /20
=====================================================

CONTEXTE :
On souhaite créer une base de données permettant de gérer une école.
La base doit gérer :
- les élèves
- les classes
- les matières
- les notes

Chaque élève appartient à une seule classe.
Chaque note est associée à un élève et à une matière.

=====================================================
PARTIE A – CRÉATION DE LA BASE (6 points)
=====================================================

A1 (2 pts)
Créer une base de données nommée "gestion_ecole"
en utilisant l’encodage utf8mb4.

A2 (4 pts)
Créer les tables suivantes :

- classes (id, nom, niveau, professeur principal)
- eleves (id, nom, prénom, date de naissance, classe, date d’inscription)
- matieres (id, nom, coefficient)
- notes (id, élève, matière, note, date, commentaire)

Contraintes :
- clés primaires
- clés étrangères
- note comprise entre 0 et 20

=====================================================
PARTIE B – INSERTION DES DONNÉES (4 points)
=====================================================

B1 (2 pts)
Insérer au moins :
- 3 classes
- 3 élèves
- 3 matières

B2 (2 pts)
Insérer au moins 4 notes cohérentes.

=====================================================
PARTIE C – REQUÊTES SQL (10 points)
=====================================================

C1 (2 pts)
Afficher la liste des élèves avec leur classe.

C2 (3 pts)
Afficher la moyenne générale de chaque élève,
triée de la meilleure à la moins bonne.

C3 (3 pts)
Afficher la moyenne des notes par classe.

C4 (2 pts)
Afficher le meilleur élève pour chaque matière.

=====================================================
CORRECTION DÉTAILLÉE
=====================================================

-------------------------------------
Correction A1
-------------------------------------

CREATE DATABASE gestion_ecole CHARACTER SET utf8mb4;
USE gestion_ecole;

-------------------------------------
Correction A2
-------------------------------------

CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE,
    niveau VARCHAR(20),
    professeur_principal VARCHAR(100)
);

CREATE TABLE eleves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    classe_id INT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (classe_id) REFERENCES classes(id)
);

CREATE TABLE matieres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    coefficient INT DEFAULT 1
);

CREATE TABLE notes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    eleve_id INT NOT NULL,
    matiere_id INT NOT NULL,
    note DECIMAL(4,2) CHECK (note BETWEEN 0 AND 20),
    date_note DATE DEFAULT CURRENT_DATE,
    commentaire TEXT,
    FOREIGN KEY (eleve_id) REFERENCES eleves(id),
    FOREIGN KEY (matiere_id) REFERENCES matieres(id)
);

-------------------------------------
Correction B1
-------------------------------------

INSERT INTO classes (nom, niveau) VALUES
('6ème A', '6ème'),
('5ème B', '5ème'),
('4ème A', '4ème');

INSERT INTO eleves (nom, prenom, date_naissance, classe_id) VALUES
('Dupont', 'Jean', '2012-05-15', 1),
('Martin', 'Sophie', '2011-08-22', 2),
('Bernard', 'Pierre', '2010-11-30', 3);

INSERT INTO matieres (nom, coefficient) VALUES
('Mathématiques', 3),
('Français', 2),
('Histoire-Géo', 1);

-------------------------------------
Correction B2
-------------------------------------

INSERT INTO notes (eleve_id, matiere_id, note) VALUES
(1, 1, 15.5),
(1, 2, 12.0),
(2, 1, 18.0),
(3, 3, 14.5);

-------------------------------------
Correction C1
-------------------------------------

SELECT 
    e.nom,
    e.prenom,
    c.nom AS classe
FROM eleves e
JOIN classes c ON e.classe_id = c.id;

-------------------------------------
Correction C2
-------------------------------------

SELECT 
    e.nom,
    e.prenom,
    ROUND(AVG(n.note), 2) AS moyenne_generale
FROM eleves e
JOIN notes n ON e.id = n.eleve_id
GROUP BY e.id
ORDER BY moyenne_generale DESC;

-------------------------------------
Correction C3
-------------------------------------

SELECT 
    c.nom AS classe,
    ROUND(AVG(n.note), 2) AS moyenne_classe
FROM classes c
JOIN eleves e ON c.id = e.classe_id
JOIN notes n ON e.id = n.eleve_id
GROUP BY c.id;

-------------------------------------
Correction C4
-------------------------------------

SELECT 
    m.nom AS matiere,
    e.nom,
    e.prenom,
    MAX(n.note) AS meilleure_note
FROM matieres m
JOIN notes n ON m.id = n.matiere_id
JOIN eleves e ON n.eleve_id = e.id
GROUP BY m.id;

=====================================================
FIN DU SUJET ET DE LA CORRECTION
=====================================================
*/

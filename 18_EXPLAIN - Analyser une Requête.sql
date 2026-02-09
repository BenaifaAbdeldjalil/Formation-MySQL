-- Voir comment MySQL exécute la requête
EXPLAIN SELECT * FROM clients WHERE ville = 'Paris';

/*
Résultat important :
- type : ALL = scanne toute la table (mauvais)
- type : ref = utilise un index (bon)
- rows : nombre de lignes examinées
*/

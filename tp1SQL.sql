-- TP : Modèle de base de données Ecrivain
-- Date : le 12 novembre 2024
-- Auteurs : Théo COUERBE

-- SERVEUR NON FONCTIONNEL AU MOMENT DU TP

/* 1. Affichez la structure, puis le contenu de chacune des tables : LOCALISATION, GENRE, ECRIVAIN */

-- Afficher la structure et le contenu de la table LOCALISATION
DESC LOCALISATION;
SELECT * FROM LOCALISATION;

-- Afficher la structure et le contenu de la table GENRE
DESC GENRE;
SELECT * FROM GENRE;

-- Afficher la structure et le contenu de la table ECRIVAIN
DESC ECRIVAIN;
SELECT * FROM ECRIVAIN;


/* 2. Déterminez pour chacune des tables son nombre d'enregistrements (3 requêtes). */

-- Nombre d'enregistrements dans la table LOCALISATION
SELECT COUNT(*) AS total_enregistrements FROM LOCALISATION;

-- Nombre d'enregistrements dans la table GENRE
SELECT COUNT(*) AS total_enregistrements FROM GENRE;

-- Nombre d'enregistrements dans la table ECRIVAIN
SELECT COUNT(*) AS total_enregistrements FROM ECRIVAIN;


/* 3. Affichez le contenu de la table ECRIVAIN en triant les écrivains par date de naissance */

-- Afficher tous les écrivains triés par date de naissance (du plus ancien au plus récent)
SELECT * FROM ECRIVAIN ORDER BY DATE_N;

/* 4. Affichez le contenu de la table ECRIVAIN en présentant d'abord les femmes, puis les hommes, et chaque liste sera triée en ordre alphabétique. */

-- Afficher les écrivains en triant par sexe puis par nom et prénom en ordre alphabétique
SELECT * FROM ECRIVAIN
ORDER BY SEXE, ENOM, PNOM;


/* 5. Affichez le nombre de pays distincts dans PAYS_N et ensuite la liste des pays sans répétition. */

-- Nombre de pays distincts dans PAYS_N
SELECT COUNT(DISTINCT PAYS_N) AS nombre_de_pays FROM ECRIVAIN;

-- Liste des pays de naissance sans répétition
SELECT DISTINCT PAYS_N FROM ECRIVAIN;


/* 6. Affichez les pays de naissance des écrivains suivi du nombre d'écrivains nés dans chaque pays. */

-- Nombre d'écrivains par pays de naissance
SELECT PAYS_N, COUNT(*) AS nombre_d_ecrivains
FROM ECRIVAIN
GROUP BY PAYS_N;


/* 7. Affichez le nombre total de femmes écrivain. */

-- Compter le nombre de femmes écrivains
SELECT COUNT(*) AS nombre_de_femmes
FROM ECRIVAIN
WHERE SEXE = 'F';

/* 8. Affichez pour chaque sexe le nombre total d'écrivains. */

-- Compter le nombre total d'écrivains par sexe
SELECT SEXE, COUNT(*) AS nombre_d_ecrivains
FROM ECRIVAIN
GROUP BY SEXE;


/* 9. Affichez pour chaque sexe le pourcentage global d'écrivains. */

-- Calculer le pourcentage d'écrivains pour chaque sexe
SELECT SEXE, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ECRIVAIN)) AS pourcentage
FROM ECRIVAIN
GROUP BY SEXE;


/* 10. Affichez l'écrivain le plus ancien et le plus jeune (2 requêtes). */

-- Ecrivain le plus ancien
SELECT * FROM ECRIVAIN
ORDER BY DATE_N ASC
FETCH FIRST 1 ROWS ONLY;

-- Ecrivain le plus jeune
SELECT * FROM ECRIVAIN
ORDER BY DATE_N DESC
FETCH FIRST 1 ROWS ONLY;
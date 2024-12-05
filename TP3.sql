-- TP3
-- Date : 29/11/2024
-- Auteur : Théo COUERBE & Adam Nahal

/* Q1 -- Mode AUTOCOMMIT ON */
SET AUTOCOMMIT ON;

/* Q2 */
CREATE TABLE ECRIVAIN AS SELECT * FROM SYS.ECRIVAIN;


/* Q3 */
ALTER TABLE ECRIVAIN ADD  CONSTRAINT cle_p PRIMARY KEY (idecr);

/* Q4 */
INSERT INTO C##COUERBE.ECRIVAIN 
VALUES (7000, 'Hugo', 'Victor', 'H', to_date('26/09/1802', 'dd/mm/yyyy'), 'France', NULL, 10000, NULL, 60);

commit;

desc ecrivain;

select owner, table_name from all_tables;

--ACID 

/* Q5 */
SELECT * FROM C##COUERBE.ECRIVAIN;

/* Q6 */
CREATE TABLE LECTEUR (
    idlecteur NUMBER PRIMARY KEY,
    lnom VARCHAR2(50),
    lpnom VARCHAR2(50)
);

/* Q7 */
INSERT INTO LECTEUR VALUES (101, 'Dupont', 'Jean');
INSERT INTO LECTEUR VALUES (102, 'Durand', 'Marie');

SELECT * FROM LECTEUR;

/* Q8 */
CREATE TABLE LIVRE (
    idlivre NUMBER PRIMARY KEY,
    idgenre NUMBER,
    titre VARCHAR2(100),
    CONSTRAINT fk_idgenre FOREIGN KEY (idgenre) REFERENCES GENRE(idgenre)
);

/* Q10 */
INSERT INTO LIVRE VALUES (1, 101, 'Les Misérables');
INSERT INTO LIVRE VALUES (2, 102, 'Le Comte de Monte-Cristo');
INSERT INTO LIVRE VALUES (3, 101, 'Notre-Dame de Paris');
INSERT INTO LIVRE VALUES (4, 103, 'Cyrano de Bergerac');
INSERT INTO LIVRE VALUES (5, 104, 'Candide');
INSERT INTO LIVRE VALUES (6, 105, 'L’Étranger');

/* Q11 */
INSERT INTO LIVRE VALUES (7, 999, 'Invalid Genre'); -- idgenre 999 n’existe pas; la clé étrangère idgenre doit exister dans la table GENRE

INSERT INTO LIVRE VALUES (1, 101, 'Les Misérables'); -- existe déjà donc erreur; idlivre est la clé primaire

/* Q12 */
CREATE TABLE EST_RECOMMANDE (
    idlivre NUMBER PRIMARY KEY,
    idlecteur NUMBER,
    CONSTRAINT fk_idlivre FOREIGN KEY (idlivre) REFERENCES LIVRE(idlivre),
    CONSTRAINT fk_idlecteur FOREIGN KEY (idlecteur) REFERENCES LECTEUR(idlecteur)
);

CREATE TABLE RECOMMANDATION (
    idlivre NUMBER,
    idlecteur NUMBER,
    CONSTRAINT pk_recommendation PRIMARY KEY (idlivre, idlecteur),
    CONSTRAINT fk_recommendation_livre FOREIGN KEY (idlivre) REFERENCES LIVRE(idlivre),
    CONSTRAINT fk_recommendation_lecteur FOREIGN KEY (idlecteur) REFERENCES LECTEUR(idlecteur)
);

/* Q13 */
INSERT INTO EST_RECOMMANDE VALUES (1, 101); -- Jean lit Les Misérables
INSERT INTO EST_RECOMMANDE VALUES (2, 102); -- Marie lit Le Comte de Monte-Cristo
INSERT INTO EST_RECOMMANDE VALUES (3, 101); -- Jean lit Notre-Dame de Paris
INSERT INTO EST_RECOMMANDE VALUES (4, 101); -- Jean lit Cyrano de Bergerac

INSERT INTO RECOMMANDATION VALUES (5, 102); -- Marie recommande Candide
INSERT INTO RECOMMANDATION VALUES (6, 101); -- Jean recommande L’Étranger

SELECT * FROM EST_RECOMMANDE;
SELECT * FROM RECOMMANDATION;

/* Partie 3 */
/* Q2 */
SELECT titre
FROM LIVRE
WHERE idlivre NOT IN (
    SELECT idlivre
    FROM EST_RECOMMANDE
);

/* Q3 */
SELECT GENRE.nom AS Genre, COUNT(EST_RECOMMANDE.idlivre) AS Nombre_Lectures
FROM LIVRE
JOIN GENRE ON LIVRE.idgenre = GENRE.idgenre
JOIN EST_RECOMMANDE ON LIVRE.idlivre = EST_RECOMMANDE.idlivre
GROUP BY GENRE.nom
ORDER BY Nombre_Lectures DESC;


/* Q6 */
SELECT l1.idlecteur AS Lecteur1, l2.idlecteur AS Lecteur2
FROM EST_RECOMMANDE e1
JOIN EST_RECOMMANDE e2 ON e1.idlivre = e2.idlivre AND e1.idlecteur < e2.idlecteur
JOIN LECTEUR l1 ON e1.idlecteur = l1.idlecteur
JOIN LECTEUR l2 ON e2.idlecteur = l2.idlecteur
GROUP BY l1.idlecteur, l2.idlecteur
HAVING COUNT(e1.idlivre) = (
    SELECT COUNT(*)
    FROM EST_RECOMMANDE
    WHERE idlecteur = l1.idlecteur
);

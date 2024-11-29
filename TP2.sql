-- TP2
-- Date : 22/11/2024
-- Auteurs : Théo COUERBE

/* Q2 */
SELECT ENOM, GNOM, LIVRES_VENDUS
FROM ECRIVAIN 
JOIN GENRE 
ON ECRIVAIN.GENRE_ID = GENRE.IDGENRE
ORDER BY (GNOM);

/* Q3 */
SELECT PNOM, ENOM, GNOM, LNOM
FROM ECRIVAIN
JOIN GENRE ON ECRIVAIN.GENRE_ID = GENRE.IDGENRE
JOIN LOCALISATION ON GENRE.LOC_ID = LOCALISATION.IDLOC;

/* Q4 */
/* Certaines données, par exemple GENRE_ID ont pour valeur (null) dans la table.
    Elles sont donc affichées lorsque l'on demande la table entière mais pas si
    on fait une requête qui requière l'ID_GENRE.
*/

/* Q5 */
SELECT PNOM, ENOM, GNOM, LNOM
FROM ECRIVAIN
LEFT JOIN GENRE ON ECRIVAIN.GENRE_ID = GENRE.IDGENRE
LEFT JOIN LOCALISATION ON GENRE.LOC_ID = LOCALISATION.IDLOC;

/* Q6 */
/* Avec Minus */
SELECT g.gnom
FROM GENRE g
MINUS
SELECT g.gnom
FROM GENRE g
JOIN ECRIVAIN e ON g.idgenre = e.genre_id;
/* Avec NOT EXIST */
SELECT g.gnom
FROM GENRE g
WHERE NOT EXISTS (
    SELECT 1
    FROM ECRIVAIN e
    WHERE e.genre_id = g.idgenre
);
/* Avec NOT IN: Je ne comprends pas pourquoi cela ne fonctionne pas*/
SELECT g.gnom
FROM GENRE g
WHERE g.idgenre NOT IN (
    SELECT e.genre_id
    FROM ECRIVAIN e
);
/* AVEC IS NULL */
SELECT g.gnom
FROM GENRE g
LEFT JOIN ECRIVAIN e ON g.idgenre = e.genre_id
WHERE e.idecr IS NULL;

/* Q7 */
SELECT g.gnom, l.lnom, COUNT(enom)
FROM GENRE g
LEFT JOIN LOCALISATION l ON GENRE.LOC_ID = l.IDLOC
INNER JOIN ECRIVAIN e ON g.idgenre = e.GENRE_ID;

SELECT 
g.gnom AS genre_litteraire, 
l.lnom AS localisation, 
COUNT(e.idecr) AS nombre_ecrivains, 
ROUND(AVG(e.livres_vendus), 2) AS moyenne_livres_vendus
FROM 
GENRE g
LEFT JOIN 
LOCALISATION l ON g.loc_id = l.idloc
LEFT JOIN 
ECRIVAIN e ON g.idgenre = e.genre_id
GROUP BY 
g.gnom, l.lnom
ORDER BY 
g.gnom;

/* Q8 */
SELECT
g.gnom, NVL(l.lnom, '--')
FROM GENRE g 
LEFT JOIN LOCALISATION l ON g.LOC_ID = l.IDLOC
;


















SELECT * FROM LOCALISATION;
SELECT * FROM GENRE;
SELECT * FROM ECRIVAIN;

DESC LOCALISATION;

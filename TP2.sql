-- TP2
-- Date : 29/11/2024
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
/* Avec NOT IN*/
SELECT g.gnom
FROM GENRE g
WHERE g.idgenre NOT IN ( /* La présence de NULL crée une erreur avec IN */
    SELECT e.genre_id
    FROM ECRIVAIN e
    WHERE NOT e.GENRE_ID IS NULL
);
/* AVEC IS NULL */
SELECT g.gnom
FROM GENRE g
LEFT JOIN ECRIVAIN e ON g.idgenre = e.genre_id
WHERE e.idecr IS NULL;

/* Q7 */
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
g.gnom AS genre_litteraire, 
NVL(l.lnom, '--') AS localisation, 
NVL(COUNT(e.idecr), 0) AS nombre_ecrivains, 
NVL(ROUND(AVG(e.livres_vendus), 2), 0) AS moyenne_livres_vendus
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

/* Q9 */
SELECT e.enom, e.pnom, NVL(e2.ENOM, '--'), NVL(e2.PNOM, '--')
FROM ECRIVAIN e 
LEFT JOIN ECRIVAIN e2 ON e.CHEF_DE_FILE = e2.IDECR
;

/* Q10 */
SELECT 
e.enom AS nom,
e.pnom AS prenom,
NVL(COUNT(c.idecr), 0) AS nombre_chefs_de_file
FROM 
ECRIVAIN e
LEFT JOIN 
ECRIVAIN c ON e.idecr = c.CHEF_DE_FILE
GROUP BY 
e.enom, e.pnom
ORDER BY 
nombre_chefs_de_file DESC;

/* Q11 */
SELECT e.enom
FROM ECRIVAIN e
WHERE e.CHEF_DE_FILE IS NULL;
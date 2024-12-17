SELECT * FROM LIVRE;

/* Q1 -- Mode AUTOCOMMIT ON */
SET AUTOCOMMIT OFF;

SELECT * FROM Livre;

/* Test sequence */
DROP sequence SEQUENCE_TEST;

CREATE SEQUENCE sequence_test START WITH 200 INCREMENT BY 1;


/* Q3 -- Test the sequence */
INSERT INTO LIVRE (idlivre, titre) VALUES (sequence_test.NEXTVAL, 'DUPONT');

SELECT sequence_test.CURRVAL
FROM dual;

/* Q4 -- Give access to COUERBE */
GRANT SELECT ON LIVRE TO c##COUERBE;

/* Q5 -- Test the sequence */
GRANT SELECT ON LIVRE TO c##COUERBE;

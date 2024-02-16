-- Cerinta cu numarul 12

/*
Definiți un trigger de tip LDD. Declanșați trigger-ul.
*/

/*
Un trigger care sa introduca intr-un tabel audit actiunile asupra bazei de date.
*/

DROP TABLE audit_cerinta_12;

CREATE TABLE audit_cerinta_12
    (utilizator     VARCHAR2(30),
    nume_bazadedate VARCHAR2(50),
    eveniment       VARCHAR2(20),
    nume_obiect     VARCHAR2(30),
    data            DATE);

CREATE OR REPLACE TRIGGER cerinta_12
    AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    INSERT INTO audit_cerinta_12
    VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT, 
            SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;
/

CREATE TABLE trigger_test (
    id_test INT NOT NULL PRIMARY KEY
);

DROP TABLE trigger_test;

SELECT * FROM audit_cerinta_12;

DROP TRIGGER cerinta_12;
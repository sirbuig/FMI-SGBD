-- Cerinta cu numarul 8

/*
Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat
independent de tip funcție care să utilizeze într-o singură comandă SQL 3 dintre tabelele definite. 
Definiți minim 2 excepții proprii. Apelați subprogramul astfel încât să evidențiați toate cazurile 
definite și tratate
*/

/*
Profesorii vor sa verifice performanta clasei la anumite teste.
Astfel, sa se afiseze media fiecarui test dintr-o clasa.
*/

CREATE OR REPLACE FUNCTION cerinta_8(id_clasa_param IN INT) RETURN SYS_REFCURSOR
IS
    cursorRezultat SYS_REFCURSOR;
    ClasaInexistenta EXCEPTION;
    ClasaFaraTeste EXCEPTION;
    clasaCount INT;
    testeCount INT;
BEGIN
    SELECT COUNT(*) INTO clasaCount FROM clase WHERE id_clasa = id_clasa_param;
    IF clasaCount = 0 THEN
        RAISE ClasaInexistenta;
    END IF;

    SELECT COUNT(*) INTO testeCount FROM teste WHERE id_clasa = id_clasa_param;
    IF testeCount = 0 THEN
        RAISE ClasaFaraTeste;
    END IF;

    OPEN cursorRezultat FOR
        SELECT c.nume_clasa AS "Clasa", t.titlu AS "TitluTest", COALESCE(TRUNC(AVG(ult.nota), 2), 0) AS "MediaNotelor"
        FROM clase c
        INNER JOIN teste t ON c.id_clasa = t.id_clasa
        LEFT JOIN utilizatori_lucreaza_teste ult ON t.id_test = ult.id_test
        WHERE c.id_clasa = id_clasa_param
        GROUP BY c.nume_clasa, t.titlu;

    RETURN cursorRezultat;
EXCEPTION
    WHEN ClasaInexistenta THEN
        DBMS_OUTPUT.PUT_LINE('Clasa cu ID-ul ' || id_clasa_param || ' nu există.');
        RETURN NULL;
    WHEN ClasaFaraTeste THEN
        DBMS_OUTPUT.PUT_LINE('Clasa cu ID-ul ' || id_clasa_param || ' nu conține teste.');
        RETURN NULL;
END;
/


DECLARE
    curs SYS_REFCURSOR;
    clasa VARCHAR2(100);
    titluTest VARCHAR2(100);
    mediaNotelor NUMBER;
BEGIN
-- Clasa inexistenta
    curs := cerinta_8(14);
-- Clasa fara teste
    -- curs := cerinta_8(13);
-- Functioneaza
    -- curs := cerinta_8(1);

    LOOP
        FETCH curs INTO clasa, titluTest, mediaNotelor;
        EXIT WHEN curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Clasa ' || clasa || ' --- Medie test ' || titluTest || ': ' || mediaNotelor);
    END LOOP;

    CLOSE curs;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A apărut o eroare: ' || SQLERRM);
        IF curs IS NOT NULL THEN
            CLOSE curs;
        END IF;
END;
/

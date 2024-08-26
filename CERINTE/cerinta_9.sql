-- Cerinta cu numarul 9
/*
Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat 
independent de tip procedură care să utilizeze într-o singură comandă SQL 5 dintre tabelele 
definite. Tratați toate excepțiile care pot apărea, incluzând excepțiile NO_DATA_FOUND și 
TOO_MANY_ROWS. Apelați subprogramul astfel încât să evidențiați toate cazurile tratate.
*/

/*
Intrucat scopul grupurilor este de a aduna oameni pasionati de acelasi subiect, creatorii grupurilor
doresc sa filtreze grupurile de membrii inactivi. Un membru inactiv se considera daca nu are resurse
accesate, nu este intr-o clasa si nu are probleme lucrate. Desigur, inclusiv creatorul grupului se poate
afla pe lista membrilor inactivi.

Exceptiile care pot aparea:
- id_utilizator este profesor -> nu are voie sa acceseze grupuri;
- id_utilizator nu are grupuri sau nu este in baza de date (NO_DATA_FOUND);
- id_utilizator are mai multe grupuri (TOO_MANY_ROWS) -> se continua cu id-ul grupului cel mai mic.
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE cerinta_9(p_id_utilizator INT) IS
    v_tip_utilizator utilizatori.tip_utilizator%TYPE;
    v_nume_grup grupuri.nume_grup%TYPE;
    v_id_grup INT;
    v_exista_membri_inactivi BOOLEAN := FALSE;
BEGIN
    SELECT tip_utilizator INTO v_tip_utilizator FROM utilizatori WHERE id_utilizator = p_id_utilizator;
    IF v_tip_utilizator = 'Profesor' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sunteți profesor, nu puteți accesa grupuri.');
    END IF;
    
    BEGIN
        SELECT id_grup INTO v_id_grup FROM grupuri WHERE id_creator = p_id_utilizator;
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            SELECT MIN(id_grup) INTO v_id_grup FROM grupuri WHERE id_creator = p_id_utilizator;
            DBMS_OUTPUT.PUT_LINE('Prea multe grupuri găsite. Se folosește grupul cu ID-ul cel mai mic.');
    END;
    
    SELECT nume_grup INTO v_nume_grup FROM grupuri WHERE id_grup = v_id_grup;
    
    FOR r_inactivi IN (
        SELECT u.nume, u.prenume, u.id_utilizator
        FROM utilizatori u
        JOIN utilizatori_creeaza_grupuri ucg ON u.id_utilizator = ucg.id_utilizator AND ucg.id_grup = v_id_grup
        LEFT JOIN utilizatori_acceseaza_resurse uar ON u.id_utilizator = uar.id_utilizator
        LEFT JOIN utilizatori_apartin_in_clase uaic ON u.id_utilizator = uaic.id_utilizator
        LEFT JOIN utilizatori_rezolva_probleme urp ON u.id_utilizator = urp.id_utilizator
        WHERE uar.id_resursa IS NULL AND uaic.id_clasa IS NULL AND urp.id_problema IS NULL
        GROUP BY u.nume, u.prenume, u.id_utilizator
    ) LOOP
        IF NOT v_exista_membri_inactivi THEN
            DBMS_OUTPUT.PUT_LINE('In grupul ' || v_nume_grup || ' membrii inactivi sunt:');
            v_exista_membri_inactivi := TRUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('--- ' || r_inactivi.nume || ' ' || r_inactivi.prenume || ', ID: ' || r_inactivi.id_utilizator);
    END LOOP;
    
    IF NOT v_exista_membri_inactivi THEN
        DBMS_OUTPUT.PUT_LINE('In grupul ' || v_nume_grup || ' toți sunt activi!');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Utilizatorul nu este în baza de date sau nu are grupuri.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare neașteptată: ' || SQLERRM);
END;
/

-- TOO_MANY_ROWS
BEGIN
    cerinta_9(4);
END;
/

-- NO_DATA_FOUND
BEGIN
    cerinta_9(1001);
END;
/

-- PROFESOR
BEGIN
    cerinta_9(2);
END;
/

-- CAZ INACTIVI
BEGIN
    cerinta_9(15);
END;
/

-- CAZ ACTIVI
BEGIN
    cerinta_9(1);
END;
/
-- Cerinta cu numarul 11

/*
Definiți un trigger de tip LMD la nivel de linie. Declanșați trigger-ul.
*/

/*
Pentru a promova excelenta, noi certificate se vor adauga pe platforma.
Cu toate acestea, pentru fiecare certificat nou, in cazul in care sunt deja utilizatori
eligibili, sa fie adaugat acel certificat pe lista lor de certificate deblocate.

Daca disciplina certificatului este 'General', atunci numarul total de probleme indiferent de
domeniu, trebuie sa fie >= de pragul necesar.
Daca disciplina certificatului este un domeniu specific, numarul de probleme trebuie sa fie
din acel de domeniu si sa respecte pragul.
*/

CREATE OR REPLACE TRIGGER cerinta_11
AFTER INSERT ON certificate
FOR EACH ROW
DECLARE
    v_nr_probleme INT;
BEGIN
    IF :NEW.disciplina = 'General' THEN
        FOR r_user IN (SELECT id_utilizator FROM utilizatori) LOOP
            SELECT COUNT(*)
            INTO v_nr_probleme
            FROM utilizatori_rezolva_probleme urp
            JOIN probleme p ON urp.id_problema = p.id_problema
            WHERE urp.id_utilizator = r_user.id_utilizator;

            IF v_nr_probleme >= :NEW.prag_deblocare THEN
                INSERT INTO utilizatori_deblocheaza_certif (id_deblocare, id_utilizator, id_certificat, data_obtinerii)
                VALUES (seq_debloc_certif.NEXTVAL, r_user.id_utilizator, :NEW.id_certificat, SYSDATE);
            END IF;
        END LOOP;
    ELSE
        FOR r_user IN (SELECT id_utilizator FROM utilizatori) LOOP
            SELECT COUNT(*)
            INTO v_nr_probleme
            FROM utilizatori_rezolva_probleme urp
            JOIN probleme p ON urp.id_problema = p.id_problema
            WHERE urp.id_utilizator = r_user.id_utilizator AND p.disciplina = :NEW.disciplina;

            IF v_nr_probleme >= :NEW.prag_deblocare THEN
                INSERT INTO utilizatori_deblocheaza_certif (id_deblocare, id_utilizator, id_certificat, data_obtinerii)
                VALUES (seq_debloc_certif.NEXTVAL, r_user.id_utilizator, :NEW.id_certificat, SYSDATE);
            END IF;
        END LOOP;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare neașteptată: ' || SQLERRM);
END;
/

SELECT * FROM utilizatori_deblocheaza_certif;

BEGIN
    INSERT INTO certificate VALUES(15, 'Test', '3 probleme rezolvate', 3, 'General');
END;
/

SELECT * FROM utilizatori_deblocheaza_certif;

DROP TRIGGER cerinta_11;
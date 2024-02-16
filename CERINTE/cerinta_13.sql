-- Cerinta cu numarul 13

/*
Definiți un pachet care să conțină toate obiectele definite în cadrul proiectului.
*/

CREATE OR REPLACE PACKAGE pachet_learnitude AS

  FUNCTION cerinta_8(id_clasa_param IN INT) RETURN SYS_REFCURSOR;

  PROCEDURE cerinta_6;
  PROCEDURE cerinta_7;
  PROCEDURE cerinta_9(p_id_utilizator INT);

END pachet_learnitude;
/

CREATE OR REPLACE PACKAGE BODY pachet_learnitude AS
-- ~~~ 6 ~~~
    PROCEDURE cerinta_6 IS
        TYPE t_clase_varray IS VARRAY(100) OF VARCHAR2(100);
        clase t_clase_varray := t_clase_varray();
        
        TYPE t_forum_record IS RECORD (
            id_forum INT,
            subiect VARCHAR2(100)
        );
        TYPE t_forum_nt IS TABLE OF t_forum_record;
        
        TYPE t_postare_record IS RECORD (
            id_postare INT,
            continut VARCHAR2(150)
        );
        TYPE t_postare_tab IS TABLE OF t_postare_record INDEX BY BINARY_INTEGER;

        forumuri t_forum_nt;
        postari t_postare_tab;
    BEGIN
        SELECT nume_clasa BULK COLLECT INTO clase FROM (SELECT nume_clasa FROM clase);
        
        FOR i IN 1..clase.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('*Clasa: ' || clase(i));
            
            SELECT id_forum, subiect BULK COLLECT INTO forumuri FROM forum WHERE id_clasa = (SELECT id_clasa FROM clase WHERE nume_clasa = clase(i));
            
            IF forumuri.COUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('---Clasa nu are forumuri inca!');
            ELSE
                FOR j IN 1..forumuri.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE('---Forum: ' || forumuri(j).subiect);
                    
                    SELECT id_postare, continut BULK COLLECT INTO postari FROM postari WHERE id_forum = forumuri(j).id_forum;
                    
                    IF postari.COUNT = 0 THEN
                        DBMS_OUTPUT.PUT_LINE('------Forumul nu are postari inca!');
                    ELSE
                        FOR k IN 1..postari.COUNT LOOP
                            DBMS_OUTPUT.PUT_LINE('------Postare: ' || postari(k).continut);
                        END LOOP;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
    END cerinta_6;
    
-- ~~~ 7 ~~~
    PROCEDURE cerinta_7 IS
        CURSOR c_profesori IS
            SELECT p.id_profesor, u.nume AS nume_profesor, u.prenume AS prenume_profesor, c.nume_clasa, c.id_clasa
            FROM profesori p
            JOIN utilizatori u ON p.id_utilizator = u.id_utilizator
            JOIN clase c ON p.id_profesor = c.id_profesor
            WHERE EXISTS (
                SELECT 1
                FROM utilizatori_apartin_in_clase uac
                WHERE uac.id_clasa = c.id_clasa
            );
        
        CURSOR c_accesari_totale_resurse (p_id_resursa INT) IS
            SELECT COUNT(*) AS nr_accesari_totale
            FROM utilizatori_acceseaza_resurse
            WHERE id_resursa = p_id_resursa;
        
        v_nr_accesari_totale INT;
        v_tip_utilizator VARCHAR2(10);
        
    BEGIN
        FOR v_profesor IN c_profesori LOOP
            DBMS_OUTPUT.PUT_LINE('*Profesor ' || v_profesor.nume_profesor || ' ' || v_profesor.prenume_profesor || ' - Clasa: ' || v_profesor.nume_clasa);
            
            DECLARE
                v_resurse_gasite BOOLEAN := FALSE;
                
                CURSOR c_resurse (p_id_clasa INT) IS
                    SELECT r.id_resursa, r.titlu, u.nume, u.prenume, u.tip_utilizator
                    FROM utilizatori_acceseaza_resurse uar
                    JOIN resurse r ON uar.id_resursa = r.id_resursa
                    JOIN utilizatori u ON uar.id_utilizator = u.id_utilizator
                    JOIN utilizatori_apartin_in_clase uac ON u.id_utilizator = uac.id_utilizator
                    WHERE uac.id_clasa = p_id_clasa
                    GROUP BY r.id_resursa, r.titlu, u.nume, u.prenume, u.tip_utilizator;
                    
            BEGIN
                FOR v_resursa IN c_resurse(v_profesor.id_clasa) LOOP
                    v_resurse_gasite := TRUE;
                    
                    IF v_resursa.tip_utilizator = 'Elev' THEN
                        v_tip_utilizator := 'elevul';
                    ELSIF v_resursa.tip_utilizator = 'Student' THEN
                        v_tip_utilizator := 'studentul';
                    ELSE
                        v_tip_utilizator := 'utilizatorul';
                    END IF;
                    
                    FOR v_accesari IN c_accesari_totale_resurse(v_resursa.id_resursa) LOOP
                        v_nr_accesari_totale := v_accesari.nr_accesari_totale;
                    END LOOP;
                    
                    DBMS_OUTPUT.PUT_LINE('---Resursa ' || v_resursa.titlu || ' accesata de ' || v_tip_utilizator || ' ' || v_resursa.nume || ' ' || v_resursa.prenume);
                    DBMS_OUTPUT.PUT_LINE('------Accesari totale resursa: ' || v_nr_accesari_totale);
                END LOOP;
                
                IF NOT v_resurse_gasite THEN
                    DBMS_OUTPUT.PUT_LINE('~In aceasta clasa nimeni nu a accesat resurse!');
                END IF;
            END;
        END LOOP;
    END cerinta_7;

-- ~~~ 8 ~~~
    FUNCTION cerinta_8(id_clasa_param IN INT) RETURN SYS_REFCURSOR
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

-- ~~~ 9 ~~~
    PROCEDURE cerinta_9(p_id_utilizator INT) IS
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
END pachet_learnitude;
/

DECLARE
    curs SYS_REFCURSOR;
    clasa VARCHAR2(100);
    titluTest VARCHAR2(100);
    mediaNotelor NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('---Cerinta 6:');
    pachet_learnitude.cerinta_6;

    DBMS_OUTPUT.PUT_LINE('==============');
    DBMS_OUTPUT.PUT_LINE('---Cerinta 7:');
    pachet_learnitude.cerinta_7;

    BEGIN
        DBMS_OUTPUT.PUT_LINE('==============');
        DBMS_OUTPUT.PUT_LINE('---Cerinta 8:');
        curs := pachet_learnitude.cerinta_8(1);
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

    DBMS_OUTPUT.PUT_LINE('==============');
    DBMS_OUTPUT.PUT_LINE('---Cerinta 9:');
    pachet_learnitude.cerinta_9(1);
END;
/
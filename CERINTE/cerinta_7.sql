-- Cerinta cu numarul 7
/*
Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat
independent care să utilizeze 2 tipuri diferite de cursoare studiate, unul dintre acestea fiind cursor 
parametrizat, dependent de celălalt cursor. Apelați subprogramul.
*/

/*
Deoarece fiecare profesor doreste sa verifice daca elevii/studentii lor sunt interesati de materiale suplimentare,
cat si pentru a vedea care sunt resursele populare se cer urmatoarele:
Pentru fiecare profesor care detine o clasa (care are elevi/studenti), afiseaza resursele accesate de elevii/studentii 
din clasa respectiva.
La fiecare resursa arata numarul maxim total de accesari.
*/

CREATE OR REPLACE PROCEDURE cerinta_7 IS
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
/

BEGIN
    cerinta_7;
END;
/
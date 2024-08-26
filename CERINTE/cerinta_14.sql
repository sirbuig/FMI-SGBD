-- Cerinta cu numarul 14

SET SERVEROUTPUT ON;

DROP TYPE tip_rezultat_acces_resursa_tab;
DROP TYPE tip_rezultat_acces_resursa_rec;

CREATE OR REPLACE TYPE tip_rezultat_acces_resursa_rec AS OBJECT (
    id_utilizator INT,
    id_resursa INT,
    titlu VARCHAR2(100),
    tip_resursa VARCHAR2(10)
);
/

CREATE OR REPLACE TYPE tip_rezultat_acces_resursa_tab IS TABLE OF tip_rezultat_acces_resursa_rec;
/


CREATE OR REPLACE PACKAGE cerinta_14 IS

    TYPE tip_utilizator_complet IS RECORD (
        id_utilizator INT,
        nume VARCHAR2(50),
        prenume VARCHAR2(50),
        email VARCHAR2(100),
        tip_utilizator VARCHAR2(10),
        detalii VARCHAR2(100));
    
    TYPE tip_rezultat_acces_resursa IS RECORD (
        id_utilizator INT,
        id_resursa INT,
        titlu VARCHAR2(100),
        tip_resursa VARCHAR2(10)
    );
    
    FUNCTION ObtineInfoUtilizator(id_utilizator_input INT) RETURN tip_utilizator_complet;
    FUNCTION ListaResurseAccesate(id_utilizator_input INT) RETURN tip_rezultat_acces_resursa_tab PIPELINED;  
     
    PROCEDURE AdaugaUtilizator(p_nume VARCHAR2, p_prenume VARCHAR2, p_email VARCHAR2, p_parola VARCHAR2, p_tip_utilizator VARCHAR2, p_detalii VARCHAR2);
    PROCEDURE AdaugaUtilizatorInClasa(id_utilizator_input INT, id_clasa_input INT);
    
END cerinta_14;
/

CREATE OR REPLACE PACKAGE BODY cerinta_14 IS

    FUNCTION ObtineInfoUtilizator(id_utilizator_input INT) RETURN tip_utilizator_complet IS
        rezultat tip_utilizator_complet;
    BEGIN
        SELECT u.id_utilizator, u.nume, u.prenume, u.email, u.tip_utilizator,
        CASE
                WHEN u.tip_utilizator = 'Elev' THEN
                    (SELECT profil || ', ' || clasa FROM elevi WHERE id_utilizator = u.id_utilizator)
                WHEN u.tip_utilizator = 'Student' THEN
                    (SELECT specializare || ', ' || an_studiu FROM studenti WHERE id_utilizator = u.id_utilizator)
                WHEN u.tip_utilizator = 'Profesor' THEN
                    (SELECT specializare FROM profesori WHERE id_utilizator = u.id_utilizator)
            END AS detalii
        INTO rezultat
        FROM utilizatori u
        WHERE u.id_utilizator = id_utilizator_input;
        
        RETURN rezultat;
    END ObtineInfoUtilizator;

    FUNCTION ListaResurseAccesate(id_utilizator_input INT) RETURN tip_rezultat_acces_resursa_tab PIPELINED IS
    BEGIN
        FOR rec IN (SELECT ur.id_utilizator, ur.id_resursa, r.titlu, r.tip_resursa
                    FROM utilizatori_acceseaza_resurse ur
                    JOIN resurse r ON ur.id_resursa = r.id_resursa
                    WHERE ur.id_utilizator = id_utilizator_input)
        LOOP
            PIPE ROW(tip_rezultat_acces_resursa_rec(rec.id_utilizator, rec.id_resursa, rec.titlu, rec.tip_resursa));
        END LOOP;
        
        RETURN;
    END ListaResurseAccesate;


    PROCEDURE AdaugaUtilizator(
            p_nume VARCHAR2, 
            p_prenume VARCHAR2, 
            p_email VARCHAR2, 
            p_parola VARCHAR2, 
            p_tip_utilizator VARCHAR2, 
            p_detalii VARCHAR2) 
    IS
        v_exist INT;
    BEGIN
        SELECT COUNT(*)
        INTO v_exist
        FROM utilizatori
        WHERE email = p_email;

        IF v_exist = 0 THEN
            INSERT INTO utilizatori (id_utilizator, nume, prenume, email, parola, tip_utilizator)
            VALUES (seq_utilizatori.NEXTVAL, p_nume, p_prenume, p_email, p_parola, p_tip_utilizator);

            IF p_tip_utilizator = 'Elev' THEN
                INSERT INTO elevi (id_elev, id_utilizator, profil, clasa)
                VALUES (seq_elevi.NEXTVAL, seq_utilizatori.CURRVAL, SUBSTR(p_detalii, 1, INSTR(p_detalii, ',')-1), SUBSTR(p_detalii, INSTR(p_detalii, ',')+2));
            ELSIF p_tip_utilizator = 'Student' THEN
                INSERT INTO studenti (id_student, id_utilizator, specializare, an_studiu)
                VALUES (seq_studenti.NEXTVAL, seq_utilizatori.CURRVAL, SUBSTR(p_detalii, 1, INSTR(p_detalii, ',')-1), SUBSTR(p_detalii, INSTR(p_detalii, ',')+2));
            ELSIF p_tip_utilizator = 'Profesor' THEN
                INSERT INTO profesori (id_profesor, id_utilizator, specializare)
                VALUES (seq_profesori.NEXTVAL, seq_utilizatori.CURRVAL, p_detalii);
            END IF;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Utilizatorul există deja în baza de date cu adresa de email ' || p_email);
        END IF;
    END AdaugaUtilizator;



    PROCEDURE AdaugaUtilizatorInClasa(id_utilizator_input INT, id_clasa_input INT) IS
        v_count_user INT;
        v_count_clasa INT;
        v_count_in_clasa INT;
    BEGIN
        SELECT COUNT(*)
        INTO v_count_user
        FROM utilizatori
        WHERE id_utilizator = id_utilizator_input;

        SELECT COUNT(*)
        INTO v_count_clasa
        FROM clase
        WHERE id_clasa = id_clasa_input;

        SELECT COUNT(*)
        INTO v_count_in_clasa
        FROM utilizatori_apartin_in_clase
        WHERE id_utilizator = id_utilizator_input AND id_clasa = id_clasa_input;

        IF v_count_user > 0 AND v_count_clasa > 0 AND v_count_in_clasa = 0 THEN
            INSERT INTO utilizatori_apartin_in_clase (id_clasa, id_utilizator)
            VALUES (id_clasa_input, id_utilizator_input);
        ELSIF v_count_user = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'ID-ul utilizatorului nu există.');
        ELSIF v_count_clasa = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'ID-ul clasei nu există.');
        ELSIF v_count_in_clasa > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Utilizatorul este deja inscris in clasa.');
        END IF;
    END AdaugaUtilizatorInClasa;

END cerinta_14;
/

BEGIN
    cerinta_14.AdaugaUtilizator('Ion', 'Ionescu', 'ion.ionescu@learnitude.com', 'parola123', 'Elev', 'Real, 10');
END;
/

select * from utilizatori;

BEGIN
    cerinta_14.AdaugaUtilizatorInClasa(99, 1);
END;
/

select * from utilizatori_apartin_in_clase;

DECLARE
    v_info_utilizator cerinta_14.tip_utilizator_complet;
BEGIN
    v_info_utilizator := cerinta_14.ObtineInfoUtilizator(1);

    DBMS_OUTPUT.PUT_LINE('Nume: ' || v_info_utilizator.nume || ', Email: ' || v_info_utilizator.email || ', ' || v_info_utilizator.detalii);
END;
/

DECLARE
    v_count INT := 0;
BEGIN
    FOR rec IN (SELECT * FROM TABLE(cerinta_14.ListaResurseAccesate(id_utilizator_input => 31))) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Utilizator: ' || rec.id_utilizator || 
                             ', ID Resursa: ' || rec.id_resursa || 
                             ', Titlu: ' || rec.titlu || 
                             ', Tip Resursa: ' || rec.tip_resursa);
        v_count := v_count + 1;
    END LOOP;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Utilizatorul nu a accesat resurse.');
    END IF;
END;
/
-- Cerinta cu numarul 6
/* 
Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat
independent care să utilizeze toate cele 3 tipuri de colecții studiate. Apelați subprogramul.
*/

/*
Pentru fiecare clasa afisati forumurile ei, iar pentru fiecare forum, toate postarile lui.
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE cerinta_6 IS
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
/

BEGIN
    cerinta_6;
END;
/

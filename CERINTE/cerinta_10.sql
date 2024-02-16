-- Cerinta cu numarul 10

/*
Definiți un trigger de tip LMD la nivel de comandă. Declanșați trigger-ul.
*/

/*
Pentru a se evita spam-ul pe forumuri, s-a decis sa se impuna o limita de maxim
10 postari / forum. In acest fel, se pot controla mai usor topic-urile discutate.
*/

CREATE OR REPLACE TRIGGER cerinta_10
BEFORE INSERT ON postari
FOR EACH ROW
DECLARE
    v_nr_postari INT;
BEGIN
    SELECT COUNT(*)
    INTO v_nr_postari
    FROM postari
    WHERE id_forum = :NEW.id_forum;

    IF v_nr_postari >= 10 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Pentru a se evita spam-ul, nu se pot insera mai mult de 10 postari!');
    END IF;
END;
/

-- NU SE DECLANSEAZA (SUNTEM IN LIMITA DE POSTARI)
BEGIN
    INSERT INTO postari VALUES(6, 4, 76, 'Postarea 3');
    INSERT INTO postari VALUES(7, 4, 76, 'Postarea 4');
    INSERT INTO postari VALUES(8, 4, 76, 'Postarea 5');
    INSERT INTO postari VALUES(9, 4, 76, 'Postarea 6');
    INSERT INTO postari VALUES(10, 4, 76, 'Postarea 7');
    INSERT INTO postari VALUES(11, 4, 76, 'Postarea 8');
    INSERT INTO postari VALUES(12, 4, 76, 'Postarea 9');
    INSERT INTO postari VALUES(13, 4, 76, 'Postarea 10');
END;
/

SELECT * FROM postari;

-- ACUM SE DECLANSEAZA
BEGIN
    INSERT INTO postari VALUES(14, 4, 76, 'Postare 11 - trigger');
END;
/

DROP TRIGGER cerinta_10;
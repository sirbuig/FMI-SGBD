-- Crearea bazei de date 

DROP TABLE utilizatori CASCADE CONSTRAINTS;
DROP TABLE elevi CASCADE CONSTRAINTS;
DROP TABLE studenti CASCADE CONSTRAINTS;
DROP TABLE profesori CASCADE CONSTRAINTS;
DROP TABLE resurse CASCADE CONSTRAINTS;
DROP TABLE utilizatori_acceseaza_resurse CASCADE CONSTRAINTS;
DROP TABLE grupuri CASCADE CONSTRAINTS;
DROP TABLE utilizatori_creeaza_grupuri CASCADE CONSTRAINTS;
DROP TABLE certificate CASCADE CONSTRAINTS;
DROP TABLE utilizatori_deblocheaza_certif CASCADE CONSTRAINTS;
DROP SEQUENCE seq_debloc_certif;
DROP TABLE probleme CASCADE CONSTRAINTS;
DROP TABLE utilizatori_rezolva_probleme CASCADE CONSTRAINTS;
DROP TABLE clase CASCADE CONSTRAINTS;
DROP TABLE utilizatori_apartin_in_clase CASCADE CONSTRAINTS;
DROP TABLE teste CASCADE CONSTRAINTS;
DROP TABLE utilizatori_lucreaza_teste CASCADE CONSTRAINTS;
DROP TABLE forum CASCADE CONSTRAINTS;
DROP TABLE postari CASCADE CONSTRAINTS;

DROP SEQUENCE seq_profesori;
CREATE SEQUENCE seq_profesori START WITH 100 INCREMENT BY 1;

DROP SEQUENCE seq_elevi;
CREATE SEQUENCE seq_elevi START WITH 100 INCREMENT BY 1;

DROP SEQUENCE seq_studenti;
CREATE SEQUENCE seq_studenti START WITH 100 INCREMENT BY 1;

DROP SEQUENCE seq_profesori;
CREATE SEQUENCE seq_profesori START WITH 100 INCREMENT BY 1;


CREATE TABLE utilizatori (
    id_utilizator INT PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    parola VARCHAR2(100) NOT NULL,
    tip_utilizator VARCHAR2(10) NOT NULL,
    CHECK (tip_utilizator IN ('Elev', 'Student', 'Profesor'))
);

CREATE TABLE elevi (
    id_elev INT PRIMARY KEY,
    id_utilizator INT UNIQUE NOT NULL,
    profil VARCHAR2(10) NOT NULL CHECK (profil IN ('Real', 'Uman')),
    clasa VARCHAR2(10) NOT NULL CHECK (clasa IN ('9', '10', '11', '12')),
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE studenti (
    id_student INT PRIMARY KEY,
    id_utilizator INT UNIQUE NOT NULL,
    specializare VARCHAR2(100) NOT NULL,
    an_studiu VARCHAR2(10) NOT NULL CHECK (an_studiu IN ('I', 'II', 'III', 'IV')),
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE profesori (
    id_profesor INT PRIMARY KEY,
    id_utilizator INT UNIQUE NOT NULL,
    specializare VARCHAR2(100) NOT NULL,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE resurse (
    id_resursa INT PRIMARY KEY,
    titlu VARCHAR2(100) NOT NULL,
    descriere VARCHAR2(100),
    tip_resursa VARCHAR2(10) CHECK (tip_resursa IN ('Video', 'Document', 'Articol'))
);

CREATE TABLE utilizatori_acceseaza_resurse (
    id_utilizator INT,
    id_resursa INT,
    PRIMARY KEY (id_utilizator, id_resursa),
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE,
    FOREIGN KEY (id_resursa) REFERENCES resurse(id_resursa) ON DELETE CASCADE
);

CREATE TABLE grupuri (
    id_grup INT PRIMARY KEY,
    id_creator INT NOT NULL,
    nume_grup VARCHAR2(100) NOT NULL,
    descriere VARCHAR2(100),
    FOREIGN KEY (id_creator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE utilizatori_creeaza_grupuri (
    id_utilizator INT,
    id_grup INT,
    PRIMARY KEY (id_utilizator, id_grup),
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE,
    FOREIGN KEY (id_grup) REFERENCES grupuri(id_grup) ON DELETE CASCADE
);

CREATE TABLE certificate (
    id_certificat INT PRIMARY KEY,
    nume_certificat VARCHAR2(100) NOT NULL,
    descriere VARCHAR2(100),
    prag_deblocare INT,
    disciplina VARCHAR2(100)
);

CREATE TABLE utilizatori_deblocheaza_certif (
    id_deblocare INT PRIMARY KEY,
    id_utilizator INT,
    id_certificat INT,
    data_obtinerii DATE,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE,
    FOREIGN KEY (id_certificat) REFERENCES certificate(id_certificat) ON DELETE CASCADE
);

CREATE SEQUENCE seq_debloc_certif
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE probleme (
    id_problema INT PRIMARY KEY,
    id_profesor INT NOT NULL,
    descriere VARCHAR2(100) NOT NULL,
    dificultate VARCHAR2(10) NOT NULL CONSTRAINT dificultate_check CHECK (dificultate IN ('Usor', 'Mediu', 'Dificil')),
    disciplina VARCHAR2(100) NOT NULL,
    FOREIGN KEY (id_profesor) REFERENCES profesori(id_profesor)
);


CREATE TABLE utilizatori_rezolva_probleme (
    id_rezolvare INT PRIMARY KEY,
    id_utilizator INT,
    id_problema INT,
    scor_obtinut INT,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE,
    FOREIGN KEY (id_problema) REFERENCES probleme(id_problema) ON DELETE CASCADE
);

CREATE TABLE clase (
    id_clasa INT PRIMARY KEY,
    id_profesor INT NOT NULL,
    nume_clasa VARCHAR2(100) NOT NULL,
    descriere VARCHAR2(100),
    FOREIGN KEY (id_profesor) REFERENCES profesori(id_profesor) ON DELETE SET NULL
);

CREATE TABLE utilizatori_apartin_in_clase (
    id_clasa INT,
    id_utilizator INT,
    PRIMARY KEY (id_clasa, id_utilizator),
    FOREIGN KEY (id_clasa) REFERENCES clase(id_clasa) ON DELETE CASCADE,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE teste (
    id_test INT PRIMARY KEY,
    id_clasa INT NOT NULL,
    titlu VARCHAR2(100) NOT NULL,
    descriere VARCHAR2(100),
    FOREIGN KEY (id_clasa) REFERENCES clase(id_clasa) ON DELETE CASCADE
);

CREATE TABLE utilizatori_lucreaza_teste (
    id_rezultat INT PRIMARY KEY,
    id_utilizator INT,
    id_test INT,
    nota INT,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE,
    FOREIGN KEY (id_test) REFERENCES teste(id_test) ON DELETE CASCADE
);

CREATE TABLE forum (
    id_forum INT PRIMARY KEY,
    id_clasa INT NOT NULL,
    id_utilizator INT,
    subiect VARCHAR2(100) NOT NULL,
    FOREIGN KEY (id_clasa) REFERENCES clase(id_clasa) ON DELETE CASCADE,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);

CREATE TABLE postari (
    id_postare INT PRIMARY KEY,
    id_forum INT NOT NULL,
    id_utilizator INT,
    continut VARCHAR2(150) NOT NULL,
    FOREIGN KEY (id_forum) REFERENCES forum(id_forum) ON DELETE CASCADE,
    FOREIGN KEY (id_utilizator) REFERENCES utilizatori(id_utilizator) ON DELETE CASCADE
);
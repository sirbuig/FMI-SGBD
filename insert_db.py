import csv
import random
import itertools
import pandas as pd

MAX_UTILIZATORI = 100
TIP_UTILIZATOR = ["Elev", "Student", "Profesor"]
PROFIL = ["Real", "Uman"]
CLASA = [9, 10, 11, 12]
SPECIALIZARE = ["Informatica", "Matematica", "Litere", "Istorie"]
AN_STUDIU = ['I', 'II', 'III']

tip_util = itertools.cycle(TIP_UTILIZATOR)
def urmatorul_tip():
    return next(tip_util)

db = open("insert_db_2.sql", 'w', encoding='utf-8')

# citim din CSVs

# prenume
prenume = []
with open("CSVs\\utilizatori_prenume.csv", 'r') as file:
    content = file.readlines()
prenume = [line.strip() for line in content[1:]]

# nume
nume = []
with open("CSVs\\utilizatori_nume.csv", 'r') as file:
    content = file.readlines()
nume = [line.strip() for line in content[1:]]

# parole
parole = []
with open("CSVs\\utilizatori_parola_criptata.csv", 'r') as file:
    content = file.readlines()
parole = [line.strip() for line in content[1:]]

# generam pentru tabela UTILIZATORI
def insert_utilizatori():
    db.write("-- TABELA UTILIZATORI\n")
    for i in range(MAX_UTILIZATORI):
        query = f"INSERT INTO utilizatori VALUES({i}, '{nume[i]}', '{prenume[i]}', '{prenume[i].lower()}.{nume[i].lower()}@learnitude.com', '{parole[i]}', '{urmatorul_tip()}');\n"
        db.write(query)
    db.write("\n")

# utilizatori
utilizatori_path = "CSVs\\utilizatori.csv"
utilizatori = pd.read_csv(utilizatori_path) # citeste dataframe-ul

# elevi, studenti, profesori
elevi = utilizatori[utilizatori['TIP_UTILIZATOR'] == 'Elev']
studenti = utilizatori[utilizatori['TIP_UTILIZATOR'] == 'Student']
profesori = utilizatori[utilizatori['TIP_UTILIZATOR'] == 'Profesor']

# certificate
certificate = pd.read_csv("CSVs\\certificate.csv")

# resurse
resurse = pd.read_csv("CSVs\\resurse.csv")

# grupuri
grupuri = pd.read_csv("CSVs\\grupuri.csv")

# probleme
probleme = pd.read_csv("CSVs\\probleme.csv")

# clase
clase = pd.read_csv("CSVs\\clase.csv")

# teste
teste = pd.read_csv("CSVs\\teste.csv")

# forum
forum = pd.read_csv("CSVs\\forum.csv")

# postari
postari = pd.read_csv("CSVs\\postari.csv")

# generam pentru tabela ELEVI
def insert_elevi():
    db.write("-- TABELA ELEVI\n")
    for index, row in elevi.iterrows():
        id_utilizator = row['ID_UTILIZATOR']
        profil = random.choice(PROFIL)
        clasa = random.choice(CLASA)
        query = f"INSERT INTO elevi VALUES({id_utilizator}, {id_utilizator}, '{profil}', '{clasa}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela STUDENTI
def insert_studenti():
    db.write("-- TABELA STUDENTI\n")
    for index, row in studenti.iterrows():
        id_utilizator = row['ID_UTILIZATOR']
        specializare = random.choice(SPECIALIZARE)
        an_studiu = random.choice(AN_STUDIU)
        query = f"INSERT INTO studenti VALUES({id_utilizator}, {id_utilizator}, '{specializare}', '{an_studiu}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela PROFESORI
def insert_profesori():
    db.write("-- TABELA PROFESORI\n")
    for index, row in profesori.iterrows():
        id_utilizator = row['ID_UTILIZATOR']
        specializare = random.choice(SPECIALIZARE)
        query = f"INSERT INTO profesori VALUES({id_utilizator}, {id_utilizator}, '{specializare}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela CERTIFICATE
def insert_certificate():
    db.write("-- TABELA CERTIFICATE\n")
    for index, row in certificate.iterrows():
        id_certificat = row['ID_CERTIFICAT']
        nume_certificat = row['NUME_CERTIFICAT']
        descriere = row['DESCRIERE']
        query = f"INSERT INTO certificate VALUES({id_certificat}, '{nume_certificat}', '{descriere}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela RESURSE
def insert_resurse():
    db.write("-- TABELA RESURSE\n")
    for index, row in resurse.iterrows():
        id_resursa = row['ID_RESURSA']
        titlu = row['TITLU']
        descriere = row['DESCRIERE']
        tip_resursa = row['TIP_RESURSA']
        query = f"INSERT INTO resurse VALUES({id_resursa}, '{titlu}', '{descriere}', '{tip_resursa}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela GRUPURI
def insert_grupuri():
    db.write("-- TABELA GRUPURI\n")
    for index, row in grupuri.iterrows():
        id_grup = row['ID_GRUP']
        id_creator = row['ID_CREATOR']
        nume_grup = row['NUME_GRUP']
        descriere = row['DESCRIERE']
        query = f"INSERT INTO grupuri VALUES({id_grup}, {id_creator}, '{nume_grup}', '{descriere}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela PROBLEME
def insert_probleme():
    db.write("-- TABELA PROBLEME\n")
    for index, row in probleme.iterrows():
        id_problema = row['ID_PROBLEMA']
        id_profesor = row['ID_PROFESOR']
        descriere = row['DESCRIERE']
        dificultate = row['DIFICULTATE']
        disciplina  = row['DISCIPLINA']
        query = f"INSERT INTO probleme VALUES({id_problema}, {id_profesor}, '{descriere}', '{dificultate}', '{disciplina}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela CLASE
def insert_clase():
    db.write("-- TABELA CLASE\n")
    for index, row in clase.iterrows():
        id_clasa = row['ID_CLASA']
        id_profesor = row['ID_PROFESOR']
        nume_clasa = row['NUME_CLASA']
        descriere = row['DESCRIERE']
        query = f"INSERT INTO clase VALUES({id_clasa}, {id_profesor}, '{nume_clasa}', '{descriere}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela TESTE
def insert_teste():
    db.write("-- TABELA TESTE\n")
    for index, row in teste.iterrows():
        id_test = row['ID_TEST']
        id_clasa = row['ID_CLASA']
        titlu = row['TITLU']
        descriere = row['DESCRIERE']
        query = f"INSERT INTO teste VALUES({id_test}, {id_clasa}, '{titlu}', '{descriere}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela FORUM
def insert_forum():
    db.write("-- TABELA FORUM\n")
    for index, row in forum.iterrows():
        id_forum = row['ID_FORUM']
        id_clasa = row['ID_CLASA']
        id_utilizator = row['ID_UTILIZATOR']
        subiect = row['SUBIECT']
        query = f"INSERT INTO forum VALUES({id_forum}, {id_clasa}, {id_utilizator}, '{subiect}');\n"
        db.write(query)
    db.write("\n")

# generam pentru tabela POSTARI
def insert_postari():
    db.write("-- TABELA POSTARI\n")
    for index, row in postari.iterrows():
        id_postare = row['ID_POSTARE']
        id_forum = row['ID_FORUM']
        id_utilizator = row['ID_UTILIZATOR']
        continut = row['CONTINUT']
        query = f"INSERT INTO postari VALUES({id_postare}, {id_forum}, {id_utilizator}, '{continut}');\n"
        db.write(query)
    db.write("\n")

# insert_utilizatori()
# insert_elevi()
# insert_studenti()
# insert_profesori()
insert_certificate()
insert_resurse()
insert_grupuri()
insert_probleme()
insert_clase()
insert_teste()
insert_forum()
insert_postari()
db.close()
-- TABELA CERTIFICATE
INSERT INTO certificate VALUES(0, 'Rezolvitor junior', 'Ai rezolvat 5 probleme!');
INSERT INTO certificate VALUES(1, 'Rezolvitor avansat', 'Ai rezolvat 10 probleme!');
INSERT INTO certificate VALUES(2, 'Rezolvitor expert', 'Ai rezolvat 15 probleme!');
INSERT INTO certificate VALUES(3, 'Pseudocod', 'Ai rezolvat 1 problema de informatica!');
INSERT INTO certificate VALUES(4, 'Algoritmi fundamentali', 'Ai rezolvat 5 probleme de informatica!');
INSERT INTO certificate VALUES(5, 'Premiul Turing', 'Ai rezolvat 10 probleme de informatica!');
INSERT INTO certificate VALUES(6, '1+1', 'Ai rezolvat 1 problema de matematica!');
INSERT INTO certificate VALUES(7, 'Pitagora', 'Ai rezolvat 5 probleme de matematica!');
INSERT INTO certificate VALUES(8, 'Medalia Fields', 'Ai rezolvat 10 probleme de matematica!');
INSERT INTO certificate VALUES(9, 'Alfabet', 'Ai rezolvat 1 problema de Litere!');
INSERT INTO certificate VALUES(10, 'Eminescu', 'Ai rezolvat 5 probleme de Litere!');
INSERT INTO certificate VALUES(11, 'Premiul Nobel', 'Ai rezolvat 10 probleme de Litere!');
INSERT INTO certificate VALUES(12, 'Aventura in trecut', 'Ai rezolvat 1 problema de Istorie!');
INSERT INTO certificate VALUES(13, 'Explorator', 'Ai rezolvat 5 probleme de Istorie!');
INSERT INTO certificate VALUES(14, 'Premiul Pulitzer', 'Ai rezolvat 10 probleme de Istorie!');

-- TABELA RESURSE
INSERT INTO resurse VALUES(1, 'Istoria Artei', 'Un document care examinează evoluția artei de-a lungul secolelor.', 'Articol');
INSERT INTO resurse VALUES(2, 'Istoria Românilor', 'Analiză cronologică a evenimentelor majore din istoria românilor.', 'Articol');
INSERT INTO resurse VALUES(3, 'Teoria Numerelor', 'Introducere în teoria numerelor, numere prime, divizibilitate, criptografie.', 'Articol');
INSERT INTO resurse VALUES(4, 'Stilistică și Poetică', 'Explorează stilistica limbii și elementele poetice în literatură.', 'Articol');
INSERT INTO resurse VALUES(5, 'Baze de Date Relaționale', 'Coveră conceptele bazelor de date relaționale și utilizarea eficientă.', 'Articol');
INSERT INTO resurse VALUES(6, 'Criticism Literar', 'Discută abordări ale criticismului literar și aplicarea acestora.', 'Video');
INSERT INTO resurse VALUES(7, 'Probabilități și Statistică', 'Bazele teoriei probabilităților și statistică cu aplicații în științe.', 'Articol');
INSERT INTO resurse VALUES(8, 'Algoritmi și Structuri de Date', 'Introducere în algoritmica cu exemple vizuale pentru structuri de date.', 'Video');
INSERT INTO resurse VALUES(9, 'Algebră Linară', 'Compendiu despre conceptele fundamentale ale algebrei liniare.', 'Document');
INSERT INTO resurse VALUES(10, 'Geometrie Diferențială', 'Ghid vizual pentru geometria diferențială și aplicațiile sale.', 'Document');
INSERT INTO resurse VALUES(11, 'Literatură Română Contemporană', 'Investighează perioadele și autorii majori ai literaturii române.', 'Document');
INSERT INTO resurse VALUES(12, 'Istoria Literaturii Române', 'Explorare a perioadelor și autorilor majori ai literaturii române.', 'Articol');
INSERT INTO resurse VALUES(13, 'Fundamentele Programării', 'Explorează principiile scrierii codului și structurile de date.', 'Articol');
INSERT INTO resurse VALUES(14, 'Literatură Comparată', 'Compară lucrări literare oferind perspectivă asupra influențelor culturale.', 'Document');
INSERT INTO resurse VALUES(15, 'Istoria Civilizațiilor Antice', 'Explorează civilizațiile antice și originile societății moderne.', 'Document');
INSERT INTO resurse VALUES(16, 'Securitatea Informațiilor', 'Tutoriale despre importanța securității informației în era digitală.', 'Document');
INSERT INTO resurse VALUES(17, 'Preistorie și Arheologie', 'Prezintă descoperiri arheologice cheie pentru înțelegerea preistoriei.', 'Video');
INSERT INTO resurse VALUES(18, 'Programare Orientată pe Obiect', 'Despre paradigmele programării orientate pe obiect și aplicațiile lor.', 'Video');
INSERT INTO resurse VALUES(19, 'Analiză Matematică', 'Abordează principiile analizei matematice și rolul lor în matematica modernă.', 'Document');
INSERT INTO resurse VALUES(20, 'Istoria Europei Moderne', 'Documentează dezvoltarea istorică și culturală a Europei moderne.', 'Video');

-- TABELA GRUPURI
INSERT INTO grupuri VALUES(1, 15, 'Code Wizards', 'Grup de programare pentru schimb de idei și rezolvarea problemelor.');
INSERT INTO grupuri VALUES(2, 22, 'Literary Legends', 'Pentru iubitorii de literatură, discuții despre autori și opere.');
INSERT INTO grupuri VALUES(3, 61, 'Math Maratoners', 'Locul pentru discuții de matematică, teoreme și pregătire pentru concursuri.');
INSERT INTO grupuri VALUES(4, 4, 'History Buffs', 'Pentru fascinații de istorie, partajare de resurse și dezbateri istorice.');
INSERT INTO grupuri VALUES(5, 1, 'Digital Designers', 'Grup de design grafic și web, focus pe proiecte practice.');
INSERT INTO grupuri VALUES(6, 19, 'Algebra Allies', 'Dedicat algebrei, de la ecuații la teoria grupurilor.');
INSERT INTO grupuri VALUES(7, 72, 'Poetry Pals', 'Spatiu pentru poeți, scriere, critică și discuții despre poezii.');
INSERT INTO grupuri VALUES(8, 99, 'Ancient Civilizations', 'Explorarea civilizațiilor antice, de la Egipt la Roma.');
INSERT INTO grupuri VALUES(9, 42, 'Programming Prodigies', 'Pentru programatori tineri, focus pe algoritmi și structuri de date.');
INSERT INTO grupuri VALUES(10, 67, 'Calculus Crew', 'Focus pe calcul diferențial și integral pentru studenți și elevi.');

-- TABELA PROBLEME
INSERT INTO probleme VALUES(1, 17, 'Calculati derivata functiei f(x) = 3x^2 - 2x + 1.', 'Mediu', 'Matematica');
INSERT INTO probleme VALUES(2, 29, 'Determinati complexitatea timpului algoritmului de sortare bubble sort.', 'Usor', 'Informatica');
INSERT INTO probleme VALUES(3, 74, 'Detaliati cauzele si consecintele Revolutiei de la 1848 in tarile romane.', 'Mediu', 'Istorie');
INSERT INTO probleme VALUES(4, 71, 'Analizati tema si viziunea despre lume in poezia Luceafarul" de Mihai Eminescu."', 'Dificil', 'Litere');
INSERT INTO probleme VALUES(5, 74, 'Descrieti principalele cauze ale Primului Razboi Mondial.', 'Mediu', 'Istorie');
INSERT INTO probleme VALUES(6, 65, 'Rezolvati ecuatia de gradul 2: x^2 - 5x + 6 = 0.', 'Usor', 'Matematica');
INSERT INTO probleme VALUES(7, 29, 'Implementati o functie recursiva pentru calculul factorialului unui numar.', 'Mediu', 'Informatica');
INSERT INTO probleme VALUES(8, 59, 'Comentati caracterizarea personajului principal din romanul Morometii"."', 'Dificil', 'Litere');
INSERT INTO probleme VALUES(9, 11, 'Explicati impactul Revolutiei Industriale asupra societatii secolului XIX.', 'Mediu', 'Istorie');
INSERT INTO probleme VALUES(10, 8, 'Demonstrati convergenta sirului an = 1/n.', 'Usor', 'Matematica');
INSERT INTO probleme VALUES(11, 56, 'Construiti un algoritm pentru gasirea celui mai scurt drum intr-un graf.', 'Dificil', 'Informatica');
INSERT INTO probleme VALUES(12, 35, 'Analizati figura stilistica predominanta in poezia Plumb" de George Bacovia."', 'Mediu', 'Litere');
INSERT INTO probleme VALUES(13, 98, 'Discutati despre formarea statelor mediuvale romanesti.', 'Usor', 'Istorie');
INSERT INTO probleme VALUES(14, 89, 'Calculati limita la infinit a functiei f(x) = (3x^3 - x^2 + 2) / (2x^3 + 3x - 1).', 'Dificil', 'Matematica');
INSERT INTO probleme VALUES(15, 80, 'Descrieti principiul de functionare al unui sistem de operare.', 'Usor', 'Informatica');
INSERT INTO probleme VALUES(16, 47, 'Explicati semnificatia titlului romanului Ion" de Liviu Rebreanu."', 'Mediu', 'Litere');
INSERT INTO probleme VALUES(17, 53, 'Prezentati principalele evenimente din perioada interbelica.', 'Dificil', 'Istorie');
INSERT INTO probleme VALUES(18, 89, 'Integrati functia f(x) = e^x * sin(x).', 'Dificil', 'Matematica');
INSERT INTO probleme VALUES(19, 29, 'Explorati conceptul de mostenire in programarea orientata obiect.', 'Mediu', 'Informatica');
INSERT INTO probleme VALUES(20, 35, 'Analizati conceptul de neomodernism" in literatura romana."', 'Usor', 'Litere');
INSERT INTO probleme VALUES(21, 8, 'Integrati functia g(x) = x^2 * e^(-x).', 'Mediu', 'Matematica');
INSERT INTO probleme VALUES(22, 29, 'Analizati eficienta algoritmului quicksort.', 'Usor', 'Informatica');
INSERT INTO probleme VALUES(23, 71, 'Identificati temele principale din "Maitreyi".', 'Mediu', 'Litere');
INSERT INTO probleme VALUES(24, 53, 'Explicati rolul Congresului de la Viena.', 'Usor', 'Istorie');
INSERT INTO probleme VALUES(25, 17, 'Aflati solutia inecuatiei x^3 - 3x > 0.', 'Usor', 'Matematica');
INSERT INTO probleme VALUES(26, 29, 'Descrieti un algoritm de hashing eficient.', 'Mediu', 'Informatica');
INSERT INTO probleme VALUES(27, 71, 'Discutati stilul lui Caragiale in "O scrisoare pierduta".', 'Dificil', 'Litere');
INSERT INTO probleme VALUES(28, 98, 'Analizati efectele Reformei Protestante.', 'Mediu', 'Istorie');
INSERT INTO probleme VALUES(29, 17, 'Calculati aria sub graficul functiei f(x) = sin(x), x ∈ [0, π].', 'Usor', 'Matematica');
INSERT INTO probleme VALUES(30, 80, 'Creeaza o aplicatie CRUD simpla in Python.', 'Usor', 'Informatica');
INSERT INTO probleme VALUES(31, 47, 'Interpretati simbolismul in "Lacul" de Eminescu.', 'Mediu', 'Litere');
INSERT INTO probleme VALUES(32, 11, 'Descrieti cauzele Revolutiei Americane.', 'Usor', 'Istorie');
INSERT INTO probleme VALUES(33, 65, 'Demonstrati identitatea lui Euler pentru poliedre.', 'Dificil', 'Matematica');
INSERT INTO probleme VALUES(34, 80, 'Explicati modelul MVC in dezvoltarea web.', 'Mediu', 'Informatica');
INSERT INTO probleme VALUES(35, 80, 'Analizati naratiunea in "Ultima noapte de dragoste".', 'Dificil', 'Litere');
INSERT INTO probleme VALUES(36, 11, 'Prezentati impactul descoperirilor geografice.', 'Mediu', 'Istorie');
INSERT INTO probleme VALUES(37, 89, 'Studiati seria Taylor pentru e^x.', 'Mediu', 'Matematica');
INSERT INTO probleme VALUES(38, 56, 'Analiza complexitatii algoritmului merge sort.', 'Mediu', 'Informatica');
INSERT INTO probleme VALUES(39, 35, 'Tematica iubirii in "Floare albastra".', 'Usor', 'Litere');
INSERT INTO probleme VALUES(40, 53, 'Sumarizati evenimentele Revolutiei Franceze.', 'Mediu', 'Istorie');

-- TABELA CLASE
INSERT INTO clase VALUES(1, 17, 'Algebra Avansata', 'Clasa de matematica pentru nivel avansat.');
INSERT INTO clase VALUES(2, 29, 'Programare in Python', 'Introducere in programare cu Python.');
INSERT INTO clase VALUES(3, 74, 'Istoria Moderna', 'Curs despre evenimentele istorice moderne.');
INSERT INTO clase VALUES(4, 71, 'Literatura Romana', 'Analiza operei literare romanesti.');
INSERT INTO clase VALUES(5, 65, 'Geometrie Descriptiva', 'Studiu geometric si desen tehnic.');
INSERT INTO clase VALUES(6, 29, 'Bazele Informaticii', 'Fundamentele informaticii pentru incepatori.');
INSERT INTO clase VALUES(7, 59, 'Critica Literara', 'Tehnici de critica si analiza literara.');
INSERT INTO clase VALUES(8, 11, 'Istoria Antichitatii', 'Curs despre civilizatiile antice.');
INSERT INTO clase VALUES(9, 89, 'Calcul Diferential', 'Concepte fundamentale in calcul diferential.');
INSERT INTO clase VALUES(10, 56, 'Securitate Cibernetica', 'Principii de securitate in mediul online.');
INSERT INTO clase VALUES(11, 35, 'Istoria Artei', 'Evolutia artei de-a lungul istoriei.');
INSERT INTO clase VALUES(12, 77, 'Poezia Moderna', 'Studiu asupra poeziei moderne si contemporane.');

-- TABELA TESTE
INSERT INTO teste VALUES(1, 2, 'Fundamente Python', 'Test initial despre conceptele de baza in Python.');
INSERT INTO teste VALUES(2, 9, 'Test Derivate', 'Evaluare bazata pe derivate si aplicatii.');
INSERT INTO teste VALUES(3, 3, 'Revolutii Moderne', 'Test despre revolutiile moderne si impactul lor.');
INSERT INTO teste VALUES(4, 4, 'Romantismul in Literatura', 'Examen despre caracteristicile romantismului.');
INSERT INTO teste VALUES(5, 6, 'Logica Programarii', 'Testeaza logica si algoritmi de baza.');
INSERT INTO teste VALUES(6, 1, 'Algebra Liniara', 'Intrebari despre vectori, matrici si spatii vectoriale.');
INSERT INTO teste VALUES(7, 8, 'Civilizatii Antice', 'Quiz despre Egipt, Grecia si Roma antica.');
INSERT INTO teste VALUES(8, 7, 'Analiza Literara Avansata', 'Test avansat de analiza literara.');
INSERT INTO teste VALUES(9, 10, 'Securitate Web', 'Test bazat pe principiile securitatii web.');
INSERT INTO teste VALUES(10, 5, 'Geometrie Spatiala', 'Evaluare despre geometrie spatiala si proiectii.');
INSERT INTO teste VALUES(11, 11, 'Istoria Artei Moderne', 'Test despre arta moderna si curentele ei.');
INSERT INTO teste VALUES(12, 12, 'Modernism vs. Postmodernism', 'Comparatie intre modernism si postmodernism.');
INSERT INTO teste VALUES(13, 2, 'Structuri de Date', 'Test despre structuri de date in Python.');
INSERT INTO teste VALUES(14, 9, 'Integrare Functii', 'Test bazat pe integrarea functiilor de o variabila.');
INSERT INTO teste VALUES(15, 3, 'Testul Imperiilor', 'Quiz despre marile imperii ale lumii.');
INSERT INTO teste VALUES(16, 6, 'Bazele OOP', 'Test despre conceptele de baza ale programarii orientate pe obiect.');
INSERT INTO teste VALUES(17, 11, 'Barocul in Arta', 'Quiz despre caracteristicile barocului in arta.');
INSERT INTO teste VALUES(18, 1, 'Probleme de Optimizare', 'Test pe probleme de optimizare matematica.');
INSERT INTO teste VALUES(19, 12, 'Poezia Secolului XX', 'Intrebari despre poezia secolului al XX-lea.');

-- TABELA FORUM
INSERT INTO forum VALUES(1, 1, 34, 'Cate solutii aveti la ecuatie?');
INSERT INTO forum VALUES(2, 1, 34, 'Puteti sa imi explicati ultima problema de la test?');
INSERT INTO forum VALUES(3, 1, 67, 'Exista o metoda eficienta pentru calculul determinantilor?');
INSERT INTO forum VALUES(4, 3, 31, 'Care sunt cauzele Revolutiei Franceze?');
INSERT INTO forum VALUES(5, 12, 55, 'Cum interpretati Luceafarul de Mihai Eminescu?');

-- TABELA POSTARI
INSERT INTO postari VALUES(1, 1, 67, 'Eu am gasit 2 solutii.');
INSERT INTO postari VALUES(2, 2, 67, 'Se rezolva exact ca ultima problema de la Seminarul 4.');
INSERT INTO postari VALUES(3, 3, 34, 'Uita-te peste expansiunea Laplace sau peste eliminarea Gaussiana.');
INSERT INTO postari VALUES(4, 4, 73, 'Franta se confrunta cu o criza financiara grava...');
INSERT INTO postari VALUES(5, 4, 76, 'Nu uita si de faptul ca societatea franceza era nemultumita!');


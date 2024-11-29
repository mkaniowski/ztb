BEGIN;

CREATE TABLE klienci (
    idklienta varchar(10) NOT NULL,
    haslo varchar(10) NOT NULL,
    nazwa varchar(40) NOT NULL,
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(40) NOT NULL,
    email varchar(40),
    telefon varchar(16) NOT NULL,
    fax varchar(16),
    nip char(13),
    regon char(9)
);

CREATE TABLE kompozycje (
    idkompozycji char(5) NOT NULL,
    nazwa varchar(40) NOT NULL,
    opis varchar(100),
    cena numeric(7,2),
    minimum integer,
    stan integer
);


CREATE TABLE odbiorcy (
    idodbiorcy integer NOT NULL,
    nazwa varchar(40) NOT NULL,
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(60) NOT NULL
);


CREATE TABLE zamowienia (
    idzamowienia integer NOT NULL,
    idklienta varchar(10) NOT NULL,
    idodbiorcy integer NOT NULL,
    idkompozycji char(5) NOT NULL,
    termin date NOT NULL,
    cena numeric(7,2),
    zaplacone boolean,
    uwagi varchar(200)
);


--
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: wojnicki
--

INSERT INTO klienci VALUES ('msowins', 'msowins', 'Magdalena Sowinska', 'Krakow', '30-362', 'ul. Ceglarska 4/101', 'msowins@wp.pl', '(012) 664 46 99', '(012) 664 46 99', '707-709-12-13', '         ');
INSERT INTO klienci VALUES ('mbabik', 'mbabik', 'Malgorzata Babik', 'Krakow', '31-466', 'ul. Akacjowa 4', 'mbabik@wp.pl', '609 101 101', '', '687-988-66-66', '         ');
INSERT INTO klienci VALUES ('mfibak', 'mfibak', 'Marta Fibak', 'Zielonki', '32-087', 'Zielonki 4', 'mfibak@wp.pl', '(012) 622 22 85', '(012) 622 22 85', '121-657-09-08', '         ');
INSERT INTO klienci VALUES ('dniemcz', 'dniemcz', 'Damian Niemczyk', 'Slomniki', '32-090', 'ul. Niecala 9', 'dniemcz@wp.pl', '(012) 444 44 57', '(012) 444 44 57', '345-675-99-87', '         ');
INSERT INTO klienci VALUES ('gurbanik', 'gurbanik', 'Grzegorz Urbanik', 'Wieliczka', '32-020', 'ul. Kwiatowa 33', 'gurbanik@wp.pl', '0 609 506 606', '', '435-987-45-55', '         ');
INSERT INTO klienci VALUES ('pjurecz', 'pjurecz', 'Pawel Jureczek', 'Wieliczka', '32-020', 'ul. Legionow 4/53', 'pjurecz@wp.pl', '(012) 411 18 88', '', '707-709-12-14', '         ');
INSERT INTO klienci VALUES ('msrokiew', 'msrokiew', 'Marcin Srokiewicz', 'Krakow', '30-362', 'ul. Ceglarska 45/12', 'msrokiew@wp.pl', '609 102 102', '', '687-988-66-67', '         ');
INSERT INTO klienci VALUES ('bzameck', 'bzameck', 'Beata Zamecka', 'Krakow', '31-450', 'ul. Ulanow 21/64', 'bzameck@wp.pl', '(012) 634 77 09', '', '121-657-09-09', '         ');
INSERT INTO klienci VALUES ('gkiwi', 'gkiwi', 'Gabriela Kiwi', 'Krakow', '31-464', 'ul. Majowa 45/2', 'gkiwi@wp.pl', '(012) 630 00 12', '(012) 630 00 12', '345-675-99-88', '         ');
INSERT INTO klienci VALUES ('jkajdeck', 'jkajdeck', 'Jan Kajdecki', 'Krzeszowice', '32-065', 'ul. Piastowska 22/45', 'jkajdeck@wp.pl', '(012) 655 77 98', '(012) 655 77 98', '435-987-45-56', '         ');
INSERT INTO klienci VALUES ('acygan', 'acygan', 'Andrzej Cygan', 'Krakow', '30-838', 'ul. Heleny 24/1', 'acygan@wp.pl', '0 609 200 300', '', '707-709-12-15', '         ');
INSERT INTO klienci VALUES ('ztylutek', 'ztylutek', 'Zofia Tylutek', 'Krakow', '30-034', 'ul. Koscielna 45/100', 'ztylutek@wp.pl', '(012) 612 12 56', '', '687-988-66-68', '         ');
INSERT INTO klienci VALUES ('msitarz', 'msitarz', 'Marcin Sitarz', 'Wieliczka', '32-020', 'ul. Kwiatowa 2', 'msitarz@wp.pl', '609 100 101', '', '121-657-09-10', '         ');
INSERT INTO klienci VALUES ('ppsiarek', 'ppsiarek', 'Paulina Psiarek', 'Niepolomice', '32-005', 'ul. Wielicka 56', 'ppsiarek@wp.pl', '0 607 200 201', '', '345-675-99-89', '         ');
INSERT INTO klienci VALUES ('Ilipska', 'Ilipska', 'Iwona Lipska', 'Wieliczka', '32-020', 'ul. Urocza 8/7', 'Ilipska@wp.pl', '(012) 433 55 55', '(012) 433 55 55', '435-987-45-57', '         ');
INSERT INTO klienci VALUES ('mmoraw', 'mmoraw', 'Malgorzata Morawiec', 'Krzeszowice', '32-065', 'ul. Mila 576/5', 'mmoraw@wp.pl', '(012) 633 55 71', '', '707-709-12-16', '         ');
INSERT INTO klienci VALUES ('abazarek', 'abazarek', 'Anna Bazarek', 'Krakow', '31-546', 'ul. Aleja Pokoju 21/23', 'abazarek@wp.pl', '(012) 611 11 23', '', '687-988-66-69', '         ');
INSERT INTO klienci VALUES ('msowin', 'msowin', 'Marek Sowinski', 'Krakow', '30-362', 'ul. Ceglarska 4/101', 'msowin@wp.pl', '(012) 664 46 99', '(012) 664 46 99', '121-657-09-11', '         ');
INSERT INTO klienci VALUES ('mpalka', 'mpalka', 'Monika Palka', 'Krakow', '31-335', 'ul. Chabrowa 43', 'mpalka@wp.pl', '0 502 322 323', '', '345-675-99-90', '         ');
INSERT INTO klienci VALUES ('jmichno', 'jmichno', 'Jacek Michno', 'Wieliczka', '32-020', 'ul. Urocza 85/7', 'jmichno@onet.pl', '(012) 433 55 56', '', '707-709-12-14', '         ');
INSERT INTO klienci VALUES ('llipecki', 'llipecki', 'Lukasz Lipecki', 'Wieliczka', '32-020', 'ul. Urocza 7/66', 'llipecki@onet.pl', '605 200 200', '', '687-988-66-67', '         ');
INSERT INTO klienci VALUES ('dkopera', 'dkopera', 'Dorota Kopera', 'Slomniki', '32-090', 'ul. Niecala 6', 'dkopera@onet.pl', '(012) 444 44 56', '(012) 444 44 56', '121-657-09-09', '         ');
INSERT INTO klienci VALUES ('lwitek', 'lwitek', 'Lukasz Witek', 'Niepolomice', '32-005', 'ul. Mala 2', 'lwitek@onet.pl', '(012) 666 66 66', '(012) 666 66 66', '345-675-99-88', '         ');
INSERT INTO klienci VALUES ('bzamecka', 'bzamecka', 'Barbara Zamecka', 'Krakow', '31-450', 'ul. Ulanow 21/64', 'bzamecka@onet.pl', '(012) 634 77 09', '(012) 634 77 09', '435-987-45-56', '         ');
INSERT INTO klienci VALUES ('mrusinek', 'mrusinek', 'Magdalena Rusinek', 'Krakow', '30-362', 'ul. Ceglarska 78/6', 'mrusinek@onet.pl', '(012) 664 44 45', '', '707-709-12-15', '         ');
INSERT INTO klienci VALUES ('kkot', 'kkot', 'Karol Kot', 'Krakow', '30-383', 'ul. Obozowa 44/122', 'kkot@onet.pl', '(012) 677 88 80', '', '687-988-66-68', '         ');
INSERT INTO klienci VALUES ('akulfon', 'akulfon', 'Anna Kulfon', 'Krzeszowice', '32-065', 'ul. Mila 22/66', 'akulfon@onet.pl', '(012) 677 88 81', '', '121-657-09-10', '         ');
INSERT INTO klienci VALUES ('ksowa', 'ksowa', 'Karolina Sowa', 'Skawina', '32-050', 'ul. Mila 3', 'ksowa@onet.pl', '(012) 444 44 44', '(012) 444 44 44', '345-675-99-89', '         ');
INSERT INTO klienci VALUES ('azarek', 'azarek', 'Artur Zarek', 'Krakow', '30-059', 'ul. Aleja A. Mickiewicza 46/75', 'azarek@onet.pl', '(012) 645 45 48', '', '435-987-45-57', '         ');
INSERT INTO klienci VALUES ('rkapusta', 'rkapusta', 'Ryszard Kapusta', 'Krakow', '31-464', 'ul. Majowa 1', 'rkapusta@onet.pl', '(012) 645 45 49', '(012) 645 45 49', '707-709-12-16', '         ');
INSERT INTO klienci VALUES ('azator', 'azator', 'Adam Zator', 'Krakow', '31-450', 'ul. Ulanow 27/52', 'azator@onet.pl', '(012) 634 77 09', '', '687-988-66-69', '         ');
INSERT INTO klienci VALUES ('gkopicz', 'gkopicz', 'Grzegorz Kopiczynski', 'Wieliczka', '32-020', 'ul. Os. Kosciuszki 12', 'gkopicz@onet.pl', '0 502 400 487', '', '121-657-09-11', '         ');
INSERT INTO klienci VALUES ('kkorzec', 'kkorzec', 'Katarzyna Korzecka', 'Krakow', '30-383', 'ul. Obozowa 57/6', 'kkorzec@onet.pl', '(012) 677 88 88', '(012) 677 88 88', '345-675-99-90', '         ');
INSERT INTO klienci VALUES ('wzakon', 'wzakon', 'Waldemar Zakoniecki', 'Skawina', '32-050', 'ul. Wrzesniowa 44', 'wzakon@onet.pl', '(012) 677 88 89', '', '435-987-45-58', '         ');
INSERT INTO klienci VALUES ('akopicz', 'akopicz', 'Anna Kopiczynska', 'Wieliczka', '32-020', 'ul. Os. Kosciuszki 12', 'akopicz@onet.pl', '0 502 400 487', '', '707-709-12-17', '         ');
INSERT INTO klienci VALUES ('mmisiek', 'mmisiek', 'Maciej Misiek', 'Niepolomice', '32-005', 'ul. Rynek 5/17', 'mmisiek@onet.pl', '(012) 651 51 52', '(012) 651 51 52', '687-988-66-70', '         ');
INSERT INTO klienci VALUES ('kkowal', 'kkowal', 'Konrad Kowal', 'Wieliczka', '32-020', 'ul. OSP Trabki 52', 'kkowal@onet.pl', '(012) 411 15 57', '(012) 411 15 57', '121-657-09-12', '         ');
INSERT INTO klienci VALUES ('kderen', 'kderen', 'Karolina Deren', 'Krakow', '30-838', 'ul. Heleny 5/23', 'kderen@onet.pl', '(012) 632 66 66', '(012) 632 66 66', '345-675-99-91', '         ');
INSERT INTO klienci VALUES ('zkamien', 'zkamien', 'Zofia Kamien', 'Krakow', '31-990', 'ul. Wadowicka 45/22', 'zkamien@interia.pl', '(012) 633 88 88', '', '707-709-12-14', '         ');
INSERT INTO klienci VALUES ('pzegadlo', 'pzegadlo', 'Piotr Zegadlo', 'Bochnia', '32-701', 'ul. Wygoda 13/13', 'pzegadlo@interia.pl', '(014) 557 55 66', '', '687-988-66-67', '         ');
INSERT INTO klienci VALUES ('pkoper', 'pkoper', 'Pawel Koper', 'Krakow', '30-650', 'ul. Makowa 1/19', 'pkoper@interia.pl', '0 608 350 334', '', '121-657-09-09', '         ');
INSERT INTO klienci VALUES ('mkon', 'mkon', 'Mariola Kon', 'Bochnia', '32-701', 'ul. Wygoda 29/1', 'mkon@interia.pl', '0 502 100 222', '', '345-675-99-88', '         ');
INSERT INTO klienci VALUES ('rrusinek', 'rrusinek', 'Robert Rusinek', 'Krakow', '30-362', 'ul. Ceglarska 78/6', 'rrusinek@interia.pl', '(012) 664 44 45', '', '435-987-45-56', NULL);
INSERT INTO klienci VALUES ('posa', 'posa', 'Paulina Osa', 'Skawina', '32-050', 'ul. Krakowska 4', 'posa@interia.pl', '(012) 442 78 78', '(012) 442 78 78', '707-709-12-15', NULL);
INSERT INTO klienci VALUES ('aenglert', 'aenglert', 'Anna Englert', 'Krakow', '31-990', 'ul. Wadowicka 3/67', 'aenglert@interia.pl', '(012) 611 22 44', '(012) 611 22 44', '687-988-66-68', NULL);
INSERT INTO klienci VALUES ('koral', 'koral', 'FHU Koral', 'Bochnia', '32-700', 'ul. Legionow Polskich 23/11', 'koral@interia.pl', '(014) 611 77 77', '(014) 611 77 77', '             ', '590096454');
INSERT INTO klienci VALUES ('caro', 'caro', 'SC Caro', 'Wieliczka', '32-020', 'ul. Kwiatowa 77', 'caro@interia.pl', '(012) 402 21 65', '', '             ', '650043357');
INSERT INTO klienci VALUES ('amanda', 'amanda', 'Sklep Amanda', 'Krakow', '31-406', 'ul. Aleja 29 Listopada 153/88', 'amanda@interia.pl', '0 607 222 345 ', '', '             ', '709990260');
INSERT INTO klienci VALUES ('sp17', 'sp17', 'SP nr 17', 'Bochnia', '32-700', 'ul. Kazimierza Wielkiego 4/67', 'sp17@interia.pl', '(014) 611 77 63', '', '             ', '769937163');
INSERT INTO klienci VALUES ('karolina', 'karolina', 'HFU Karolina', 'Wieliczka', '32-020', 'ul. Legionow 4/53', 'karolina@interia.pl', '(012) 411 18 88', '(012) 411 18 88', '             ', '829884066');


--
-- Data for Name: kompozycje; Type: TABLE DATA; Schema: public; Owner: wojnicki
--

INSERT INTO kompozycje VALUES ('buk1 ', 'Bukiet 1', 'roze, trachelium, jagodzina, ti-tin, fizelina', 95.00, 3, 3);
INSERT INTO kompozycje VALUES ('buk2 ', 'Bukiet 2', 'rozyczki rodeo i inne kwiaty, fizelina', 75.00, 3, 4);
INSERT INTO kompozycje VALUES ('buk3 ', 'Bukiet 3', 'gozdziki, margerytki, santini, kapustka, jagodzina, magic mushrums, papier', 90.00, 3, 4);
INSERT INTO kompozycje VALUES ('ko1  ', 'Kosz 1', '21 roz pomaranczowych, duzo zieleni i kosz z palakiem', 250.00, 4, 4);
INSERT INTO kompozycje VALUES ('ko2  ', 'Kosz rozyczek', 'tuzin czerwonych rozyczek, molucella, gips, sizal, koszyk czerwony z palakiem', 120.00, 10, 12);
INSERT INTO kompozycje VALUES ('ko3  ', 'Kosz mix', 'gladiole, gerbery, sloneczniki mini, leuki, kolorowe liscie, kosz z palakiem', 250.00, 4, 5);
INSERT INTO kompozycje VALUES ('susz ', 'Kompozycja suszona', 'suszone i preparowane owoce, warzywa i czesci roslin', 70.00, 2, 2);
INSERT INTO kompozycje VALUES ('ko4  ', 'Koszyk gozdzikowy', 'gozdziki mini w roznych kolorach, gips, molucella, zatrwian, koszyk z kolnierzem', 95.00, 3, 4);
INSERT INTO kompozycje VALUES ('ko5  ', 'Hiacynty w koszyku', 'kosz wiklinowy z hiacyntami i przybraniem', 110.00, 4, 4);
INSERT INTO kompozycje VALUES ('don1 ', 'Biala azalia', 'biala azalia z dekoracja w koszyku', 120.00, 4, 4);
INSERT INTO kompozycje VALUES ('don2 ', 'Rozowa azalia', 'rozowa azalia z dekoracja w koszyku', 120.00, 4, 5);
INSERT INTO kompozycje VALUES ('kw1  ', 'Orchidea rozowa', 'galaz cymbidium, zielona dekoracja, patyki, liscie', 95.00, 3, 4);
INSERT INTO kompozycje VALUES ('ko6  ', 'Kosz z azalia', 'azalia, aglomena, wstazka, sizal, kosz z palakiem', 70.00, 3, 3);
INSERT INTO kompozycje VALUES ('buk4 ', 'Wiazanka czerwona', '11 roz Amor i przybranie', 90.00, 8, 9);
INSERT INTO kompozycje VALUES ('buk5 ', 'Bukiecik serc', '3 czerwone rozyczki, serduszka, zielen, podklad sizalowy', 75.00, 15, 16);
INSERT INTO kompozycje VALUES ('kw2  ', 'Ikebana z rozami', 'czerwone rozyczki midi, kwiaty sezonowe, ikebana', 50.00, 6, 7);
INSERT INTO kompozycje VALUES ('ko7  ', 'Kwitnacy kosz', 'cyklamen, hiacynty, ST. Paula, bluszcze, kosz z palakiem, dekoracja', 115.00, 4, 4);
INSERT INTO kompozycje VALUES ('kw3  ', 'Sloneczniki z lilia', 'lilie orientalne, sloneczniki, zeniszek, assengai, mulumbecia, dzbanuszek', 100.00, 4, 4);
INSERT INTO kompozycje VALUES ('kw4  ', 'Strelicje', '5 strelicji, mandzuria, wazon', 240.00, 4, 5);
INSERT INTO kompozycje VALUES ('kw5  ', 'Anturium latem', '3 anturia, kapusta, knofia, roza herbaciana, margerytka, pteris', 145.00, 5, 5);


--
-- Data for Name: odbiorcy; Type: TABLE DATA; Schema: public; Owner: wojnicki
--

INSERT INTO odbiorcy VALUES (1, 'Slawomir Zeganek', 'Krakow', '30-059', 'Al A. Mickiewicza 4/3');
INSERT INTO odbiorcy VALUES (2, 'Dorota Pszczolka', 'Slomniki', '32-090', 'ul. Wiosenna 8');
INSERT INTO odbiorcy VALUES (3, 'Wioletta Barszcz', 'Skawina', '32-050', 'ul. Zwirki i Wigury 7/11');
INSERT INTO odbiorcy VALUES (4, 'Monika Kotarek', 'Wieliczka', '32-020', 'ul. OSP Trabki 5');
INSERT INTO odbiorcy VALUES (5, 'Wojciech Skalecki', 'Skawina', '32-050', 'ul. Krakowska 34');
INSERT INTO odbiorcy VALUES (6, 'Malgorzata Mis', 'Wieliczka', '32-020', 'ul. Krakowska 2/6');
INSERT INTO odbiorcy VALUES (7, 'Piotr Tynski', 'Krakow', '31-235', 'ul. Banacha 3/4');
INSERT INTO odbiorcy VALUES (8, 'Pawel Engel', 'Krzeszowice', '32-065', 'ul. Daszynskiego 7/55');
INSERT INTO odbiorcy VALUES (9, 'Malgorzata Korbicz', 'Krzeszowice', '32-065', 'ul. Piastowska 55/4');
INSERT INTO odbiorcy VALUES (10, 'Jakub Pionek', 'Wieliczka', '32-020', 'ul. Krakowska 44/12');
INSERT INTO odbiorcy VALUES (11, 'Katarzyna Nawarek', 'Niepolomice', '32-005', 'ul. Wielicka 22');
INSERT INTO odbiorcy VALUES (12, 'Konrad Misiek', 'Niepolomice', '32-005', 'ul. Rynek 5/17');
INSERT INTO odbiorcy VALUES (13, 'Monika Bazarek', 'Krakow', '31-546', 'ul. Aleja Pokoju 21/23');
INSERT INTO odbiorcy VALUES (14, 'Anna Bykowska', 'Krakow', '30-145', 'ul. Hamernia 25/11');
INSERT INTO odbiorcy VALUES (15, 'Paulina Sitarz', 'Wieliczka', '32-020', 'ul. Kwiatowa 2');
INSERT INTO odbiorcy VALUES (16, 'Joanna Galecki', 'Krzeszowice', '32-065', 'ul. Krakowska 44/23');
INSERT INTO odbiorcy VALUES (17, 'Justyna Kiwi', 'Krakow', '31-464', 'ul. Majowa 45/2');
INSERT INTO odbiorcy VALUES (18, 'Marcin Rympinski', 'Niepolomice', '32-005', 'ul. Mala 76');
INSERT INTO odbiorcy VALUES (19, 'Adam Gierka', 'Bochnia', '32-701', 'ul. Wygoda 13/12');
INSERT INTO odbiorcy VALUES (20, 'Grzegorz Fibak', 'Zielonki', '32-087', 'Zielonki 4');
INSERT INTO odbiorcy VALUES (21, 'Mariusz Gancarz', 'Wieliczka', '32-020', 'ul. Legionow 2/12');
INSERT INTO odbiorcy VALUES (22, 'Michal Knyszecka', 'Krakow', '30-650', 'ul. Makowa 7/44');
INSERT INTO odbiorcy VALUES (23, 'Pawel Skalecki', 'Skawina', '32-050', 'ul. Krakowska 34');
INSERT INTO odbiorcy VALUES (24, 'Marcin Szarotka', 'Skawina', '32-050', 'ul. Wrzesniowa 1');
INSERT INTO odbiorcy VALUES (25, 'Marcin Kod', 'Krakow', '30-650', 'ul. Makowa 12/47');
INSERT INTO odbiorcy VALUES (26, 'Magdalena Szostek', 'Krakow', '30-034', 'ul. Koscielna 11/88');
INSERT INTO odbiorcy VALUES (27, 'Lukasz Krawiec', 'Krzeszowice', '32-065', 'ul. Piastowska 79/4');


--
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: wojnicki
--

INSERT INTO zamowienia VALUES (2703001, 'msowins', 1, 'buk1 ', '2006-04-27', 95.00, false, 'dolaczyc zyczenia urodzinowe');
INSERT INTO zamowienia VALUES (2703002, 'mbabik', 1, 'buk2 ', '2006-04-27', 75.00, false, 'dolaczyc zyczenia urodzinowe');
INSERT INTO zamowienia VALUES (2703003, 'mfibak', 2, 'buk3 ', '2006-04-27', 90.00, true, 'dostarczyc po godzinie 17.00');
INSERT INTO zamowienia VALUES (2803001, 'dniemcz', 3, 'ko1  ', '2006-04-28', 250.00, true, '');
INSERT INTO zamowienia VALUES (2803002, 'gurbanik', 3, 'ko2  ', '2006-04-29', 120.00, true, 'dostarczyc na godzine 10.30');
INSERT INTO zamowienia VALUES (2803003, 'pjurecz', 5, 'ko3  ', '2006-04-29', 250.00, false, 'dolaczyc zyczenia imieninowe');
INSERT INTO zamowienia VALUES (2803004, 'msrokiew', 6, 'susz ', '2006-04-29', 70.00, false, '');
INSERT INTO zamowienia VALUES (2803005, 'bzameck', 8, 'ko4  ', '2006-04-29', 95.00, true, 'dolaczyc zyczenia imieninowe');
INSERT INTO zamowienia VALUES (2903001, 'gkiwi', 10, 'ko5  ', '2006-04-29', 110.00, false, 'dolaczyc zyczenia imieninowe');
INSERT INTO zamowienia VALUES (2903002, 'jkajdeck', 2, 'don1 ', '2006-04-30', 120.00, true, '');
INSERT INTO zamowienia VALUES (2903003, 'acygan', 12, 'buk2 ', '2006-04-30', 75.00, true, '');
INSERT INTO zamowienia VALUES (2903004, 'ztylutek', 9, 'buk3 ', '2006-04-30', 90.00, false, 'dostarczyc na godzine 10.30');
INSERT INTO zamowienia VALUES (2903005, 'amanda', 9, 'ko1  ', '2006-04-30', 250.00, false, 'dostarczyc na godzine 12.30');
INSERT INTO zamowienia VALUES (2903006, 'sp17', 10, 'ko2  ', '2006-05-12', 120.00, true, 'dostarczyc na godzine 10.00');
INSERT INTO zamowienia VALUES (2903007, 'karolina', 15, 'ko3  ', '2006-05-12', 250.00, true, 'dostarczyc na godzine 11.30');

COMMIT;

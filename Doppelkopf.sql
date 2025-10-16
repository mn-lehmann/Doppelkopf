-- Grundlegende Datenbankstruktur
CREATE TABLE Person(
        Person_ID INTEGER NOT NULL,
        Vorname VARCHAR(255) NOT NULL,
        PRIMARY KEY (Person_ID)
    );

CREATE TABLE Normalspiel(
        Spiel_ID INTEGER NOT NULL,
        Punktzahl INTEGER NOT NULL,
        Datum TEXT DEFAULT (DATE('now')), 
        Nor_gew_1 INTEGER NOT NULL,
        Nor_gew_2 INTEGER NOT NULL,
        Nor_ver_1 INTEGER NOT NULL,
        Nor_ver_2 INTEGER NOT NULL,
        PRIMARY KEY (Spiel_ID)
        FOREIGN KEY (Nor_gew_1) REFERENCES Person(ID)
        FOREIGN KEY (Nor_gew_2) REFERENCES Person(ID)
        FOREIGN KEY (Nor_ver_1) REFERENCES Person(ID)
        FOREIGN KEY (Nor_ver_2) REFERENCES Person(ID)
    );

CREATE TABLE Solospiel(
        Spiel_ID INTEGER NOT NULL,
        Punktzahl INTEGER NOT NULL,
        Datum DATE DEFAULT (DATE('now')),
        Solo_sol INTEGER NOT NULL,
        Solo_geg_1 INTEGER NOT NULL,
        Solo_geg_2 INTEGER NOT NULL,
        Solo_geg_3 INTEGER NOT NULL,
        PRIMARY KEY (Spiel_ID)
        FOREIGN KEY (Solo_sol) REFERENCES Person(ID)
        FOREIGN KEY (Solo_geg_1) REFERENCES Person(ID)
        FOREIGN KEY (Solo_geg_2) REFERENCES Person(ID)
        FOREIGN KEY (Solo_geg_3) REFERENCES Person(ID)
    );


-- 
CREATE TABLE Feigheit(
    Feigheit_ID INTEGER NOT NULL,
    Spiel_ID INTEGER NOT NULL,
    Punkte INTEGER NOT NULL,
    Person_1 INTEGER NOT NULL,
    Person_2 INTEGER NOT NULL,
    PRIMARY KEY (Feigheit_ID)
    FOREIGN KEY (Spiel_ID) REFERENCES Normalspiel
    FOREIGN KEY (Person_1) REFERENCES Person(ID)
    FOREIGN KEY (Person_2) REFERENCES Person(ID)
);


UPDATE Normalspiel SET 
    Nor_ver_2 = Nor_ver_1, 
    Nor_ver_1 =  Nor_ver_2
WHERE
    Nor_ver_2 < Nor_ver_1;

UPDATE Normalspiel SET
    Nor_gew_2 = Nor_gew_1,
    Nor_gew_1 = Nor_gew_2
WHERE
    Nor_gew_2 < Nor_gew_1;

--
Allgemeine Regeln:
(falls vorhanden) erste Dulle sticht immer die zweite
nächster Stich erst anspielen, wenn der davor aufgenommen wurde
fasch bedient: solange keine weitere Karte gelegt (falls letzte Person bedient, Stich aufgenommen), darf zurückgenommen werden. Anderenfalls: Solo verloren mit 4 Punkten Wertigkeit
außerhalb von falsch bedient: gelegt ist gelegt
gelegt wenn nicht dran: fällt unter falsch bedient
alles Sportsmanship - seid keine Pisser!

gelegt: sobald für alle anderen sichtbar ist
Die Karten sprechen für sich (keine Taktikkommunikation) best case ;) - bullshitting ist ok
Kontra-Ansage ändert Mindestpunktanzahl zum Gewinnen auf 121 für Kontra; nicht durch Gegenansage beeinflusst
ansonsten gewinnt Kontra bei Gleichstand

Vorbehalte in aufsteigender Reihenfolge: Schmeißen (nur bei 5+ Neunen; falls Eduard mitspielt - auch bei Geberrunden - muss er muss mischen, sonst die schmeißende Person), Hochzeit, Armut (3- Trupf),  Solo

Solo in Vorhandreihenfolge
Solo: Damen, Buben, Fleischlos, Trumpf, Farbe
Solo kommt immer raus
Bei Solo wird nochmal von gleicher Person gemsicht - selbe Farbe


Armut: Fragen in Vorhandreihenfolge, keine Sonderpunkte, nur Trumpf wird weitergegeben, Ansage wie viele Trumpf zurück
- heute testen - Ramschen bei alle lehnen ab - Person mizt meisten Punkten verliert - wie viel verlieren (2 Punkte Solo?) - tirbreaker: letzter Stich
- heute testen - Sonderpnkte bei Armut
- heute Schweinchen - immer

Hochzeit: erster Fremder innerhab von drei Stichen, ansonsten Solo
- bei solohochzeit gibt es Sonderpunkte


Bei allen Soli (außer Hochtzeitssolo) gibt es keine Sonderpunkte

bei Farbsolo wird karo ausgetauscht (bei Herzsolo bleibt 10 die Dulle)
- heute testen - bei Fabsolo gibt es keine Schweine 
- heute testen - beim Trumpsolo gibt es Schweine (aber kein Fuchs da keine Sonderpunkte)


Sonderpunkte: Karl holt den letzten Stich, Doppelkopf, Fuchs gefangen, gegen die Alten

Schwein bei doppeltem Fuchs, nach Vorbehalt ansagen, so früh wie möglich (bestenfalls vor der esten generell gespielten Karte), falls erste eigene Karte gespielt wurde sind beides Füchse. Falls absichtlich gewartet Tischrunde (für alle die spielen)

An-/Absageregeln:
Normalspiel/Solo/Armut - Ansagen vor Ausspiel der zweiten Karte (11 Karten auf der Hand); jede weitere Absage +1 Karte Zeit (U9 mit 10 Karten auf der Hand, U6 mit 9, U3 mit 8, Schwarz (alle Stiche) mit 7; Gegenansage verschiebt ebenfalls um +1)
Hochzeit - Ansagen vor Ausspiel der ersten Karte nach dem Findungsstich; bei abgelehnter Hochzeit vor Ausspiel der vierten Karte (9 Karten auf der Hand); jede weitere Absage (Verschiebung analog Normalspiel)
Gegenansage möglich, solange die Gegnerpartei in der gleichen Runde noch absagen könnte/konnte



mit eintragen in die Liste akzeptieren Sie die allgemeinen Geschäftsbedingungen und Regeln dieser Liste



--


-- Einfügen von Personen
INSERT INTO Person (Vorname) VALUES ('Sora');



-- automatisches Datum 

INSERT INTO Normalspiel(Punktzahl, Nor_gew_1, Nor_gew_2, Nor_ver_1, Nor_ver_2) VALUES (2, 1,5, 3,9);
SELECT * FROM Person;


SELECT MAX(Spiel_ID) FROM Normalspiel;

INSERT INTO Feigheit(Spiel_ID, Punkte, Person_1, Person_2) VALUES (1, 4, 1, 2);
UPDATE Feigheit SET Spiel_ID = (SELECT MAX(Spiel_ID) FROM Normalspiel) WHERE Feigheit_ID = (SELECT MAX(Feigheit_ID) FROM Feigheit);


INSERT INTO Solospiel(Punktzahl, Solo_sol, Solo_geg_1, Solo_geg_2, Solo_geg_3) VALUES (-2, 5,2,4,6);
SELECT * FROM Person;




-- löschen von einzelnen Einträgen
DELETE FROM Solospiel WHERE Solospiel.Spiel_ID = 13;

DELETE FROM Normalspiel WHERE Normalspiel.Spiel_ID = 114;
DELETE FROM Person WHERE Person.Person_ID = 1;

-- Datenabfragen
SELECT * FROM Person;
SELECT * From Normalspiel;
SELECT * FROM Solospiel;
-- Punkteabfrage
SELECT Vorname, Punkte, Anzahl_Spiele, Anzahl_Siege, Anzahl_Solo, ROUND(Punkte/(Anzahl_Spiele*1.0),2) dsn_Punkte, round(Anzahl_Siege/(Anzahl_Spiele*1.0),2) W_keit_Sieg FROM 
    -- Einfügen der Namen
    (SELECT * FROM Person),
    -- Abfrage für Punkte und Anzahl Spiele
    (SELECT Person1, Punkte, Anzahl_Spiele, Anzahl_Siege, Anzahl_Solo FROM
        (SELECT S1 Person1, P1+P2+P3+P4 Punkte, C1+C2+C3+C4 Anzahl_Spiele FROM 
            -- gewonnen Normalspiel
            (SELECT Person_ID S1, SUM(P1) P1, SUM(C1) C1 FROM(
                SELECT Person_ID, 0 P1, 0 C1 FROM Person 
                    UNION 
                SELECT Person_ID S1, SUM(Normalspiel.Punktzahl) P1, COUNT(Normalspiel.Spiel_ID) C1 FROM Person, Normalspiel WHERE (Person.Person_ID = Normalspiel.Nor_gew_1 OR Person.Person_ID = Normalspiel.Nor_gew_2) GROUP BY Person_ID) GROUP BY Person_ID),
            -- verloren Normalspiel
            (SELECT Person_ID S2, SUM(P2) P2, SUM(C2) C2 FROM(
                SELECT Person_ID, 0 P2, 0 C2 FROM Person 
                    UNION 
                SELECT Person_ID S2, SUM(- Normalspiel.Punktzahl) P2, COUNT(Normalspiel.Spiel_ID) C2  FROM Person, Normalspiel WHERE (Person.Person_ID = Normalspiel.Nor_ver_1 OR Person.Person_ID = Normalspiel.Nor_ver_2) GROUP BY Person_ID) GROUP BY Person_ID),
            -- Alleinspieler Solospiel
            (SELECT Person_ID S3, SUM(P3) P3, SUM(C3) C3 FROM(
                SELECT Person_ID, 0 P3, 0 C3 FROM Person 
                    UNION 
                SELECT Person_ID S3, 3*SUM(Solospiel.Punktzahl) P3, COUNT(Solospiel.Spiel_ID) C3  FROM Person, Solospiel WHERE Person.Person_ID = Solospiel.Solo_sol
                GROUP BY Person_ID) GROUP BY Person_ID),
            -- Gemeinschaft Solospiel
            (SELECT Person_ID S4, SUM(P4) P4, SUM(C4) C4 FROM(
                SELECT Person_ID, 0 P4, 0 C4 FROM Person 
                    UNION 
                SELECT Person_ID S4, SUM(-Solospiel.Punktzahl) P4, COUNT(Solospiel.Spiel_ID) C4  FROM Person, Solospiel WHERE (Person.Person_ID = Solospiel.Solo_geg_1 OR Person.Person_ID = Solospiel.Solo_geg_2 OR Person.Person_ID = Solospiel.Solo_geg_3) GROUP BY Person_ID) GROUP BY Person_ID)
        WHERE S1 = S2 AND S2 = S3 AND S3 = S4),
        -- Abfrage für Anzahl Siege
        (SELECT S1 Person2, C1+C2+C3 Anzahl_Siege FROM
            -- gewonnen Normalspiel
            (SELECT Person_ID S1, SUM(C1) C1 FROM(
                SELECT Person_ID, 0 C1 FROM Person 
                    UNION 
                SELECT Person_ID S1, COUNT(Normalspiel.Spiel_ID) C1 FROM Person, Normalspiel WHERE (Person.Person_ID = Normalspiel.Nor_gew_1 OR Person.Person_ID = Normalspiel.Nor_gew_2) GROUP BY Person_ID) 
            GROUP BY Person_ID),
            -- gewonnen solo
            (SELECT Person_ID S2, SUM(C2) C2 FROM(
                SELECT Person_ID, 0 C2 FROM Person 
                    UNION 
                SELECT Person_ID S2,  COUNT(Solospiel.Spiel_ID) C2  FROM Person, Solospiel WHERE Person.Person_ID = Solospiel.Solo_sol AND Solospiel.Punktzahl > 0 GROUP BY Person_ID) 
            GROUP BY Person_ID),
            -- gewonnen gegen Solo
            (SELECT Person_ID S3, SUM(C3) C3 FROM(
                SELECT Person_ID, 0 C3 FROM Person 
                    UNION 
                SELECT Person_ID S3, COUNT(Solospiel.Spiel_ID) C3  FROM Person, Solospiel WHERE (Person.Person_ID = Solospiel.Solo_geg_1 OR Person.Person_ID = Solospiel.Solo_geg_2 OR Person.Person_ID = Solospiel.Solo_geg_3) AND Solospiel.Punktzahl < 0 GROUP BY Person_ID) GROUP BY Person_ID)
            WHERE S1=S2 AND S2 = S3),
        -- Anfrage für Anzahl Solo
        (SELECT Person_ID Person3, SUM(Count) Anzahl_Solo FROM 
            (SELECT Person_ID, 0 Count FROM Person 
                UNION 
            SELECT Person_ID S3, COUNT(Solospiel.Spiel_ID) C3  FROM Person, Solospiel 
                WHERE Person.Person_ID = Solospiel.Solo_sol
     GROUP BY Person_ID)
            GROUP BY Person_ID)
        WHERE Person1 = Person2 AND Person2 = Person3)
    WHERE Person_ID = Person1 ORDER BY Punkte DESC;
        



-- noch machen

SELECT Person_ID, SUM(Feigheit.Punkte) Punkte FROM Person, Feigheit WHERE (Person.Person_ID = Feigheit.Person_1 OR Person.Person_ID = Feigheit.Person_2) GROUP BY Person_ID;

SELECT Person.Vorname Name, SUM(Feigheit.Punkte) Punkte FROM Person, Feigheit WHERE (Person.Person_ID = Feigheit.Person_1 OR Person.Person_ID = Feigheit.Person_2) GROUP BY Person_ID;


-- Tagesliste Punkteabfrage
SELECT Spiel_ID N_ID from Normalspiel WHERE Datum IN ('2025-05-17', '2025-05-18');
SELECT Spiel_ID S_ID from Solospiel WHERE Datum IN ('2025-05-17', '2025-05-18');


-- Abfrage der Paarungen - vorher updaten sonst Fehler
SELECT P1, P2, Anz_Spiele Anz_Spiele_Tisch, Anzahl_Spiele_zsm Anz_Spiele_Team, W_keit_zsm, dsn_Punkte dsn_Punkte_als_Team FROM 
    (SELECT Person_ID ID1, Vorname P1 FROM Person),
    (SELECT Person_ID ID2, Vorname P2 FROM Person),
    (SELECT  Spieler_1, Spieler_2, Anzahl_Spiele_zsm, Anz_Spiele, ROUND((Anzahl_Spiele_zsm*1.0/Anz_Spiele*1.0), 2) W_keit_zsm, dsn_Punkte from
        (SELECT * FROM
            (SELECT Spieler_1, Spieler_2, Anzahl_Spiele_zsm, dsn_Punkte FROM
                (SELECT Nor_gew_1 Spieler_1, Nor_gew_2 Spieler_2, Count(*) Anzahl_Spiele_zsm, round(AVG(dns) , 2) dsn_Punkte  FROM
                    (SELECT Spiel_ID, Punktzahl dns, Nor_gew_1, Nor_gew_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, -Punktzahl dns, Nor_ver_1, Nor_ver_2 FROM Normalspiel)
                GROUP BY Nor_gew_1, Nor_gew_2 ORDER BY Nor_gew_1, Nor_gew_2) 
            UNION
            SELECT Spieler_2 Spieler_1, Spieler_1 Spieler_2, Anzahl_Spiele_zsm, dsn_Punkte FROM
                (SELECT Nor_gew_1 Spieler_1, Nor_gew_2 Spieler_2, Count(*) Anzahl_Spiele_zsm, round(AVG(dns) , 2) dsn_Punkte  FROM
                    (SELECT Spiel_ID, Punktzahl dns, Nor_gew_1, Nor_gew_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, -Punktzahl dns, Nor_ver_1, Nor_ver_2 FROM Normalspiel)
                GROUP BY Nor_gew_1, Nor_gew_2 ORDER BY Nor_gew_1, Nor_gew_2) 
            )
        ORDER BY Spieler_1, Spieler_2),
        (SELECT Anz1+Anz2 Anz_Spiele, S11 S1, S22 S2 FROM
            (SELECT Anz_Spiele Anz1, S1 S11, S2 S12 FROM
                (SELECT COUNT(*) Anz_Spiele, Nor_gew_1 S1, Nor_gew_2 S2 FROM 
                    (SELECT Spiel_ID, Nor_gew_1, Nor_gew_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_1, Nor_ver_1 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_1, Nor_ver_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_2, Nor_ver_1 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_2, Nor_ver_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_ver_1, Nor_ver_2 FROM Normalspiel)
                GROUP BY Nor_gew_1, Nor_gew_2)
            WHERE S1 < S2),
            (SELECT Anz_Spiele Anz2, S2 S21, S1 S22 FROM
                (SELECT COUNT(*) Anz_Spiele, Nor_gew_1 S1, Nor_gew_2 S2 FROM 
                    (SELECT Spiel_ID, Nor_gew_1, Nor_gew_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_1, Nor_ver_1 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_1, Nor_ver_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_2, Nor_ver_1 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_gew_2, Nor_ver_2 FROM Normalspiel
                    UNION
                    SELECT Spiel_ID, Nor_ver_1, Nor_ver_2 FROM Normalspiel)
                GROUP BY Nor_gew_1, Nor_gew_2)
            WHERE S1 > S2)
        WHERE S11 = S21 AND S12 = S22)
    WHERE (Spieler_1=S1 AND Spieler_2=S2) OR (Spieler_1=S2 AND Spieler_2=S1))
WHERE P1 = 'Manes' AND ID1 = Spieler_1 AND ID2 = Spieler_2;
--

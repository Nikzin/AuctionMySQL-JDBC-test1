use aukademin;

# Registrera en produkt

DELIMITER //
CREATE PROCEDURE Registrera_Produkt(IN ProduktNamn VARCHAR(50), IN LeverantörID INT, Beskrivningar VARCHAR(50))
  BEGIN
    INSERT INTO produkter (Namn, Leverantör_ID, Beskrivning) VALUES (ProduktNamn, LeverantörID, Beskrivningar);
  END //
DELIMITER ;
# Skapa en auktion utifrån en viss produkt där man kan sätta utgångspris,
# acceptpris samt start och slutdatum för auktionen.
-- DROP PROCEDURE IF EXISTS Skapa_Auktion;

DELIMITER //
CREATE PROCEDURE Skapa_Auktion(IN ProduktID     INT, IN StartDatum DATETIME, IN SlutDatum DATETIME,
                               IN utgångsPris   DOUBLE,
                               IN AcceptansPris DOUBLE)
  BEGIN
    INSERT INTO auktion (Produkt_ID, Start_Datum, Slut_Datum, Utgång_Pris, Acceptans_Pris)
    VALUES (ProduktID, StartDatum, SlutDatum, utgångsPris, AcceptansPris);
  END //
DELIMITER ;
# Lista pågående auktioner samt kunna se det högsta budet och vilken kund som lagt det.
SELECT
  auktion.Auktion_ID,
  produkter.Namn AS                         Produkt_Namn,
  max(bud.Pris)  AS                         Högsta_Bud,
  concat(kund.Förnamn, ' ', kund.Efternamn) Kund_Namn
FROM auktion
  JOIN bud ON auktion.Auktion_ID = bud.Auktion_ID
  JOIN kund ON bud.Kund_ID = kund.Kund_ID
  JOIN produkter ON auktion.Produkt_ID = produkter.Produkt_ID
WHERE current_time BETWEEN auktion.Start_Datum AND auktion.Slut_Datum
GROUP BY auktion.Auktion_ID;
# Se budhistoriken på en viss auktion, samt vilka kunder som lagt buden.
SELECT
  auktion.Auktion_ID,
  concat(kund.Förnamn, ' ', kund.Efternamn) Kund_Namn,
  bud.Pris
FROM auktion
  JOIN bud ON auktion.Auktion_ID = bud.Auktion_ID
  JOIN kund ON bud.Kund_ID = kund.Kund_ID
WHERE auktion.Auktion_ID = 6
ORDER BY bud.Pris DESC;
# Vilka auktioner avslutas under e5 visst datumintervall? Samt vad blir
# provisionen för varje auktion inom det intervallet?

DROP PROCEDURE IF EXISTS auktioner_som_avslutas_under_ett_visst_datum;
DELIMITER //
CREATE PROCEDURE auktioner_som_avslutas_under_ett_visst_datum
  (IN  datumintervall_1 DATETIME,IN  datumintervall_2 DATETIME)
  BEGIN
    SELECT
      auktionhistorik.Auktion_ID,
      sum(auktionhistorik.Högsta_Bud * leverantör.Provision) AS Provision
    FROM auktionhistorik
      JOIN produkter ON auktionhistorik.Produkt_ID = produkter.Produkt_ID
      JOIN leverantör ON produkter.Leverantör_ID = leverantör.Leverantör_ID
    WHERE auktionhistorik.Slut_Datum BETWEEN datumintervall_1 AND datumintervall_2;
  END //
DELIMITER ;
call auktioner_som_avslutas_under_ett_visst_datum('2017-02-08 00:00:01','2017-02-22 23:00:00');
# Om en auktion avslutas utan något bud så skall Gunnar få ett mail om det.
# Gunnar har ångrat sig angående att få mail,
# han vill inte ha mail längre utan istället
# vill han att alla auktioner som avslutats och inte har någon köpare flyttas till en separat tabell.
# Han vill också att eran applikation skall ha möjlighet att lista alla de auktioner
# som blivit avslutade utan någon köpare.


DROP EVENT IF EXISTS Avslutade_auktioner;
SET GLOBAL event_scheduler = 1;
DELIMITER //
CREATE EVENT Avslutade_auktioner
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 10 SECOND
DO
  BEGIN
    IF EXISTS(SELECT bud.Pris
              FROM bud)
    THEN
      INSERT INTO auktionhistorik(Auktion_ID, Start_Datum, Slut_Datum, Acceptans_Pris, Produkt_ID, Högsta_Bud, Kund_ID)
        SELECT
          auktion.Auktion_ID,
          auktion.Start_Datum,
          auktion.Slut_Datum,
          auktion.Acceptans_Pris,
          auktion.Produkt_ID,
          bud.Pris,
          kund.Kund_ID
        FROM auktion
          JOIN bud ON auktion.Auktion_ID = bud.Auktion_ID
          JOIN kund ON bud.Kund_ID = kund.Kund_ID
        WHERE Slut_Datum < current_timestamp OR auktion.Acceptans_Pris = bud.Pris;
      DELETE FROM auktion
      WHERE Slut_Datum < current_timestamp AND
            (SELECT bud.Pris FROM bud WHERE bud.Auktion_ID = auktion.Auktion_ID);

      INSERT INTO auktioner_osåldaprodukter(AuktionerOsålda_ID, Start_Datum, Slut_Datum, Utgång_Pris, Acceptans_Pris)
        SELECT
          auktion.Auktion_ID,
          auktion.Start_Datum,
          auktion.Slut_Datum,
          auktion.Utgång_Pris,
          auktion.Acceptans_Pris
        FROM auktion
        WHERE Slut_Datum < current_timestamp;
      DELETE FROM auktion
      WHERE Slut_Datum < current_timestamp AND
            (SELECT bud.Pris FROM bud WHERE bud.Auktion_ID = auktion.Auktion_ID) IS NULL;
    END IF;
  END//
DELIMITER ;

 /*DROP TRIGGER IF EXISTS LäggTill_budhistorik;
DELIMITER //
CREATE TRIGGER LäggTill_budhistorik
AFTER DELETE ON auktion
FOR EACH ROW
  BEGIN
  INSERT INTO budhistorik (Auktion_ID, Pris, Datum, Kund_ID)
    SELECT
      old.Auktion_ID,
      bud.Pris,
      bud.Datum,
      bud.Kund_ID
    from bud
    WHERE bud.Auktion_ID = old.Auktion_ID;

    DELETE from bud where OLD.Auktion_ID= bud.Auktion_ID;

  END //
DELIMITER ;
*/

DROP TRIGGER IF EXISTS LäggTill_produkthistorik;
DELIMITER //
CREATE TRIGGER LäggTill_produkthistorik
AFTER DELETE ON produkter
FOR EACH ROW
  BEGIN
    INSERT INTO produkthistorik (Produkt_ID, Namn, Beskrivning, Leverantör_ID)
    VALUES (old.Produkt_ID, old.Namn, old.Beskrivning, old.Leverantör_ID);
  END //
DELIMITER ;
# När en auktion är avslutad och det finns en köpare så skall auktionen flyttas
# till en auktionshistoriktabell.
# Visa en kundlista på alla kunder som köpt något, samt vad deras totala ordervärde är.

DROP VIEW IF EXISTS kunder_som_köpt_något_samt_totalt_ordervärde;
CREATE VIEW kunder_som_köpt_något_samt_totalt_ordervärde
AS
  SELECT
    CONCAT(kund.Förnamn, ' ', kund.Efternamn) Customer,
    SUM(auktionhistorik.Högsta_Bud) AS                  Total_Value
  FROM kund
  INNER JOIN bud ON kund.Kund_ID = bud.Kund_ID
    INNER JOIN auktion ON bud.Auktion_ID = auktion.Auktion_ID
    INNER JOIN produkter ON auktion.Produkt_ID = produkter.Produkt_ID
    INNER JOIN auktionhistorik ON produkter.Produkt_ID = auktionhistorik.Produkt_ID
  GROUP BY Customer;

# Vad den totala provisionen är per månad.

DROP VIEW IF EXISTS total_provision_per_månad;
CREATE VIEW total_provision_per_månad
AS
  SELECT
    MONTHNAME(auktionhistorik.Slut_Datum)        AS Month,
    SUM(auktionhistorik.Högsta_Bud * leverantör.Provision) AS Total_Commission
  FROM leverantör
    JOIN produkter ON leverantör.Leverantör_ID = produkter.Leverantör_ID
    JOIN auktionhistorik ON produkter.Produkt_ID = auktionhistorik.Produkt_ID
  GROUP BY Month;

#Nicoles text från firsta dagen:
/*View Pågående  Auktioner + Högsta Bud
             + Budgivare
Trigger/Event  Slut_datum + Bud - Antingen maila Gunnar om att det inte fanns något bud för auktionen
                   - Eller lägg till Auktionshistorik
Trigger Acceptans pris
View Visa kundlista, vad kund köpt + totala ordervärde
Procedure Lägg in nya auktioner från leverantör
Procedure Registera Produkt
Procedure Skapa Auktion
View Vilka Auktioner avslutas en viss intervall
     + Provision för varje Auktion*/
/*INSERT INTO auktionhistorik (Start_Datum, Slut_Datum, Acceptans_Pris, Produkt_ID) SELECT
                                                                                    auktion.Start_Datum,
                                                                                    auktion.Slut_Datum,
                                                                                    auktion.Acceptans_Pris,
                                                                                    auktion.Produkt_ID
                                                                                  FROM auktion
                                                                                    INNER JOIN bud
                                                                                  WHERE
                                                                                    bud.Auktion_ID = auktion.Auktion_ID
                                                                                    AND CURRENT_TIMESTAMP >
                                                                                        auktion.Slut_Datum
                                                                                  GROUP BY auktion.Auktion_ID;*/
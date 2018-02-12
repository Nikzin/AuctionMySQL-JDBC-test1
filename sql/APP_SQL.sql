use aukademin;

# Lägg till en leverantör

DROP PROCEDURE IF EXISTS LäggTillLeverantör;
DELIMITER //

CREATE PROCEDURE LäggTillLeverantör(IN Lev_Namn  VARCHAR(50), IN lev_provision DOUBLE, IN Lev_telefon VARCHAR(12),
                                    IN Lev_org   VARCHAR(50),
                                    IN Lev_Epost VARCHAR(50), IN Lev_Gatuadress VARCHAR(50), IN Lev_postnr CHAR(5),
                                    IN Lev_Ort   VARCHAR(50))

  BEGIN
    INSERT INTO leverantör (Namn, Provision, Telefon, Organisationsnummer, Epost, Gatuadress, Postnummer, Ort)
    VALUES (Lev_Namn, lev_provision, Lev_telefon, Lev_org, Lev_Epost, Lev_Gatuadress, Lev_postnr, Lev_Ort);
  END //
DELIMITER ;


# Lägg till en kund

DROP PROCEDURE IF EXISTS LäggTillKund;

DELIMITER //

CREATE PROCEDURE LäggTillKund(IN kund_pers    VARCHAR(10), IN kund_förnamn VARCHAR(50), IN kund_efternamn VARCHAR(50),
                              IN kund_telefon VARCHAR(12), IN kund_epost VARCHAR(50), IN kund_gatuadress VARCHAR(50),
                              IN kund_postnr  CHAR(5), IN kund_ort VARCHAR(50))

  BEGIN
    INSERT INTO kund (Personnummer, Förnamn, Efternamn, Telefon, Epost, Gatuadress, Postnummer, Ort)
    VALUES (kund_pers, kund_förnamn, kund_efternamn, kund_telefon, kund_epost, kund_gatuadress, kund_postnr, kund_ort);
  END //
DELIMITER ;


CREATE PROCEDURE showActiveAuctions()
  BEGIN
    SELECT
      auktion.Auktion_ID,
      produkter.Namn AS                         Product_Name,
      max(bud.Pris)  AS                         Highest_Bid,
      concat(kund.Förnamn, ' ', kund.Efternamn) Customer_Name
    FROM auktion
      JOIN bud ON auktion.Auktion_ID = bud.Auktion_ID
      JOIN kund ON bud.Kund_ID = kund.Kund_ID
      JOIN produkter ON auktion.Produkt_ID = produkter.Produkt_ID
    WHERE current_time BETWEEN auktion.Start_Datum AND auktion.Slut_Datum
    GROUP BY auktion.Auktion_ID;
  END;


CREATE PROCEDURE showAuctionBids(IN auctionId INT)
  BEGIN
    SELECT
      concat(kund.Förnamn, ' ', kund.Efternamn) Customer,
      bud.Pris AS Bid,
      bud.Datum AS Date
    FROM auktion
      JOIN bud ON auktion.Auktion_ID = bud.Auktion_ID
      JOIN kund ON bud.Kund_ID = kund.Kund_ID
    WHERE auktion.Auktion_ID = auctionId
    ORDER BY Bid DESC;
  END;

/*Hej, Gunnar läste i en tidning att det är viktigt med säkerhet. Därför
vill han att man skall kunna logga in i er applikation.Dvs innan man ser
något så ska det komma upp en inloggningsruta där man kan skriva in ett
användarnamn och ett lösenord. Detta skall sedan verifieras mot en tabell
i databasen och om allt stämmer så ska man bli inloggad.*/

CREATE PROCEDURE enterPassword(IN sp_kund CHAR(10), sp_password CHAR(10))
  BEGIN
    SELECT Kund_ID, inloggnings_uppgifter.Password
    FROM inloggnings_uppgifter
    WHERE sp_kund = Kund_ID
    AND inloggnings_uppgifter.Password = sp_password;
  END;

-- Buy_directly

DROP PROCEDURE IF EXISTS Buy_directly;

CREATE PROCEDURE Buy_directly(IN auktionID INT, IN kundID INT)
  BEGIN
    INSERT INTO auktionhistorik (Auktion_ID, Start_Datum, Slut_Datum, Acceptans_Pris, Produkt_ID, Högsta_Bud, Kund_ID)
    VALUES
      (auktionID,
       (SELECT Start_Datum FROM auktion WHERE auktion.Auktion_ID = auktionID),
       current_timestamp,
       (SELECT Acceptans_Pris FROM auktion WHERE auktion.Auktion_ID = auktionID),
       (SELECT Produkt_ID FROM auktion WHERE auktion.Auktion_ID=auktionID),
       (SELECT Acceptans_Pris FROM auktion WHERE auktion.Auktion_ID = auktionID),
       kundID);

    DELETE FROM auktion WHERE auktion.Auktion_ID= auktionID;

  END;

CREATE VIEW Direkt_Köpta
  AS
  SELECT * FROM auktionhistorik WHERE Acceptans_Pris = Högsta_Bud;
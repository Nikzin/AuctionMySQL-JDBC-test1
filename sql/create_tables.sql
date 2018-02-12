DROP DATABASE IF EXISTS Aukademin;
CREATE DATABASE Aukademin;
USE Aukademin;

CREATE TABLE Leverantör (
  Leverantör_ID       INT AUTO_INCREMENT PRIMARY KEY,
  Namn                VARCHAR(50)   NOT NULL,
  Provision           DECIMAL(8, 2) NOT NULL,
  Telefon             VARCHAR(12),
  Organisationsnummer INT           NOT NULL,
  Epost               VARCHAR(50),
  Gatuadress          VARCHAR(50),
  Postnummer          CHAR(5),
  Ort                 VARCHAR(50)
);
CREATE INDEX IX_Leverantör
  ON Leverantör (Namn);


CREATE TABLE Produkter (
  Produkt_ID    INT AUTO_INCREMENT PRIMARY KEY,
  Namn          VARCHAR(50) NOT NULL,
  Beskrivning   VARCHAR(50),
  Leverantör_ID INT         NOT NULL,
  FOREIGN KEY (Leverantör_ID) REFERENCES Leverantör (Leverantör_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE

);
CREATE INDEX IX_Produkt_Namn
  ON Produkter (Namn);


CREATE TABLE Auktion (
  Auktion_ID     INT AUTO_INCREMENT PRIMARY KEY,
  Start_Datum    DATETIME      NOT NULL,
  Slut_Datum     DATETIME      NOT NULL,
  Utgång_Pris    DECIMAL(8, 2) NOT NULL,
  Acceptans_Pris DECIMAL(8, 2),
  Produkt_ID     INT,
  FOREIGN KEY (Produkt_ID) REFERENCES Produkter (Produkt_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX IX_Start_Datum
  ON Auktion (Start_Datum);


CREATE TABLE Kund (
  Kund_ID      INT AUTO_INCREMENT PRIMARY KEY,
  Personnummer VARCHAR(10) NOT NULL,
  Förnamn      VARCHAR(50) NOT NULL,
  Efternamn    VARCHAR(50) NOT NULL,
  Telefon      VARCHAR(12) NOT NULL,
  Epost        VARCHAR(50) NOT NULL,
  Gatuadress   VARCHAR(50) NOT NULL,
  Postnummer   VARCHAR(50) NOT NULL,
  Ort          VARCHAR(50) NOT NULL
);
CREATE INDEX IX_Kund_Namn
  ON Kund (Förnamn);

CREATE TABLE Bud (
  Auktion_ID INT           NOT NULL,
  Pris       DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (Auktion_ID, Pris),
  Datum      DATETIME      NOT NULL,
  Kund_ID    INT           NOT NULL,
  FOREIGN KEY (Kund_ID) REFERENCES Kund (Kund_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Auktion_ID) REFERENCES Auktion (Auktion_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE AuktionHistorik (
  Auktion_ID     INT  PRIMARY KEY,
  Start_Datum    DATETIME      NOT NULL,
  Slut_Datum     DATETIME      NOT NULL,
  Acceptans_Pris DECIMAL(8, 2) NOT NULL,
  Produkt_ID     INT,
  Högsta_Bud       DECIMAL(8, 2) NOT NULL,
  Kund_ID    INT           NOT NULL,
  FOREIGN KEY (Produkt_ID) REFERENCES Produkter (Produkt_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE


);
/*
CREATE TABLE BudHistorik (
  Auktion_ID INT           NOT NULL,
  Pris       DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (Auktion_ID, Pris),
  Datum      DATETIME      NOT NULL,
  Kund_ID    INT           NOT NULL,
  FOREIGN KEY (Auktion_ID) REFERENCES AuktionHistorik (Auktion_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Kund_ID) REFERENCES Kund (Kund_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);*/



CREATE TABLE Auktioner_OsåldaProdukter (
  AuktionerOsålda_ID INT PRIMARY KEY ,
  Start_Datum    DATETIME      NOT NULL,
  Slut_Datum     DATETIME      NOT NULL,
  Utgång_Pris    DECIMAL(8, 2) NOT NULL,
  Acceptans_Pris DECIMAL(8, 2)
);

CREATE TABLE inloggnings_uppgifter (
  Kund_ID      VARCHAR(10) PRIMARY KEY NOT NULL,
  Password     VARCHAR(10) NOT NULL
);




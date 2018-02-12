  USE Aukademin;

  -- INSERTS

  -- Leverantörer
  INSERT INTO Leverantör VALUES (Leverantör_ID, 'Varvsö Möbler', 0.15, '018151418', '789456123', 'vo@mail.com', 'Norrbackagatan 64', '11325', 'Stockholm');
  INSERT INTO Leverantör VALUES (Leverantör_ID, 'Jannes Antik', 0.05, '031458978', '123456789', 'jannes@mail.com', 'Axvägen 4', '75427', 'Uppsala');
  INSERT INTO Leverantör VALUES (Leverantör_ID, 'Wikners Juvelerare', 0.12, '08125648', '456789123', 'wikjuv@mail.com', 'Vanadisvägen 23', '11323', 'Stockholm');
  INSERT INTO Leverantör VALUES (Leverantör_ID, 'Designakademin', 0.08, '08456785', '741258963', 'deak@mail.com', 'Valhallavägen 23', '72654', 'Västerås');
  INSERT INTO Leverantör VALUES (Leverantör_ID, 'Skumrask AB', 0.25, '0451875632', '852123458', 'skum@mail.com', 'Norrtäljegatan 6C', '75327', 'Uppsala');

  -- Produkter

  INSERT INTO Produkter VALUES (Produkt_ID, 'Vitrinskåp', '1900-talets första hälft', 1);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Mingvas', 'Kopia av vas med ursprung i Mingdynastin', 2);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Diamantringen Glitter', 'Vacker förlovningsring', 3);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Landskapstavla', 'Tavla med landskapsmotiv', 4);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Kristallkrona', 'Sent 1800-tal', 2);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Antik ljusstake', '1920-tal', 5);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Guldpläterat halsband', 'Vackert halsband', 3);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Stol Svanen', 'Dansk design', 2);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Klädskåp', 'Robuskt klädskåp från tidigt 1900-tal', 1);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Vy-över-sjö-Tavla', 'Tavla med vy över sjö', 4);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Antik skulptur', 'Okänt ursprung', 5);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Mässingslampa', 'Lampa i mässing', 2);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Robust Ekbord', 'Bord i vackert snidat ek', 1);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Grammofonspelare', 'Fungerande, från 1918', 2);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Klädbyrå', '1900-talets andra hälft', 1);
  INSERT INTO Produkter VALUES (Produkt_ID, 'Sovrumslampa', 'Lampa perfekt till sovrummet', 4);

  -- Auktion

  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-08 17:23:17', '2017-02-21 17:23:17', 3000.00, 7000.00, 1);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-08 23:00:07', '2017-02-18 23:00:07', 10000.00, 16500.00, 2);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-08 23:57:12', '2017-02-22 23:57:12', 10000.00, 18000.00, 3);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-08 18:52:00', '2017-02-10 18:52:00', 2500.00, 5000.00, 4);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-09-09 01:20:00', '2017-02-19 01:20:00', 2300.00, 6000.00, 5);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 03:01:32', '2017-02-19 03:01:32', 22000.00, 38000.00, 6);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 05:57:00', '2017-02-21 05:57:00', 300.00, 1500.00, 7);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 06:24:54', '2017-02-20 06:24:54', 12000.00, 30000.00, 8);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 07:51:00', '2017-02-20 07:51:00', 4000.00, 10500.00, 9);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 08:02:12', '2017-02-10 08:02:12', 3200.00, 7800.00, 10);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-09 11:36:01', '2017-02-21 11:36:01', 1500.00, 45000.00, 11);
  INSERT INTO Auktion VALUES (Auktion_ID, '2017-02-08 11:58:00', '2017-02-21 11:58:00', 3000.00, 10000.00, 12);



  --  Kunder
  INSERT INTO Kund VALUES (Kund_ID, '6501231502', 'Yasin', 'Danielsson', '0705889741', 'yd@mail.com', 'Lantmannagatan 56', '26041', 'Nyhamnsläge');
  INSERT INTO Kund VALUES (Kund_ID, '7304281519', 'Theodor', 'Samuelsson', '0734300606', 'ts@mail.com', 'Valldammsgatan 88', '18676', 'Brottby');
  INSERT INTO Kund VALUES (Kund_ID, '8405094353', 'Billy', 'Martinsson', '0702254754', 'bima@mail.com', 'Föreningsgatan 38', '36023', 'Älmeboda');
  INSERT INTO Kund VALUES (Kund_ID, '4801280745', 'Zanna', 'Björklund', '0702145642', 'zabj@mail.com', 'Läktargatan 64', '77601', 'Hedemora');
  INSERT INTO Kund VALUES (Kund_ID, '6108087625', 'Elma', 'Bergqvist', '0707975066', 'elmab@mail.com', 'Violvägen', '91011', 'Bjurholm');
  INSERT INTO Kund VALUES (Kund_ID, '7709081538', 'Rasmus', 'Söderberg', '0764914603', 'rasm@mail.com', 'Bonaröd 14', '51095', 'Dalstorp');
  INSERT INTO Kund VALUES (Kund_ID, '3611022686', 'Alicia', 'Ivarsson', '0738275624', 'aliv@mail.com', 'Söråsele 15', '91060', 'Åsele');
  INSERT INTO Kund VALUES (Kund_ID, '8603114946', 'Evelin', 'Sandström', '0705524272', 'evesand@mail.com', 'Södra Kroksdal 62', '54557', 'Töreboda');
  INSERT INTO Kund VALUES (Kund_ID, '5004091657', 'Natanael', 'Lund', '0706522254', 'nl@mail.com', 'Alingsåsvägen 93', '51041', 'Sjömarken');
  INSERT INTO Kund VALUES (Kund_ID, '5503060039', 'Amin', 'Gustafsson', '0705816958', 'amigu@mail.com', 'Storgatan 43', '34032', 'Grimslöv');

  -- Bud

  INSERT INTO Bud VALUES (1, 4500.00, '2017-02-08 18:01:00', 1);
  INSERT INTO Bud VALUES (1, 4800.00, '2017-02-08 18:23:00', 3);
  INSERT INTO Bud VALUES (1, 5000.00, '2017-02-08 19:57:56', 1);
  INSERT INTO Bud VALUES (2, 10000.00, '2017-02-09 01:03:00', 6);
  INSERT INTO Bud VALUES (2, 10200.00, '2017-02-09 01:10:00', 2);
  INSERT INTO Bud VALUES (2, 13000.00, '2017-02-09 01:12:23', 6);
  -- INSERT INTO Bud VALUES (4, 2700.00, '2017-02-09 10:00:00', 4);
  INSERT INTO Bud VALUES (6, 26000.00, '2017-02-09 11:35:00', 7);
  INSERT INTO Bud VALUES (6, 30000.00, '2017-02-09 11:37:15', 5);
  INSERT INTO Bud VALUES (10, 4500.00, '2017-02-09 08:05:00', 3);

  -- Inloggningsuppgifter
  INSERT INTO inloggnings_uppgifter VALUE ('1', '1111');
  INSERT INTO inloggnings_uppgifter VALUE ('2', '2222');
  INSERT INTO inloggnings_uppgifter VALUE ('3', '3333');
  INSERT INTO inloggnings_uppgifter VALUE ('4', '4444');
  INSERT INTO inloggnings_uppgifter VALUE ('5', '5555');


  -- AuktionHistorik
  -- INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-08 17:23:17', '2017-02-21 17:23:17',  7000.00, 1,3000.00,1);
  /*INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-08 23:00:07', '2017-02-18 23:00:07',  16500.00, 2);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-08 23:57:12', '2017-02-22 23:57:12',  18000.00, 3);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-08 18:52:00', '2017-02-20 18:52:00',  5000.00, 4);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-09-09 01:20:00', '2017-02-19 01:20:00',  6000.00, 5);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 03:01:32', '2017-02-19 03:01:32', 38000.00, 6);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 05:57:00', '2017-02-21 05:57:00',  1500.00, 7);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 06:24:54', '2017-02-20 06:24:54',  30000.00, 8);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 07:51:00', '2017-02-20 07:51:00',  10500.00, 9);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 08:02:12', '2017-02-19 08:02:12',  7800.00, 10);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-09 11:36:01', '2017-02-21 11:36:01',  45000.00, 11);
  INSERT INTO auktionhistorik VALUES (Auktion_ID, '2017-02-08 11:58:00', '2017-02-09 11:58:00', 10000.00, 12);*/



  -- Budhistorik

  /*INSERT INTO Budhistorik VALUES (12, 8500.00, '2017-02-09 10:00:00', 1);
  INSERT INTO Budhistorik VALUES (11, 10000.00, '2017-02-09 11:00:00', 2);
  INSERT INTO Budhistorik VALUES (10, 13000.00, '2017-02-09 09:00:00', 1);


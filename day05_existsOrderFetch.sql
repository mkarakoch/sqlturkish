CREATE TABLE mart_satislar 
(
	urun_id NUMBER(10),
	musteri_isim VARCHAR2(50),
	urun_isim VARCHAR2(50)
);

CREATE TABLE nisan_satislar 
(
	urun_id NUMBER(10),
	musteri_isim VARCHAR2(50),
	urun_isim VARCHAR2(50)
);

INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');

INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');

SELECT * FROM MART_SATISLAR ;

/*
 ORNEK 1 : Mart ve nisan aylarinda ayni urun_id ile satilan urunlerin 
 urun_id'llerini listeleyen ve ayni zamanda bu urunlerin Mart ayinda 
 alan musteri_isim'lerini listeleyen bir sorgu yaziniz. 
 */

SELECT urun_id, musteri_isim FROM mart_satislar ms
WHERE EXISTS (SELECT urun_id FROM nisan_satislar ns 
					WHERE ms.urun_id = ns.urun_id);
				

/*
  ORNEK 2 : Her iki ayda da satilan urunlerin urun_isim'lerini ve bu urunleri
  Nisan ayinda satin alan musteri_isim'lerini listeleyen bir sorgu yaziniz. 
 */

SELECT urun_isim, musteri_isim FROM nisan_satislar ns
WHERE EXISTS (SELECT urun_isim FROM mart_satislar ms
				WHERE ns.urun_isim = ms.urun_isim);




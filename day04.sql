CREATE TABLE tedarikciler
(
	vergi_no NUMBER(3) PRIMARY KEY,
 	firma_ismi VARCHAR2(50),
 	irtibat_ismi VARCHAR2(50)
 	 
);
 	
	INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huwaei', 'Cin Li');
 	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
 	INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
 
 SELECT * FROM TEDARIKCILER;

CREATE TABLE urunler  
(
	 ted_vergino NUMBER(3),
 	 urun_id NUMBER(11),
 	 urun_isim VARCHAR2(50),
 	 musteri_isim VARCHAR(50),
 	 CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES tedarikciler (vergi_no)
);
 	
 	INSERT INTO urunler VALUES(101, 1001, 'Laptop', 'Ayse Can'); 
 	INSERT INTO urunler VALUES(102, 1002, 'Phone', 'Fatma Aka'); 
 	INSERT INTO urunler VALUES(102, 1003, 'TV', 'Ramazan Oz'); 
 	INSERT INTO urunler VALUES(102, 1004, 'Laptop', 'Veli Han'); 
 	INSERT INTO urunler VALUES(103, 1005, 'Phone', 'Canan Ak'); 
 	INSERT INTO urunler VALUES(104, 1006, 'Tv', 'Ali Bak'); 
 	INSERT INTO urunler VALUES(104, 1007, 'Phone', 'Aslan Yilmaz'); 
    
SELECT * FROM urunler;

--ornek8 : Laptop satin alan musterilerin ismini, Apple'in irtibat_isim'i ile 
--degistirin

UPDATE urunler
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler 
                    WHERE firma_ismi = 'Apple')
WHERE urun_isim = 'Laptop';

---------SUBQUERY------------------
--Sorgu icinde calisan sorguya subquery(alt sorgu) denir. 
CREATE TABLE personel 
(
    id NUMBER(9),
    isim VARCHAR2(50),
    sehir VARCHAR2(50),
    maas NUMBER(20),
    sirket VARCHAR2(20)
);

INSERT INTO personel VALUES (123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO personel VALUES (234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO personel VALUES (345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO personel VALUES (456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO personel VALUES (567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO personel VALUES (456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO personel VALUES (123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');



CREATE TABLE sirketler
(
    sirket_id NUMBER(9),
    sirket_adi VARCHAR2(20),
    personel_sayisi NUMBER(20)
);

INSERT INTO sirketler VALUES (100, 'Honda', 12000);
INSERT INTO sirketler VALUES (101, 'Ford', 18000);
INSERT INTO sirketler VALUES (102, 'Hyundai', 10000);
INSERT INTO sirketler VALUES (103, 'Toyota', 21000);
INSERT INTO sirketler VALUES (104, 'Mazda', 17000);

/*
Ornek 1 : Personle sayisi 15000'den cok olan sirketlerin isimlerini ( alt sorgu sirketler)
ve bu sirkette calisan personelin isimlerini ve maaslarini (asil sorgu personle) listeleyin.
*/

SELECT isim, maas, sirket FROM personel
WHERE sirket IN ( SELECT sirket_adi FROM sirketler
                 WHERE personel_sayisi>15000);

/*
Ornek 2 : sirket_id'si 101'den buyuk olan sirket calisanlarinin isim maas ve sehirlerini
listeleyiniz. 
*/

SELECT isim, maas, sehir FROM personel
WHERE sirket IN (SELECT sirket_adi FROM sirketler 
                WHERE sirket_id > 101 );












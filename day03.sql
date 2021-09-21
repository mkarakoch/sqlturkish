---------SELECT --- WHERE ---------
CREATE TABLE  ogrenciler 
(
	id NUMBER(9),
	isim VARCHAR2(50),
	adres VARCHAR2(100),
	sinav_notu NUMBER(3)
);

INSERT INTO ogrenciler VALUES (123, 'Ali Can', 'Ankara', 75);
INSERT INTO ogrenciler VALUES (124, 'Merve Gul', 'Ankara', 85);
INSERT INTO ogrenciler VALUES (125, 'Kemal Yasa', 'Istanbul', 85);

SELECT * FROM ogrenciler;


/*
 	Verileri SELECT komutu ile veritabanindan cekerken filitreleme yapmak icin 
 	
 	Syntax 
 	------------
 	
 	SELECT ile birlikte WHERE komutu kullanilabilir. 
 	
 	SELECT sutun1, sutun2
 	
 	FROM tablo_adi WHERE kosul;
 */

/*
 	= 		esittir
 	<>		Esit degil != sekinde de kullanilir
 	>		Buyuktur
 	<		Kucuktur
 	>=		Buyuktur veya esittir
 	<=		Kucuktur veya esittir 
 	BETWEEN	Arasinda
 	LIKE	Metin Arama
 	IN		Bir sutun icinde birden cok olasi degerleri
 */

--ornek-1 : sinav notu 80 den buyuk olan ogrencilerin tum bilgilerini listele 

SELECT * FROM ogrenciler 
WHERE sinav_notu >80;

--ornek-2 : adresi Ankara olan ogrecilerin isim ve adres bilgilerini listele 
SELECT isim,adres FROM ogrenciler
WHERE adres = 'Ankara' ;

--ornek-3 : idsi 124 olan ogrencilerin tum bilgilerini sil

DELETE FROM ogrenciler 
WHERE id = 124 ;

---------SELECT --- BETWEEN ---------

CREATE TABLE personel 
(
	id CHAR(5),
	isim VARCHAR2(50),
	maas NUMBER(5)
);

INSERT INTO personel VALUES('10001', 'Ahmet Aslan', 7000);
INSERT INTO personel VALUES('10002', 'Mehmet Yilmaz', 12000);
INSERT INTO personel VALUES('10003', 'Meryem', 7215);
INSERT INTO personel VALUES('10004', 'Veli Han', 5000);
INSERT INTO personel VALUES('10005', 'Mustafa Ali', 5500);
INSERT INTO personel VALUES('10005', 'Ayse Can', 4000);

SELECT * FROM personel;

--ornek4 : id si 10002 ile 10005 arasinda olan personelin bilgilerini listele 

--1.Yontem

SELECT * FROM personel 
WHERE id BETWEEN '10002' AND '10005'; --Between'de ilk ve son deger dahildir. 

--2.Yontem
SELECT * FROM personel 
WHERE id >='10002' AND id <= '10005';
 

--ornek5 : ismi Mehmet yilmaz ile Veli Han arasinda olan personel bilgilerini listeleyin. 
SELECT * FROM PERSONEL 
WHERE isim BETWEEN 'Mehmet Yilmaz' AND 'Veli Han';

--ornek6 : id'si 10002 -10004 arasinda olmayan personeli maasini listele
SELECT id, maas FROM PERSONEL 
WHERE id NOT BETWEEN '10002' AND '10004';


---------SELECT --- IN ---------

/*
 	IN birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme
 	imani verir. 
 	
 	SYNTAX : 
 	---------------
 	SELECT sutun1, sutun2,.....
 	FROM tablo adi 
 	WHERE satin_adi IN (deger1, deger2 ..)
 	
 */

--ornek7 : maasi 4000,5000,7000 olan personelin bilgilerlini listele. 

SELECT * FROM personel
WHERE maas IN (4000,5000,7000);

SELECT * FROM personel
WHERE isim IN ('Veli Han', 'Ahmet Aslan');


---------UPDATE --- SET ---------
/*
 	Asadidaki gibi tedarikciler adinda bir tablo olusturunuz ve vergi_no sutunun
 	primary key yapiniz. Ayrica asagidaki verileri tabloya giriniz. 
 	
 	vergi_no NUMBER(3),
 	firma_ismi VARCHAR2(50,
 	irtibat_ismi VARCHAR2(50),
 	
 	
 	INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huwaei', 'Cin Li');
 	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
 	INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
 	
 	
 	Sonrasinda asagidaki gibi urunler adinda bir baska tablo olusturunuz ve
 	bu tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
 	iliskilendiriniz. Verileri giriniz. 
 	
 	 ted_vergino NUMBER(3),
 	 urunler_id NUMBER(11),
 	 urun_isim VARCHAR2(50),
 	 musteri_isim VARCHAR(50),
 	 
 	  
 	INSERT INTO urunler VALUES(101, 1001, 'Laptop', 'Ayse Can'); 
 	INSERT INTO urunler VALUES(102, 1002, 'Phone', 'Fatma Aka'); 
 	INSERT INTO urunler VALUES(102, 1003, 'TV', 'Ramazan Oz'); 
 	INSERT INTO urunler VALUES(102, 1004, 'Laptop', 'Veli Han'); 
 	INSERT INTO urunler VALUES(103, 1005, 'Phone', 'Canan Ak'); 
 	INSERT INTO urunler VALUES(104, 1006, 'Tv', 'Ali Bak'); 
 	INSERT INTO urunler VALUES(104, 1007, 'Phone', 'Aslan Yilmaz'); 
 	
 */
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

/*
        SYNTAX 
        ------------
        UPDATE tablo_adi
        SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
        WHERE kosul;
*/

--ornek1 : vergi_no 101 olan tedarikcinin firma ismini 'LG' olarak guncelleyin

UPDATE tedarikciler
SET firma_ismi = 'LG'
WHERE vergi_no = 101;

SELECT * FROM tedarikciler;

--ornek2 : tedarikciler tablosundaki tum firma isimlerini Samsung olarak guncelleyiniz. 

UPDATE tedarikciler
SET firma_ismi = 'Samsung';

--ornek3 : vergi no'su 102 olan tedarikcinin ismini 'Lenovo' ve irtibat_ismi'ni
-- 'Ali Veli' olarak guncelleyiniz. 

UPDATE tedarikciler
SET firma_ismi = 'Lenovo', irtibat_ismi = 'Ali Veli'
WHERE vergi_no = 102;

--ornek4 : firma ismi Samsung olan tedarikcinin irtibat ismini Ayse Yilmaz yapiniz 

UPDATE tedarikciler
SET irtibat_ismi = 'Ayse Yilmaz'
WHERE firma_ismi = 'Samsung';

--ornek5 : urunler tablosundaki urun_id degeri 1004'ten buyuk olanlarin urun_id
-- degerlerini bir arttiriniz 

UPDATE urunler
SET urun_id = urun_id+1 
WHERE urun_id >1004;

SELECT * FROM urunler;

--ornek6: urunler tablosundaki tum urunlerin urun_id degerini ted_vergino
--sutun deger ile toplayarak guncelleyiniz. 

UPDATE urunler 
SET urun_id = urun_id + ted_vergino;

--ornek7 : urunler tablosundan Ali Bak'in (Ayse Yilmaz) aldigi urunun ismini , TEDARIKCI
--TABLOSUNDAN irtibat_ismi 'Adam Eve' olan formanin ismi ( firma_ismi) ile 
-- degistiriniz. 

UPDATE urunler 
SET urun_isim = (SELECT firma_ismi FROM tedarikciler
                    WHERE irtibat_ismi = 'Adem Eve')
WHERE musteri_isim = 'Ali Bak';

SELECT * FROM urunler;
SELECT * FROM tedarikciler;













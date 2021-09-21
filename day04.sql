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
-- ======================= DELETE ==============================

--DELETE FROM tablo_adi; Tablonun tum icerigini siler. 
-- Bu komut bir DML komutudur. Dolayisiyla devamin WHERE gibi cumlecikler 
-- kullanilabilir. 


--DELETE FROM tablo_adi 
--WHERE sutun_adi = veri;

CREATE TABLE ogrenciler 
(
    id CHAR(3),
    isim VARCHAR2(50),
    veli_ismi VARCHAR2(50),
    yazili_notu NUMBER(3)
);

INSERT INTO ogrenciler VALUES (123 , 'Ali Can', 'Hasan', 75 );
INSERT INTO ogrenciler VALUES (124 , 'Merve Gul', 'Ayse', 85 );
INSERT INTO ogrenciler VALUES (125 , 'Kemal Yasa', 'Hasan', 85 );
INSERT INTO ogrenciler VALUES (126 , 'Nesibe Yilmaz', 'Ayse', 95 );
INSERT INTO ogrenciler VALUES (127 , 'Mustafa Bak', 'Can', 99 );



SELECT * FROM ogrenciler;

-- Secerek silmek icin WHERE Anahtar kelimesi kullanilabilir. 

--Ornek : id'si 124 olan ogrenciyi siliniz. 

DELETE FROM ogrenciler
WHERE id = 124;

--Ornek : Ismi Kemal Yasa olan satirini silinir

DELETE FROM ogrenciler 
WHERE isim = 'Kemal Yasa';

--Ornek : Ismi Nesibe Yilmaz ve Mustafa Bak olan kayilarini silelim 

DELETE FROM ogrenciler 
WHERE isim = 'Nesibe Yilmaz' OR isim ='Mustafa Bak';

--Ornek : Ismi Ali Can ve id'si 123 olan kaydi silinir 

DELETE FROM ogrenciler
WHERE isim = 'Ali Can' OR id=123;

--Ornek id'si 126'dan buyuk olan kayilari silelim
DELETE FROM ogrenciler 
WHERE id >126;

--Ornek : id'si 123,125 ve 126 olanlari silelim 
DELETE FROM ogrenciler 
WHERE id IN (123,125,126);

--Ornek : Tablodaki tum kayirlari silelim 
DELETE FROM ogrenciler;




/*
    Tablodaki kayilari silmek ile tabloyu silmek farkli islemlerdir. Silme
    komutlari da iki basamaklidir, biz genelde geri getirebilecek sekilde 
    sileriz. Ancak bazi guvenlik gibi sebeplerden geri getirilmeyecek 
    sekilde silinmesi istenebilir. 
*/

-- ======================= DELETE - TRUCATE - DROP==============================
/*
1) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler. 
Ancak secmeli silme yapmak. Cunku TRUNCATE komutu DML degil DDL komutudur. 
*/

TRUNCATE TABLE ogrenciler;

/*
2) DELETE komutu beraberinde WHERE cumlecigi kullanilabilir. TRUNCATE ile 
kullanilmaz. 
    TRUNCATE komutu tablo yapisini degistirmeden tablo icinde yer alan tum 
    verileri tek komutla silmenizi saglar 
3) Truncate ile silinen veriler geri alinmasi daha zordur. Ancak Transaction
yontemi ile geri alinmasi mumkun olabilir. 

4) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da siler. 
Silinen tablo Vertabaninin geri donusum kutuna gider. Silinen tablo asagidaki
komut ile geri alinabilir. Veya SQL GUI'den geri alinabilir. 

    FLASHBACK TABLE tablo_adi TO BEFORE DROP: -> tabloyu geri alir 
    
    PURGE TABLE tablo_adi; --> Geri donusumdeki tabloyu siler. 
    
    DROP TABLE tablo_adi PURGE; --> Tabloyu tamamen  siler. 
*/

--Cop kutusundan tabliyu geri getirmek icin 
FLASHBACK TABLE ogrenciler TO BEFORE DROP;

--Tabloyu tamamen siler ( Cop Kutusuna Atmaz.)
DROP TABLE ogrenciler PURGE;

--PURGE sadece DROP ile silinmis tablolar icin kullanilir. 
--DROP kullanmadan PURGE komutu kullanmak isterseniz
--ORA-38302 : invalid PURGE option hatasi alirsiniz
--Tum veriler hassas bir sekilde siler. rollback ile geri alinamaz. 

--PURGE yapmak icin 2 yontem kullanabiliriz. 
--1 tek satirda DROP ve PURGE beraber kullanabiliriz. 
DROP TABLE ogrenciler PURGE;

--Bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
--ORA : 38305 : Object not is RECYCLE BIN  hatasini alirsiniz

--2 : Daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz. 

DROP TABLE ogrenciler;
--Bu asamada ostersek FLASHBACK ile tablomusu geti getirebiliriz. 
PURGE TABLE ogrenciler;
--bu asamada istesem de tabloyu geri getiremem 


--Tablolar arasinda iliski varsa veriler nasil silinebilir ? 

-- =======================ON DELETE CASCADE==============================
/*
Her defasinda once child tablodaki verileri silmek yerine ON DELETE CASCADE
silme ozelligini aktif hale getirebiliriz. 

Bunun icin FK olan saticin en sonunda ON DELETE CASCADE koomutunu yazmak yeterli
*/

CREATE TABLE talebeler 
(
    id CHAR(3), --PK
    isim VARCHAR2(50),
    veli_isim VARCHAR2(50),
    yazili_notu NUMBER(3),
    CONSTRAINT talebe_pk PRIMARY KEY(id)
);

INSERT INTO ogrenciler VALUES (123 , 'Ali Can', 'Hasan', 75 );
INSERT INTO ogrenciler VALUES (124 , 'Merve Gul', 'Ayse', 85 );
INSERT INTO ogrenciler VALUES (125 , 'Kemal Yasa', 'Hasan', 85 );
INSERT INTO ogrenciler VALUES (126 , 'Nesibe Yilmaz', 'Ayse', 95 );
INSERT INTO ogrenciler VALUES (127 , 'Mustafa Bak', 'Can', 99 );

CREATE TABLE notlar 
(
    talebe_id CHAR(3),      --FK
    ders_adi VARCHAR2(30),
    yazili_notu NUMBER(3),
    CONSTRAINT talebeler(id) FOREIGN KEY(talebeler_id)
    REFERENCES talebeler(id) ON DELETE CASCADE  --on delete cascade sayesinde
--parenttaki silinen bir kayit ile iliskili olan tum child kaylarini 
--siler. DELETE FROM talebeler WHERE id=124; yaparsak childdaki 124lerde silinir. 
--mesela bir hastane silindi o hastanedeki butun kayilar silinmeli, oda boyle olur
--cascade yoksa once child temizlenir sonra parent 
);

INSERT INTO notlar VALUES ('123', 'kimya', 75);
INSERT INTO notlar VALUES ('124', 'fizik', 65);
INSERT INTO notlar VALUES ('125', 'tarih', 90);
INSERT INTO notlar VALUES ('126', 'matematik', 90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

DELETE FROM notlar 
WHERE talebe_id = 124; 

DELETE FROM talebeler 
WHERE id = 124;
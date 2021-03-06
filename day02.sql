/*========CONSTRAINTS - KISITLAMALAR =============

	NOT NULL - Bir situnun NULL icermemesini garanti eder 

	UNIQUE - Bir sutundaki tum degerlerin BENZERSIZ olmasini garanti eder. 
				Null kabul eder, hatta birden fazla nul deger girilebilir. 

	PRIMARY KEY - Bir sutunun NULL icermemesini ve stundaki verilerin 
					BENZERSIZ olmasini garanti eder. ( NOT NULL ve UNIQUE birlesimi gibi)

	FOREIGN KEY - Baska bir talodaki PRIMARY Key'i referans gostermek icin kullanilir. 
					Boylelikle, tablolar arasinda iliski kurulmus olur. 

	CHECK - Bir sutundaki tum verilerin belirlenen ozel bir sarti saglamasini garanti eder. 
	soldan tablo silerken toblonun kapali olmasi lazim. */


--ORNEK1 - NOT NULL --
--ogrenciler tablosu olusturalim ve Id field ini bos birakilamaz yapalim 

CREATE TABLE ogrenciler
(
		id char(4) NOT NULL,
		isim VARCHAR(50),
		not_ort NUMBER, --98.55 
		kayit_tarihi DATE
);


INSERT INTO ogrenciler VALUES('1234','HASAN', 75.25 , '14-Jan-2020');
INSERT INTO ogrenciler VALUES('1234','AYSE', NULL, null);
INSERT INTO ogrenciler (id, isim) VALUES('3456', 'FATMA');
--INSERT INTO ogrenciler VALUES(null,'OSMAN', 45.25 , '05-Jan-2020'); id ye null biraktigimiz icin hata mesaji verir. 


SELECT * FROM ogrenciler ;



--ORNEK2 UNIQUE
--Tedarikciler tablosunu olusturalim id unique olsun 
--

CREATE TABLE tedarikciler 
(
	id CHAR(4) UNIQUE ,
	isim VARCHAR(50),
	adres VARCHAR(100),
	tarih DATE
);

INSERT INTO tedarikciler VALUES('1234','AYSE','mehmet mah izmir','10-Nov-2020');
--INSERT INTO tedarikciler VALUES('1234','FATMA','veli mah istanbul','05-Nov-2020'); id unique oldugu icin kabul etmedi ilk girilen
--bilgi ile ayni oldugu icin
INSERT INTO tedarikciler VALUES(null,'CEM','suvari mah denizli','05-Nov-1997');
INSERT INTO tedarikciler VALUES(null,'CAN','zeki mah mus','05-Nov-1998');

--Unique constraint tekrara izin vermez ancak ancak istediginiz kadar null girebilirsiniz


SELECT * FROM TEDARIKCILER ;


--ORNEK 3 PRIMARY KEY 

CREATE TABLE personel 
(
	id CHAR(5) PRIMARY KEY,
	isim VARCHAR(50) UNIQUE,
	maas NUMBER(5) NOT NULL,
	ise_baslama DATE	
	
);

INSERT INTO personel VALUES ('10001', 'Ahmet Aslan', 7000, '13-Apr-2018');
INSERT INTO personel VALUES ('10001', 'Mehmet Yilmaz', 12000, '14-Apr-2018'); --UNIQUE oldugu icin kabul etmiyor '10001'
INSERT INTO personel VALUES ('10003', '', 5000, '14-Apr-2018');
INSERT INTO personel VALUES ('10004', 'Veli Han', 5000, '14-Apr-2018');
INSERT INTO personel VALUES ('10005', 'Ahmet Aslan', 5000, '14-Apr-2018'); --Ahmet Aslan UNIQUE oldugu icin kabul etmiyor. 
INSERT INTO personel VALUES (null, 'Canan Yas', null, '12-Apr-2019'); --id NULL olarak girildigi icin hata mesaji aliniyor. 

SELECT * FROM PERSONEL ;

--ogrenciler3 tablosu olusturalim ve ogrenci_id'yi PRIMARY KEY yapalim 

CREATE TABLE ogrenciler3
(
		ogrenci_id CHAR(4) PRIMARY KEY,
		isim_soyisim VARCHAR2(50),
		not_ort NUMBER(5,2), --100.00 
		kayit_tarihi DATE
);

INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman', 75.70, '14-Jan-2020');
INSERT INTO ogrenciler3 VALUES (NULL, 'veli yaman', 85.70, '14-Jan-2020'); --id NULL olamaz 
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can', 55.70, '14-Jun-2020');--id benzersiz olmali. daha onceverilen id kullanilamaz
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ('Velli Cem');--id vermeden baska seyler vermeye gecemezsin, DEFAULT NULL atar
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ('5678');

SELECT * FROM ogrenciler3;


--Primary key alternatif yontem 
--Bu yontemde kisitlamaya istedigimiz ismi atayabiliriz. 

CREATE TABLE calisanlar 
(
	id CHAR(5),
	isim VARCHAR(50) UNIQUE,
	maas NUMBER(5) NOT NULL,
	CONSTRAINT id_primary PRIMARY KEY (id)
);

INSERT INTO calisanlar VALUES ('10001', 'Ahmet Aslan', 7000);
INSERT INTO calisanlar VALUES ('10002', 'Mehmet Yilmaz', 12000);
INSERT INTO calisanlar VALUES ('10003', 'Can', 5000);

SELECT * FROM calisanlar;
--Bir tabloya data eklerken constraints'lere dikkat edilmelidir. 



--ORNEK 4 FOREIGN KEY 
CREATE TABLE adresler
(
	adres_id CHAR(5),
	sokak VARCHAR(30),
	cadee VARCHAR(30),
	sehir VARCHAR(15),
	CONSTRAINT id_foreign FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES ('10001', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES ('10001', 'Can Sok', '50.Cad.', 'Ankara');
INSERT INTO adresler VALUES ('10002', 'Aga Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES ('', 'Aga Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES ('', 'Aga Sok', '30.Cad.', 'Antep');

--foreign key null degeri atanabilir. 

INSERT INTO adresler VALUES ('10004', 'Gel Sok', '60.Cad.', 'Van'); --Parent ta olmayan id li veri giremeyiz. 


SELECT * FROM calisanlar; --parent
DROP TABLE calisanlar;

SELECT * FROM adresler; --child
DROP TABLE adresler;
--child tablo silinmeden parent tablo silinmez. 


--ogrenciler5 tablosunu olusturun ve id, isim hanelerinin birlesimini primary key yapin 

CREATE TABLE ogrenciler5 
(
	id CHAR(4),
	isim VARCHAR(20),
	not_ort NUMBER(5,2),
	kayit_tarihi DATE,
	CONSTRAINT ogrenciler5_primary PRIMARY KEY(id,isim,not)
);

INSERT INTO ogrenciler5 VALUES (NULL, 'Veli Cem', 90.6, '15-May-2019');
INSERT INTO ogrenciler5 VALUES (1234, NULL, 90.6,'15-May-2019');
INSERT INTO ogrenciler5 VALUES (1234, 'Ali Can', 90.6,'15-May-2019');
INSERT INTO ogrenciler5 VALUES (1234, 'Veli Cen', 90.6,'15-May-2019');
INSERT INTO ogrenciler5 VALUES (1234, 'Oli Can', 90.6,'15-May-2019');

SELECT * FROM ogrenciler5;



--"tedarikiler4" isimli bir Tablo olusurun. Icinde tedarikciler_id tedarikci_isim iletisim_isim feild'lari olsun.
--tedarikci_id e tedarikci_isim feildlerini birlestirerek Primary Key olusturun 
--urunler2 isminde baska bir tablo olusurun. icinde tedarikci_id ve urun_id fieldleri olsun
--tedarikci_id ve urun_id fieldlari birlesitirerek Foreign Key olusturun 

CREATE TABLE tedarikciler4 
(
	tedarikci_id CHAR(4),
	tedarikci_isim VARCHAR2(20),
	ilertisim_ismi VARCHAR2(20),
	CONSTRAINT tedarikciler4_pk PRIMARY KEY(tedarikci_id,tedarikci_isim)
);

CREATE TABLE urunler2 
(
	tedarikci_id CHAR(4),
	urun_id VARCHAR2(5),
	yas NUMBER,
	CONSTRAINT urunler2_fk FOREIGN KEY(tedarikci_id,urun_id) REFERENCES tedarikciler4
);

CREATE TABLE sehirler2 
(
	alan_kodu CHAR(3),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
);


INSERT INTO sehirler2 VALUES('312', 'Ankara', 5750000);
INSERT INTO sehirler2 VALUES('232', 'izmir', 375); --CHECK degeri 1000 altinda oldugu icin eklerken error verdi.
INSERT INTO sehirler2 VALUES('232', 'izmir', 3750000);
INSERT INTO sehirler2 VALUES('436', 'Maras', null);











 
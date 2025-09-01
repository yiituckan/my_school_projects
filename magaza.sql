CREATE DATABASE magaza;

CREATE TABLE musteriler (
	id INT NOT NULL AUTO_INCREMENT,
    isim VARCHAR(45) NOT NULL,
    soyisim VARCHAR(45) NOT NULL,
    sehir VARCHAR(20),
    adres VARCHAR(255),
    telefon VARCHAR(10),
	PRIMARY KEY(id)
);

CREATE TABLE tedarikciler (
	id INT NOT NULL AUTO_INCREMENT,
    sirket_ismi VARCHAR(255) NOT NULL,
    kisi_ismi VARCHAR(90) NOT NULL,
    sehir VARCHAR(20),
    adres VARCHAR(255),
    telefon VARCHAR(10),
	PRIMARY KEY(id)
);

CREATE TABLE urunler (
	id INT NOT NULL AUTO_INCREMENT,
    ismi VARCHAR(255) NOT NULL,
    tedarikci_id INT NOT NULL,
    fiyat decimal,
    stok_miktari INT,
	PRIMARY KEY(id),
    FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler(id)
);

CREATE TABLE siparisler (
	id INT NOT NULL AUTO_INCREMENT,
    tarih datetime NOT NULL,
    musteri_id INT NOT NULL,
    tutar decimal,
	PRIMARY KEY(id),
    FOREIGN KEY(musteri_id) REFERENCES musteriler(id)
);

CREATE TABLE siparis_urun (
	id INT NOT NULL AUTO_INCREMENT,
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT,
	PRIMARY KEY(id),
    FOREIGN KEY(siparis_id) REFERENCES siparisler(id),
    FOREIGN KEY(urun_id) REFERENCES urunler(id)
);

INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("Kubilay", "Erişlik", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("ALi Kerem", "Bölük", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("Berkay", "Akçay", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("Deniz", "Gerçeker", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("Yiğit", "Uçkan", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO musteriler(isim, soyisim, sehir, adres, telefon) VALUES ("Ezgi", "Kutay", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");

INSERT INTO tedarikciler(sirket_ismi, kisi_ismi, sehir, adres, telefon) VALUES ("İstanbul Ticaret Üniversitesi", "İlayda Yakan", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO tedarikciler(sirket_ismi, kisi_ismi, sehir, adres, telefon) VALUES ("İstanbul Ticaret Odası", "Muhammet Kemal Ata", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO tedarikciler(sirket_ismi, kisi_ismi, sehir, adres, telefon) VALUES ("İstanbul Borsa", "Samet İlhan", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");
INSERT INTO tedarikciler(sirket_ismi, kisi_ismi, sehir, adres, telefon) VALUES ("İstanbul Emniyet", "Yusuf Mirza Tümür", "İstanbul", "Örnektepe Mah. İmrahor Cad.", "5366484191");

INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Telefon", 2, 25750, 10);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Laptop", 5, 32000, 20);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Monitör", 4, 6000, 15);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Klavye", 4, 1000, 35);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Mouse", 4, 800, 55);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Mouse", 3, 800, 55);
INSERT INTO urunler(isim, tedarikci_id, fiyat, stok_miktari) values ("Mouse", 2, 750, 55);

INSERT INTO siparisler(tarih,musteri_id,tutar) values (CURRENT_TIMESTAMP,1,10000);
INSERT INTO siparisler(tarih,musteri_id,tutar) values (CURRENT_TIMESTAMP,3,25000);
INSERT INTO siparisler(tarih,musteri_id,tutar) values (CURRENT_TIMESTAMP,4,5000);
INSERT INTO siparisler(tarih,musteri_id,tutar) values (CURRENT_TIMESTAMP,2,75000);
INSERT INTO siparisler(tarih,musteri_id,tutar) values (CURRENT_TIMESTAMP,1,800);

INSERT INTO siparis_urun(siparis_id, urun_id,adet) values (1, 3, 1);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (1, 4, 4);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (2, 1, 1);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (3, 4, 5);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (4, 3, 2);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (4, 4, 1);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (4, 4, 5);
INSERT INTO siparis_urun(siparis_id,urun_id,adet) values (5, 5, 1);

Update siparis_urun SET urun_id = 4 where id =7;
Update siparis_urun SET urun_id = 5 where id =8;
Update siparis_urun SET urun_id = 6 where id =9;

SELECT isim AS "Ürün Adı", stok_miktari AS "Stok" FROM urunler ORDER BY stok_miktari;

SELECT * From siparis_urun;

SELECT DISTINCT siparis_id FROM siparis_urun;

select * from siparisler;

select isim, stok_miktari from urunler;

SELECT isim AS "İsim", avg(fiyat) AS "Ortalama Fiyat", count(tedarikci_id) AS "Tedarikçi Miktarı" from urunler group by isim;

SELECT * FROM siparis_urun;

SELECT siparis_id, isim,  fiyat, adet, tutar FROM siparis_urun LEFT JOIN urunler on urun_id = urunler.id join siparisler on siparis_id = siparisler.id;

SELECT siparisler.id, adet, fiyat FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id;

SELECT siparisler.id, adet, fiyat, fiyat*adet FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id;

SELECT siparisler.id, tarih, sum(fiyat*adet) AS "Tutar" FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id group by siparisler.id;

SELECT siparisler.id, tarih, sum(fiyat*adet) AS "Tutar" FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id where tarih > "2023-03-09 09:48:00" group by siparisler.id ;

SELECT siparisler.id, tarih, sum(fiyat*adet) AS "Tutar" FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id group by siparisler.id having sum(fiyat*adet) between 25000 and 30000 ;

SELECT siparisler.id, tarih, sum(fiyat*adet) AS "Tutar" FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id  group by siparisler.id having sum(fiyat*adet) between 25000 and 30000;

SELECT count(siparisler.id), tarih, sum(fiyat*adet) AS "Tutar" FROM siparisler join siparis_urun on siparis_id = siparisler.id join urunler on urunler.id = urun_id  group by siparisler.tarih;


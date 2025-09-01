-- Soru 1: Customers isimli bir veritaban� ve verilen veri setindeki de�i�kenleri i�erecek flo_data isimli bir tablo olu�turunuz.
create database customers

create table flo_data

select * from flo_data

-- Soru 2: Ka� farkl� m��terinin al��veri� yapt���n� g�sterecek sorguyu yaz�n�z.
select count(master_id) from flo_data as Musteri_Sayisi


-- Soru 3: Toplam yap�lan al��veri� say�s� ve ciroyu getirecek sorguyu yaz�n�z--
select (sum(customer_value_total_ever_offline) + sum(customer_value_total_ever_online)) as ciro, 
ROUND(SUM(order_num_total_ever_online) + sum(order_num_total_ever_offline), 2) as Toplam_Alisveris from flo_data;



-- Soru 4: Al��veri� ba��na ortalama ciroyu getirecek sorguyu yaz�n�z--
select Sum(customer_value_total_ever_offline + customer_value_total_ever_online) / sum(order_num_total_ever_online + order_num_total_ever_offline) as ortalama_ciro from flo_data;



-- Soru 5: En son al��veri� yap�lan kanal (last_order_channel) �zerinden yap�lan al��veri�lerin toplam ciro ve al��veri� say�lar�n� getirecek sorguyu yaz�n�z--
select last_order_channel as son_alisveris_kanali, sum(customer_value_total_ever_offline + customer_value_total_ever_online) as Ciro, 
sum(order_num_total_ever_online + order_num_total_ever_offline) as toplam_alisveris from Flo_Data group by last_order_channel;



-- Soru 6: Store type k�r�l�m�nda elde edilen toplam ciroyu getiren sorguyu yaz�n�z--
select store_type as magaza_tipi, sum(customer_value_total_ever_offline + customer_value_total_ever_online) as Ciro from Flo_Data 
group by store_type;


-- Soru 7: Y�l k�r�l�m�nda al��veri� say�lar�n� getirecek sorguyu yaz�n�z (Y�l olarak m��terinin ilk al��veri� tarihi (first_order_date) y�l�n� baz al�n�z)--
select YEAR(first_order_date) as ilk_siparis_yili,
sum(order_num_total_ever_online + order_num_total_ever_offline) as alisveris_sayisi 
from flo_data group by YEAR(first_order_date) order by 1 desc; 


-- Soru 8: En son al��veri� yap�lan kanal k�r�l�m�nda al��veri� ba��na ortalama ciroyu hesaplayacak sorguyu yaz�n�z.--
select last_order_channel as son_siparis_kanali, 
ROUND(Sum(customer_value_total_ever_offline + customer_value_total_ever_online) / sum(order_num_total_ever_online + order_num_total_ever_offline), 2) as ortalama_ciro 
from Flo_Data group by last_order_channel;



--Soru 9: Son 12 ayda en �ok ilgi g�ren kategoriyi getiren sorguyu yaz�n�z.--
select interested_in_categories_12 as Kategoriler, count(*) Frekans_Bilgisi from Flo_Data group by interested_in_categories_12 order by 2 desc; 


-- Soru 10: En �ok tercih edilen store_type bilgisini getiren sorguyu yaz�n�z--
select top 1 store_type as magaza_tipi , count(*) as frekans from Flo_Data group by store_type order by 2 desc;



-- Soru 11: En son al��veri� yap�lan kanal (last_order_channel) baz�nda, en �ok ilgi g�ren kategoriyi ve bu kategoriden ne kadarl�k al��veri� yap�ld���n� getiren sorguyu yaz�n�z--
SELECT DISTINCT last_order_channel,
(select top 1 interested_in_categories_12 from flo_data where last_order_channel = f.last_order_channel
group by interested_in_categories_12 order by sum(order_num_total_ever_online + order_num_total_ever_offline) desc
) AS CATEGORY,
(select top 1 sum(order_num_total_ever_online + order_num_total_ever_offline) from flo_data where last_order_channel = f.last_order_channel
group by interested_in_categories_12 order by sum(order_num_total_ever_online + order_num_total_ever_offline) desc
) AS SHOPP�NG_COUNT from flo_data F;



-- Soru 12: En �ok al��veri� yapan ki�inin ID� sini getiren sorguyu yaz�n�z--
SELECT TOP 1 master_id as id from Flo_Data 
	group by  master_id order by Sum(customer_value_total_ever_offline + customer_value_total_ever_online) desc;



-- Soru 13: En �ok al��veri� yapan ki�inin al��veri� ba��na ortalama cirosunu ve al��veri� yapma g�n ortalamas�n� (al��veri� s�kl���n�) getiren sorguyu yaz�n�z.--
SELECT *,
	ROUND((D.TOPLAM_CIRO / D.TOPLAM_SIPARIS_SAYISI), 2) SIPARIS_BASINA_ORTALAMA
FROM
	(SELECT TOP 1
		master_id,
		sum(customer_value_total_ever_offline + customer_value_total_ever_offline) TOPLAM_CIRO,
		sum(order_num_total_ever_offline + order_num_total_ever_online) TOPLAM_SIPARIS_SAYISI
	FROM flo_data
	GROUP BY master_id
	ORDER BY TOPLAM_CIRO DESC
	) D;



-- Soru 14: En �ok al��veri� yapan (ciro baz�nda) ilk 100 ki�inin al��veri� yapma g�n ortalamas�n� (al��veri� s�kl���n�) getiren sorguyu yaz�n�z.--
SELECT
	D.master_id,
	D.TOPLAM_CIRO,
	D.TOPLAM_SIPARIS_SAYISI,
	ROUND((D.TOPLAM_CIRO / D.TOPLAM_SIPARIS_SAYISI), 2) as SIPARIS_BASINA_ORTALAMA,
	DATEDIFF(DAY, first_order_date, last_order_date) as GUN_FARKI,
	ROUND((DATEDIFF(DAY, first_order_date, last_order_date)/ D.TOPLAM_SIPARIS_SAYISI), 1) AS ALISVERIS_GUN_ORT
FROM
	(SELECT TOP 100
		master_id,
		first_order_date,
		last_order_date,
		sum(customer_value_total_ever_offline + customer_value_total_ever_offline) TOPLAM_CIRO,
		sum(order_num_total_ever_offline + order_num_total_ever_online) TOPLAM_SIPARIS_SAYISI
	FROM flo_data
	GROUP BY master_id, first_order_date, last_order_date
	ORDER BY TOPLAM_CIRO DESC
	) D;




-- Soru 15: En son al��veri� yap�lan kanal (last_order_channel) k�r�l�m�nda en �ok al��veri� yapan m��teriyi getiren sorguyu yaz�n�z.-
SELECT DISTINCT last_order_channel,
	(select top 1
		master_id 
	from flo_data 
	where last_order_channel = f.last_order_channel
	group by master_id 
	order by sum(customer_value_total_ever_offline + customer_value_total_ever_offline) desc
		) as EN_COK_ALISVERIS_YAPAN_MUSTERI,
	(SELECT TOP 1
		sum(customer_value_total_ever_offline + customer_value_total_ever_offline)
	from flo_data
	where last_order_channel= f.last_order_channel
	group by master_id
	order by sum(customer_value_total_ever_offline + customer_value_total_ever_offline) desc
	) as ciro FROM flo_data F;




-- Soru 16: En son al��veri� yapan ki�inin ID� sini getiren sorguyu yaz�n�z. (Max son tarihte birden fazla al��veri� yapan ID bulunmakta.Bunlar� da getiriniz.)
SELECT last_order_date, master_id from flo_data where last_order_date = (select max(last_order_date) from flo_data)

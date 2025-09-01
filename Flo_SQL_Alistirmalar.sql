-- Soru 1: Customers isimli bir veritabaný ve verilen veri setindeki deðiþkenleri içerecek flo_data isimli bir tablo oluþturunuz.
create database customers

create table flo_data

select * from flo_data

-- Soru 2: Kaç farklý müþterinin alýþveriþ yaptýðýný gösterecek sorguyu yazýnýz.
select count(master_id) from flo_data as Musteri_Sayisi


-- Soru 3: Toplam yapýlan alýþveriþ sayýsý ve ciroyu getirecek sorguyu yazýnýz--
select (sum(customer_value_total_ever_offline) + sum(customer_value_total_ever_online)) as ciro, 
ROUND(SUM(order_num_total_ever_online) + sum(order_num_total_ever_offline), 2) as Toplam_Alisveris from flo_data;



-- Soru 4: Alýþveriþ baþýna ortalama ciroyu getirecek sorguyu yazýnýz--
select Sum(customer_value_total_ever_offline + customer_value_total_ever_online) / sum(order_num_total_ever_online + order_num_total_ever_offline) as ortalama_ciro from flo_data;



-- Soru 5: En son alýþveriþ yapýlan kanal (last_order_channel) üzerinden yapýlan alýþveriþlerin toplam ciro ve alýþveriþ sayýlarýný getirecek sorguyu yazýnýz--
select last_order_channel as son_alisveris_kanali, sum(customer_value_total_ever_offline + customer_value_total_ever_online) as Ciro, 
sum(order_num_total_ever_online + order_num_total_ever_offline) as toplam_alisveris from Flo_Data group by last_order_channel;



-- Soru 6: Store type kýrýlýmýnda elde edilen toplam ciroyu getiren sorguyu yazýnýz--
select store_type as magaza_tipi, sum(customer_value_total_ever_offline + customer_value_total_ever_online) as Ciro from Flo_Data 
group by store_type;


-- Soru 7: Yýl kýrýlýmýnda alýþveriþ sayýlarýný getirecek sorguyu yazýnýz (Yýl olarak müþterinin ilk alýþveriþ tarihi (first_order_date) yýlýný baz alýnýz)--
select YEAR(first_order_date) as ilk_siparis_yili,
sum(order_num_total_ever_online + order_num_total_ever_offline) as alisveris_sayisi 
from flo_data group by YEAR(first_order_date) order by 1 desc; 


-- Soru 8: En son alýþveriþ yapýlan kanal kýrýlýmýnda alýþveriþ baþýna ortalama ciroyu hesaplayacak sorguyu yazýnýz.--
select last_order_channel as son_siparis_kanali, 
ROUND(Sum(customer_value_total_ever_offline + customer_value_total_ever_online) / sum(order_num_total_ever_online + order_num_total_ever_offline), 2) as ortalama_ciro 
from Flo_Data group by last_order_channel;



--Soru 9: Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazýnýz.--
select interested_in_categories_12 as Kategoriler, count(*) Frekans_Bilgisi from Flo_Data group by interested_in_categories_12 order by 2 desc; 


-- Soru 10: En çok tercih edilen store_type bilgisini getiren sorguyu yazýnýz--
select top 1 store_type as magaza_tipi , count(*) as frekans from Flo_Data group by store_type order by 2 desc;



-- Soru 11: En son alýþveriþ yapýlan kanal (last_order_channel) bazýnda, en çok ilgi gören kategoriyi ve bu kategoriden ne kadarlýk alýþveriþ yapýldýðýný getiren sorguyu yazýnýz--
SELECT DISTINCT last_order_channel,
(select top 1 interested_in_categories_12 from flo_data where last_order_channel = f.last_order_channel
group by interested_in_categories_12 order by sum(order_num_total_ever_online + order_num_total_ever_offline) desc
) AS CATEGORY,
(select top 1 sum(order_num_total_ever_online + order_num_total_ever_offline) from flo_data where last_order_channel = f.last_order_channel
group by interested_in_categories_12 order by sum(order_num_total_ever_online + order_num_total_ever_offline) desc
) AS SHOPPÝNG_COUNT from flo_data F;



-- Soru 12: En çok alýþveriþ yapan kiþinin ID’ sini getiren sorguyu yazýnýz--
SELECT TOP 1 master_id as id from Flo_Data 
	group by  master_id order by Sum(customer_value_total_ever_offline + customer_value_total_ever_online) desc;



-- Soru 13: En çok alýþveriþ yapan kiþinin alýþveriþ baþýna ortalama cirosunu ve alýþveriþ yapma gün ortalamasýný (alýþveriþ sýklýðýný) getiren sorguyu yazýnýz.--
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



-- Soru 14: En çok alýþveriþ yapan (ciro bazýnda) ilk 100 kiþinin alýþveriþ yapma gün ortalamasýný (alýþveriþ sýklýðýný) getiren sorguyu yazýnýz.--
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




-- Soru 15: En son alýþveriþ yapýlan kanal (last_order_channel) kýrýlýmýnda en çok alýþveriþ yapan müþteriyi getiren sorguyu yazýnýz.-
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




-- Soru 16: En son alýþveriþ yapan kiþinin ID’ sini getiren sorguyu yazýnýz. (Max son tarihte birden fazla alýþveriþ yapan ID bulunmakta.Bunlarý da getiriniz.)
SELECT last_order_date, master_id from flo_data where last_order_date = (select max(last_order_date) from flo_data)

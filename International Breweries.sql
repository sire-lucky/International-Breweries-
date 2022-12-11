CREATE DATABASE international_breweries;

CREATE TABLE root_data (
    sales_id int,
    sales_rep text,
    emails varchar,
	brand text,
    plant_cost int,
    unit_price int,
    quntity int,
    cost int,
    profit int,
    countries text,
    region text,
    months text,
    years int
    );

COPY root_data 
FROM 'C:\Users\DELL\Desktop\luck\Utiva\UTIVA FILES\International_Breweries.csv'
DELIMITER ',' CSV 
HEADER;

SELECT * 
FROM root_data;

/* question 1: Within the space of the last three years, what was the profit worth of the breweries, inclusive of 
 the anglophone and the francophone territories?*/

select sum(profit) as total_profit from root_data

/* question 2. Compare the total profit between these two territories in order for the territory manager, Mr.
Stone make strategic decision that will aid profit maximization in 2020.*/

---select distinct countries from root_data

select case 
	when (countries = 'Ghana' or countries = 'Nigeria') then 'Anglophone'
	else 'Francophone'
end as Territory,
sum(profit) as total_profit from root_data
group by 1
order by 2

---3. Country that generated the highest profit in 2019

select years, countries, sum(profit) as highest_profit_2019 from root_data
where years = '2019'
group by 1, 2 
order by 3 desc
limit 1

---4. Help him find the year with the highest profit.

select years, sum(profit) as year_highest_profit from root_data
group by 1 
order by 2 desc 
limit 1

---5. Which month in the three years were the least profit generated?

select months, years, sum(profit) as least_profit from root_data
group by 1, 2
order by 3 
limit 1


---6. What was the minimum profit in the month of December 2018?

select months, years, min(profit) as min_profit_dec2018 from root_data
where years='2018' and months='December'
group by 1, 2

---7. Compare the profit in percentage for each of the month in 2019

select months, years, sum(profit), count(profit) * 100/ sum(count(profit)) over () as percentage_per_year from root_data
where years= 2019
group by 1,2
order by 4 desc

---8. Which particular brand generated the highest profit in Senegal?

select brand, countries, sum(profit) as highest_profit_senegal from root_data
where countries='Senegal'
group by 1, 2
order by 3 desc 
limit 1

/*BRAND ANALYSIS
1. Within the last two years, the brand manager wants to know the top three brands consumed in 
the francophone countries*/
--select distinct years from root_data


select years, brand, sum(quntity) as Brands_consumend from root_data
where (years='2019' or years='2018')
and (countries = 'Senegal' or countries='Togo' or countries='Benin')
group by 1,2
order by 3 desc
limit 3


---2. Find out the top two choice of consumer brands in Ghana

select brand, countries, sum(quntity)as top_choice_ghana from root_data
where countries='Ghana'
group by 1, 2
order by 3 desc
limit 2


/*3. Find out the details of beers consumed in the past three years in the most oil reach country in 
West Africa.*/
select distinct brand from root_data

select brand, countries, sum(quntity) as beers_consumed from root_data
where countries='Nigeria'
and brand in ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy')
group by 1,2
order by 3 desc

and brand not like '%malt' / and not brand = 'beta malt' and not brand = 'grand malt' 

---4. Favorites malt brand in Anglophone region between 2018 and 2019 

select brand, sum(quntity) as favorites_malt_Anglophone from root_data
where (years='2019' or years='2018')
and (countries = 'Nigeria' or countries='Ghana')
and brand= 'beta malt' or brand= 'grand malt'
group by 1
order by 2 desc
limit 1

---5. Which brands sold the highest in 2019 in Nigeria?

select brand as highest_sold_brand, countries, sum(quntity) from root_data
where countries='Nigeria'
and years= 2019
group by 1,2
order by 3 desc

---6. Favorites brand in South_South region in Nigeria

select brand as favorites_brand_southsouth, countries, sum(quntity) from root_data
where countries='Nigeria'
and region= 'southsouth'
group by 1,2
order by 3 desc

7. Bear consumption in Nigeria

select brand, countries, sum(quntity) as beers_consumed from root_data
where countries='Nigeria'
and brand in ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy')
group by 1,2
order by 3 desc

---8. Level of consumption of Budweiser in the regions in Nigeria

select brand, region, sum(quntity) as budweiser_consumed from root_data
where countries='Nigeria'
and brand = 'budweiser'
group by 1,2
order by 3 desc


9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)

select brand, region, sum(quntity) as budweiser_consumed from root_data
where countries='Nigeria'
and brand = 'budweiser'
and years = '2019'
group by 1,2
order by 3 desc

COUNTRIES ANALYSIS
---1. Country with the highest consumption of beer.

select countries, sum(quntity) from root_data
where brand not like '%malt' 
group by 1
order by 2 desc
limit 1

---2. Highest sales personnel of Budweiser in Senegal

select sales_rep as highest_sales_personnel, sum(quntity) as budweiser from root_data
where countries = 'Senegal'
and brand = 'budweiser'
group by 1
order by 2 desc
limit 1

---3. Country with the highest profit of the fourth quarter in 2019

select countries, sum(profit) as profit from root_data
where years = 2019
and months in ('October', 'November', 'December')
group by 1
order by 2 desc
limit 1
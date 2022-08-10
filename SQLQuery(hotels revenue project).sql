with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select * from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal

--showing the revenues per year  after applying discount (if the profites increase on the hotels from one year to another or not )

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.arrival_date_year,h.hotel ,round(sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as revenue from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled=0
group by h.arrival_date_year ,h.hotel
order by h.hotel asc

-----------------------------------------------------------------
--total revenues per year
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.arrival_date_year,round(sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as revenue from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled=0
group by h.arrival_date_year
order by revenue asc
-----------------------------------------------------
--total revenue per hotel regardless year 

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.hotel ,round(sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as revenue  from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 0
group by h.hotel
order by revenue asc
---------------------------------------------------------------
--total number of guests per hotel ,average stayed nights per guest  , total nights per hotel , revenue average per hotel , total revenuse per hotel 

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.hotel ,count(h.hotel) as number_guests,round(avg(stays_in_week_nights +stays_in_weekend_nights),2) as avg_nights ,sum(stays_in_week_nights + stays_in_weekend_nights) as total_nights
,round(Avg(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as average_per_stay_discount,
round(Sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as total_revenue

from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 0
group by h.hotel
order by average_per_stay_discount  asc

----------------------------
--total number of guests per year ,average stayed nights per guest  , total nights per year , revenue average per year , total revenuse per year 

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.arrival_date_year ,count(h.hotel) as number_guests,round(avg(stays_in_week_nights +stays_in_weekend_nights),2) as avg_nights ,sum(stays_in_week_nights + stays_in_weekend_nights) as total_nights
,round(Avg(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as average_revenue,round(avg(((stays_in_week_nights +stays_in_weekend_nights)*(h.adr*ms.Discount))),2) as avg_discount_value,
round(Sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as total_revenue

from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 0 and h.hotel like '%resort%'
group by h.arrival_date_year
order by h.arrival_date_year  asc

------------------------------------------------------------
--showing market segment for the two hotels in terms of (number of guests , average nights , total nights , average revenue ,average discount , total revenuse )
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.market_segment ,count(h.hotel) as number_guests,round(avg(stays_in_week_nights +stays_in_weekend_nights),2) as avg_nights ,sum(stays_in_week_nights + stays_in_weekend_nights) as total_nights
,round(Avg(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as average_revenue,round(avg(((stays_in_week_nights +stays_in_weekend_nights)*(h.adr*ms.Discount))),2) as avg_discount_value,
round(Sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as total_revenue

from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 0 and h.hotel like '%%'
group by h.market_segment
order by total_revenue  asc
------------------------------------------------------
--total income from meals 


with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.meal ,round(sum(mc.Cost),2) total_income_meals from hotels  h 
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled=0
group by h.meal

-------------------------------------------------------


--showing countries  for the two hotels in terms of (number of guests , average nights , total nights , average revenue ,average discount , total revenuse )
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.country ,count(h.hotel) as number_guests,round(avg(stays_in_week_nights +stays_in_weekend_nights),2) as avg_nights ,sum(stays_in_week_nights + stays_in_weekend_nights) as total_nights
,round(Avg(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as average_revenue,round(avg(((stays_in_week_nights +stays_in_weekend_nights)*(h.adr*ms.Discount))),2) as avg_discount_value,
round(Sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as total_revenue

from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 0 and h.hotel like '%%'
group by h.country
order by total_revenue  desc
-------------------------

--if there are increments for needing parking spaces in terms of years 


with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.arrival_date_year,sum(h.required_car_parking_spaces) as parking_needed  from hotels  h 
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled=0
group by h.arrival_date_year
order by h.arrival_date_year asc

--------------------------------------------------------
--cancellation by market segments (average , average revenue lost , average lost nights .....
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])
select h.market_segment ,count(h.hotel) as number_guests,round(avg(stays_in_week_nights +stays_in_weekend_nights),2) as avg_lost_nights ,sum(stays_in_week_nights + stays_in_weekend_nights) as total_lost_nights
,round(Avg(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as average_lost_revenue,round(avg(((stays_in_week_nights +stays_in_weekend_nights)*(h.adr*ms.Discount))),2) as avg_discount_value,
round(Sum(((h.stays_in_week_nights + h.stays_in_weekend_nights) * ( h.adr - (h.adr * ms.Discount)))),2) as total_loss_revenue

from hotels  h
left join dbo.market_segment$  ms
on h.market_segment=ms.market_segment
left join dbo.meal_cost$  mc
on h.meal=mc.meal
where h.is_canceled = 1 and h.hotel like '%%'
group by h.market_segment
order by total_loss_revenue asc


















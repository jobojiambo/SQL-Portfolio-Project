select *
from portfolioproject..housing_stats
order by Land_Value

Select SaleDateB, Convert(Date,Sale_Date) as N_date
from portfolioproject..Housing_stats

Update Housing_stats
Set SaleDateB = Convert(Date,Sale_Date)

Alter Table Housing_Stats
Add SaleDateB Date;

select *
from portfolioproject..housing_stats

Alter Table Housing_Stats
Drop column Sale_Date


--Filling in the null gaps

---populating null land values
Select*
from portfolioproject..Housing_stats
where Land_Value is null
order by parcel_ID


select a.sale_price, a.land_value,  b.sale_price, b.land_value, ISNULL (a.land_value, b.land_value) 
from portfolioproject..housing_stats a
join portfolioproject..housing_stats b
	 on b.sale_price = b.land_value
	 and a.unique_id<>b.unique_id
where a.land_value is null


update a
set Land_Value = isnull(a.Land_Value,b.Land_Value)
from portfolioproject..housing_stats a
join portfolioproject..housing_stats b
	 on b.sale_price = b.land_value
	 and a.unique_id<>b.unique_id
where a.land_value is null


---populating null building value
select *
from portfolioproject..housing_stats
where Building_Value is null
order by parcel_ID

select x.land_value, x.Building_Value,  y.land_value, y.Building_Value, ISNULL(x.Building_Value, y.Building_Value) 
from portfolioproject..housing_stats x
join portfolioproject..housing_stats y
	 on x.land_value = y.land_value
	 and x.Parcel_ID<>y.Parcel_ID
where y.Building_Value is null

update y
set Building_Value = isnull(x.building_Value,y.building_Value)
from portfolioproject..housing_stats x
join portfolioproject..housing_stats y
	 on y.land_value = y.land_value
	 and x.Parcel_ID<>y.Parcel_ID
where y.Building_Value is null

Select*
from portfolioproject..Housing_stats
where Building_Value is null
order by parcel_ID

update y
set Building_Value = isnull(x.building_Value,y.building_Value)
from portfolioproject..housing_stats x
join portfolioproject..housing_stats y
	 on x.land_value = y.Building_Value
	 and x.Parcel_ID<>y.Unique_ID
where y.Building_Value is null

---populating null total values
Select*
from portfolioproject..Housing_stats
where Total_Vale is null
order by Unique_ID

select f.land_value, f.Total_Vale, t.land_value, t.Total_Vale, ISNULL(f.Total_Vale, t.Total_Vale)
from portfolioproject..Housing_Stats f
join portfolioproject..Housing_Stats t
	 on f.land_value <> t.land_value
	 and f.Parcel_ID <> t.Parcel_ID
where f.Total_Vale is null

update f
set Total_Vale = ISNULL(f.Total_Vale, t.Total_Vale)
from portfolioproject..Housing_Stats f
join portfolioproject..Housing_Stats t
	 on f.land_value <> t.Land_Value
	 and f.Parcel_ID <> t.Parcel_ID
where f.Total_Vale is null


---populating null unique ID
Select*
from portfolioproject..Housing_stats
where Unique_ID is null
order by parcel_ID

select j.Unique_ID, j.Parcel_ID, k.Parcel_ID, k.Unique_ID, ISNULL(j.Unique_ID, k.Unique_ID)
from portfolioproject..Housing_Stats j
join portfolioproject..Housing_Stats k
	 on j.Parcel_ID <> k.Parcel_ID
	 and j.Land_Value <> k.Land_Value
where j.Unique_ID is null

update j
set Unique_ID = ISNULL(j.Unique_ID, k.Unique_ID)
from portfolioproject..Housing_Stats j
join portfolioproject..Housing_Stats k
	 on j.Parcel_ID <> k.Parcel_ID
	 and j.Land_Value <> k.Land_Value
where j.Unique_ID is null


---Updating null parcel price entries 
select *
from portfolioproject..Housing_Stats
where Sale_Price is null
order by Parcel_ID

select r.Sale_Price, s.Sale_Price, r.Total_Vale, s.Total_Vale, ISNULL(r.Sale_Price, s.Sale_Price)
from portfolioproject..Housing_Stats r
join portfolioproject..Housing_Stats s
	 on r.Total_Vale <> s.Total_Vale
	 and r.Land_Value <> s.Land_Value
where r.Sale_Price is null

update r
set Sale_Price = ISNULL(r.Sale_Price, s.Sale_Price)
from portfolioproject..Housing_Stats r
join portfolioproject..Housing_Stats s
	 on r.Total_Vale <> s.Total_Vale
	 and r.Land_Value <> s.Land_Value
where r.Sale_Price is null

select Unique_ID, Parcel_ID, Sale_Price, Legal_Reference, Land_Value, Building_Value, Total_Vale, property_city, Property_Address
from portfolioproject..Housing_Stats
where Land_Value like '%240000%'
and property_Address is not null

Alter Table Housing_Stats
Drop column Year_Buit, Bedrooms, full_bath, Half_bath, Vacancy_status, Owner

select *
from portfolioproject..Housing_Stats

select sum(Land_Value) as net_value, sum(Acerage) as net_Acerage, sum(Building_Value) as Net_Built,  sum(Total_Vale) as Net_Total, sum(Land_Value)/sum(Building_Value)*100 as percent_net_value, sum(Building_Value)/sum(Total_Vale)*100 as percent_Net_Total 
from portfolioproject..Housing_Stats


select sum(Land_Value) as net_value, sum(Total_Vale) as Net_Total, sum(Land_Value)/sum(Total_Vale)*100 as percent_Net_Total 
from portfolioproject..Housing_Stats
where Acerage is not null
group by Parcel_ID
order by 2,3 asc


select (MAx(Acerage))/sum(Land_Value)*100 as percent_Value_Per_Acre
from portfolioproject..Housing_stats
where Acerage is not null
group by Parcel_ID


--CREATING VIEW to Store data for later visualizations

create View Percent_value_per_Acre as
select dea.Parcel_ID, Land_Use, dea.Sale_Price, dea.Legal_reference, vac.TotalValue, dea.Land_Value, dea.building_Value
, sum(convert(int,Acerage)) over (partition by dea.Land_Value order by dea.Building_Value) as RollingPeopleVaccinanted
--, (RollingPeopleVaccinated/population)*100
from portfolioproject..[Housing_Stats] dea
join portfolioproject..Housing_data  vac
	on dea.Unique_Id <> vac.[UniqueID ]
	and dea.parcel_Id <> vac.ParcelID
where vac.TotalValue is not null
--order by 2,3

select *
from Percent_value_per_Acre

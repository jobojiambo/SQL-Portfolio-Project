select *
from portfolioproject..[Covid Death$]
where continent is not null
order by 3,4

--select *
--from portfolioproject..Vaccinations$
--order by 3,4

--select the data that we are going to use

select location, date, total_cases, new_cases, total_deaths, population 
from portfolioproject..[Covid Death$]
where continent is not null
order by 1,2

-- looking at the Total Case vs Total Deaths
--percentage probability (in the nigeria) of succumbing to Covid once infected

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolioproject..[Covid Death$]
where location like '%Nigeria%'
and continent is not null
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Covid Death$]
--where location like '%Nigeria%'
order by 1,2

--looking at countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Covid Death$]
--where location like '%Nigeria%'
Group by location, population, date
order by PercentPopulationInfected desc



--Showing Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..[Covid Death$]
--where location like '%Nigeria%'
where continent is not null
Group by location
order by TotalDeathCount desc

--Breaking the Data Down by Continent 



--showing the Continents with the highest death count per population

select continent, Max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..[Covid Death$]
--where location like '%Nigeria%'
where continent is not null
Group by continent
order by TotalDeathCount desc

--Global Numbers


select SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Covid Death$]
--where location like '%Nigeria%'
where continent is not null
--Group by date
order by 1,2


--looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinanted
--, (RollingPeopleVaccinated/population)*100
from portfolioproject..[Covid Death$] dea
join portfolioproject..Vaccinations$  vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--USE CTE
with PopvsVac (Continent, Location, Date, population, new_vaccinations, RollingPeopleVAccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinanted
--, (RollingPeopleVaccinated/population)*100
from portfolioproject..[Covid Death$] dea
join portfolioproject..Vaccinations$  vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVAccinated/population)*100
from PopvsVac

--CREATING VIEW to Store data for later visualizations

create View Percent_Population_Vaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinanted
--, (RollingPeopleVaccinated/population)*100
from portfolioproject..[Covid_Death$] dea
join portfolioproject..Vaccinations$  vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select *
from Percent_Population_Vaccinated


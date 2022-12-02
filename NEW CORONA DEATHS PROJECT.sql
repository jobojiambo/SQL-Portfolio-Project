--selecting the dataset that is to be used
select location, date, continent, total_cases, new_cases, total_deaths, population 
from portfolioproject..[Corona_Death$]
where continent is not null
order by 1,2

 
 --Global Numbers

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in Europe

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Europe%'
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in Africa

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Africa%'
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in North America

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%North America%'
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in South America

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%South_America%'
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in Asia

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Asia%'
order by 1,2

--looking at Total Cases vs Population
--percentage population diagnosed with Covid in Oceania

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Oceania%'
order by 1,2


--Sampling Several Countries
-- looking at the Total Case vs Total Deaths to establish the-
--percentage probability of succumbing to Covid once infected (in Nigeria)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage_per_infection
from portfolioproject..[Corona_Death$]
where location like '%Nigeria%'
and continent is not null
order by date


-- looking at the Total Case vs Total Deaths to establish the-
--percentage probability of succumbing to Covid once infected (in Kenya)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage_per_infection
from portfolioproject..[Corona_Death$]
where location like '%Kenya%'
and continent is not null
order by date

-- looking at the Total Case vs Total Deaths to establish the-
--percentage probability of succumbing to Covid once infected (in India)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage_per_infection
from portfolioproject..[Corona_Death$]
where location like '%India%'
--and continent is not null
order by date

-- looking at the Total Case vs Total Deaths to establish the-
--percentage probability of succumbing to Covid once infected (in United States)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage_per_infection
from portfolioproject..[Corona_Death$]
where location like '%United States%'
and continent is not null
order by date

-- looking at the Total Case vs Total Deaths to establish the-
--percentage probability of succumbing to Covid once infected (in Italy)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage_per_infection
from portfolioproject..[Corona_Death$]
where location like '%Italy%'
and continent is not null
order by date

--Looking at Countries With The Highest Infection Rates (Grouped By Continents)

--Evaluating African countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Africa%'
Group by location, population, date
order by PercentPopulationInfected desc

--Evaluating European countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Europe%'
Group by location, population, date
order by PercentPopulationInfected desc

--Evaluating Asian countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Asia%'
Group by location, population, date
order by PercentPopulationInfected desc

--Evaluating North American countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%North America%'
Group by location, population, date
order by PercentPopulationInfected desc

--Evaluating South American countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%South America%'
Group by location, population, date
order by PercentPopulationInfected desc

--Evaluating Oceanian countries with the highest rates of infection relative to the population

select location, population , date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..[Corona_Death$]
where continent like '%Oceania%'
Group by location, population, date
order by PercentPopulationInfected desc


--Showing African Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%Africa%'
Group by location
order by Max_DeathCount desc

--Showing European Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%Europe%'
Group by location
order by Max_DeathCount desc

--Showing Asian Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%Asia%'
Group by location
order by Max_DeathCount desc


--Showing North American Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%North America%'
Group by location
order by Max_DeathCount desc


--Showing South American Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%South America%'
Group by location
order by Max_DeathCount desc


--Showing Oceanic Countries With Highest death Count per Population

select location, Max(cast(total_deaths as int)) as Max_DeathCount, Max(cast(total_cases as int)) as Max_Casescount, min(cast(total_deaths as int)) as Min_deaths, Min(cast(total_cases as int)) as Min_Cases
from portfolioproject..[Corona_Death$]
where continent like '%Oceania%'
Group by location
order by Max_DeathCount desc


--Breaking the Data Down by Death Percrntage Per Total Reported Cases in Countries within Continent 

--showing the Continents with the highest death count per population

select continent, Max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..[Corona_Death$]
where continent is not null
Group by continent
order by TotalDeathCount desc


---Death Percrntage Per Total Reported Cases in African Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%Africa%'
Group by location
order by 1,2

---Death Percrntage Per Total Reported Cases in North American Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%North America%'
Group by location
order by 1,2

---Death Percrntage Per Total Reported Cases in South American Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%South America%'
Group by location
order by 1,2

---Death Percrntage Per Total Reported Cases in European Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%Europe%'
Group by location
order by 1,2

---Death Percrntage Per Total Reported Cases in North Asian Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%Asia%'
Group by location
order by 1,2


---Death Percrntage Per Total Reported Cases in Oceanic Countries

select location, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..[Corona_Death$]
where continent like '%Oceania%'
Group by location
order by 1,2

--looking at total population vs vaccinations and Joining Tables

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinanted
from portfolioproject..[Corona_Death$] dea
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
from portfolioproject..[Corona_Death$] dea
join portfolioproject..Vaccinations$  vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingPeopleVAccinated/population)*100
from PopvsVac

--CREATING Data Storage View for Later References

create View Percent_Population_Vaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinanted
from portfolioproject..[Corona_Death$] dea
join portfolioproject..Vaccinations$  vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null



Select *
from Percent_Population_Vaccinated


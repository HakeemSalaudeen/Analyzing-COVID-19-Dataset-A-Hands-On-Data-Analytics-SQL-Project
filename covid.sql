-- Dataset preview

select * 
from [Portfolio].[dbo].[CovidDeaths$] 


-- select data that we are using 
select location, date, total_cases, new_cases, total_deaths, population 
from [Portfolio].[dbo].[CovidDeaths$]
order by 1, 2

-- total case vs population 
select location, total_cases,  total_deaths, population, (total_cases/population)*100 as PercentDeathPopulation 
from CovidDeaths$
order by 1, 2

-- total death vs population 
select location, total_cases,  total_deaths, population, (total_deaths/population)*100 as PercentDeathPopulation 
from [Portfolio].[dbo].[CovidDeaths$] 
order by 1, 2

-- total death vs population in Nigeria  
select location, total_cases,  total_deaths, population, (total_deaths/population)*100 as PercentDeathPopulation 
from [Portfolio].[dbo].[CovidDeaths$] 
where location = 'nigeria'
order by 1, 2


-- global numbers 

Select SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage, 
(SUM(new_cases) - SUM(cast(new_deaths as int))) as Total_recovred,
SUM(cast(people_fully_vaccinated as bigint))/SUM(total_Cases)*100 as Recovered_percentage, 
(100 - ((SUM(cast(people_fully_vaccinated as bigint))/SUM(total_Cases)*100)- (SUM(cast(new_deaths as int))/SUM(New_Cases)*100))) as Stiil_in_treatment, 


-- Countries with Highest Infection Rate compared to Population

Select top(10) Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio].[dbo].[CovidDeaths$] 
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- Showing contintents with the highest death count per population

Select continent, MAX (cast (Total_deaths as int)) as TotalDeathCount
From  [Portfolio].[dbo].[CovidDeaths$]
--Where location like '%states%'
Where continent is not null 
Group by continent 
order by TotalDeathCount desc


-- Total Population vs Vaccinations
Select *
From [Portfolio].[dbo].[CovidDeaths$]  dea
Join [Portfolio].[dbo].[CovidVaccinations$] vac
	On dea.location = vac.location
	and dea.date = vac.date


-- select COUNT (DISTINCT location) as location
From [Portfolio].[dbo].[CovidDeaths$]
where location is not null 

-- select COUNT (DISTINCT location) as location
From [Portfolio].[dbo].[CovidDeaths$]
where location is null 




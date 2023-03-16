SELECT * 
FROM [Portfolio Project]..coviddeaths
order by 3,4 



SELECT * 
FROM [Portfolio Project]..covidvaccines
order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
FROM [Portfolio Project]..coviddeaths
order by 1,2

--Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio Project]..coviddeaths
order by 1,2

-- Total Caes vs Population 
Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
FROM [Portfolio Project]..coviddeaths
Where location like '%states%'
order by 1,2

--countries with highest infection rate compared to population 
Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM [Portfolio Project]..coviddeaths
Group by location, Population
Order by PercentPopulationInfected desc

--Continents with Highest Death Count per Population 
Select continent, MAX(cast(Total_deaths AS int)) as TotalDeathCount
FROM [Portfolio Project]..coviddeaths
Where continent is not null
Group by continent 
Order by TotalDeathCount desc


-- Global Numbers 
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage 
FROM [Portfolio Project]..coviddeaths
WHERE continent is not null 
Group by date 
order by 1

-- Total Population vs Vaccinations

SELECT * 
From [Portfolio Project]..covidvaccines

Select dea.continent, dea.location,vac.date, dea.population, vac.new_vaccinations, 
SUM(Cast(vac. new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
FROM [Portfolio Project]..coviddeaths dea
 INNER JOIN [Portfolio Project].. covidvaccines vac
ON dea.location = vac.location
and dea.date=vac.date
Where dea.continent is not null 
order by 2,3

-- CTE 
With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac. new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
FROM [Portfolio Project]..coviddeaths dea
JOIN [Portfolio Project].. covidvaccines vac
ON dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


--SELECT * FROM portfolioproject.coviddeaths;
-- select data we are going to be usinG
-- SELECT Location,date, total_cases, new_cases, total_deaths, population
FROM portfolioproject.coviddeaths
order by 1,2

-- looking at Total cases vs Total death
-- show the likelyhood of dieing from covid
SELECT Location,date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeatPercentage
FROM portfolioproject.coviddeaths
WHERE location = "Africa"
order by 2 DESC

-- Looking at total cases vs population
--  shows what percentage of population got covid
SELECT Location,date, total_cases, population, (total_cases/population)*100 as casesPerPopulation
FROM portfolioproject.coviddeaths
WHERE location = "Africa"
order by 2 

-- looking at coutries with highest infection rate compared to population

SELECT Location, MAX(total_cases) AS HighestInfectionCount, population, MAX((total_cases/population))*100 as PercentOfPopulationInfected
FROM portfolioproject.coviddeaths
GROUP BY Location, Population
order by PercentOfPopulationInfected DESC

-- SHOWING COUNTRIES WITH HIGHEST DEAT COUNT PER POPULATION

SELECT Location, continent, MAX(total_deaths) AS TotalDeathCount
FROM portfolioproject.coviddeaths
WHERE Continent is not null
GROUP BY Location
order by TotalDeathCount DESC

-- SHOWING THE CONTINENT WITH HIGHEST DEATH COUNT

SELECT continent, location, MAX(total_deaths) AS TotalDeathsCount
FROM portfolioproject.coviddeaths
WHERE continent IS NOT null
GROUP BY continent
ORDER BY TotalDeathsCount DESC

-- GLOBAL NUMBERS
SELECT date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM portfolioproject.coviddeaths
WHERE continent IS NOT null
GROUP BY date
ORDER BY 1,2

-- Looking at total population vs vaccination

SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations, dea.date
FROM portfolioproject.coviddeaths dea
JOIN portfolioproject.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
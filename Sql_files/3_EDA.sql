/*
   KEY QUESTIONS ANSWERED IN THIS ANALYSIS

   1. Which countries experienced the highest year-over-year growth in vaccinations?
   2. Which countries experienced the lowest or slowest year-over-year growth in vaccinations?
   3. How have vaccination efforts changed over time within each country?
   4. Which countries consistently rank among the top performers in vaccination growth?
   5. Which countries are showing declining or stagnating vaccination growth trends?
   6. How does total vaccination uptake vary across African regions over time?
   7. Which African regions administered the highest number of vaccinations each year?
   8. How have regional vaccination trends evolved throughout the study period?
   9. Which diseases received the highest vaccination coverage each year?
   10. How do vaccination priorities differ across diseases over time?

*/



WITH yearly_vaccinations AS (
SELECT
   country Country,
   YEAR(vaccination_date) Year,
   SUM(vaccinations_administered) TotalVaccinations
FROM vaccination_data1
GROUP BY Country,year),
yearly_vaccinations2 AS (
SELECT *, 
   LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year) PreviousYearVaccinations,
   ROUND(((TotalVaccinations-LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year))/LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year))*100,2) AS YoYGrowthPercent
FROM yearly_vaccinations),
yearly_vaccinations3 AS (
SELECT *,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY YoYGrowthPercent DESC) Ranking
FROM yearly_vaccinations2
WHERE YoYGrowthPercent IS NOT NULL) 
SELECT *
FROM yearly_vaccinations3
WHERE ranking <= 10;


WITH yearly_vaccinations AS (
SELECT
   country Country,
   YEAR(vaccination_date) Year,
   SUM(vaccinations_administered) TotalVaccinations
FROM vaccination_data1
GROUP BY Country,year),
yearly_vaccinations2 AS (
SELECT *, 
   LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year) PreviousYearVaccinations,
   ROUND(((TotalVaccinations-LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year))/LAG(TotalVaccinations) 
   OVER (PARTITION BY Country ORDER BY year))*100,2) AS YoYGrowthPercent
FROM yearly_vaccinations),
yearly_vaccinations3 AS (
SELECT *,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY YoYGrowthPercent ASC) Ranking
FROM yearly_vaccinations2
WHERE YoYGrowthPercent IS NOT NULL) 
SELECT *
FROM yearly_vaccinations3
WHERE ranking <= 10;

SELECT 
     Region,
     Year(vaccination_date) Year,
     SUM(vaccinations_administered) TotalVaccination
FROM vaccination_data1
GROUP BY
     Region,
     Year(vaccination_date)
	ORDER BY 1;
     
     
WITH DiseasesVaccination1 AS (
SELECT 
     Disease,
     Year(vaccination_date) Year,
     SUM(vaccinations_administered) TotalVaccination
FROM vaccination_data1
GROUP BY
     Disease,
     Year(vaccination_date)
	ORDER BY 1),
DiseasesVaccination2 AS (
SELECT *,
       DENSE_RANK() OVER(PARTITION BY Year ORDER BY TotalVaccination DESC) Ranking
FROM DiseasesVaccination1)
SELECT *
FROM DiseasesVaccination2
WHERE Ranking <= 5;



















































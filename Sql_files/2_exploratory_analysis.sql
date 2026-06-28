SELECT* 
FROM vaccination_data1;

SELECT 
   country,
   SUM(target_population) total_target,
   SUM(vaccinations_administered) total_vaccination
FROM vaccination_data1
WHERE 
   record_id IS NOT NULL
GROUP BY 
   country
ORDER BY 2 DESC;

SELECT *
FROM vaccination_data1;

SELECT *
FROM (
SELECT 
   country,
   YEAR(vaccination_date) year,
   SUM(target_population) total_targeted,
   SUM(vaccinations_administered) total_vaccinated,
   SUM(target_population) - SUM(vaccinations_administered) total_unvaccinated,
   ROUND((SUM(vaccinations_administered)/SUM(target_population))*100,2) coverage_rate,
   DENSE_RANK() OVER(PARTITION BY YEAR(vaccination_date) 
   ORDER BY (SUM(vaccinations_administered)/SUM(target_population))*100 DESC) ranking
FROM vaccination_data1
GROUP BY country, year) AS X
WHERE ranking < 11 ;
   
SELECT *
FROM (
SELECT 
   country,
   YEAR(vaccination_date) year,
   SUM(target_population) total_targeted,
   SUM(vaccinations_administered) total_vaccinated,
   SUM(target_population) - SUM(vaccinations_administered) total_unvaccinated,
   ROUND((SUM(vaccinations_administered)/SUM(target_population))*100,2) coverage_rate,
   DENSE_RANK() OVER(PARTITION BY YEAR(vaccination_date) 
   ORDER BY (SUM(vaccinations_administered)/SUM(target_population))*100 ASC) ranking
FROM vaccination_data1
GROUP BY country, year) AS X
WHERE ranking < 6;

SELECT *
FROM (
SELECT 
   country,
   region,
   YEAR(vaccination_date) year,
   SUM(target_population) total_targeted,
   SUM(vaccinations_administered) total_vaccinated,
   SUM(target_population) - SUM(vaccinations_administered) total_unvaccinated,
   ROUND((SUM(vaccinations_administered)/SUM(target_population))*100,2) coverage_rate,
   DENSE_RANK() OVER(PARTITION BY YEAR(vaccination_date) 
   ORDER BY (SUM(vaccinations_administered)/SUM(target_population))*100 ASC) ranking
FROM vaccination_data1
GROUP BY country, year, region) AS X
WHERE ranking < 6;





































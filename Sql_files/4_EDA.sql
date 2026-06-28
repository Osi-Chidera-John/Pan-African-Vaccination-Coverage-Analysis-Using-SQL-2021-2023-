/*
   KEY QUESTIONS ANSWERED IN THIS ANALYSIS

   1. Which countries achieved the highest vaccination coverage rates?
   2. Which countries recorded the lowest vaccination coverage rates?
   3. Is there a relationship between the number of healthcare workers and vaccination coverage?
   4. Which countries appear to utilize their healthcare workforce most effectively in vaccination campaigns?
   5. Which countries may require additional support to improve vaccination coverage?
   6. How does vaccination performance compare across African countries?
   7. Which regions achieved the highest overall vaccination coverage?
   8. Which regions administered the largest number of vaccinations relative to their target populations?
   9. How does healthcare workforce capacity vary across regions?
   10. Are there regional disparities in vaccination coverage and healthcare resources?

 */


SELECT 
     Country,
     Workers,
     ROUND((TotalVaccination/TargetVaccination)*100,2) CoverageRate
FROM (
SELECT 
	 Country,
     SUM(healthcare_workers) Workers,
     SUM(vaccinations_administered) TotalVaccination,
     SUM(target_population) TargetVaccination
FROM vaccination_data1
GROUP BY 
     Country
) AS X
ORDER BY 
     ROUND((TotalVaccination/TargetVaccination)*100,2) DESC
LIMIT 10;
     
     
 SELECT 
     Country,
     Workers,
     ROUND((TotalVaccination/TargetVaccination)*100,2) CoverageRate
FROM (
SELECT 
	 Country,
     SUM(healthcare_workers) Workers,
     SUM(vaccinations_administered) TotalVaccination,
     SUM(target_population) TargetVaccination
FROM vaccination_data1
GROUP BY 
     Country
) AS X
WHERE Country <> ' '
ORDER BY 
     ROUND((TotalVaccination/TargetVaccination)*100,2) ASC
LIMIT 10;    
     
     
SELECT 
     Region,
     Workers,
     TargetVaccination,
     TotalVaccination,
     ROUND((TotalVaccination/TargetVaccination)*100,2) CoverageRate
FROM (
SELECT 
	 Region,
     SUM(healthcare_workers) Workers,
     SUM(vaccinations_administered) TotalVaccination,
     SUM(target_population) TargetVaccination
FROM vaccination_data1
GROUP BY 
     Region
) AS X
ORDER BY 
     ROUND((TotalVaccination/TargetVaccination)*100,2) DESC
;
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
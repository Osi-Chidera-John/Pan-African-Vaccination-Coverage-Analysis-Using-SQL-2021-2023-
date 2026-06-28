/*
   KEY QUESTIONS ANSWERED IN THIS ANALYSIS

   1. How does vaccination coverage compare between urban and rural populations across regions?
   2. Which region achieved the highest vaccination coverage rate?
   3. Are there disparities in vaccination coverage between urban and rural areas?
   4. How does healthcare workforce capacity vary across regions and settlement types?
   5. Is vaccination coverage distributed equitably across regions and populations?

 */

SELECT 
     Region,
     Workers,
     urban_rural,
     ROUND((TotalVaccination/TargetVaccination)*100,2) CoverageRate
FROM (
SELECT 
	 Region,
     urban_rural,
     SUM(healthcare_workers) Workers,
     SUM(vaccinations_administered) TotalVaccination,
     SUM(target_population) TargetVaccination
FROM vaccination_data1
GROUP BY 
     Region,
     urban_rural
) AS X
ORDER BY 
     ROUND((TotalVaccination/TargetVaccination)*100,2) DESC
;
     
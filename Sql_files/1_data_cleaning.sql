        -- removing Duplicated rows
CREATE TABLE `vaccination_data1` (
  `record_id` text,
  `vaccination_date` text,
  `country` text,
  `region` text,
  `disease` text,
  `vaccine_type` text,
  `gender` text,
  `age_group` text,
  `vaccinations_administered` int DEFAULT NULL,
  `target_population` int DEFAULT NULL,
  `coverage_rate` double DEFAULT NULL,
  `health_facility_type` text,
  `urban_rural` text,
  `funding_source` text,
  `stock_availability` text,
  `healthcare_workers` int DEFAULT NULL,
  `reporting_year` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO vaccination_data1
SELECT *, 
	   ROW_NUMBER() OVER(
       PARTITION BY record_id,
  vaccination_date,
  country,
  region,
  disease,
  vaccine_type,
  gender,
  age_group,
  vaccinations_administered,
  target_population,
  coverage_rate,
  health_facility_type,
  urban_rural,
  funding_source,
  stock_availability,
  healthcare_workers,
  reporting_year
  )
FROM vaccination_data;

SELECT *
FROM vaccination_data1;

DELETE
FROM vaccination_data1
WHERE row_num > 1;




           -- Data Cleaning and Standardization
SELECT DISTINCT 
   country
FROM vaccination_data1
ORDER BY 1 ASC;

UPDATE vaccination_data1
SET country =
    CASE
        WHEN TRIM(country) = 'ghana' THEN 'Ghana'
        WHEN country = 'DR Congo' THEN 'Democratic Republic of the Congo'
        WHEN country = 'Congo' THEN 'Republic of the Congo'
        WHEN country = 'Cape Verde' THEN 'Cabo Verde'
        WHEN country = 'Ivory Coast' THEN 'Côte d''Ivoire'
        WHEN country = 'Sao Tome and Principe' THEN 'São Tomé and Príncipe'
        ELSE country
    END;

UPDATE vaccination_data1
SET vaccination_date = 
    STR_TO_DATE(vaccination_date,'%d/%m/%Y');

ALTER TABLE vaccination_data1
DROP COLUMN row_num;

ALTER TABLE vaccination_data1
MODIFY vaccination_date Date;





































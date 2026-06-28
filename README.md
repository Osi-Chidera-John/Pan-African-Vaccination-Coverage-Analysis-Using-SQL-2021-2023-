# Vaccination Coverage Analysis Across Africa (2021–2023)

## Introduction

Vaccination remains one of the most effective public health interventions for reducing childhood mortality and preventing the spread of infectious diseases. This project explores vaccination coverage trends across African countries and regions between **2021** and **2023** using a synthetic dataset inspired by World Health Organization (WHO) reporting structures.

The objective was to identify regional performance patterns, country-level leaders and laggards, vaccination growth trends, healthcare workforce efficiency, and demographic differences in vaccine distribution through advanced SQL analysis.

---

## Background

The inspiration for this project came from a clinical posting at Nnamdi Azikiwe University Teaching Hospital during my training as a Medical Laboratory Science student.

During the posting, I observed large numbers of mothers waiting in long queues to vaccinate their children. This experience sparked my curiosity about vaccination coverage beyond my local environment and motivated me to investigate immunization trends across Africa.

Finding reliable continental vaccination data proved challenging. After extensive searching, I discovered a synthetic dataset on Kaggle designed around WHO vaccination reporting standards. While synthetic, the dataset provided a realistic framework for analyzing vaccination trends, workforce deployment, and regional healthcare performance across African countries.

---

## Project Objectives

This project sought to answer the following questions:

* Which African regions achieved the highest vaccination coverage?
* Which countries were the strongest and weakest performers?
* How did vaccination campaigns change year-over-year?
* What relationship exists between healthcare workforce size and vaccination outcomes?
* How do urban and rural vaccination programs compare?
* Which diseases received the highest vaccination attention?

---

## Tools Used

* MySQL
* GitHub
* Advanced SQL
* Window Functions
* CTEs (Common Table Expressions)
* Aggregate Functions
* Ranking Functions
* Subqueries
* Data Analysis & Reporting

---

## Dataset Information

**Source:** Kaggle Synthetic Dataset

**Dataset Characteristics:**

* WHO-inspired vaccination reporting structure
* Covers African countries and regions
* Includes vaccination targets, administered vaccines, workforce metrics, disease categories, and demographic classifications
* Time period: 2021–2023

---

# Key Findings

### 1. North Africa Recorded the Highest Regional Vaccination Coverage

North Africa consistently ranked among the best-performing regions, achieving approximately 78% coverage despite operating with one of the smallest healthcare workforces.

---

### 2. East and West Africa Managed the Largest Vaccination Volumes

Both regions administered between 35 million and 40 million vaccinations annually, demonstrating strong operational capacity despite significantly larger target populations.

---

### 3. Polio Remained Africa's Most Administered Vaccine

Polio vaccines ranked first across all years analyzed, with vaccination volumes nearly double those of the second-ranked disease category.

---

### 4. Workforce Size Alone Did Not Guarantee Better Outcomes

Several countries achieved superior vaccination coverage despite having fewer healthcare workers than lower-performing counterparts, highlighting the importance of healthcare delivery efficiency.

---

# SQL Analysis

Below are some of the SQL queries used in this project.

###  Regional Vaccination Coverage Ranking

```sql
SELECT *
FROM (
SELECT 
   region,
   YEAR(vaccination_date) year,
   SUM(target_population) total_targeted,
   SUM(vaccinations_administered) total_vaccinated,
   SUM(target_population) - SUM(vaccinations_administered) total_unvaccinated,
   ROUND((SUM(vaccinations_administered)/SUM(target_population))*100,2) coverage_rate,
   DENSE_RANK() OVER(PARTITION BY YEAR(vaccination_date) 
   ORDER BY (SUM(vaccinations_administered)/SUM(target_population))*100 DESC) ranking
FROM vaccination_data1
GROUP BY year, region) AS X
WHERE ranking <= 5;
```

### Top Performing Countries

```sql
SELECT *
FROM (
SELECT 
   country,
   SUM(target_population) total_targeted,
   SUM(vaccinations_administered) total_vaccinated,
   SUM(target_population) - SUM(vaccinations_administered) total_unvaccinated,
   ROUND((SUM(vaccinations_administered)/SUM(target_population))*100,2) coverage_rate,
   DENSE_RANK() OVER(ORDER BY (SUM(vaccinations_administered)/SUM(target_population))*100 DESC) Ranking
FROM vaccination_data1
GROUP BY country) AS X
WHERE ranking < 11 ;
```

### Year-over-Year Vaccination Growth

```sql
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
```

### Urban vs Rural Vaccination Analysis

```sql
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
```

---

## What I Learnt

This project strengthened my understanding of both healthcare analytics and advanced SQL.

### Technical Skills

* Writing complex SQL queries
* Window functions and ranking analysis
* Multi-table aggregations
* Trend analysis
* Data storytelling
* Performance optimization

### Domain Knowledge

* Vaccination coverage assessment
* Healthcare workforce analysis
* Regional public health comparisons
* Demographic healthcare disparities
* Public health reporting frameworks

---

## Conclusion

This project demonstrates how SQL can be leveraged to transform raw healthcare data into actionable public health insights.

Through the analysis of vaccination trends across Africa, I identified regional strengths, country-level disparities, growth opportunities, and demographic patterns that influence vaccination outcomes. While the dataset is synthetic, its WHO-inspired structure provides a realistic environment for exploring healthcare analytics challenges.

This project also reflects my ability to combine my Medical Laboratory Science background with data analytics to investigate healthcare problems using evidence-based approaches and advanced SQL techniques.

---

## Author

**John Chidera Jr.**

Healthcare Data Analyst

Focused on Healthcare Analytics, SQL, Data Visualization, and Evidence-Based Public Health Research.

Linkedln Profile: [View Profile](https://www.linkedin.com/in/john-chidera-jr-0b6b55319/)

Email: chiderajohn519@gmail.com


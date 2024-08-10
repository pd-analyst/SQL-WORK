CREATE DATABASE PRODUCTION;
USE PRODUCTION;

SELECT*FROM FOOD;

--------- Total Food Grain  Production of India -----------

SELECT ROUND(SUM(Production_Foodgrains)) AS TOTAL_PRODUCTION_TONNES
FROM FOOD;

--------- The Average Rainfall Across All States-----------

SELECT ROUND(AVG(Rainfall_mm)) AS AVERAGE_RAINFALL FROM FOOD;

--------- Which State Having The Highest Food Grain Production ---------

SELECT State, MAX(Production_Foodgrains) AS Highest_Food_Grain_Production FROM FOOD
GROUP BY State
ORDER BY Highest_Food_Grain_Production DESC LIMIT 1;

--------- Three State Having The Lowest Fertilizer Usage ----------

SELECT State, Fertilizer_Usage FROM FOOD
ORDER BY Fertilizer_Usage LIMIT 3;

------- Total Area Under Production For All States Combined ---------

SELECT SUM(Area_Under_Production) AS TOTAL_AREA FROM FOOD;

--------- Calculating The Average Food Grain Production Per Hectare For Each State -----------

SELECT State, AVG(Production_Foodgrains/Area_Under_Production) AS AVERAGE_PRODUCTION_PER_HECTARE FROM FOOD
GROUP BY State;

------------- Determine The States With Food Grain Production Above The National Average -----------

WITH AverageProduction AS(
SELECT AVG(Production_Foodgrains) AS National_Average FROM FOOD)
SELECT State, Production_Foodgrains FROM FOOD
WHERE Production_Foodgrains > (SELECT National_Average FROM AverageProduction);

--------------- The Maximum and Minimum Rainfall Recorded Among All States --------------

SELECT State, MAX(Rainfall_mm) AS Max_Rainfall, MIN(Rainfall_mm) AS MIN_Rainfall FROM FOOD
GROUP BY State;

------------- States Having A Fertilizer Usage Higher Than The Average Fertilizer Usage And A Food Grain Production Lower Than The Average Food Grain Production? ---------------

WITH Average AS(
SELECT ROUND(AVG(Fertilizer_Usage)) AS Average_Fertilizer_Usage,
ROUND(AVG(Production_Foodgrains)) AS Average_Production
FROM FOOD)
SELECT State, Fertilizer_Usage, Average_Fertilizer_Usage, Production_Foodgrains, Average_Production FROM FOOD,AVERAGE
WHERE Fertilizer_Usage > Average_Fertilizer_Usage &
Production_Foodgrains < Average_Production;

----------- Creating a New Column for Rainfall Categories ---------------

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE FOOD
ADD COLUMN  Rainfall_Category VARCHAR(10);

UPDATE FOOD
SET Rainfall_Category = 
CASE WHEN Rainfall_mm < 1000 THEN 'Low'
WHEN Rainfall_mm BETWEEN 1000 AND 3000 THEN 'Moderate'
ELSE 'High'
END;
    
SELECT*FROM FOOD; 

-------------- Ranking States Based On Foodgrain Production -------------

SELECT State, Production_Foodgrains,
RANK() OVER (ORDER BY Production_Foodgrains DESC) AS Production_Rank
FROM FOOD;

-------------  Generate A New Column That Categorizes States Based On Area Under Production (Small, Medium, Large) ---------------

ALTER TABLE FOOD
ADD COLUMN Area_Category VARCHAR(50);

UPDATE FOOD SET Area_Category =
CASE WHEN Area_Under_Production <2000 THEN 'Small'
WHEN Area_Under_Production BETWEEN 2000 AND 5000 THEN 'Medium'
ELSE 'Large' 
END;
 
SELECT*FROM FOOD;

------------- Group States By Area Category(Low, Medium, High) --------------

SELECT Area_Category,
COUNT(*) AS Number_Of_States
FROM FOOD 
GROUP BY Area_Category;

------------ Find The States With Total Fertilizer Usage For The 'Low' Area Category ---------------

SELECT State, Area_Category,
SUM(Fertilizer_Usage) AS Total_Fertilizer_Usage FROM FOOD
WHERE Area_Category = 'Small' 
GROUP BY State;

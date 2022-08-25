--DATA EXPLORATION AND CLEANING

Select *
From vgsales

--We need to change some columns to int and float data type
--We can use columns 'modify' in Columns selection
--Rank and Year columns as int
--All Sales columns as float

--But in column 'Year', there are 'N/A' values, so we have to replace it with 0

Select *
From vgsales
Where Year = 'N/A'

Update vgsales
Set Year = REPLACE(Year, 'N/A', '0')

--Then we set 0 values to NULL

UPDATE vgsales
SET Year = NULL
WHERE Year = 0

--Now we change all the selected columns to data type that we expected in 'Modify' selection.
--Rank and Year columns as int
--All Sales columns as float

--If we look at Year column, there are some data that has incorrect value which are 2017 and 2020 (since this dataset was updated only until 2016).

Select *
From vgsales
Order By Year

--So we need to replace it with the correct value. I searched on the internet for the correct release year
--All 2017 will be replaced with 2016 and 2020 will be replaced with 2009

UPDATE vgsales
SET Year = REPLACE(Year,'2017','2016')

UPDATE vgsales
SET Year = REPLACE(Year,'2020','2009')

--Now the data is clean and we are ready to analyze the dataset

--DATA ANALYSIS

--Top 10 Video Game Global Sales
Select Top 10 Name, Platform, Global_Sales, Year
From vgsales

--Distribution of Genre
Select Genre, Count(Genre) as Total_Genre
From vgsales
Group By Genre
Order By Total_Genre desc

--Distribution of Platform
Select Platform, Count(Platform) as Total_Platform
From vgsales
Group By Platform
Order By Total_Platform desc

--Most sold Video Game on each Genre 
SELECT t1.Genre, t1.Name, t1.Platform, t1.Year, t1.Global_Sales
FROM vgsales as t1
INNER JOIN
(
    SELECT Genre, MAX(Global_Sales) AS Max_Global_Sales
    FROM vgsales
    GROUP BY Genre
) t2
    ON t1.Genre = t2.Genre AND t1.Global_Sales = t2.Max_Global_Sales


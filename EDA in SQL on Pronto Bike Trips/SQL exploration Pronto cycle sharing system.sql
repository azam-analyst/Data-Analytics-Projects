
  /******************* Exploring Pronto city bike trips data in SQL*************************/ 
  
  
  SELECT * 
  FROM	BikeTrips

/* Determining outliers in TripDuration */

SELECT TripDuration
FROM BikeTrips
ORDER BY TripDuration DESC


/* Removing Duplicates with ROW_NUMBER window function */

WITH list_rownumbers as 
(	SELECT *,
	ROW_NUMBER() OVER
	( PARTITION BY trip_id,starttime,stoptime,bikeid,tripduration 
		ORDER BY trip_id) RowNumber
		FROM BikeTrips
)

DELETE 
FROM list_rownumbers
WHERE RowNumber > 1


-- Getting MIN,MAX and AVERAGE trip duration 

select * from biketrips where trip_id=431

  SELECT 
	ROUND(MIn(Tripduration),2) as MinTripDuration ,
	ROUND(MAX(tripduration),2) as MaxTripDuration,
	ROUND(AVG(tripduration),2) as AverageTripDuration
	from BikeTrips


--Top 3 Station based on number of trips

SELECT TOP 3 from_station_name,count(*) as total
FROM biketrips
group by from_station_name
order by 2 desc


-- Calculating percentile within trip duration

SELECT TOP 1
	PERCENTILE_CONT(0.25) within group( ORDER BY tripduration) OVER() as Q1_TripDuration,
	PERCENTILE_CONT(0.50) within group( ORDER BY tripduration) OVER() as [Q2_TripDuration/Median],
	PERCENTILE_CONT(0.75) within group( ORDER BY tripduration) OVER() as Q3_TripDuration
FROM BikeTrips


--Splitting up time and date form datetime fields(StartTime and EndTime)

ALTER TABLE Biketrips
ADD [Date] date

ALTER TABLE BikeTrips
ADD StartTime1 time

ALTER TABLE BikeTrips
ADD EndTime1 time


UPDATE BikeTrips
SET StartTime1= CAST(starttime as time)

UPDATE BikeTrips
SET EndTime1= CAST(stoptime as time)
				
SELECT starttime1 from biketrips
order by starttime1 asc


--Creating frequency distribution/ Histogram

WITH Hist as
 (	SELECT	starttime1,endtime1,
			CASE
				WHEN  starttime1>='6:00:00' and endtime1<='09:59:00' then 'Between 6am and 10 am'
				WHEN StartTime1>= '10:0:00' and endtime1<='13:59:00' then 'Between 10am and 2 pm'
				WHEN StartTime1>= '14:00:00' and endtime1<='17:59:00' then 'Between 2pm and 6 pm'
				WHEN StartTime1>= '18:00:00' and endtime1<= '21:59:00' then 'Between 6pm and 10pm'
				ELSE 'Between 10pm and 6am'
			END as RideTimeBins
	FROM biketrips
 )
 SELECT 
	RideTimeBins, 
	COUNT(RideTimeBins) as Frequency
 FROM Hist
 GROUP BY RideTimeBins
 ORDER BY Frequency DESC


 
 -- Retriving number of rides occured in each weekdays

 SELECT DATENAME(Weekday,starttime) as 'Weekday',COUNT(*) as 'Total'
 FROM biketrips
 GROUP BY DATENAME(Weekday,starttime)
 ORDER BY Total desc


--Replacing null values in Gender Column with 'N/A'

UPDATE biketrips
SET Gender= ISNULL(Gender,'N/A')

SELECT gender,count(*)
FROM BikeTrips
GROUP BY gender
ORDER BY gender 



--Fiding out the day with max number of rides

select TOP 1
	CONVERT(date,starttime) as 'RideDate' ,
	COUNT(*) as 'NumberOfRides'	
from biketrips 
group by CAST(starttime as Date)
order by NumberOfRides desc


/* FIndings from the dataset: 

1.	Average trip duration was 1202.61 seconds or 20 minutes.
2.	Station with highest start location : Pier 69 / Alaskan Way & Clay St(Number of rides started= 11,274).
3.	From the percentile calculation:
	25% of the trip duration lied below the value of 391.265 seconds, 
	50% of the trip duration lied below the value of 633.235 seconds,
	75 % of the trip duration lied below the value of 1145.015 seconds 
4.	From the histogram: Most trips were taken between 2pm and 6pm with total number of trips of 67,335
5.	Most number of rides occured on Thursday(36,122) and Friday(35,128) with the lowest on Sunday(27,401)
6.	Highest number of rides were taken by male riders at 112,940 times.

*/



















	

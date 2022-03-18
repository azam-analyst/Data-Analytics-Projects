

/******************************************************************************************************************************                
                                [WELCOME TO THE SQL DATA CLEANING PROJECT]

This is the SQL DATA CLEANING Project for a Football league Dataset containing 25,199 rows and having data from 2001 till 2021.

The SQL queries are present in this file and all have been  done by me to clean and retrieve data in a much more organised manner,
and ready for visualization.

The cleaning process has been done in Microsoft SQL Server Management Studio.

Thorughout the cleaning process I have used SQL TEXT Functions,CASE statement,PARSENAME;COALESCE,DROP and ADD statements

*********************************************************************************************************************************/


--1. Changing MatchTime field to show Time in a new colum named MatchTimeConverted


ALTER TABLE Matches
ADD MatchTimeConverted TIME;

UPDATE Matches
SET MatchTimeConverted= CAST(MatchTime as TIME)
FROM Matches;


--2. SPLITTING UP date field to get MatchDay and MatchDate in seperate field


SELECT date,MatchDate,Matchday
FROM Matches;

ALTER TABLE Matches
ADD MatchDate Nvarchar(50);

SELECT SUBSTRING([date],CHARINDEX(',',[date])+1,LEN([date]))
FROM Matches;

UPDATE Matches
SET MatchDate=SUBSTRING([date],CHARINDEX(',',[date])+1,LEN([date]));

ALTER TABLE Matches
ADD MatchDay Nvarchar(250);

UPDATE Matches
SET Matchday=SUBSTRING([date],1,CHARINDEX(',',[date])-1);



--3. SPLITTING UP league field into Season and LeagueName


SELECT league,Season,LeagueName
FROM Matches;

ALTER TABLE Matches
ADD Season nvarchar(250);


ALTER TABLE Matches
ADD LeagueName nvarchar(250);

UPDATE Matches
SET Season= SUBSTRING(league,1,CHARINDEX(' ',league)-1) from matches ;

UPDATE Matches
SET LeagueName=SUBSTRING(league,CHARINDEX(' ',league,1)+1,LEN(league));

SELECT DISTINCT Leaguename,Season
FROM Matches
Order by Season;

UPDATE Matches 
SET Season= REPLACE(Season,'/','-');


--4. Modifying Season data field values and getting Distinct season values by updating with CASE Statement

UPDATE Matches
SET Season= CASE Season
				WHEN '2008-09' THEN '2008-2009'
				WHEN '2009-10' THEN '2009-2010'
				WHEN '2010-11' THEN '2010-2011'
				WHEN '2011-12' THEN '2011-2012'
				WHEN '2012-13' THEN '2012-2013'
				WHEN '2013-14' THEN '2013-2014'
				WHEN '2014-15' THEN '2014-2015'
				WHEN '2015-16' THEN '2015-2016'
				WHEN '2016-17' THEN '2016-2017'
				WHEN '2017-18' THEN '2017-2018'
				WHEN '2018-19' THEN '2018-2019'
				WHEN '2019-20' THEN '2019-2020'
				WHEN '2020-21' THEN '2020-2021'
				WHEN '2021-22' THEN '2021-2022'
				ELSE Season
				END

SELECT DISTINCT Season
FROM Matches;


--5. SPLITTING UP venue field to fetch the Venue Name and Location in different Columns


SELECT venue,COALESCE(venue,'N/A')
FROM Matches
Where venue is NULL;

ALTER TABLE Matches 
ADD Stadium nvarchar(250);

UPDATE Matches
SET Stadium= SUBSTRING(venue,1,CHARINDEX(',',venue));


UPDATE Matches
SET Stadium= LTRIM(RTRIM(Replace(Stadium,',','')));


ALTER table Matches
ADD Location nvarchar(255);

UPDATE Matches
SET Location=TRIM(RIGHT(venue,LEN(venue) - charindex(',',venue)));


--6. Replacing Null Values with 'N/A'

UPDATE Matches
SET Stadium= COALESCE(Stadium,'N/A');

UPDATE Matches
SET Location= COALESCE(Location,'N/A');



--7. SPLITTING UP HomeShotsSummary and AwayShotsSummary


ALTER TABLE Matches
ADD HomeTotalShots nvarchar(50);

ALTER TABLE Matches
ADD HomeShotsOnTarget nvarchar(50);


SELECT HomeShotsSummary,
PARSENAME(REPLACE(HomeShotsSummary,' ','.'),2),
PARSENAME(REPLACE(HomeShotsSummary,' ','.'),1)
FROM Matches;

UPDATE Matches
SET HomeTotalShots=PARSENAME(REPLACE(HomeShotsSummary,' ','.'),2);

UPDATE Matches
SET HomeShotsOnTarget=PARSENAME(REPLACE(HomeShotsSummary,' ','.'),1);



--8. Retriving ShotsOnTarget amount by excluding the brackets on both sides of the values


SELECT SUBSTRING(HomeShotsOnTarget,CHARINDEX('(',HomeShotsOnTarget)+1,LEN(HomeShotsOnTarget)-2) 
FROM Matches;

UPDATE Matches
SET HomeShotsOnTarget=SUBSTRING(HomeShotsOnTarget,CHARINDEX('(',HomeShotsOnTarget)+1,LEN(HomeShotsOnTarget)-2);

ALTER TABLE Matches
ADD AwayTotalShots INT;

ALTER TABLE Matches
ADD AwayShotsOnTarget nvarchar(255);

UPDATE Matches
SET AwayTotalShots=PARSENAME(REPLACE(awayShotsSummary,' ','.'),2);

UPDATE Matches
SET AwayShotsOnTarget=PARSENAME(REPLACE(AwayShotsSummary,' ','.'),1);

UPDATE Matches
SET AwayShotsOnTarget=SUBSTRING(AwayShotsOnTarget,CHARINDEX('(',AwayShotsOnTarget)+1,LEN(AwayShotsOnTarget)-2);



--9. DROPING The columns which will not be used for analysis


ALTER TABLE Matches
--DROP COLUMN home_goal_minutes,
--DROP COLUMN home_goal_scorers,
--DROP COLUMN away_goal_minutes,
--DROP COLUMN away_goal_scorers
--DROP COLUMN League3
--DROP COLUMN MatchTime
--DROP COLUMN venue
--DROP COLUMN league
--DROP COLUMN part_of_competition
--DROP COLUMN HomeShotsSummary
--DROP COLUMN AwayShotsSummary
DROP COLUMN [date]
;


--Removing Duplicate Rows with CTE and Row_Number 

With List_rownumbers As
(
	SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY	[ID]
      ,[HomeTeam]
      ,[AwayTeam]
      ,[Year]
      ,[Attendance]
      ,[MatchTimeConverted]
      ,[MatchDate]
      ,[MatchDay]
      ,[Season]
      ,[LeagueName]
      ,[Stadium]
      ,[Location]
      ,[HomeScore]
      ,[AwayScore]
      ,[HomeTotalShots]
      ,[HomeShotsOnTarget]
      ,[AwayTotalShots]
      ,[AwayShotsOnTarget]
      ,[GameStatus]
      ,[Shootout]
      ,[HomePossesion]
      ,[AwayPossesion]
      ,[HomeFoulsCommited]
      ,[AwayFoulsCommited]
      ,[HomeYellowCards]
      ,[AwayYellowCards]
      ,[HomeRedCards]
      ,[AwayRedCards]
      ,[HomeOffsides]
      ,[AwayOffsides]
      ,[HomeWonCorners]
      ,[AwayWonCorners]
      ,[HomeSaves]
      ,[AwaySaves]
					ORDER BY
					ID
					) row_number
	FROM matches
	)

DELETE
FROM List_rownumbers
WHERE row_number>1
;


/*********************************************************END*********************************************************************/

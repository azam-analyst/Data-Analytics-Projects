*************WELCOME To the Top 6 European Football League Data Analysis Project*************

This  is a data analytics project done on a dataset collected from Kaggle.com containing European football League records of 6 major european leagues.The total number of records were 25,200. The dataset contains records from English Premier league, French League,Spanish La Liga,Italian Serie A,German Bundesliga and Eridivisie from 2001 to 2021.The project has been done in three stages. 

Stage 1: The file was opened in excel for general data overview of the dataset. Then the unnecessary columns which I was not willing to take into analysis part was deleted.

Stage 2: The file was imported in Microsoft SQL Server management studio for cleaning procedures with SQL queries. After the process the cleaned dataset was saved to a new file.

Stage 3: The cleaned dataset were imported in Tableau for visualization and making interactive dashboard.

##SQL Output Tables after in cleanin process after Executing SQL queries##

Below the screenshots of SQL output table is presented to showcase what the outcome of the organised data table acheived through sql queries with the purpose of data cleaning. 

--SPLITTING UP date field to get MatchDay and MatchDate in seperate field

<img width="205" alt="1" src="https://user-images.githubusercontent.com/96620728/159095733-717d08c8-cc41-4a4a-9516-f8b1f1ef339b.png">

--SPLITTING UP league field into Season and LeagueName

<img width="310" alt="league to season and leaguename" src="https://user-images.githubusercontent.com/96620728/159095779-06e01914-7057-4280-a559-2dd46938ea0b.png">

--SPLITTING UP venue field to fetch the Venue Name and Country in different Columns

<img width="400" alt="venue to stadium and location" src="https://user-images.githubusercontent.com/96620728/159095833-e3ca7cb3-ea7b-42d3-9be9-24ab10695a93.png">

--SPLITTING UP HomeShotsSummary and AwayShotsSummary into TotalShots and ShotsonTarget

<img width="475" alt="shots" src="https://user-images.githubusercontent.com/96620728/159095902-43b6abbd-1448-4ad9-93cd-e56773460d94.png">







# WELCOME To the Top 6 European Football League Data Analysis Project


This  is a data analytics project done on a dataset collected from Kaggle.com containing European football League records of 6 major european leagues.The total number of records were 25,200. The dataset contains records from English Premier league, French League,Spanish La Liga,Italian Serie A,German Bundesliga and Eridivisie from 2001 to 2021. For the purpose of the data visulization, data records used was for Year 2018 to 2021.

The project has been done in three stages. 

Stage 1: The file was opened in excel for general data overview of the dataset. Then the unnecessary columns which I was not willing to take into analysis part was deleted.

Stage 2: The file was imported in Microsoft SQL Server management studio for cleaning procedures with SQL queries. After the process the cleaned dataset was saved to a new file. The whole SQL queries in the cleaning procedure is uploaded in the file section.

Stage 3: The cleaned dataset were imported in Tableau for visualization and making interactive dashboard.

**SQL Output Tables after Executing SQL queries:**

Below the screenshots of SQL output table is presented to showcase what the outcome of the organised data table acheived through sql queries with the purpose of data cleaning. 

**SPLITTING UP date field to get MatchDay and MatchDate in seperate field**

<img width="205" alt="1" src="https://user-images.githubusercontent.com/96620728/159095733-717d08c8-cc41-4a4a-9516-f8b1f1ef339b.png">

**SPLITTING UP league field into Season and LeagueName**

<img width="310" alt="league to season and leaguename" src="https://user-images.githubusercontent.com/96620728/159095779-06e01914-7057-4280-a559-2dd46938ea0b.png">

**SPLITTING UP venue field to fetch the Venue Name and Location in different Columns**

<img width="400" alt="venue to stadium and location" src="https://user-images.githubusercontent.com/96620728/159095833-e3ca7cb3-ea7b-42d3-9be9-24ab10695a93.png">

**SPLITTING UP HomeShotsSummary and AwayShotsSummary into TotalShots and ShotsonTarget**

<img width="475" alt="shots" src="https://user-images.githubusercontent.com/96620728/159095902-43b6abbd-1448-4ad9-93cd-e56773460d94.png">

**Tableau Visualization:**

After the SQl cleaning process the cleaned dataset wassaved as Csv file. The saved football dataset along with three other dataset named goal_leaders,assist_leaders and team_discipline were imported in tableau for visulaization to draw out findings from the dataset.

From the cleaned footbll dataset four mesures(Sum of Home Score,Sum of away score,Average home ball possesion and Average away ball possesion ) and two dimensions(Home team and away team) were used for visualization where each team can be selectd from filter to see their total number of goals scored against top 5 teams ranked by number of goals scored while playing at home ground or playing as an away team.Along with that he same filter also shows records of avergae ball possesion against top 5 teams ranked by the average value while playing at home ground or away for the selected team from the filter. For the visuzlization most recent years(2018-2021) records were filtered from the Year value and visualized in the final dashboard. 

From the goal_leaders,assist_leaders and team discipline the dimesions used was Player name and team name and the mesures were Sum of goal scored,sum of assists ,sum of yellow cards and sum of red cards) to find out Top 10 goal scorers,top 10 assist makers and top 5 teams to get most yellow and red cards. The dynamic filters used are League Name and Year which can be selected to see respective values for each year in different leagues. To get the Top 5 and Top 10 values from the measures Tableau RANK function was used with each measures used for analysis.

Here is the Tableau dashboard which was prepared in the analysis which can be also be acessed from my tableau public page:
https://public.tableau.com/app/profile/azam.analyst

<img width="500" alt="European League data analysis" src="https://user-images.githubusercontent.com/96620728/160712992-10eec927-931a-43f8-ab1f-40fa4843f989.png">



**Interesting findings:**

I have done this project not only to enhance my SQL and tableau skills but also as a huge footbal fan I had a real interest in preparing this data and getting a nice visualization out of the data. From the tableau analysis it was found that-

Among the top 5 teams with count of yellow and red cards all of them was in Spanish La Liga over the years(2018-2021) and Getafe had the highest amount of yellow and red cards,followed by real betis and atheletico madrid.

The most amount of goals conceded while playing away durig this periods was by Fortuna Sittard of Netherlands.

The highest amount of home goals was conceded by Sassoulo of Italian Serie A league.

Besides From the visualization, you can pick up your faourite and see their home and away performances from 2018-2021.

**Learning Outcomes:**

1. Major SQL string functions and they can be used effectively in data cleaning process(e.g CHARINDEX,SUBSTRING,LEN,LEFT;RIGT;TRIM).

2. Use of SQL CTE and Row_NUMBER function with Window function to remove duplicates which is a very important SQL technique for cleaning process.

3. Importing dataset to tableau and making analysis with different charts, Importing additional data tables from Edit data source,creating calcualted fields,Rank Function by measure values,using format tools for dashboards and layout, applying dynamic filters in dashboard, Organising dashboard design and choosing desired color format for to make dashboard meaningful and appealing.

END


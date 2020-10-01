CREATE DATABASE Covid19_DB;
USE Covid19_DB;

CREATE TABLE state (
	State_Name VARCHAR(50),
    State_Cap_City VARCHAR(50),
    PRIMARY KEY (State_Name)
);

CREATE TABLE county (
	County_Name VARCHAR(50),
    State_Name VARCHAR(50),
    FOREIGN KEY (State_Name) REFERENCES state (State_Name),
    PRIMARY KEY (County_Name, State_Name)
);


SELECT * FROM Covid_By_County;

SELECT * FROM county;
SELECT * FROM state;

SELECT count(*) FROM county;
SELECT count(*) FROM state;


Insert into state (State_Name) Select distinct State_Name from Covid_By_County;

Update state set State_Cap_City = 'Oklahoma City' where State_Name='Oklahoma';

Insert into County (County_Name, State_Name) Select DISTINCT County_Name, State_Name from Covid_By_County;

-- Answer 4 Part 1

CREATE VIEW COVID_BY_STATE AS 
SELECT Date, State_Name, Sum(Daily_Count_Cases) as ConfirmedCases, Sum(Daily_Deaths) as DailyDeath
FROM Covid_By_County
GROUP BY Date, State_Name;

DESCRIBE COVID_BY_STATE;
select * from COVID_BY_STATE;
SELECT COUNT(*) FROM COVID_BY_STATE;

-- Answer 4 Part 2 Query 1
SELECT State_Name, Date, ConfirmedCases as Max_ConfirmedCases FROM covid_by_state 
WHERE ConfirmedCases = (SELECT max(ConfirmedCases) AS Max_ConfirmedCases 
FROM covid_by_state WHERE State_Name='Texas');

-- Answer 4 Part 2 Query 2
SELECT State_Name, Date, ConfirmedCases as Max_ConfirmedCases FROM covid_by_state 
WHERE ConfirmedCases = (SELECT max(ConfirmedCases) AS Max_ConfirmedCases 
FROM covid_by_state WHERE State_Name='Louisiana');

-- Answer 4 Part 2 Query 3
SELECT State_Name, Date, ConfirmedCases as Max_ConfirmedCases FROM covid_by_state 
WHERE ConfirmedCases = (SELECT max(ConfirmedCases) AS Max_ConfirmedCases 
FROM covid_by_state WHERE State_Name='Oklahoma');

-- Answer 4 Part 2 Query 4
SELECT State_Name, Date, ConfirmedCases as Max_ConfirmedCases FROM covid_by_state 
WHERE ConfirmedCases = (SELECT max(ConfirmedCases) AS Max_ConfirmedCases 
FROM covid_by_state WHERE State_Name='Arkansas');

-- Answer 4 Part 2 Query 5
SELECT State_Name, Date, ConfirmedCases as Max_ConfirmedCases FROM covid_by_state 
WHERE ConfirmedCases = (SELECT max(ConfirmedCases) AS Max_ConfirmedCases 
FROM covid_by_state WHERE State_Name='New Mexico');

-- Answer 4 Part 3
SELECT cbs.State_Name, cbs.Date, cbs.ConfirmedCases as Max_ConfirmedCases
FROM covid_by_state cbs
WHERE cbs.ConfirmedCases = (SELECT max(cbs2.ConfirmedCases) 
                            FROM covid_by_state cbs2
                            WHERE cbs2.State_Name = cbs.State_Name
                           );


-- Answer 4 Part 4
SELECT State_Name, Sum(ConfirmedCases), Sum(DailyDeath)
FROM COVID_BY_STATE
GROUP BY State_Name;


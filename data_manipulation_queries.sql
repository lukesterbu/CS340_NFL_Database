-- get all teams   
SELECT * 
FROM   team; 

-- get all coaches   
SELECT coachid, 
       firstname + ' ' + lastname AS name, 
       title, 
       t.name                     AS team 
FROM   coach c 
       left join team t 
              ON c.teamid = t.teamid; 

-- get all corporate sponsors   
SELECT * 
FROM   corporatesponsor; 

-- get all players   
SELECT playerid, 
       firstname + ' ' + lastname AS name, 
       position, 
       height, 
       weight, 
       t.name                     AS team 
FROM   player p 
       left join team t 
              ON p.teamid = t.teamid; 

-- get all season statistics   
SELECT p.playerid, 
       p.firstname + ' ' + lastname AS name, 
       year, 
       passingattempts, 
       passingcompletions, 
       passingyards, 
       passingtouchdowns, 
       receptions, 
       receivingyards, 
       receivingtouchdowns, 
       rushes, 
       rushingyards, 
       rushingtouchdowns, 
       tackles, 
       sacks, 
       interceptions 
FROM   seasonstatistics ss 
       inner join player p 
               ON ss.playerid = p.playerid; 

-- get all sponsored players   
SELECT p.playerid, 
       p.firstname + ' ' + lastname AS playerName, 
       cs.name                      AS sponsorName 
FROM   sponsoredplayers sp 
       inner join player p 
               ON sp.playerid = p.playerid 
       inner join corporatesponsor cs 
               ON sp.sponsorid = cs.sponsorid; 

-- Query for Add new team  
-- with colon : character being used to denote the variables that will have data from the backend programming language
INSERT INTO team 
            (city, 
             conference, 
             division, 
             majority_owner, 
             name, 
             state, 
             teamid, 
             year_founded) 
VALUES      (:city, 
             :conference, 
             :division, 
             :majority_owner, 
             :name, 
             :state, 
             :year_founded); 

-- Query for Add new player  
-- with colon : character being used to denote the variables that will have data from the backend programming 
INSERT INTO player 
            (firstname, 
             height, 
             lastname, 
             position, 
             teamid, 
             weight) 
VALUES      (:firstName, 
             :height, 
             :lastName, 
             :position, 
             :teamID, 
             :weight); 

-- Query for Add new coach  
-- with colon : character being used to denote the variables that will have data from the backend programming 
INSERT INTO coach 
            (firstname, 
             lastname, 
             title, 
             teamid) 
VALUES      ( :firstname, 
             :lastname, 
             :title, 
             :teamid); 

-- Query for Add new season statistics  
-- with colon : character being used to denote the variables that will have data from the backend programming 
INSERT INTO seasonstatistics 
            (playerid, 
             year, 
             passingattempts, 
             passingcompletions, 
             passingyards, 
             passingtouchdowns, 
             receptions, 
             receivingyards, 
             receivingtouchdowns, 
             rushes, 
             rushingyards, 
             rushingtouchdowns, 
             tackles, 
             sacks, 
             interceptions) 
VALUES      (:playerid, 
             :year, 
             :passingattempts, 
             :passingcompletions, 
             :passingyards, 
             :passingtouchdowns, 
             :receptions, 
             :receivingyards, 
             :receivingtouchdowns, 
             :rushes, 
             :rushingyards, 
             :rushingtouchdowns, 
             :tackles, 
             :sacks, 
             :interceptions); 

-- Query for Add new corporate Sponsor 
-- with colon : character being used to denote the variables that will have data from the backend programming 
INSERT INTO corporatesponsor 
            (name, 
             producttype) 
VALUES      (:name, 
             :productType); 

-- Query for Add new corporate Sponsor/player relationship 
-- with colon : character being used to denote the variables that will have data from the backend programming 
INSERT INTO sponsoredplayers 
            (playerid, 
             sponsorid) 
VALUES      (:playerID, 
             :sponsorID); 

-- Query for deleting corporate Sponsor/player relationship 
-- with colon : character being used to denote the variables that will have data from the backend programming 
DELETE FROM sponsoredplayers 
WHERE  playerid = :playerID 
       AND sponsorid = :sponsorID; 

-- Query for deleting player 
-- with colon : character being used to denote the variables that will have data from the backend programming 
DELETE FROM player 
WHERE  playerid = :playerID; 

-- Query for updating player 
-- with colon : character being used to denote the variables that will have data from the backend programming 
UPDATE player 
SET    firstname = :firstname, 
       lastname = :lastname, 
       position = :position, 
       height = :height, 
       weight = :weight, 
       teamid = :teamid 
WHERE  playerid = :playerID; 

-- query to search for player by first or last name
-- with colon : character being used to denote the variables that will have data from the backend programming 
SELECT playerid, 
       firstname + ' ' + lastname AS name, 
       t.name                     AS team 
FROM   player p 
       left join team t 
              ON p.teamid = t.teamid; 
WHERE ((:isSearchByFirstName = false) OR (:isSearchByFirstName = true AND firstName LIKE CONCAT ('%', :firstNameSearchTerm, '%'))
OR ((:isSearchByLastName = false) OR (:isSearchByLastName = true AND firstName LIKE CONCAT ('%', :firstNameSearchTerm, '%'));
    
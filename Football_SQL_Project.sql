-- QUE NO 1
-- write a SQL query to find out which country hosted the 2016 Football EURO Cup. Return country name.

SELECT country_name
FROM soccer_country a
JOIN soccer_city b ON a.country_id=b.country_id
JOIN soccer_venue c ON b.city_id=c.city_id
GROUP BY country_name ;

-- QUE NO 2
-- find the teams that have scored one goal in the tournament.
--  Return country_name as "Team", team in the group, goal_for.
Select country_name as 'Team' , team_group , goal_for 
from soccer_team as a join soccer_country as b on a.team_id = b.country_id
where goal_for = 1
order by country_name ;

-- QUE NO 3. write a SQL query to count the number of yellow cards each country has received. 
-- Return country name and number of yellow cards

SELECT country_name, COUNT(*)
FROM soccer_country 
JOIN player_booked
ON soccer_country.country_id=player_booked.team_id
GROUP BY country_name
ORDER BY COUNT(*) DESC;
select * from player_booked ;

-- QUE NO 4. write a SQL query to find the match where there was no stoppage time in the first half
--  Return match number, country name
SELECT match_details.match_no, soccer_country.country_name 
FROM match_mast
JOIN match_details 
ON match_mast.match_no=match_details.match_no
JOIN soccer_country
ON match_details.team_id=soccer_country.country_id
WHERE stop1_sec=0;

-- QUE NO 5. write a SQL query to find the team(s) who conceded the most goals in EURO cup 2016. 
-- Return country name, team group and match played
Select country_name , team_group, match_played ,won,lost,goal_for,goal_agnst
from soccer_team as a join soccer_country as b
on a.team_id = b.country_id 
 WHERE goal_agnst=(
SELECT MAX(goal_agnst) 
FROM soccer_team);

-- QUE NO 6. Write a SQL query to count the number of goals scored by each player within a normal play schedule. Group the result set on player name and country name and 
-- sorts the result-set according to the highest to the lowest scorer. 
-- Return player name, number of goals and country name.

SELECT player_name,count(*),country_name
FROM goal_details a
JOIN player_mast b ON a.player_id=b.player_id
JOIN soccer_country c ON a.team_id=c.country_id
WHERE goal_schedule = 'NT'
GROUP BY player_name,country_name
ORDER BY count(*) DESC;


-- QUE NO 7. Write a SQL query to find out who scored the most goals in the 2016 Euro Cup.  
-- Return player name, country name and highest individual scorer

SELECT player_name, country_name, goals_scored
FROM ( SELECT pm.player_id, player_name, sc.country_name,
           COUNT(*) AS goals_scored,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS goal_rank
    FROM goal_details gd
    JOIN player_mast pm ON gd.player_id = pm.player_id
    JOIN soccer_country sc ON pm.team_id = sc.country_id
    GROUP BY pm.player_id, player_name, sc.country_name ) AS ranked_goals
WHERE goal_rank = 1;

-- QUE NO 8. Write a SQL query to find out who scored in the final of the 2016 Euro Cup.
-- Return player name, jersey number and country name.

SELECT player_name,jersey_no,country_name
FROM goal_details a
JOIN player_mast b ON a.player_id=b.player_id
JOIN soccer_country c ON a.team_id=c.country_id
WHERE play_stage='F';


-- QUE NO 9. write a SQL query to count the number of matches played at each venue.
--  Sort the result-set on venue name. Return Venue name, city, and number of matches
Select venue_name , city , count(match_no) as 'number of matches '
from soccer_venue as a join soccer_city as b on a.city_id = b.city_id
join match_mast as c on a.venue_id = c.venue_id 
group by venue_name,city
order by venue_name ;

-- QUE NO 10. write a SQL query to find the matches that ended in a goalless draw at the group stage.
--  Return match number, country name
select match_no , country_name from match_details  as a join soccer_country as b 
on a.team_id = b.country_id
where play_stage = "G" and goal_score = 0 and win_lose = "D" ;

-- QUE NO 11.Write a SQL query to find the number of matches played by a player as a goalkeeper for his team.
--  Return country name, player name, number of matches played as a goalkeeper.
SELECT country_name,c.player_name,COUNT(a.player_gk) count_gk
FROM match_details a
JOIN soccer_country b ON a.team_id=b.country_id
JOIN player_mast c ON a.player_gk=c.player_id
GROUP BY country_name,c.player_name
ORDER BY count_gk DESC;


-- QUE NO 12.write a SQL query to find the player who was the first player to be sent off at the tournament EURO cup 2016. 
-- Return match Number, country name and player name
SELECT match_no, country_name, player_name, 
booking_time as "sent_off_time", play_schedule, jersey_no
FROM player_booked a
JOIN player_mast b
ON a.player_id=b.player_id
JOIN soccer_country c
ON a.team_id=c.country_id
AND  a.sent_off='Y'
AND match_no=(
	SELECT MIN(match_no) 
	from player_booked)
ORDER BY match_no,play_schedule,play_half,booking_time;

-- 13.Write a SQL query to find those matches where the second highest amount of stoppage time was added in the second half of the match. 
-- Return match number, country name and stoppage time
select b.match_no , country_name , stop2_sec as "Stoppage_time" from match_mast as a 
join match_details as b on a.match_no = b.match_no
join soccer_country as c on b.team_id = c.country_id
 WHERE (2-1) = (
SELECT COUNT(DISTINCT(b.stop2_sec))
FROM match_mast b
WHERE b.stop2_sec > a.stop2_sec);

-- QUE NO 14. write a SQL query to find the venue where the most goals have been scored.
--  Return venue name, number of goals
SELECT venue_name, count(venue_name) venue_count
FROM goal_details
JOIN soccer_country
ON goal_details.team_id=soccer_country.country_id
JOIN match_mast ON goal_details.match_no=match_mast.match_no
JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
GROUP BY venue_name
HAVING COUNT(venue_name)=( 
SELECT MAX(mycount) 
FROM ( 
SELECT venue_name, COUNT(venue_name) mycount
FROM goal_details
JOIN soccer_country
ON goal_details.team_id=soccer_country.country_id
JOIN match_mast ON goal_details.match_no=match_mast.match_no
JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
GROUP BY venue_name) gd);





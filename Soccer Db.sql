create database soccer_db;

use soccer_db;

-- Create soccer_country table
CREATE TABLE soccer_country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_abbr VARCHAR(3) NOT NULL,
    country_name VARCHAR(255) NOT NULL
);

-- Create soccer_city table
CREATE TABLE soccer_city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES soccer_country(country_id)
);

-- Create soccer_venue table
CREATE TABLE soccer_venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(255) NOT NULL,
    city_id INT,
    aud_capacity INT,
    FOREIGN KEY (city_id) REFERENCES soccer_city(city_id)
);

-- Create soccer_team table
CREATE TABLE soccer_team (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    team_group VARCHAR(1),
    match_played INT,
    won INT,
    draw INT,
    lost INT,
    goal_for INT,
    goal_agnst INT,
    goal_diff INT,
    points INT,
    group_position INT,
    FOREIGN KEY (country_id) REFERENCES soccer_country(country_id)
);

-- Create playing_position table
CREATE TABLE playing_position (
    position_id VARCHAR(255) PRIMARY KEY,
    position_desc VARCHAR(255) NOT NULL
);

-- Create player_mast table
CREATE TABLE player_mast (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    jersey_no INT,
    player_name VARCHAR(255) NOT NULL,
    posi_to_play VARCHAR(255),
    dt_of_bir DATE,
    age INT,
    playing_club VARCHAR(255),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (posi_to_play) REFERENCES playing_position(position_id)
);

-- Create referee_mast table
CREATE TABLE referee_mast (
    referee_id INT AUTO_INCREMENT PRIMARY KEY,
    referee_name VARCHAR(255) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES soccer_country(country_id)
);

-- Create match_mast table
CREATE TABLE match_mast (
    match_no INT AUTO_INCREMENT PRIMARY KEY,
    play_stage CHAR(1),
    play_date DATE,
    results CHAR(5),
    decided_by CHAR(1),
    goal_score VARCHAR(10),
    venue_id INT,
    referee_id INT,
    audience INT,
    plr_of_match INT,
    stop1_sec INT,
    stop2_sec INT,
    FOREIGN KEY (venue_id) REFERENCES soccer_venue(venue_id),
    FOREIGN KEY (referee_id) REFERENCES referee_mast(referee_id),
    FOREIGN KEY (plr_of_match) REFERENCES player_mast(player_id)
);

-- Create coach_mast table
CREATE TABLE coach_mast (
    coach_id INT AUTO_INCREMENT PRIMARY KEY,
    coach_name VARCHAR(255) NOT NULL
);

-- Create asst_referee_mast table
CREATE TABLE asst_referee_mast (
    ass_ref_id INT AUTO_INCREMENT PRIMARY KEY,
    ass_ref_name VARCHAR(255) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES soccer_country(country_id)
);

-- Create match_details table
CREATE TABLE match_details (
    match_no INT,
    play_stage CHAR(1),
    team_id INT,
    win_lose CHAR(1),
    decided_by CHAR(1),
    goal_score VARCHAR(10),
    penalty_score VARCHAR(10),
    ass_ref INT,
    player_gk INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (ass_ref) REFERENCES asst_referee_mast(ass_ref_id),
    FOREIGN KEY (player_gk) REFERENCES player_mast(player_id)
);

-- Create goal_details table
CREATE TABLE goal_details (
    goal_id INT AUTO_INCREMENT PRIMARY KEY,
    match_no INT,
    player_id INT,
    team_id INT,
    goal_time VARCHAR(10),
    goal_type CHAR(1),
    play_stage CHAR(1),
    goal_schedule CHAR(2),
    goal_half CHAR(1),
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (player_id) REFERENCES player_mast(player_id),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id)
);

-- Create penalty_shootout table
CREATE TABLE penalty_shootout (
    kick_id INT AUTO_INCREMENT PRIMARY KEY,
    match_no INT,
    team_id INT,
    player_id INT,
    score_goal CHAR(1),
    kick_no INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (player_id) REFERENCES player_mast(player_id)
);

-- Create player_booked table
CREATE TABLE player_booked (
    match_no INT,
    team_id INT,
    player_id INT,
    booking_time INT,
    sent_off CHAR(1),
    play_schedule CHAR(2),
    play_half INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (player_id) REFERENCES player_mast(player_id)
);

-- Create player_in_out table
CREATE TABLE player_in_out (
    match_no INT,
    team_id INT,
    player_id INT,
    in_out CHAR(1),
    time_in_out INT,
    play_schedule CHAR(2),
    play_half INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (player_id) REFERENCES player_mast(player_id)
);

-- Create match_captain table
CREATE TABLE match_captain (
    match_no INT,
    team_id INT,
    player_captain INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (player_captain) REFERENCES player_mast(player_id)
);

-- Create team_coaches table
CREATE TABLE team_coaches (
    team_id INT,
    coach_id INT,
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (coach_id) REFERENCES coach_mast(coach_id)
);

-- Create penalty_gk table
CREATE TABLE penalty_gk (
    match_no INT,
    team_id INT,
    player_gk INT,
    FOREIGN KEY (match_no) REFERENCES match_mast(match_no),
    FOREIGN KEY (team_id) REFERENCES soccer_team(team_id),
    FOREIGN KEY (player_gk) REFERENCES player_mast(player_id)
);


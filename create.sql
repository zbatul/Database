-- CS 631 Spring 2021 midterm
-- WEBSITE USED: https://www.usatoday.com/
-- For this assignment, I have used 3 tables for storing and managing the data
-- Weather table for weather information
-- News table for news information

-- Creating schema named zaminb_midterm if it does not exist already
CREATE SCHEMA IF NOT EXISTS zaminb_midterm;

-- Set path to my schema and public schema
SET search_path TO zaminb_midterm, public;

-- Creating Weather table
-- Contains relevant information for determining weather 
-- Contains weather information for every hour of the day
CREATE TABLE weather (
	wid BIGSERIAL PRIMARY KEY,
	hour_of_day INT NOT NULL,
	location VARCHAR(255) NOT NULL,
	temperature INT NOT NULL,
	date DATE NOT NULL,
	weather_category VARCHAR(20) NOT NULL,
	UNIQUE(hour_of_day, date, location, temperature, weather_category) -- at a timestamp(time and date) and location, temperature should be unique
);

-- Creating News table
-- Contains all the news related information displayed on the homepage of chosen website
CREATE TABLE news (
	news_id BIGSERIAL PRIMARY KEY,
	heading_text VARCHAR(255) NOT NULL,
	news_category VARCHAR(20) NOT NULL,-- politics, business, world news, us news, technology, science, sports, climate, education, health
	bullet_points_text TEXT,
	news_url VARCHAR(255) NOT NULL,
	image_path_url VARCHAR(255) NOT NULL,
	news_desc_text TEXT,
	author_name VARCHAR(255) NOT NULL,
	publish_timestamp TIMESTAMP NOT NULL,
	news_rank BIGINT UNIQUE NOT NULL,
	news_type VARCHAR(10) NOT NULL, -- TEXT or VIDEO or STORY
	news_tag VARCHAR(30) NOT NULL
);

-- DROP TABLE IF EXISTS weather;
-- DROP TABLE IF EXISTS news;
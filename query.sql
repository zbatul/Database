-- CS 631 Spring 2021 midterm
-- WEBSITE USED: https://www.usatoday.com/

SET search_path TO zaminb_midterm, public;

-- QUERY 1: 
-- Query to fetch current weather at a given location on the website.
-- This query will run on the header section of the website which shows current temperature and weather symbol.
-- Assumptions: Weather is updated every hour.
-- 			    Weather symbol is generated based on the weather_category.
-- (Please see attached screenshot - mentioned in Pink color).

SELECT temperature, 
	weather_category 
FROM weather
WHERE date = date(timestamp '2021-03-11 19:31:21.658882-08') --value of timestamp=current_timestamp in real-time fetching
	AND hour_of_day = date_part('hour', timestamp '2021-03-11 19:31:21.658882-08') 
	AND location = 'Fremont'; --in real-time, location maybe fetched from an api
	
-- ==================================================================================================================

-- Created a materialized view for 15 main 'TEXT' news displayed on the website.
-- The purpose to create this view is to reduce the runtime of fetch queries in real time.
-- Assumption: News Rank decides which news is primary, secondary etc. 
--             Some backend algorithm will decide news_rank based on source and content of news, region, language etc.
-- 			   We are directly using this new_rank column to prioritize the news on the website.

CREATE MATERIALIZED VIEW main_news AS
	SELECT heading_text, 
		news_category, 
		bullet_points_text, 
		news_url, 
		image_path_url, 
		news_desc_text, 
		to_char(publish_timestamp, 'HH12:MI a.m. ET Mon. DD') as news_time
	FROM news
	WHERE news_type = 'TEXT'
	ORDER BY news_rank DESC 
	LIMIT 15;
	
-- If say the website news data is updated every 10 minutes, then this view will also be refreshed every 10 minutes.
-- So that, even if the fetch query is executed anytime, it will use this view to get the data to display on website.

-- REFRESH MATERIALIZED VIEW main_news;

-- DROP MATERIALIZED VIEW IF EXISTS main_news;

-- ==================================================================================================================

-- QUERY 2a: 
-- Query to fetch the Primary News.
-- This query will run for fetching the main headline news which is located at the top center of the website.
-- Assumption: News with the highest rank in the materialized view is primary news.
-- (Please see attached screenshot - mentioned in Red color).

SELECT * 
FROM main_news 
LIMIT 1;

-- QUERY 2b: 
-- Query to fetch the Secondary News.
-- This query will run for fetching the other 4 main news with text description.
-- It is located at the bottom (3 main news) and left (1 main news) of the main headline news.
-- (Please see attached screenshot - mentioned in Green color).

SELECT heading_text, 
	news_category, 
	news_url, 
	image_path_url, 
	news_desc_text, 
	news_time
FROM main_news
LIMIT 4 
OFFSET 1;

-- QUERY 2c: 
-- Query to fetch Other Main News without text description.
-- This query will run for fetching the next 2 other main news without the text description.
-- It is located at the left of the main headline without text descriptions.
-- (Please see attached screenshot - mentioned in Yellow color).

SELECT heading_text, 
	news_category, 
	news_url, 
	image_path_url, 
	news_time
FROM main_news
LIMIT 2 
OFFSET 5;

-- ==================================================================================================================

-- QUERY 3: 
-- Query to fetch 'Top Headlines' section
-- This query will run to get the heading_text of the next 8 news from the main_news materialized view.
-- This will just display the headline and a news url attached to the headline.
-- Located to the right of the main headline on the homepage of the website.
-- (Please see attached screenshot - mentioned in Blue color)

SELECT heading_text, 
	news_url 
FROM main_news
LIMIT 8 
OFFSET 7;

-- ==================================================================================================================

-- Created a materialized view for the featured video news displayed on the website
-- Assumption: The lastest videos uploaded in the database comes up first in this table

CREATE MATERIALIZED VIEW featured_videos AS
	SELECT heading_text, 
		news_category, 
		news_url, 
		image_path_url
	FROM news
	WHERE news_type = 'VIDEO'
	ORDER BY publish_timestamp DESC 
	LIMIT 4;
	
-- DROP MATERIALIZED VIEW IF EXISTS featured_videos;

-- ==================================================================================================================

-- QUERY 4: 
-- Query to fetch 'Featured Videos' section
-- This query will fetch the top 4 featured videos decided based on rank for 'VIDEO' news category.
-- It is located just below the main news in the 'Featured Videos' section on the website.
-- (Please see attached screenshot page 2)

SELECT * 
FROM featured_videos;

-- ==================================================================================================================

-- Created a materialized view for the grouped news displayed on the website
-- For each news tag / group, the view will have top 4 news only. 
-- Assumption: The order of the news in each news tag (group) is decided from news_rank column 

CREATE MATERIALIZED VIEW grouped_news_mv AS
	WITH grouped_news AS 
		(SELECT news_tag, 
				heading_text, 
				image_path_url, 
				news_rank, 
				news_url, 
				RANK() OVER (PARTITION BY news_tag ORDER BY news_rank DESC) as calc_rank
		FROM news
		WHERE news_type = 'TEXT')
	SELECT * 
	FROM grouped_news
	WHERE calc_rank <= 4 
	ORDER BY news_tag;
	
-- DROP MATERIALIZED VIEW IF EXISTS grouped_news_mv;

-- ==================================================================================================================

-- QUERY 5a:
-- Query to fetch 'Coronavirus Updates' section on website
-- This query will fetch all the 4 news with news tag 'Coronavirus Updates' from the materialized view decided based on rank for 'TEXT' news category.
-- The image url path is the image from the first news displayed, hence image path is same for all for rows returned. 
-- 'Coronavirus Updates' section is located just below the 'Discover' section on the website.
-- (Please see attached screenshot page 3)

SELECT heading_text, 
	(SELECT image_path_url 
	 FROM grouped_news_mv 
	 WHERE news_tag = 'Coronavirus Updates'
	 	AND calc_rank = 1),
	news_url
FROM grouped_news_mv
WHERE news_tag = 'Coronavirus Updates';

-- QUERY 5b:
-- Query to fetch 'News' section on website
-- This query will fetch all the 4 news with news tag 'News' from the materialized view decided based on rank for 'TEXT' news category.
-- The image url path is the image from the first news displayed, hence image path is same for all for rows returned. 
-- 'News' section is located just below the 'Coronavirus Updates' section on the website.
-- (Please see attached screenshot page 3)

SELECT heading_text, 
	(SELECT image_path_url 
	 FROM grouped_news_mv 
	 WHERE news_tag = 'News'
	 	AND calc_rank=1),
	news_url
FROM grouped_news_mv
WHERE news_tag = 'News';

-- ==================================================================================================================

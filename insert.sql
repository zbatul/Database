-- CS 631 Spring 2021 midterm
-- WEBSITE USED: https://www.usatoday.com/

SET search_path TO zaminb_midterm, public;

--- INSERT STATEMENT(DML) FOR WEATHER TABLE
INSERT INTO weather(hour_of_day, location, temperature, date, weather_category) VALUES
	(0, 'Fremont', 49, '2021-03-11', 'clear'),
	(1, 'Fremont', 49, '2021-03-11', 'clear'),
	(2, 'Fremont', 48, '2021-03-11', 'clear'),
	(3, 'Fremont', 48, '2021-03-11', 'clear'),
	(4, 'Fremont', 47, '2021-03-11', 'foggy'),
	(5, 'Fremont', 47, '2021-03-11', 'haze'),
	(6, 'Fremont', 47, '2021-03-11', 'haze'),
	(7, 'Fremont', 48, '2021-03-11', 'cloudy'),
	(8, 'Fremont', 49, '2021-03-11', 'rainy'),
	(9, 'Fremont', 50, '2021-03-11', 'rainy'),
	(10, 'Fremont', 51, '2021-03-11', 'cloudy'),
	(11, 'Fremont', 52, '2021-03-11', 'cloudy'),
	(12, 'Fremont', 53, '2021-03-11', 'clear'),
	(13, 'Fremont', 53, '2021-03-11', 'sunny'),
	(14, 'Fremont', 54, '2021-03-11', 'sunny'),
	(15, 'Fremont', 54, '2021-03-11', 'sunny'),
	(16, 'Fremont', 53, '2021-03-11', 'cloudy'),
	(17, 'Fremont', 52, '2021-03-11', 'cloudy'),
	(18, 'Fremont', 51, '2021-03-11', 'cloudy'),
	(19, 'Fremont', 50, '2021-03-11', 'clear'),
	(20, 'Fremont', 50, '2021-03-11', 'clear'),
	(21, 'Fremont', 49, '2021-03-11', 'clear'),
	(22, 'Fremont', 49, '2021-03-11', 'clear'),
	(23, 'Fremont', 49, '2021-03-11', 'clear')
	;
	
-- INSERT STATEMENT(DML) FOR NEWS TABLE
-- NOTE: The heading_text is from news headlines from the website.
-- 		 The bullet_points_text for some news are from website.
-- 		 The news_desc_text is from the text description of news on homepage of website.
--	 	 All urls for news and image locations are dummy.
-- 		 Some publish dates, news category, news tags and author names are from website and some are dummy.
--  	 Ranking given to the news are design assumptions. 
-- Assumption: The higher the rank, the more important the news.
INSERT INTO news (heading_text, news_category, bullet_points_text, news_url, image_path_url, news_desc_text, 
				  author_name, publish_timestamp, news_rank, news_type, news_tag) VALUES
	('10 things you might not know are in Biden''s COVID-19 relief bill', 'POLITICS', '3 relief bills added thousands to US incomes', 
	 'https://www.usatoday.com/news/1', 'https://www.usatoday.com/images/1', 'The COVID-19 relief...',
	 'JOEY GARRISON', '2021-03-10 18:56:00', 110, 'TEXT', 'Coronavirus Updates'),
	 
	 ('Michael Regan confirmed as first Black man to head EPA', 'POLITICS', 'NULL', 
	 'https://www.usatoday.com/news/2', 'https://www.usatoday.com/images/2', 'Regan, Attorney General...',
	 'USA TODAY MEMBER', '2021-03-10 19:57:00', 102, 'TEXT', 'News'),
	 
	 ('Your home made simple', 'MONEY', 'NULL', 
	 'https://www.usatoday.com/news/3', 'https://www.usatoday.com/images/3', 'NULL',
	 'USA TODAY MEMBER', '2021-03-10 10:57:00', 101, 'STORY', 'Life'),
	 
	 ('Jameela Jamil slams Piers Morgan over Markle criticism', 'POLITICS', 'NULL', 
	 'https://www.usatoday.com/news/4', 'https://www.usatoday.com/images/4', 'The criticism faced...',
	 'USA TODAY MEMBER', '2021-03-10 15:56:00', 103, 'TEXT', 'Life'),
	 
	 ('First $1,400 COVID-relief checks to start hitting bank accounts this weekend', 'POLITICS', 'What to know about child tax credit in COVID relief bill', 
	 'https://www.usatoday.com/news/5', 'https://www.usatoday.com/images/5', 'White House press...',
	 'MICHAEL COLLINS', '2021-03-11 15:15:00', 122, 'TEXT', 'Coronavirus Updates'),
	 
	 ('Kroger accidentally ''vaccinates'' some customers with empty syringes: Live COVID news', 'HEALTH', 'NULL', 
	 'https://www.usatoday.com/news/6', 'https://www.usatoday.com/images/6', 'Thursday marks one...',
	 'USA TODAY MEMBER', '2021-03-11 15:35:00', 121, 'TEXT', 'Coronavirus Updates'),
	 
	 ('Kansas splits with AD Jeff Long amid fallout from Les Miles-LSU scandal', 'NATION', 'NULL', 
	 'https://www.usatoday.com/news/7', 'https://www.usatoday.com/images/7', 'The criticism faced...',
	 'USA TODAY MEMBER', '2021-03-10 15:56:00', 104, 'TEXT', 'News'),
	 
	 ('House Democrat urges investigation of 3 Republicans over Capitol riot', 'ELECTIONS', 'NULL', 
	 'https://www.usatoday.com/news/8', 'https://www.usatoday.com/images/8', 'NULL',
	 'USA TODAY MEMBER', '2021-03-11 13:51:00', 115, 'TEXT', 'News'),
	 
	 ('An appreciation: The father of the cassette tape', 'TECH', 'NULL', 
	 'https://www.usatoday.com/news/9', 'https://www.usatoday.com/images/9', 'NULL',
	 'USA TODAY MEMBER', '2021-03-11 15:33:00', 114, 'TEXT', 'Life'),
	 
	 ('Derek Chauvin trial live: Judge reinstates 3rd-degree murder charge; 6th juror selected', 'NATION', 'NULL', 
	 'https://www.usatoday.com/news/10', 'https://www.usatoday.com/images/10', 'Jury selection continued...',
	 'USA TODAY MEMBER', '2021-03-11 14:39:00', 119, 'TEXT', 'News'),
	 
	 ('4 ways to find anyone’s cellphone number online', 'KOMANDO', 'NULL', 
	 'https://www.usatoday.com/news/11', 'https://www.usatoday.com/images/11', 'Maybe you''re trying...',
	 'USA TODAY MEMBER', '2021-03-11 11:08:00', 118, 'TEXT', 'Life'),
	 
	 ('Duke''s season ends after COVID-19 positive during ACC tourney', 'SPORTS', 'NULL', 
	 'https://www.usatoday.com/news/12', 'https://www.usatoday.com/images/12', 'Duke has pulled...',
	 'USA TODAY MEMBER', '2021-03-11 11:49:00', 117, 'TEXT', 'Sports'),
	 
	 ('Biden signs COVID-19 stimulus into law ahead of primetime speech', 'POLITICS', 'NULL', 
	 'https://www.usatoday.com/news/13', 'https://www.usatoday.com/images/13', 'NULL',
	 'MICHAEL COLLINS', '2021-03-11 15:33:00', 113, 'TEXT', 'Coronavirus Updates'),
	 
	 ('''We must not forget'': 10 years ago, a quake led to one of world''s worst nuke disasters', 'U', 'NULL', 
	 'https://www.usatoday.com/news/14', 'https://www.usatoday.com/images/14', 'NULL',
	 'JOHN BACON', '2021-03-11 15:03:00', 111, 'TEXT', 'News'),
	 
	 ('Eddie Murphy to be NAACP Hall of Fame inductee', 'U', 'NULL', 
	 'https://www.usatoday.com/news/15', 'https://www.usatoday.com/images/15', 'NULL',
	 'ASSOCIATION PRESS', '2021-03-11 05:13:00', 109, 'TEXT', 'News'),
	 
	 ('House passes bills to expand background checks for gun sales', 'NATION', 'NULL', 
	 'https://www.usatoday.com/news/16', 'https://www.usatoday.com/images/16', 'NULL',
	 'MATTHEW BROWN', '2021-03-11 17:30:00', 108, 'TEXT', 'News'),
	 
	 ('These symptoms, risk factors may predict if you''ll become a COVID long hauler', 'HEALTH', 'NULL', 
	 'https://www.usatoday.com/news/17', 'https://www.usatoday.com/images/17', 'NULL',
	 'ADRIANNE RODRIGUEZ', '2021-03-11 10:33:00', 107, 'TEXT', 'Coronavirus Updates'),
	 
	 ('What does the end of COVID-19 look like? Experts say it will take more than the vaccine.', 'HEALTH', 'NULL', 
	 'https://www.usatoday.com/news/18', 'https://www.usatoday.com/images/18', 'NULL',
	 'Elizabeth Weise and Karen Weintraub', '2021-03-11 05:53:00', 106, 'TEXT', 'Coronavirus Updates'),
	 
	 ('Prince William: We''re very much not a racist family', 'POLITICS', 'NULL', 
	 'https://www.usatoday.com/news/19', 'https://www.usatoday.com/images/19', 'NULL',
	 'HANNAH YASHAROFF', '2021-03-11 14:33:00', 105, 'TEXT', 'News'),
	 
	 ('Video: Sweet moment with Queen, Meghan Markle', 'CELEBRITIES', 'NULL', 
	 'https://www.usatoday.com/news/20', 'https://www.usatoday.com/images/20', 'NULL',
	 'USA TODAY MEMBER', '2021-03-06 14:37:00', 112, 'VIDEO', 'Life'),
	 
	 ('Naked Cowboy arrested in Daytona Beach', 'HAVE YOU SEEN', 'NULL', 
	 'https://www.usatoday.com/news/21', 'https://www.usatoday.com/images/21', 'NULL',
	 'USA TODAY MEMBER', '2021-03-11 15:43:00', 116, 'VIDEO', 'Life'),
	 
	 ('Firefighters brave icy water to save husky', 'ANIMALKIND', 'NULL', 
	 'https://www.usatoday.com/news/22', 'https://www.usatoday.com/images/22', 'NULL',
	 'USA TODAY MEMBER', '2021-03-08 5:33:00', 120, 'VIDEO', 'News'),
	 
	 ('Get rid of refrigerator odors', 'PROBLEM SOLVED', 'NULL', 
	 'https://www.usatoday.com/news/23', 'https://www.usatoday.com/images/23', 'NULL',
	 'USA TODAY MEMBER', '2021-03-02 5:03:00', 123, 'VIDEO', 'Life'),
	 
	 ('7-year-old dribbles basketball on treadmill', 'SPORTSKIND', 'NULL', 
	 'https://www.usatoday.com/news/24', 'https://www.usatoday.com/images/24', 'NULL',
	 'USA TODAY MEMBER', '2021-03-07 01:33:00', 124, 'VIDEO', 'Sports'),
	 
	 ('Chiefs cut two key starters to clear cap space', 'SPORTS', 'NULL', 
	 'https://www.usatoday.com/news/25', 'https://www.usatoday.com/images/25', 'NULL',
	 'USA TODAY MEMBER', '2021-03-07 11:33:00', 71, 'TEXT', 'Sports'),
	 
	 ('NFL free agency tracker: Updates on major moves', 'SPORTS', 'NULL', 
	 'https://www.usatoday.com/news/26', 'https://www.usatoday.com/images/26', 'NULL',
	 'USA TODAY MEMBER', '2021-03-07 05:33:00', 72, 'TEXT', 'Sports'),
	 
	 ('NCAA Tournament teams heed warning: Duke proves…', 'SPORTS', 'NULL', 
	 'https://www.usatoday.com/news/27', 'https://www.usatoday.com/images/27', 'NULL',
	 'USA TODAY MEMBER', '2021-03-07 01:23:00', 73, 'TEXT', 'Sports')
	;
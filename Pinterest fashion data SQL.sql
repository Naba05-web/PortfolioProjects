-- the goal is to help AI understand the customers need when they are searching for
-- fashion on pinterest

-- 1. so look at the clickrate vs. ratings 
-- WHY: to understand whether high-rated items actually get clicked ( are users alighed with the ratings?)
-- 2. ratings vs. age and gender 
--  WHY: Idenify which groups like which products - good for personaliztion 
-- 3. brands vs. price and how it might connect wiith ratings 
-- WHY: See which brands deliver value (high ratings despite low prices) 
-- 4.  Search terms vs. what gets clicked or rated highly
-- WHY see people's click or rate certain brands or type of shoes
-- 5. track users flow see click & ratings 
-- WHY see how many people are intrested in the pin and whether if it has fallen of or not 

Select *
FROM pinterest_fashion_datasetx ;

SELECT Location, User_name, click_rate
FROM pinterest_fashion_datasetx ;

Select *
FROM pinterest_fashion_datasetx ;

Select 
click_rate, ratings, age, gender, brands 
FROM pinterest_fashion_datasetx;



Select 
ratings, 
click_rate,
ratings / click_rate AS ratings_to_click_ratio
FROM pinterest_fashion_datasetx;

Select 
ratings, 
click_rate,
ratings / click_rate AS rating_per_click
FROM pinterest_fashion_datasetx;

Select gender, age, AVG(ratings) AS avg_ratings 
FROM pinterest_fashion_datasetx 
GROUP BY  gender, age; 

Select Brands, ratings, ('price in $') 
FROM pinterest_fashion_datasetx;



ALTER TABLE pinterest_fashion_datasetx
CHANGE `price in $` price_usd DOUBLE;

SELECT 
  Brands,
  AVG(price_usd) AS avg_price,
  AVG(ratings) AS avg_rating
FROM pinterest_fashion_datasetx
GROUP BY Brands;



SELECT 
  Brands,
  AVG(price_usd) AS avg_price,
  AVG(ratings) AS avg_rating
FROM pinterest_fashion_datasetx
GROUP BY Brands;

SELECT 
image_description, ratings, click_rate, availability
FROM pinterest_fashion_datasetx;

SELECT DISTINCT `image_description`
FROM pinterest_fashion_datasetx
LIMIT 1000;

SELECT 
  image_description,
  Brands,
  price_usd,
  click_rate,
  ratings
FROM pinterest_fashion_datasetx
WHERE image_description LIKE '%shoes%';

SELECT *
FROM pinterest_fashion_datasetx
WHERE LOWER(`image_description`) LIKE '%leather%'
  AND LOWER(`image_description`) LIKE '%shoes%';

SELECT 
	COUNT(*) AS total_items, 
    COUNT( CASE WHEN click_rate > 0 THEN 1 END) AS clicked_items,
    COUNT(CASE WHEN ratings > 0 THEN 1 END) AS rated_items
FROM pinterest_fashion_datasetx ;

SELECT 
	User_name,
    ratings,
    click_rate,
    ROUND(ratings / NULLIF (click_rate, 0), 4) AS rating_per_click
FROM pinterest_fashion_datasetx
WHERE click_rate > 0 
LIMIT 1000;
	
SELECT 
	ROUND(AVG(ratings / NULLIF(click_rate, 0)), 2) AS 
    avg_rating_per_click 
FROM pinterest_fashion_datasetx
WHERE click_rate > 0;

SELECT image_description 
FROM pinterest_fashion_datasetx;

-- CTE

SELECT
  Brands,
  AVG(price_usd) AS avg_price,
  AVG(ratings) AS avg_rating
FROM (
  SELECT *
  FROM pinterest_fashion_datasetx
  WHERE price_usd IS NOT NULL
    AND ratings IS NOT NULL
    AND price_usd > 0
    AND ratings > 0
) AS filtered_data
GROUP BY Brands;
  
  WITH filtered_data AS (
    SELECT * FROM pinterest_fashion_datasetx
    WHERE price_usd IS NOT NULL AND ratings IS NOT NULL
      AND price_usd > 0 AND ratings > 0
)
SELECT Brands, AVG(price_usd) AS avg_price, AVG(ratings) AS avg_rating
FROM filtered_data
GROUP BY Brands;
  
  
  
-- TEMP TABLE 

CREATE TEMPORARY TABLE high_rated_products AS 
SELECT *
FROM pinterest_fashion_datasetx
WHERE ratings >= 4.5; 
  
  SELECT * FROM high_rated_products;
  
  CREATE TEMPORARY TABLE high_rated_products AS 
SELECT *
FROM pinterest_fashion_datasetx
WHERE ratings >= 4.5; 
  
  SELECT * FROM high_rated_products;
  DROP TEMPORARY TABLE IF EXISTS high_rated_products;
  

SELECT * 
FROM pinterest_fashion_datasetx;

ALTER TABLE pinterest_fashion_datasetx
DROP COLUMN  MyUnknownColumn ; 

SHOW CREATE TABLE pinterest_fashion_datasetx;
UPDATE pinterest_fashion_datasetx
SET 
  user_id = row_id,
  User_name = CONCAT('user', row_id);
  
ALTER TABLE pinterest_fashion_datasetx
DROP COLUMN row_id;

ALTER TABLE pinterest_fashion_datasetx
DROP COLUMN user_id;

SELECT * 
FROM pinterest_fashion_datasetx;


-- Create view to store data for later visualizations 

CREATE VIEW high_rated_products_view AS
SELECT * 
FROM pinterest_fashion_datasetx
WHERE ratings >= 4;
SELECT * 
FROM high_rated_products_view;

-- seeing how each brand is doing based on average rating, average price, and total clicks.

CREATE VIEW brand_performance_view AS
SELECT 
  Brands,
  COUNT(*) AS total_products,
  ROUND(AVG(price_usd), 2) AS avg_price,
  ROUND(AVG(ratings), 2) AS avg_rating,
  ROUND(SUM(click_rate), 2) AS total_clicks
FROM pinterest_fashion_datasetx
WHERE ratings IS NOT NULL AND price_usd IS NOT NULL
GROUP BY Brands; 

SELECT * FROM brand_performance_view
ORDER BY avg_rating DESC
LIMIT 12;

SELECT * FROM brand_performance_view
ORDER BY avg_rating DESC
LIMIT 1000;

-- Track how engaged each user is based on how much they rated and clicked.

CREATE VIEW user_engagement_view AS

SELECT image_description 
FROM pinterest_fashion_datasetx;

UPDATE pinterest_fashion_datasetx 
SET image_description = NULL 
WHERE image_description = '';

 SELECT 
  COUNT(*) AS total_items,
  ROUND(AVG(click_rate), 2) AS avg_click_rate,
  ROUND(AVG(ratings), 2) AS avg_rating
FROM pinterest_fashion_datasetx;


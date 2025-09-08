# Pinterest Fashion Trends Dashboard

--  Business Problem
Pinterest wanted to understand what types of fashion content drive the most **user engagement** (clicks and ratings). The goal was to identify trends to guide content strategy and attract advertisers.

 * Tools Used
- **SQL** (data cleaning, exploration, and analysis)  
- **Excel** (preprocessing, backups)  
- **Tableau** (interactive dashboards & KPIs)  
- **Kaggle Dataset** (fashion engagement data)

* Dataset
- Source: Kaggle  
- Table: `pinterest_fashion_datasetx`  
- Key fields: `user_name`, `age`, `gender`, `brands`, `price_usd`, `ratings`, `click_rate`, `image_description`

* Analytical Questions
1. Do higher-rated items actually get more clicks? *(ratings vs. click_rate)*  
2. Which age and gender groups prefer which products? *(ratings vs. demographics)*  
3. Which brands provide the best value (good ratings despite lower prices)?  
4. How do search terms (e.g., “leather shoes”) connect to clicks and ratings?  
5. How engaged are users overall (clicks + ratings flow)?  

 * Data Preparation
- Cleaned duplicate/missing values  
- Standardized `price in $` column → `price_usd`  
- Dropped unused columns (e.g., `row_id`, `MyUnknownColumn`)  
- Created views and temp tables for reusability:
  - `high_rated_products_view` (ratings ≥ 4)  
  - `brand_performance_view` (brand-level KPIs)

 * Key SQL Queries
  -- Average Ratings by Age & Gender
SELECT gender, age, AVG(ratings) AS avg_ratings 
FROM pinterest_fashion_datasetx 
GROUP BY gender, age;

 -- Brand Performance
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
 * Engagement by Rating
```sql
SELECT 
  ratings, 
  click_rate,
  ratings / click_rate AS rating_per_click
FROM pinterest_fashion_datasetx
WHERE click_rate > 0;

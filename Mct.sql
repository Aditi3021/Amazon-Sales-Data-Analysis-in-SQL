Create database MCT;
Use MCT;
Show Tables;
Describe MCT;
 
 CREATE TABLE amazon_products (
 product_id VARCHAR(20), 
 product_name TEXT NOT NULL, 
 category TEXT NOT NULL, 
 discounted_price VARCHAR (50),
 actual_price VARCHAR(50),
 discount_percentage VARCHAR (10),
 rating text,
 rating_count VARCHAR(20),
 about_product TEXT, 
 user_id TEXT,
 user_name TEXT, 
 review_id TEXT,
 review_title TEXT, 
 review_content TEXT, 
 img_link TEXT, 
 product_link TEXT 
 );
 show variables like 'secure_file_priv';
 
 LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Aditi.csv.csv"
 INTO TABLE amazon_products 
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS ;
 
 select * from Amazon_products;
 
 /*Ques1 AditiSharma*/
 
Select product_id, product_name, category from amazon_products;
 
 /*Ques2 Aditi Sharma*/
 
 Select * from amazon_products where rating >=4;
 
 /*Ques3 AditiSharma*/
 
 Select * from amazon_products where category like '%Computers&Accessories%';
 
 /*Ques4 AditiSharma*/
 
 Select * from amazon_products where about_product like '%durable%';

/*Ques5 AditiSharma*/

 Select count( product_id) as Total_Products from amazon_products;

/*Ques6 AditiSharma*/
 
 Select Avg(rating) as average_rating from amazon_products;

/*Ques7 AditiSharma*/
 
 SELECT product_id, product_name, rating
FROM amazon_products
ORDER BY CAST(rating AS DECIMAL(3,2)) DESC
LIMIT 5;

/*Ques8 AditiSharma*/

SELECT 
    product_id, 
    product_name, 
    COUNT(review_id) AS review_count
FROM amazon_products
GROUP BY product_id, product_name;

/*Ques9 AditiSharma*/

SELECT 
    a.product_id, 
    a.product_name, 
    a.category, 
    a.rating
FROM amazon_products a
JOIN amazon_products b
    ON a.category = b.category 
    AND a.rating = b.rating 
    AND a.product_id != b.product_id;

/*Ques10 Aditi Sharma*/
     
    SELECT 
    product_id, 
    product_name, 
    rating,
    CASE 
        WHEN CAST(rating AS DECIMAL(3,2)) >= 4.5 THEN 'Excellent'
        WHEN CAST(rating AS DECIMAL(3,2)) >= 4.0 AND CAST(rating AS DECIMAL(3,2)) < 4.5 THEN 'Good'
        ELSE 'Average'
    END AS rating_category
FROM amazon_products;
 
 

/*Ques11 AditiSharma*/

 ALTER TABLE amazon_products1
ADD discount_amount DECIMAL(10, 2);
UPDATE amazon_products1
SET discount_amount = CAST(actual_price AS DECIMAL(10, 2)) - CAST(discounted_price AS DECIMAL(10, 2));
select actual_price,discounted_price,((actual_price) - (discounted_price)) from amazon_products1;
SElect * from amazon_products;

/*Ques12 AditiSharma*/

SELECT product_id, product_name, discount_percentage
FROM amazon_products
ORDER BY CAST(discount_percentage AS DECIMAL(5,2)) DESC
LIMIT 1;

/*Ques13 AditiSharma*/

CREATE VIEW HighRatingProducts AS
SELECT product_id, product_name, rating, category
FROM amazon_products
WHERE CAST(rating AS DECIMAL(3,2)) >= 4.5;
SELECT * FROM HighRatingProducts;

/*Ques14 AditiSharma*/

SELECT 
    product_id, 
    product_name, 
    category, 
    rating,
    RANK() OVER (PARTITION BY category ORDER BY CAST(rating AS DECIMAL(3,2)) DESC) AS rating_rank
FROM amazon_products;

/*Ques15 AditiSharma*/

SELECT 
    EXTRACT(YEAR FROM date_added) AS year,
    EXTRACT(MONTH FROM date_added) AS month,
    COUNT(*) AS products_added,
    SUM(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM date_added), EXTRACT(MONTH FROM date_added)) AS cumulative_count
FROM amazon_products
GROUP BY EXTRACT(YEAR FROM date_added), EXTRACT(MONTH FROM date_added)
ORDER BY discounted_price DESC;

/*Ques16 AditiSharma*/

DELIMITER $$
CREATE PROCEDURE update_product_rating1(IN p_product_id VARCHAR(20), IN p_new_rating DECIMAL(3,2))
BEGIN
    UPDATE amazon_products1
    SET rating = CAST(p_new_rating AS DECIMAL(3,2))
    WHERE product_id = p_product_id;
END $$
DELIMITER ;
CALL update_product_rating1('P12345', 4.8);

/*Ques17 AditiSharma*/

SELECT category, AVG_rating
FROM (
    SELECT 
        category, 
        AVG(CAST(rating AS DECIMAL(3,2))) AS AVG_rating
    FROM amazon_products
    GROUP BY category
) AS category_avg
ORDER BY AVG_rating DESC
LIMIT 1;

/*Ques18 AditiSharma*/
SELECT 
    p1.product_id AS product_id_1,
    p1.product_name AS product_name_1,
    CAST(p1.rating AS DECIMAL(3,2)) AS rating_1,
    p2.product_id AS product_id_2,
    p2.product_name AS product_name_2,
    CAST(p2.rating AS DECIMAL(3,2)) AS rating_2
FROM amazon_products p1
JOIN amazon_products p2
    ON p1.category = p2.category
   AND CAST(p1.rating AS DECIMAL(3,2)) > CAST(p2.rating AS DECIMAL(3,2))
ORDER BY p1.category, rating_1 DESC, rating_2 DESC;


CREATE TABLE amazon_products1 (
 product_id VARCHAR(20), 
 product_name TEXT NOT NULL, 
 category TEXT NOT NULL, 
 discounted_price VARCHAR (50),
 actual_price VARCHAR(50),
 discount_percentage VARCHAR (10),
 rating text,
 rating_count VARCHAR(20),
 about_product TEXT, 
 user_id TEXT,
 user_name TEXT, 
 review_id TEXT,
 review_title TEXT, 
 review_content TEXT, 
 img_link TEXT, 
 product_link TEXT 
 );
 show variables like 'secure_file_priv';
 
 LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dupli.csv"
 INTO TABLE amazon_products1 
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS ;





CREATE DATABASE josh_db

USE josh_db

CREATE TABLE film_table(
    film_id INT IDENTITY(1,5) PRIMARY KEY,
    film_name VARCHAR(10),
    film_type VARCHAR(6)
)

--shows you the details about the table you  created
SP_HELP film_table

ALTER TABLE film_table
ALTER COLUMN film_name VARCHAR(30)

INSERT INTO film_table (film_name, film_type) VALUES(
    'Shaun', 'Comedy'
)


ALTER TABLE film_table
ADD date_of_release DATE,
Director VARCHAR(20),
Writer VARCHAR(20), 
STAR INT,
Film_language VARCHAR(20), 
Official_website VARCHAR(50), 
Plot_Summary VARCHAR(100);

SELECT * FROM film_table

-- MODIFY DATA TYPE OF COLOMN 
ALTER TABLE film_table
ALTER COLUMN film_name VARCHAR(10) NOt NULL

ALTER TABLE film_table
ADD DEFAULT 0 FOR STAR 

UPDATE film_table
SET film_name = 'Wonder woman'
WHERE film_id = 2
-- @block
USE accidents;

-- Create a table for the car accident dataset
-- @block
CREATE TABLE accidents_true ( 
    num INT NOT NULL, 
    id VARCHAR(10) NOT NULL, 
    severity INT NOT NULL, 
    date DATE NOT NULL, 
    city VARCHAR(255) NOT NULL, 
    state VARCHAR(255) NOT NULL, 
    visibility DECIMAL(4,3), 
    PRIMARY KEY (num) 
    );

-- Create a table for the demographics dataset
-- Both of the datasets were uploaded through MYSQL terminal
-- @block
CREATE TABLE demographics ( 
    id INT NOT NULL, 
    city VARCHAR(255) NOT NULL, 
    state VARCHAR(255) NOT NULL, 
    population INT NOT NULL, 
    PRIMARY KEY (id) 
    );

-- Count the number of accidents by each state
-- @block 
SELECT state, COUNT(ID) as cases 
FROM accidents_true
GROUP BY state
ORDER BY cases DESC;

-- @block
SELECT city, COUNT(ID) as cases
FROM accidents_true
GROUP BY city
ORDER BY cases DESC
LIMIT 10;

-- Count the number of cases by every year
-- @block
SELECT
    EXTRACT(year FROM date) AS year,
    COUNT(ID) AS cases
FROM accidents_true
GROUP BY year
ORDER BY year;

-- Count the severity distribution
-- @block
SELECT severity, COUNT(ID) 
FROM accidents_true
GROUP BY severity
ORDER BY severity;

-- Count the number of cases per capita in each city and
-- retrieve the top 10 places accident-wise
-- @block
SELECT s.city, s.state, s.cases, d.population, s.cases/d.population as k
FROM
(SELECT city, state, COUNT(ID) as cases
FROM accidents_true
GROUP BY city, state) s
JOIN demographics d
ON s.city = d.city
    AND s.state = d.state
ORDER BY k DESC
LIMIT 10;

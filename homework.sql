-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.customer_id = address.address_id
WHERE district = 'Texas';

-- ANSWER: Dorothy Taylor, Thelma Murray, Daniel Cabral, Leonard Schofield, Alfredo Mcadams

-- ------------------------------------------------------------------------------------------------

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
);

-- There are 597 customers with payments above $6.99

-- ------------------------------------------------------------------------------------------------

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

-- ANSWER: 135 customers had payments over $175

-- ------------------------------------------------------------------------------------------------

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT first_name, last_name
FROM (
    SELECT first_name, last_name
    FROM customer
    INNER JOIN address
    ON customer.customer_id = address.address_id
    INNER JOIN city
    ON address.address_id = city.city_id
    WHERE city = 'Nepal'
) AS customers_in_nepal;

-- ANSWER: None. There are no customers that live in Nepal
-- On a check, Nepal isn't even a city listed in the city table

-- ------------------------------------------------------------------------------------------------

-- 5. Which staff member had the most
-- transactions?
SELECT COUNT(amount), first_name, last_name
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(amount) DESC;

-- ANSWER: Jon Stephens had the most transactions

-- ------------------------------------------------------------------------------------------------

-- 6. How many movies of each rating are
-- there?
SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- ANSWER: 5 rating categories, PG-13 has the most movies total

-- ------------------------------------------------------------------------------------------------

-- 7. Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id, amount
    HAVING COUNT(amount) = 1 AND amount > 6.99
);

-- ANSWER: 529 customers have made a single payment above $6.99

-- ------------------------------------------------------------------------------------------------

-- 8. How many free rentals did our stores give away?
SELECT customer_id
FROM rental
WHERE rental_id IN (
    SELECT amount
    FROM payment
    WHERE amount = 0
);

-- ANSWER: No free rentals were given away
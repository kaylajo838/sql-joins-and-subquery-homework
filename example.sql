-- MULTI JOIN
-- NOTE: Its good practice to do no more than 3 joins in a multijoin.
-- Start from the actor table, join to the film_actor table, join to the film table
SELECT first_name, last_name, title
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.actor_id = film.film_id;


-- Subqueries
-- You can use subqueries 3 different ways
-- SELECT, FROM, and WHERE clauses


-- WHERE is the most common
-- SELECT is the most uncommon

-- Query 1: Find all customer_ids that have spent more than $175
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175;


-- Query 2: Get all customer info
SELECT *
FROM customer;


-- NOW our subquery to combine them together using WHERE and IN
-- inside parentheses runs first, outside runs second

SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);


-- Another Subquery Example (adding joins)
-- query actors that worked on the movie "Mulan Moon"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor.actor_id
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film
    ON film_actor.film_id = film.film_id
    WHERE title = 'Mulan Moon'
);


-- FROM clause subquery
-- Christian likes this one better than WHERE
SELECT first_name, last_name
FROM (     -- Where we put subquery, or a table based on a condition
    SELECT first_name, last_name
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film
    ON film_actor.film_id = film.film_id
    WHERE title = 'Mulan Moon'
) AS actors_on_mulan_moon; -- Add alias here
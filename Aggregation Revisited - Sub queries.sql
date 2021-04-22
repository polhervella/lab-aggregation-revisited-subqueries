-- Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT first_name,last_name,email
FROM sakila.customer as customer_table
JOIN sakila.rental as rental_table on customer_table.customer_id = rental_table.customer_id
WHERE rental_date is not null;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT customer_table.customer_id, concat(first_name," ",last_name), avg(amount) as avg_amount_payment
FROM sakila.customer as customer_table
JOIN sakila.payment as payment_table on customer_table.customer_id = payment_table.customer_id
GROUP BY customer_id, concat(first_name,last_name);

-- Select the name and email address of all the customers who have rented the "Action" movies.

SELECT distinct customer_table.customer_id, concat(first_name," ", last_name) as name, email, category_table.name
FROM sakila.customer as customer_table
JOIN sakila.rental as rental_table using (customer_id)
JOIN sakila.inventory as inventory_table using (inventory_id) 
JOIN sakila.film_category as film_category_table using (film_id)
JOIN sakila.category as category_table using (category_id)
WHERE category_table.name in ("Action");

SELECT distinct email, first_name
FROM sakila.customer
WHERE customer_id in (
SELECT customer_id
FROM sakila.rental
WHERE inventory_id in (
SELECT inventory_id
FROM sakila.inventory
WHERE film_id in (
SELECT film_id
FROM sakila.film_category
WHERE category_id in (
SELECT category_id
FROM sakila.category
WHERE name = "Action"))));

-- COMPARING

SELECT distinct customer_table.customer_id, concat(first_name," ", last_name) as name, email, category_table.name
FROM sakila.customer as customer_table
JOIN sakila.rental as rental_table using (customer_id)
JOIN sakila.inventory as inventory_table using (inventory_id) 
JOIN sakila.film_category as film_category_table using (film_id)
JOIN sakila.category as category_table using (category_id)
WHERE category_table.name in ("Action");

SELECT distinct customer_table.customer_id, concat(first_name," ", last_name) as name, email, category_table.name
FROM sakila.customer as customer_table
JOIN sakila.rental as rental_table using (customer_id)
JOIN sakila.inventory as inventory_table using (inventory_id) 
JOIN sakila.film_category as film_category_table using (film_id)
JOIN sakila.category as category_table on category_table.category_id = film_category_table.category_id
WHERE category_table.name in ("Action");











Select distinct customer_id, concat(c.first_name," ", c.last_name) as name, c.email, ca.name 
from customer as c
join rental as r
using (customer_id)
join inventory as i
using (inventory_id)
join film_category as f
using (film_id)
join category as ca
using (category_id)
where name in ("Action")
order by customer_id;


-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

SELECT *,
CASE WHEN amount > 0 AND amount < 2 THEN "low"
WHEN amount > 2 AND amount < 4 THEN "medium"
WHEN amount > 4 THEN "high"
END AS "transaction value"
FROM sakila.payment;


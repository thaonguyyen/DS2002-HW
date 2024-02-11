--list actors in specific film
SELECT actor.first_name, actor.last_name 
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id 
JOIN film ON film_actor.film_id = film.film_id WHERE film.title = 'ACADEMY DINOSAUR';

--count of films in each category
SELECT category.name AS Category, COUNT(film_category.film_id) AS FilmCount
FROM category 
JOIN film_category ON category.category_id = film_category.category_id 
GROUP BY category.name;

--average rental duration for each rating
SELECT rating AS Rating, AVG(rental_duration) AS AverageRentalDuration
FROM film
GROUP BY Rating
ORDER BY Rating;

--total number of rentals for each customer
SELECT first_name AS FirstName, last_name AS LastName, COUNT(rental.rental_id) AS RentalCount
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY RentalCount DESC;

--store with highest number of rentals
SELECT inventory.store_id AS StoreID, COUNT(rental.rental_id) AS RentalCount
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY inventory.store_id
ORDER BY RentalCount DESC
LIMIT 1;

--most popular film category among customers
SELECT category.name AS Category, COUNT(rental.rental_id) AS RentalCount
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY Category
ORDER BY RentalCount DESC
LIMIT 1;

--average rental cost of films by category
SELECT category.name AS Category, AVG(film.rental_rate) AS AverageRentalCost
FROM category
JOIN film_category ON film_category.category_id = category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY Category;

--list of films not rented in last month
SELECT film.title AS Film, MAX(rental.rental_date) AS LastRentalDate 
FROM film 
JOIN inventory on film.film_id = inventory.film_id 
JOIN rental on inventory.inventory_id = rental.inventory_id
GROUP BY Film 
ORDER BY LastRentalDate DESC;

--customer spending on rentals
SELECT first_name AS FirstName, last_name AS LastName, SUM(payment.amount) AS TotalSpent
FROM customer 
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id;

--average length of films in each language
SELECT language.name AS Language, AVG(length)
FROM film
JOIN language ON language.language_id = film.language_id
GROUP BY Language;



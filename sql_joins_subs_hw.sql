--1. List all customers who live in Texas (use JOINs)
select customer.first_name, customer.last_name, district
from customer 
full join address 
on customer.address_id = address.address_id 
where district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, amount
from customer 
full join payment 
on customer.customer_id = payment.customer_id 
group by customer.first_name, customer.last_name, amount
having SUM(amount) > 6.99 and SUM(amount) < 400 --added to remove the very high amounts
order by amount desc;

--2. extra practice: get first and last name with total amounts
select customer.customer_id, customer.first_name, customer.last_name, SUM(amount)
from customer 
full join payment 
on customer.customer_id = payment.customer_id 
group by customer.customer_id
order by SUM(amount) asc;


--3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name 
from customer 
where customer_id  in (
	select customer_id from payment 
	where amount >175
)

--4. List all customers that live in Nepal (use the city table) 
select first_name, last_name, address_id 
from customer 
where address_id in (
	select address_id from address
	where city_id in (
		select city_id  from city
		where country_id in (
			select country_id 
			from country 
			where country = 'Nepal'
		)
	)
)

--5. Which staff member had the most transactions?
select first_name, last_name, COUNT(payment.rental_id)
from staff 
full join payment
on staff.staff_id = payment.staff_id
group by staff.first_name, staff.last_name
order by COUNT(payment.rental_id) desc;

--6. How many movies of each rating are there?
select rating, COUNT(rating) from film 
group by rating
order by count(rating) asc;

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
--i think something has happened to the amount column in the payment table
select first_name, last_name from customer 
where customer_id in (
	select customer_id 
	from payment 
	where amount > 6.99	
)


--8. How many free rentals did our stores give away?
select COUNT(rental_id),
from rental 
where rental_id NOT in (
	select rental_id 
	from payment 
);





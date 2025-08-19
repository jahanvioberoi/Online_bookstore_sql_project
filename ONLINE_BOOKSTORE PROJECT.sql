-- Online_Bookstore SQL Project


CREATE TABLE Books(
Book_ID	 INT PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(50),
Genre VARCHAR(50),
Published_Year INT,
Price FLOAT,	
Stock INT
)


CREATE TABLE Customers(
Customer_ID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(50),
Phone INT,
City VARCHAR(50),	
Country VARCHAR(100)
)

CREATE TABLE orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount FLOAT
);

select * from books;
select * from Customers;
select * from orders;


-- 1) Retrieve all books in the "Fiction" genre:
       select * from books
	   WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
         select * from books
		 WHERE Published_Year>1950;

-- 3) List all customers from the Canada:
        select * from Customers
		WHERE Country='Canada';

-- 4) Show orders placed in November 2023:
       select * from orders
		 WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:
          select sum(stock) as total_stock from books;
  
-- 6) Find the details of the most expensive book:
        select * from books
		order by price desc
		limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
      select * from orders
	  where quantity>1;
    
-- 8) Retrieve all orders where the total amount exceeds $20:
       select * from orders where Total_Amount>20;

-- 9) List all genres available in the Books table:
     SELECT DISTINCT Genre from books;

-- 10) Find the book with the lowest stock:
        SELECT * FROM books 
		order by stock asc
		LIMIT 1;
		

-- 11) Calculate the total revenue generated from all orders:
         SELECT SUM(Total_Amount) as total_revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
      select books.genre,sum(orders.quantity) as Total_books_sold
	  from orders
	  JOIN books 
	  on orders.book_id=books.book_id
	  group by books.genre;
	  
-- 2) Find the average price of books in the "Fantasy" genre:

 Select avg(price) as avg_price 
 from books 
 where genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
 select customer_id,count(order_id) AS ORDER_COUNT
 FROM ORDERS
 GROUP BY customer_id
 HAVING COUNT(order_id)>=2;

 select orders.customer_id,customers.name,count(orders.order_id) as order_count
 from orders
 join customers on customers.customer_id=orders.customer_id
 group by orders.customer_id,customers.name
 having count(order_id)>=2;

-- 4) Find the most frequently ordered book:
     select book_id,count(order_id) as order_count
	 from orders
	 group by book_id
     order by order_count desc limit 1;
	 
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
      select * from books
	  where genre = 'fantasy'
	   order by price desc limit 3;
	  
-- 6) Retrieve the total quantity of books sold by each author:
      select books.author,sum(orders.quantity) as total_quantity
	  from orders
	  join books on orders.order_id=books.book_id
       group by books.author;
	   
-- 7) List the cities where customers who spent over $30 are located:
      select distinct(customers.city),total_amount
       from orders
	   join customers on orders.customer_id=customers.customer_id
	   where orders.total_amount > 30;
	   
-- 8) Find the customer who spent the most on orders:
      select customers.name,customers.customer_id,sum(orders.total_amount) as total_spent
	  from orders
	  join customers on orders.customer_id=customers.customer_id
	  group by customers.customer_id,customers.name
	  order by total_spent desc limit 1;
	  
--9) Calculate the stock remaining after fulfilling all orders:
      select books.book_id,books.title,books.stock,coalesce(sum(orders.quantity),0) as order_quantity,
	  books.stock-coalesce(sum(orders.quantity),0) as remaining_quantity
	  from books
	  left join orders on books.book_id=orders.book_id
	  group by books.book_id;
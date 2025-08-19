# Online_bookstore_sql_project
## Overview

This project is about creating and analyzing an Online Bookstore database using SQL.
It includes three tables: Books, Customers, and Orders. The aim is to run queries that help in managing books, understanding customer behavior, tracking sales, and calculating revenue. The project uses SQL concepts such as joins, grouping, aggregation, filtering, and subqueries.


![Bookstore Project](Bookstore.jpeg)

## Objectives

1) Track books by genre, stock, and prices.

2) Analyze customer behavior such as repeat buyers, spending patterns, and locations.

3) Study order trends such as monthly sales and high-value purchases.

4) Identify best-selling books, authors, and genres.

5) Calculate revenue generated from sales.

6) Compare stock before and after sales to manage inventory.

## Dataset

The database consists of three tables:

1) Books: Contains book details (title, author, genre, published year, price, stock).

2) Customers: Stores customer information (name, email, city, country).

3) Orders: Stores purchase details (customer, book, date, quantity, total amount).

 ## Schema
 CREATE TABLE Books(
  Book_ID INT PRIMARY KEY,
  Title VARCHAR(100),
  Author VARCHAR(50),
  Genre VARCHAR(50),
  Published_Year INT,
  Price FLOAT,
  Stock INT
);

CREATE TABLE Customers(
  Customer_ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(50),
  Phone INT,
  City VARCHAR(50),
  Country VARCHAR(100)
);

CREATE TABLE Orders(
  Order_ID SERIAL PRIMARY KEY,
  Customer_ID INT REFERENCES Customers(Customer_ID),
  Book_ID INT REFERENCES Books(Book_ID),
  Order_Date DATE,
  Quantity INT,
  Total_Amount FLOAT
);

## Business Problems and Solutions

  1) List all Fiction books
 SELECT * FROM Books WHERE Genre = 'Fiction';
 
 2) Find books published after 1950
 SELECT * FROM Books WHERE Published_Year > 1950;

 3) Show all customers from Canada
 SELECT * FROM Customers WHERE Country = 'Canada';

4) Display orders placed in November 2023
SELECT * FROM Orders WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

5) Calculate total stock of books
SELECT SUM(Stock) AS Total_Stock FROM Books;

 6) Identify the most expensive book
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

 7) Show customers ordering more than 1 quantity
SELECT * FROM Orders WHERE Quantity > 1;

 8) Retrieve orders with total amount greater than $20
SELECT * FROM Orders WHERE Total_Amount > 20;

 9) List all available genres
SELECT DISTINCT Genre FROM Books;

 10) Find the book with the lowest stock
SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;

 11) Calculate total revenue generated
SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

 12) Identify the most sold genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY Total_Sold DESC;

 13) List customers with at least 2 orders
SELECT Customer_ID, COUNT(Order_ID) AS Order_Count
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2;

 14) Find the most frequently ordered book
SELECT Book_ID, COUNT(Order_ID) AS Order_Count
FROM Orders
GROUP BY Book_ID
ORDER BY Order_Count DESC
LIMIT 1;

 15) Show top 3 Fantasy books by price
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

 16) Retrieve total quantity sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

 17) List cities of customers spending more than $30
SELECT DISTINCT c.City, SUM(o.Total_Amount) AS Total_Spending
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
HAVING SUM(o.Total_Amount) > 30;

 18) Find the customer who spent the most overall
SELECT c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

 19) Calculate remaining stock after sales
SELECT b.Book_ID, b.Title, b.Stock, 
       COALESCE(SUM(o.Quantity), 0) AS Sold, 
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;

## Findings and Insights

 1) Fiction and Fantasy are the most popular genres.

 2) Revenue is largely driven by repeat customers.

 3) A few customers account for a large share of total sales.

 4) Some books quickly run out of stock and need restocking.

 5) Customers from Canada and the USA contribute heavily to sales.

 6) Certain authors consistently sell more copies compared to others.

## Conclusion

This project shows how SQL can be used to manage and analyze an online bookstore. By using SQL queries, we can track sales, understand customer behavior, and monitor inventory. The analysis helps bookstore managers in decision-making for sales strategy, customer retention, and stock management.

## Connect With Me

 LinkedIn:www.linkedin.com/in/jahanvioberoi
 GitHub: https://github.com/jahanvioberoi


 





/* select all columns from all tables */

SELECT * FROM ACTIVE_REWARDS;
SELECT * FROM ARTISAN_PRODUCTS;
SELECT * FROM ARTISAN_PRODUCTS_COMMISSION_HISTORY;
SELECT * FROM ARTIST_COMMISSION_HISTORY;
SELECT * FROM ARTISTS;
SELECT * FROM CUSTOMERS;
SELECT * FROM CUSTOMER_PREFERENCES;
SELECT * FROM EMPLOYEES;
SELECT * FROM HISTORIC_REWARDS;
SELECT * FROM LOOKUP_COUNTRIES;
SELECT * FROM LOOKUP_EMPLOYEE_ROLES;
SELECT * FROM LOOKUP_STATES;
SELECT * FROM MANUFACTURED_PRODUCTS;
SELECT * FROM MANUFACTURED_PURCHASE_HISTORY;
SELECT * FROM MANUFACTURERS;
SELECT * FROM ORDER_DETAILS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCT_PRICE_HISTORY;
SELECT * FROM PRODUCT_TYPES;
SELECT * FROM PRODUCTS;
SELECT * FROM TAX_RATES;

/* select ProductID and ProductName for all items more than $100 */
SELECT ProductID, ProductName FROM PRODUCTS
WHERE UnitPrice > 100;

/* select CustomerFirstName and CustomerLastName of customers
who made at least one purchase with PreTaxTotal over $2000
using a subquery */
SELECT CustomerLastName, CustomerFirstName
FROM CUSTOMERS
WHERE CustomerID IN(
	SELECT CustomerID
	FROM ORDERS
	WHERE PreTaxTotal > 2000
);

/* select CustomerFirstName and CustomerLastName of customers
who made at least one purchase with PreTaxTotal over $2000 
using a JOIN */
SELECT c.CustomerFirstName, c.CustomerLastName FROM CUSTOMERS as c
JOIN ORDERS as o ON (c.CustomerID = o.CustomerID)
WHERE o.PreTaxTotal > 2000;

/* select CustomerFirstName and CustomerLastName of customers
who purchased an item that costs over $1000
using a subquery */
SELECT CustomerFirstName, CustomerLastName FROM CUSTOMERS as c
WHERE c.CustomerID IN(
	SELECT CustomerID FROM ORDERS as o
	WHERE o.OrderID IN(	
		SELECT OrderID FROM ORDER_DETAILS as d
		WHERE d.ProductID IN(
			SELECT p.ProductID FROM Products as p
			WHERE p.UnitPrice > 1000
		)
	)
);

/* select CustomerFirstName and CustomerLastName of customers
who purchased an item that costs over $1000 
using a JOIN */
SELECT c.CustomerFirstName, c.CustomerLastName FROM 
CUSTOMERS as c JOIN ORDERS as o ON (c.CustomerID = o.CustomerID)
JOIN ORDER_DETAILS as d ON (d.OrderID = o.OrderID)
JOIN PRODUCTS as p ON (d.ProductID = p.ProductID)
WHERE p.UnitPrice > 1000;

/* select CustomerFirstName and CustomerLastName of customers
who made at least one purchase with an Artist whose first name begins with J 
using a subquery */
SELECT c.CustomerFirstName, c.CustomerLastName FROM 
CUSTOMERS as c, ORDERS as o, ORDER_DETAILS as d, ARTISAN_PRODUCTS as p, ARTISTS as a
WHERE (c.CustomerID = o.CustomerID) and (d.OrderID = o.OrderID) 
	and (d.ProductID = p.ProductID) and (p.ArtistID = a.ArtistID) and (a.ArtistFirstName LIKE 'J%');

/* select CustomerFirstName and CustomerLastName of customers
who made at least one purchase with an Artist whose first name begins with J 
using a JOIN */
SELECT c.CustomerFirstName, c.CustomerLastName FROM 
CUSTOMERS as c JOIN ORDERS as o ON (c.CustomerID = o.CustomerID)
JOIN ORDER_DETAILS as d ON (d.OrderID = o.OrderID)
JOIN ARTISAN_PRODUCTS as p ON (d.ProductID = p.ProductID)
JOIN ARTISTS as a ON (p.ArtistID = a.ArtistID)
WHERE a.ArtistFirstName LIKE 'J%';

/* select CustomerFirstName and CustomerLastName with sum of PreTaxAmounts for each customer */
SELECT c.CustomerFirstName, c.CustomerLastName, SUM(o.PreTaxTotal) as SumPreTaxTotals FROM CUSTOMERS as c
LEFT JOIN ORDERS as o ON (c.CustomerID = o.CustomerID)
GROUP BY c.CustomerFirstName, c.CustomerLastName;

/* select ArtistFirstName and ArtistLastName with sum of PreTaxAmounts for each artist */
SELECT a.ArtistFirstName, a.ArtistLastName, SUM(o.PreTaxTotal) as SumPreTaxTotal FROM ARTISTS as a JOIN ARTISAN_PRODUCTS as r
ON (a.ArtistID = r.ArtistID) JOIN PRODUCTS as p
ON (p.ProductID = r.ProductID) JOIN ORDER_DETAILS as d
ON (d.ProductID = p.ProductID) JOIN ORDERS as o
ON (o.OrderID = d.OrderID)
GROUP BY a.ArtistFirstName, a.ArtistLastName;



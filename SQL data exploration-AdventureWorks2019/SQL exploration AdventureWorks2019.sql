
/****************************************************************************************************************

----WELCOME to this SQL practice queries on aggregate functions,JOINS,Sub Queries,CTE and Window Function--------

  ( The queries have been done on AdventureWorks2019 dataset containing 68 tables.The queries have been done to showcase 
    my SQL skills on database containing multiple tables to retrieve required information) 

*****************************************************************************************************************/


/*SQL Aggregate Functions   */


--1)Write SQL Query to find the total Order quantity by each product which prodution started Between 2011-06-03 and 2011-12-03

SELECT ProductID,
		SUM(OrderQty) TotalQuantity
FROM	Production.WorkOrder
WHERE	StartDate BETWEEN '2011-06-03' AND '2011-12-03'
GROUP BY ProductID
ORDER BY TotalQuantity

----------------------------

-- 2)Write a SQL query to find out Average Production Cost.

SELECT ROUND(AVG(StandardCost),2) AS AverageCost
FROM Production.product

-----

--3)Find out Total number of products by each color whose standard production cost is less than 20.

SELECT COLOR,COUNT(*) as Quantity
FROM Production.Product
WHERE StandardCost <20
GROUP BY Color

--4)Find out the Vendor information information whose Average Lead time is the lowest among all.

SELECT * 
FROM Purchasing.ProductVendor
WHERE AverageLeadTime IN ( SELECT MIN(AverageLeadTime)
							FROM Purchasing.ProductVendor)

--5)Find out the Vendor with Maximum Standard Price
SELECT MAX(StandardPrice) as MaximumPrice
FROM	Purchasing.ProductVendor



/*   SQL JOINS   */

--1) Write a SQL Query to find out the BusinessEnttyID,Average Lead Time and vendor name  which has the highest vendor price

SELECT 
	pv.BusinessEntityID,
	pv.AverageLeadTime,
	--pv.MinOrderQty,
	--pv.MaxOrderQty,
	pv.standardPrice,
	v.Name as VendorName
FROM Purchasing.ProductVendor as pv
JOIN Purchasing.Vendor as v on pv.businessEntityID=v.BusinessEntityID
WHERE StandardPrice IN
					(SELECT MAX(StandardPrice)FROM Purchasing.ProductVendor) 


--2) Find out the vacation hours and sickleave hours of the employees who works only in the evening shift
--join HumanResources.employee with Humanresources.EmployeeDepartmentHistory on businessentityID, 
--then HumanResources.departmentHistory with HumanResources.Shift table on shiftID


SELECT 
		e.businessEntityID,e.VacationHours,e.SickleaveHours,s.name as ShiftName
		FROM HumanResources.Employee e
		JOIN HumanResources.EmployeeDepartmentHistory ed
		ON e.BusinessEntityID= ed.BusinessEntityID
		JOIN HumanResources.Shift s
		ON s.ShiftID = ed.ShiftID
		WHERE s.Name= 'Evening'



--3) Find Out the full name,EmailAddress,Job title and total sickleave hours who were hired after 2009.
--JOIN HumanResources.employee table and Person.Person table on BusinessEntityID


SELECT  p.FirstName + ' ' + p.MiddleName+' '+p.LastName as FullName,
		e.HireDate,
		e.JobTitle,
		e.SickLeaveHours,
		ea. EmailAddress

FROM	HumanResources.Employee e
JOIN	Person.Person p
ON		e.BusinessEntityID= p.BusinessEntityID
JOIN	Person.EmailAddress ea
ON		ea.BusinessEntityID= p.BusinessEntityID
WHERE	e.HireDate > '2009-01-01'
ORDER BY e.HireDate




--4) Findout the product name,standard cost for production from production.product table whose production cost is more than 100 usd. 
--join Production.product table with Production.productcostHistory


SELECT 
	p.Name as ProductName,
	pch.StandardCost
FROM
	production.product p
JOIN Production.ProductCostHistory pch
ON
	p.ProductID= pch.ProductID
WHERE pch.StandardCost> 100
ORDER BY pch.StandardCost



--5) Find out the Product name,category and subcategory,stadard price ,list price
--by joining Production.product table, Production.productcategory table and Production.productSubCategory table on product ID,
--productcategoryID,productsubcategoryID

SELECT 
		p.Name,p.StandardCost,p.listPrice,pc.Name as Category,psc.Name as Subcategory
FROM	Production.product p
LEFT JOIN	Production.ProductSubCategory psc
ON		p.ProductSubcategoryID=psc.ProductSubcategoryID
LEFT JOIN	Production.ProductCategory pc
ON		pc.ProductCategoryID= psc.ProductCategoryID	

--204 Columns had NULL ProductSubCategoryID but with LEFT JOIN all the rows has been retrieved


--6) Find out the product name,order qty,uniteprice,total order price, average unite price of those products whose StandardCost is 
--greater than that of Minipump.
--join product table with purchaseOrderDetail on ProductID

SELECT
	p.ProductID,
	p.Name as ProductName,
	p.StandardCost,
	pod.OrderQty,
	pod.UnitPrice,
	pod.OrderQty*pod.UnitPrice as TotalOrderPrice
FROM
	Production.Product p
JOIN
	Purchasing.PurchaseOrderDetail pod
ON	p.ProductID= pod.ProductID
WHERE
p.StandardCost>(SELECT p.StandardCost FROM Production.product p
				WHERE Name='Minipump')


--7) Find out the Due amount,Vendor Name where the shipping method was Overseas Delux and Cargo Transport 5
--JOIN Purchasing.Shipmethod and Purchasing.purchaseOrderheader on ShipMethodID
--THEN JOIN Purchasing.purchaseOrderHeader with Purchasing.Vendor table on VendorID and BusinessEntityID


SELECT 
	poh.ShipMethodID,
	sm.Name as ShippingName,
	v.name as VendorName,
	poh.TotalDue
FROM Purchasing.PurchaseOrderHeader poh
JOIN Purchasing.ShipMethod sm
ON poh.ShipMethodID=sm.shipMethodID
JOIN Purchasing.Vendor v
ON v.BusinessEntityID= poh.VendorID
WHERE poh.ShipMethodID IN(3,5)
ORDER BY poh.TotalDue




/*     SQL Sub Queries    */


--1) Find out the JobTitle,Birthdate and Gender of the employees, who has less vacation hours than the Employee 
--whose BusinessEntityID is 263.

SELECT JobTitle,BirthDate,Gender 
FROM	HumanResources.Employee
WHERE VacationHours < (SELECT VacationHours 
						FROM HumanResources.Employee WHERE BusinessEntityID=263)


--2) Findout the Gender,vacation Hours and Sickleave Hours of the employees whose Job Title id same as the employee whose 
--BusinessEntityID is 214

SELECT JobTitle,Gender,VacationHours,SickLeaveHours 
FROM HumanResources.Employee 
WHERE JobTitle= (SELECT Jobtitle 
				FROM HumanResources.Employee 
				WHERE BusinessEntityID =214
				)

--3) Write a SQL query to find out the productID,ProductName and Color whose list price is between Minimum list price and 90.

SELECT 
	ProductID,
	Name,
	COlor,
	ListPrice
FROM
	Production.Product
WHERE 
	ListPrice BETWEEN (SELECT MIN(ListPrice) FROM Production.Product) AND 90;


/* 4)  write a SQL query to find those employees who got second-highest vacation Hours. Find out 
--BusinessEntityID,JobTitle,Gender
*/

SELECT 
	BusinessEntityID,
	JobTitle,
	Gender,
	VacationHours
FROM
	HumanResources.Employee
WHERE 
	VacationHours=
			(SELECT MAX(VacationHours)
			FROM HumanResources.Employee
			WHERE VacationHours <(SELECT MAX(VacationHours) FROM HumanResources.Employee));

--5) FInd out the products which have been sold more units than the average unit sold by all the other Products. Find ProductID and 
--Total Sales Quantity.

SELECT 
	ProductID,SUM(OrderQty) as TotalSalesQty
FROM
	Sales.SalesOrderDetail
	GROUP BY ProductID
	HAVING SUM(OrderQty) > (SELECT AVG(OrderQty) FROM Sales.SalesOrderDetail)
	ORDER BY TotalSalesQty


--6 )Write a SQL query to find out porduct details and add remarks to those product whose Standard production cost is higher than the
--average production cost.

SELECT 
	ProductID,
	Name,
	Color,
	Standardcost,
	(CASE WHEN StandardCost> (SELECT AVG(StandardCost) FROM Production.Product)
				THEN 'High Production Cost'
				ELSE 'Normal Production Cost'
				END
	) as Remarks
FROM Production.Product

--SQL Subquery in UPDATE Statement
--Increase the Order Quantity of all product by 20%  in PurchaseOrderDetail Table,consider only the products of those 
--the inventory quantity is less than 300 




/*     SQL CTE/TEMP TABLES   */

--1) Write a SQL query with WITH cause to find the products (Name and Color) whose standard cost is higher than the average standard cost

WITH cte_avgcost  as
(SELECT avg(StandardCost) as AvgCost FROM Production.Product)

SELECT 
	Name,
	Color,
	ROUND(StandardCost,2) as StandardCost
FROM
	Production.Product ,cte_avgcost 
WHERE StandardCost > avgcost ;



--2) From the Sales.SalesOrderDetail Table
--Write a SQL Query to find the products whose total sales is greater than the Avergae sales for all products.

--1st Stage: Find Total sales per each product.

--2nd: Find average sale with respoect to all products

--3rd: Find the products with higher sale than the average sale


WITH    CTE_SalesPerProduct as                        ---This CTE is for finding total sales per each product	
(SELECT 
	ProductID,SUM(OrderQty) as TotalQuantity, 
	CAST(SUM(UnitPrice)as INT) as TotalSalesPerProduct
FROM	
	Sales.SalesOrderDetail
GROUP BY
	ProductID ),

CTE_AverageSales as                                --This CTE is to find Average Sales with respect to all products
(SELECT 
	CAST(AVG(TotalSalesPerProduct) as INT) as AverageSalesForAllProducts
FROM 
	CTE_SalesPerProduct)

SELECT *                 --The SELECT query to compare total sales for all products and the avergae sales with respect to all product.
FROM	CTE_SalesPerProduct sp
JOIN	CTE_AverageSales av 
ON		sp.TotalSalesPerProduct>av.AverageSalesForAllProducts
ORDER BY sp.ProductID ;

--Result: There are 65 Products whose Total sales is Higher than the average sales with respoect to all products.



/*						SQL Window Function      */


--1) SUM Window Function
--FindOut The count of total Orders for each product by each Sales Order. Feth, SalesOrderID,ProductID,LineTotal and TotalOrders.

SELECT 
	SalesOrderID,
	ProductID,
	LineTotal,
	SUM(OrderQty) OVER(PARTITION BY ProductID Order BY salesOrderID) TotalOrders
FROM Sales.SalesOrderDetail

ORDER BY ProductID
	
	SELECT ProductID,SUM(OrderQty)
	From sales.SalesOrderDetail
	GROUP BY ProductID
	ORDER BY ProductID


--2)--ROW_NUMBER function
--Wirte a SQL query to get the first hired employee based on HireDate Column for each Job Title



SELECT BusinessEntityID,JobTitle,HireDate 
FROM
	(SELECT *,
	ROW_NUMBER() OVER(PARTITION BY JobTitle ORDER BY HireDate) row_num
	FROM HumanResources.Employee) x
WHERE x.row_num<2
ORDER BY Hiredate ;


--3) RANK Function

--FindOut the Top 3 products of each color with highest Standard Cost. 

SELECT *
FROM 
(
SELECT ProductID,name,color,standardcost,
RANK () OVER(PARTITION BY Color ORDER BY StandardCost DESC) as RNK

FROM Production.Product ) x
WHERE x.RNK < 3
 AND Color is NOT NULL


 
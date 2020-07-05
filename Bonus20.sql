--BONUS 20 --

--Write SQL Queries for the following:
--1. Select all records from the customers table.
SELECT
    *
FROM Sales.Customer

--2. Find all customers living in London or Paris
SELECT
    P.FirstName,
    P.LastName,
    PA.City
FROM Person.Person as P
JOIN Person.BusinessEntityAddress as BE
    ON P.BusinessEntityID = BE.BusinessEntityID
JOIN Person.Address AS PA
    ON BE.AddressID = PA.AddressID
WHERE P.PersonType = 'IN' AND (PA.City = 'London' OR PA.City = 'Paris')

--3. Make a list of cities where customers are coming from. The list should not have any duplicates or nulls.
SELECT
    DISTINCT PA.City
FROM Person.Person as P
JOIN Person.BusinessEntityAddress as BE
    ON P.BusinessEntityID = BE.BusinessEntityID
JOIN Person.Address AS PA
    ON BE.AddressID = PA.AddressID
WHERE P.PersonType = 'IN' AND PA.City IS NOT NULL

--4. Show a sorted list of employees’ first names.
SELECT
    FirstName  
FROM Person.Person 
WHERE PersonType = 'EM'
ORDER BY FirstName

--5. Find the average of employees’ salaries
SELECT
    AVG(Rate) AS AverageRate
FROM HumanResources.EmployeePayHistory

--6. Show the first name and last name for the employee with the highest salary.
SELECT
    PER.FirstName,
    PER.LastName
FROM Person.Person  AS PER
JOIN HumanResources.EmployeePayHistory AS PH 
    ON PH.BusinessEntityID = PER.BusinessEntityID
WHERE PH.Rate IN
(SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory)

--7. Find a list of all employees who have a BA
SELECT
    P.FirstName,
    P.LastName
FROM HumanResources.vJobCandidateEducation AS ED 
JOIN HumanResources.JobCandidate as JC
    ON JC.JobCandidateID = ED.JobCandidateID
JOIN Person.Person as P
    ON P.BusinessEntityID = JC.BusinessEntityID
WHERE ED.[Edu.Degree] LIKE '%Bach%'

--8. Find total for each order
SELECT
    PurchaseOrderID,
    TotalDue
FROM Purchasing.PurchaseOrderHeader

--9. Get a list of all employees who got hired between 1/1/1994 and today
SELECT
    P.FirstName,
    P.MiddleName,
    P.LastName
    FROM HumanResources.Employee AS EM
JOIN Person.Person AS P 
    ON P.BusinessEntityID = EM.BusinessEntityID
WHERE EM.HireDate > '1994-01-01'

--10.Find how long employees have been working for Northwind (in years!)
SELECT 
    DATEDIFF(year, HireDate, '2020-07-05') AS YearsEmployed
FROM HumanResources.Employee

--11.Get a list of all products sorted by quantity (ascending and descending order)
SELECT
    PR.ProductNumber,
    PR.Name,
    PI.Quantity
FROM Production.Product AS PR 
JOIN Production.ProductInventory AS PI 
    ON PR.ProductID = PI.ProductID
ORDER BY PI.Quantity ASC --acending (could also leave blank)

SELECT
    PR.ProductNumber,
    PR.Name,
    PI.Quantity
FROM Production.Product AS PR 
JOIN Production.ProductInventory AS PI 
    ON PR.ProductID = PI.ProductID
ORDER BY PI.Quantity DESC --descending

--12.Find all products that are low on stock (quantity less than 6)
SELECT
    PR.ProductNumber,
    PR.Name,
    PI.Quantity
FROM Production.Product AS PR 
JOIN Production.ProductInventory AS PI 
    ON PR.ProductID = PI.ProductID
WHERE PI.Quantity < 6

--13.Find a list of all discontinued products.
SELECT
    ProductID,
    ProductNumber,
    [Name]
FROM Production.Product
WHERE SellEndDate IS NOT NULL -- I originally used the "DiscontinuedDate" column, but it appears all results are null.

--14.Find a list of all products that have Tofu in them.
SELECT
    PR.Name
FROM Production.Product AS PR 
WHERE PR.Name = 'Tofu' 

--15.Find the product that has the highest unit price.
SELECT 
    ProductID, 
    [Name]
FROM Production.Product
WHERE ListPrice IN 
(SELECT MAX(ListPrice) FROM Production.Product)

--16.Get a list of all employees who got hired after 1/1/1993
SELECT
    P.FirstName,
    P.MiddleName,
    P.LastName
    FROM HumanResources.Employee AS EM
JOIN Person.Person AS P 
    ON P.BusinessEntityID = EM.BusinessEntityID
WHERE EM.HireDate > '1993-01-01'

--17.Get all employees who have title : “Ms.” And “Mrs.”
SELECT
    FirstName,
    LastName
FROM Person.Person
WHERE PersonType = 'EM' AND (Title = 'Ms.'OR Title ='Mrs.')

--18.Get all employees who have a Home phone number that has area code 206
SELECT
    P.FirstName,
    P.LastName
FROM Person.Person AS P
JOIN Person.PersonPhone AS PH 
    ON P.BusinessEntityID = PH.BusinessEntityID
WHERE P.PersonType ='EM' AND 
PH.PhoneNumberTypeID = 2 AND 
PH.PhoneNumber LIKE '206%' 

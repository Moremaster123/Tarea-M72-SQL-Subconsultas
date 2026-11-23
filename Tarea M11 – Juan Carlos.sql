USE AdventureWorks2022;
GO

SELECT Name, ProductID
FROM Production.Product
WHERE ProductID IN (SELECT ProductID FROM Sales.SalesOrderDetail)
ORDER BY Name ASC;
GO

SELECT e.BusinessEntityID,
       p.FirstName + ' ' + p.LastName AS Empleado,
       d.Name AS Departamento
FROM HumanResources.Employee e
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL
ORDER BY e.BusinessEntityID;
GO

WITH DepartamentoActual AS (
    SELECT edh.BusinessEntityID, d.Name
    FROM HumanResources.EmployeeDepartmentHistory edh
    INNER JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL
)
SELECT e.BusinessEntityID,
       p.FirstName + ' ' + p.LastName AS Empleado,
       da.Name AS Departamento
FROM HumanResources.Employee e
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN DepartamentoActual da ON e.BusinessEntityID = da.BusinessEntityID
ORDER BY e.BusinessEntityID;
GO

DROP TABLE IF EXISTS #ProductosOrdenados;
DROP TABLE IF EXISTS ##ProductosOrdenados;

CREATE TABLE #ProductosOrdenados (
    ProductID INT,
    Name NVARCHAR(50)
);

CREATE TABLE ##ProductosOrdenados (
    ProductID INT,
    Name NVARCHAR(50)
);

INSERT INTO #ProductosOrdenados (ProductID, Name)
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID IN (SELECT ProductID FROM Sales.SalesOrderDetail);

INSERT INTO ##ProductosOrdenados (ProductID, Name)
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID IN (SELECT ProductID FROM Sales.SalesOrderDetail);

SELECT ProductID, Name
FROM #ProductosOrdenados
ORDER BY ProductID;
GO

SELECT SalesOrderNumber, PurchaseOrderNumber
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011;
GO

SELECT SUBSTRING(SalesOrderNumber, 3, LEN(SalesOrderNumber)) AS NewSalesOrderNumber,
       SUBSTRING(PurchaseOrderNumber, 3, LEN(PurchaseOrderNumber)) AS NewPurchaseOrderNumber
FROM Sales.SalesOrderHeader;
GO

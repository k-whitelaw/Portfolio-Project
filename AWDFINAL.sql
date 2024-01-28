-- Calculate total sales --
SELECT
    ROUND(SUM(TotalDue), 2) AS TotalSales
FROM
    Sales.SalesOrderHeader;

-- Calculate total profit --
SELECT
    SUM(SOD.LineTotal - P.StandardCost) AS TotalProfit
FROM
    Sales.SalesOrderDetail SOD
JOIN
    Production.Product P 
ON 
	SOD.ProductID = P.ProductID
JOIN
    Sales.SalesOrderHeader SOH 
ON 
	SOD.SalesOrderID = SOH.SalesOrderID;

-- Top 10 regions with the most orders --
SELECT TOP 10 WITH TIES
    ST.Name AS Region,
    SUM(SOD.OrderQty) AS TotalOrderQty
FROM 
    Sales.SalesOrderHeader SOH
JOIN
    Sales.SalesOrderDetail SOD 
ON
	SOH.SalesOrderID = SOD.SalesOrderID
JOIN
    Sales.SalesTerritory ST 
ON 
	SOH.TerritoryID = ST.TerritoryID
GROUP BY 
    ST.Name
ORDER BY 
    TotalOrderQty DESC;

-- Calculate total sales for each year --
SELECT
	YEAR(OrderDate) AS Year,
    ROUND(SUM(TotalDue), 2) AS TotalSales
FROM
    Sales.SalesOrderHeader
GROUP BY
	YEAR(OrderDate)
ORDER BY YEAR;

-- Select the top 10 products --
SELECT TOP 10
	P.Name,
	COUNT(OrderQty) AS OrderQty,
	ROUND(SUM(LineTotal), 2) AS TotalCost	
FROM
    Sales.SalesOrderDetail SOD 
JOIN
	Production.Product P
ON 
	P.ProductID = SOD.ProductID
GROUP BY
    P.ProductID, P.Name
ORDER BY
    COUNT(SOD.OrderQty) DESC
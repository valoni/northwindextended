
DROP PROCEDURE sp_Employees_Insert ( nvarchar,nvarchar,nvarchar,nvarchar,datetime,datetime,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,image,ntext,int,int ) ;

DROP PROCEDURE sp_Employees_Update ( int,nvarchar,nvarchar,nvarchar,nvarchar,datetime,datetime,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,nvarchar,image,ntext,int ) ;

DROP PROCEDURE sp_Employees_SelectAll ;

DROP PROCEDURE sp_Employees_SelectRow ( int ) ;

DROP PROCEDURE sp_Employees_Cursor ( nvarchar(15) ) ;

DROP PROCEDURE sp_employees_rownum ;

DROP PROCEDURE sp_employees_rank ;

DROP PROCEDURE sp_employees_rollup ;

DROP PROCEDURE Ten_Most_Expensive_Products ;

DROP PROCEDURE Employee_Sales_by_Country ( datetime,datetime ) ;

DROP PROCEDURE Sales_by_Year ( datetime,datetime ) ;

DROP PROCEDURE CustOrdersDetail ( int ) ;

DROP PROCEDURE CustOrdersOrders ( nchar(5) ) ;

DROP PROCEDURE CustOrderHist ( nchar(5) ) ;

DROP PROCEDURE SalesByCategory ( nvarchar(15),nvarchar(4) ) ;

DROP FUNCTION LookByFName ;

DROP FUNCTION DateOnly ;

DROP FUNCTION MyRound ;

CREATE TABLE Categories
(
	CategoryID            INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	CategoryName          VARCHAR(15)
			       NOT NULL ,
	Description           CLOB
			      ,
	Picture               BLOB(1000)
			      
);

ALTER TABLE Categories
	ADD CONSTRAINT PK_Categories  PRIMARY KEY (CategoryID);

CREATE INDEX CategoryName ON Categories
(
	CategoryName         ASC
);

CREATE TABLE CustomerCustomerDemo
(
	CustomerID            CHAR(5)
			       NOT NULL ,
	CustomerTypeID        CHAR(10)
			       NOT NULL 
);

ALTER TABLE CustomerCustomerDemo
	ADD CONSTRAINT PK_CustomerCustomerDemo  PRIMARY KEY (CustomerID,CustomerTypeID);

CREATE TABLE CustomerDemographics
(
	CustomerTypeID        CHAR(10)
			       NOT NULL ,
	CustomerDesc          CLOB
			      
);

ALTER TABLE CustomerDemographics
	ADD CONSTRAINT PK_CustomerDemographics  PRIMARY KEY (CustomerTypeID);

CREATE TABLE Customers
(
	CustomerID            CHAR(5)
			       NOT NULL ,
	CompanyName           VARCHAR(40)
			       NOT NULL ,
	ContactName           VARCHAR(30)
			      ,
	ContactTitle          VARCHAR(30)
			      ,
	Address               VARCHAR(60)
			      ,
	City                  VARCHAR(15)
			      ,
	Region                VARCHAR(15)
			      ,
	PostalCode            VARCHAR(10)
			      ,
	Country               VARCHAR(15)
			      ,
	Phone                 VARCHAR(24)
			      ,
	Fax                   VARCHAR(24)
			      
);

ALTER TABLE Customers
	ADD CONSTRAINT PK_Customers  PRIMARY KEY (CustomerID);

CREATE INDEX City ON Customers
(
	City                 ASC
);

CREATE INDEX CompanyName ON Customers
(
	CompanyName          ASC
);

CREATE INDEX PostalCode ON Customers
(
	PostalCode           ASC
);

CREATE INDEX Region ON Customers
(
	Region               ASC
);

CREATE TABLE Employees
(
	EmployeeID            INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	LastName              VARCHAR(20)
			       NOT NULL ,
	FirstName             VARCHAR(10)
			       NOT NULL ,
	Title                 VARCHAR(30)
			      ,
	TitleOfCourtesy       VARCHAR(25)
			      ,
	BirthDate             TIMESTAMP
			       CONSTRAINT  CK_Birthdate CHECK ( [BirthDate]<getdate() ),
	HireDate              TIMESTAMP
			      ,
	Address               VARCHAR(60)
			      ,
	City                  VARCHAR(15)
			      ,
	Region                VARCHAR(15)
			      ,
	PostalCode            VARCHAR(10)
			      ,
	Country               VARCHAR(15)
			      ,
	HomePhone             VARCHAR(24)
			      ,
	Extension             VARCHAR(4)
			      ,
	Photo                 BLOB(1000)
			      ,
	Notes                 CLOB
			      ,
	ReportsTo             INTEGER
			      ,
	PhotoPath             VARCHAR(255)
			      ,
	Salary                decimal(18,2)
			      
);

ALTER TABLE Employees
	ADD CONSTRAINT PK_Employees  PRIMARY KEY (EmployeeID);

CREATE INDEX LastName ON Employees
(
	LastName             ASC
);

CREATE INDEX PostalCode ON Employees
(
	PostalCode           ASC
);

CREATE TABLE EmployeeTerritories
(
	EmployeeID            INTEGER
			       NOT NULL ,
	TerritoryID           VARCHAR(20)
			       NOT NULL 
);

ALTER TABLE EmployeeTerritories
	ADD CONSTRAINT PK_EmployeeTerritories  PRIMARY KEY (EmployeeID,TerritoryID);

CREATE TABLE Order_Details
(
	OrderID               INTEGER
			       NOT NULL ,
	ProductID             INTEGER
			       NOT NULL ,
	UnitPrice             DECIMAL(19,4)
			       NOT NULL  DEFAULT 0 CONSTRAINT  CK_UnitPrice CHECK ( UnitPrice >= 0 ),
	Quantity              smallint
			       NOT NULL  DEFAULT 1 CONSTRAINT  CK_Quantity CHECK ( [Quantity]>(0) ),
	Discount              real
			       NOT NULL  DEFAULT 0 CONSTRAINT  CK_Discount CHECK ( Discount BETWEEN 0 AND 1 )
);

ALTER TABLE Order_Details
	ADD CONSTRAINT PK_Order_Details  PRIMARY KEY (OrderID,ProductID);

CREATE INDEX OrdersOrder_Details ON Order_Details
(
	OrderID              ASC
);

CREATE INDEX ProductsOrder_Details ON Order_Details
(
	ProductID            ASC
);

CREATE TABLE Orders
(
	OrderID               INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	CustomerID            CHAR(5)
			      ,
	EmployeeID            INTEGER
			      ,
	OrderDate             TIMESTAMP
			      ,
	RequiredDate          TIMESTAMP
			      ,
	ShippedDate           TIMESTAMP
			      ,
	ShipVia               INTEGER
			      ,
	Freight               DECIMAL(19,4)
			       DEFAULT 0,
	ShipName              VARCHAR(40)
			      ,
	ShipAddress           VARCHAR(60)
			      ,
	ShipCity              VARCHAR(15)
			      ,
	ShipRegion            VARCHAR(15)
			      ,
	ShipPostalCode        VARCHAR(10)
			      ,
	ShipCountry           VARCHAR(15)
			      
);

ALTER TABLE Orders
	ADD CONSTRAINT PK_Orders  PRIMARY KEY (OrderID);

CREATE INDEX CustomersOrders ON Orders
(
	CustomerID           ASC
);

CREATE INDEX EmployeesOrders ON Orders
(
	EmployeeID           ASC
);

CREATE INDEX OrderDate ON Orders
(
	OrderDate            ASC
);

CREATE INDEX ShipPostalCode ON Orders
(
	ShipPostalCode       ASC
);

CREATE INDEX ShippedDate ON Orders
(
	ShippedDate          ASC
);

CREATE TABLE Products
(
	ProductID             INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	ProductName           VARCHAR(40)
			       NOT NULL ,
	SupplierID            INTEGER
			      ,
	CategoryID            INTEGER
			      ,
	QuantityPerUnit       VARCHAR(20)
			      ,
	UnitPrice             DECIMAL(19,4)
			       DEFAULT 0 CONSTRAINT  CK_Products_UnitPrice CHECK ( UnitPrice >= 0 ),
	UnitsInStock          smallint
			       DEFAULT 0 CONSTRAINT  CK_UnitsInStock CHECK ( UnitsInStock >= 0 ),
	UnitsOnOrder          smallint
			       DEFAULT 0 CONSTRAINT  CK_UnitsOnOrder CHECK ( UnitsOnOrder >= 0 ),
	ReorderLevel          smallint
			       DEFAULT 0 CONSTRAINT  CK_ReorderLevel CHECK ( ReorderLevel >= 0 ),
	Discontinued          SMALLINT
			       NOT NULL  DEFAULT 0
);

ALTER TABLE Products
	ADD CONSTRAINT PK_Products  PRIMARY KEY (ProductID);

CREATE INDEX CategoryID ON Products
(
	CategoryID           ASC
);

CREATE INDEX ProductName ON Products
(
	ProductName          ASC
);

CREATE INDEX SuppliersProducts ON Products
(
	SupplierID           ASC
);

CREATE TABLE Region
(
	RegionID              INTEGER
			       NOT NULL ,
	RegionDescription     CHAR(50)
			       NOT NULL 
);

ALTER TABLE Region
	ADD CONSTRAINT PK_Region  PRIMARY KEY (RegionID);

CREATE TABLE Shippers
(
	ShipperID             INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	CompanyName           VARCHAR(40)
			       NOT NULL ,
	Phone                 VARCHAR(24)
			      
);

ALTER TABLE Shippers
	ADD CONSTRAINT PK_Shippers  PRIMARY KEY (ShipperID);

CREATE TABLE Suppliers
(
	SupplierID            INTEGER
			      AS IDENTITY (
					START WITH 1
					INCREMENT BY 1 ) NOT NULL ,
	CompanyName           VARCHAR(40)
			       NOT NULL ,
	ContactName           VARCHAR(30)
			      ,
	ContactTitle          VARCHAR(30)
			      ,
	Address               VARCHAR(60)
			      ,
	City                  VARCHAR(15)
			      ,
	Region                VARCHAR(15)
			      ,
	PostalCode            VARCHAR(10)
			      ,
	Country               VARCHAR(15)
			      ,
	Phone                 VARCHAR(24)
			      ,
	Fax                   VARCHAR(24)
			      ,
	HomePage              CLOB
			      
);

ALTER TABLE Suppliers
	ADD CONSTRAINT PK_Suppliers  PRIMARY KEY (SupplierID);

CREATE INDEX CompanyName ON Suppliers
(
	CompanyName          ASC
);

CREATE INDEX PostalCode ON Suppliers
(
	PostalCode           ASC
);

CREATE TABLE Territories
(
	TerritoryID           VARCHAR(20)
			       NOT NULL ,
	TerritoryDescription  CHAR(50)
			       NOT NULL ,
	RegionID              INTEGER
			       NOT NULL 
);

ALTER TABLE Territories
	ADD CONSTRAINT PK_Territories  PRIMARY KEY (TerritoryID);

CREATE VIEW [Customer and Suppliers by City] AS  SELECT City, CompanyName, ContactName, 'Customers' AS Relationship FROM Customers UNION SELECT City, CompanyName, ContactName, 'Suppliers' FROM Suppliers;

CREATE VIEW [Alphabetical list of products] AS  SELECT Products.*, Categories.CategoryName FROM Categories   INNER JOIN   Products ON Categories.CategoryID = Products.CategoryID WHERE ( ( (Products.Discontinued) = 0 ) );

CREATE VIEW Current_Product_List ( ProductID,ProductName ) AS 
    SELECT Product_List.ProductID,Product_List.ProductName
    FROM Products Product_List
	WHERE ( ( (Product_List.Discontinued) = 0 ) );

CREATE VIEW [Orders Qry] AS  SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country FROM Customers   INNER JOIN   Orders ON Customers.CustomerID = Orders.CustomerID;

CREATE VIEW Products_Above_Average_Price ( ProductName,UnitPrice ) AS 
    SELECT .ProductName,.UnitPrice
    FROM Products 
	WHERE Products.UnitPrice > (  SELECT AVG( UnitPrice) FROM Products );

CREATE VIEW [Products by Category] AS  SELECT Categories.CategoryName, Products.ProductName, Products.QuantityPerUnit, Products.UnitsInStock, Products.Discontinued FROM Categories   INNER JOIN   Products ON Categories.CategoryID = Products.CategoryID WHERE Products.Discontinued <> 1;

CREATE VIEW [Quarterly Orders] AS  SELECT  DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country FROM Customers   RIGHT JOIN   Orders ON Customers.CustomerID = Orders.CustomerID WHERE Orders.OrderDate BETWEEN '19970101' AND '19971231';

CREATE VIEW [Invoices] AS  SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country, (FirstName + ' ' + LastName) AS Salesperson, Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName AS ShipperName, Order Details.ProductID, Products.ProductName, Order Details.UnitPrice, Order Details.Quantity, Order Details.Discount, ( CONVERT(money, ("Order Details".UnitPrice * Quantity * (1 - Discount) / 100)) * 100) AS ExtendedPrice, Orders.Freight FROM Shippers   INNER JOIN   Products   INNER JOIN   Employees   INNER JOIN   Customers   INNER JOIN   Orders ON Customers.CustomerID = Orders.CustomerID ON Employees.EmployeeID = Orders.EmployeeID   INNER JOIN   Order Details ON Orders.OrderID = "Order Details".OrderID ON Products.ProductID = "Order Details".ProductID ON Shippers.ShipperID = Orders.ShipVia;

CREATE VIEW [Order Details Extended] AS  SELECT Order Details.OrderID, Order Details.ProductID, Products.ProductName, Order Details.UnitPrice, Order Details.Quantity, Order Details.Discount, ( CONVERT(money, ("Order Details".UnitPrice * Quantity * (1 - Discount) / 100)) * 100) AS ExtendedPrice FROM Products   INNER JOIN   Order Details ON Products.ProductID = "Order Details".ProductID;

CREATE VIEW Order_Subtotals ( OrderID,Subtotal ) AS 
    SELECT .OrderID,SUM(  CONVERT(money, ("Order Details".UnitPrice * Quantity * (1 - Discount) / 100)) * 100)
    FROM Order_Details 
	GROUP BY "Order Details".OrderID;

CREATE VIEW [Product Sales for 1997] AS  SELECT Categories.CategoryName, Products.ProductName, SUM(  CONVERT(money, ("Order Details".UnitPrice * Quantity * (1 - Discount) / 100)) * 100) AS ProductSales FROM Categories   INNER JOIN   Products ON Categories.CategoryID = Products.CategoryID   INNER JOIN   Orders   INNER JOIN   Order Details ON Orders.OrderID = "Order Details".OrderID ON Products.ProductID = "Order Details".ProductID WHERE ( ( (Orders.ShippedDate) BETWEEN '19970101' AND '19971231' ) ) GROUP BY Categories.CategoryName, Products.ProductName;

CREATE VIEW Category_Sales_for_1997 ( CategoryName,CategorySales ) AS 
    SELECT .CategoryName,SUM( "Product Sales for 1997".ProductSales)
    FROM Product_Sales_for_1997 
	GROUP BY "Product Sales for 1997".CategoryName;

CREATE VIEW [Sales by Category] AS  SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, SUM( "Order Details Extended".ExtendedPrice) AS ProductSales FROM Categories   INNER JOIN   Products   INNER JOIN   Orders   INNER JOIN   Order Details Extended ON Orders.OrderID = "Order Details Extended".OrderID ON Products.ProductID = "Order Details Extended".ProductID ON Categories.CategoryID = Products.CategoryID WHERE Orders.OrderDate BETWEEN '19970101' AND '19971231' GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName;

CREATE VIEW [Sales Totals by Amount] AS  SELECT Order Subtotals.Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate FROM Customers   INNER JOIN   Orders   INNER JOIN   Order Subtotals ON Orders.OrderID = "Order Subtotals".OrderID ON Customers.CustomerID = Orders.CustomerID WHERE ( "Order Subtotals".Subtotal > 2500 ) AND ( Orders.ShippedDate BETWEEN '19970101' AND '19971231' );

CREATE VIEW [Summary of Sales by Quarter] AS  SELECT Orders.ShippedDate, Orders.OrderID, Order Subtotals.Subtotal FROM Orders   INNER JOIN   Order Subtotals ON Orders.OrderID = "Order Subtotals".OrderID WHERE Orders.ShippedDate IS NOT NULL;

CREATE VIEW [Summary of Sales by Year] AS  SELECT Orders.ShippedDate, Orders.OrderID, Order Subtotals.Subtotal FROM Orders   INNER JOIN   Order Subtotals ON Orders.OrderID = "Order Subtotals".OrderID WHERE Orders.ShippedDate IS NOT NULL;

ALTER TABLE CustomerCustomerDemo
	ADD CONSTRAINT FK_CustomerCustomerDemo  FOREIGN KEY (CustomerTypeID) REFERENCES CustomerDemographics (CustomerTypeID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE CustomerCustomerDemo
	ADD CONSTRAINT FK_CustomerCustomerDemo_Customers  FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Employees
	ADD CONSTRAINT FK_Employees_Employees  FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE EmployeeTerritories
	ADD CONSTRAINT FK_EmployeeTerritories_Territories  FOREIGN KEY (TerritoryID) REFERENCES Territories (TerritoryID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE EmployeeTerritories
	ADD CONSTRAINT FK_EmployeeTerritories_Employees  FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Order_Details
	ADD CONSTRAINT FK_Order_Details_Orders  FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Order_Details
	ADD CONSTRAINT FK_Order_Details_Products  FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Orders
	ADD CONSTRAINT FK_Orders_Customers  FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Orders
	ADD CONSTRAINT FK_Orders_Employees  FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Orders
	ADD CONSTRAINT FK_Orders_Shippers  FOREIGN KEY (ShipVia) REFERENCES Shippers (ShipperID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Products
	ADD CONSTRAINT FK_Products_Categories  FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Products
	ADD CONSTRAINT FK_Products_Suppliers  FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

ALTER TABLE Territories
	ADD CONSTRAINT FK_Territories_Region  FOREIGN KEY (RegionID) REFERENCES Region (RegionID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;


CREATE PROCEDURE sp_Employees_Insert   
   
 AS BEGIN
Insert Into Employees([LastName],[FirstName],[Title],[TitleOfCourtesy],[BirthDate],[HireDate],[Address],[City],[Region],[PostalCode],[Country],[HomePhone],[Extension],[Photo],[Notes],[ReportsTo])
	Values(@LastName,@FirstName,@Title,@TitleOfCourtesy,@BirthDate,@HireDate,@Address,@City,@Region,@PostalCode,@Country,@HomePhone,@Extension,@Photo,@Notes,@ReportsTo);

	SELECT @ReturnID = @@IDENTITY;
END;


CREATE PROCEDURE sp_Employees_Update   
   
 AS BEGIN
Update Employees
	Set
		[LastName] = @LastName,
		[FirstName] = @FirstName,
		[Title] = @Title,
		[TitleOfCourtesy] = @TitleOfCourtesy,
		[BirthDate] = @BirthDate,
		[HireDate] = @HireDate,
		[Address] = @Address,
		[City] = @City,
		[Region] = @Region,
		[PostalCode] = @PostalCode,
		[Country] = @Country,
		[HomePhone] = @HomePhone,
		[Extension] = @Extension,
		[Photo] = @Photo,
		[Notes] = @Notes,
		[ReportsTo] = @ReportsTo
	Where		
		[EmployeeID] = @EmployeeID;
END;


CREATE PROCEDURE sp_Employees_SelectAll   
   
 AS BEGIN
Select 
		[EmployeeID],
		[LastName],
		[FirstName],
		[Title],
		[TitleOfCourtesy],
		[BirthDate],
		[HireDate],
		[Address],
		[City],
		[Region],
		[PostalCode],
		[Country],
		[HomePhone],
		[Extension],
		[Photo],
		[Notes],
		[ReportsTo]
	From Employees;
END;


CREATE PROCEDURE sp_Employees_SelectRow   
   
 AS BEGIN
Select 
		[EmployeeID],
		[LastName],
		[FirstName],
		[Title],
		[TitleOfCourtesy],
		[BirthDate],
		[HireDate],
		[Address],
		[City],
		[Region],
		[PostalCode],
		[Country],
		[HomePhone],
		[Extension],
		[Photo],
		[Notes],
		[ReportsTo]
	From Employees
	Where
		[EmployeeID] = @EmployeeID;
END;


CREATE PROCEDURE sp_Employees_Cursor   
   
 AS BEGIN
	
Declare @FName as nvarchar(10)
Declare @LName as nvarchar(20)
Declare @PhotoPath as nvarchar(255)

Declare @people TABLE 
( 
    FName nvarchar(10), 
    LName nvarchar(20),
    PhotoPath nvarchar(255) 
)

Declare EmployeeCursor CURSOR FAST_FORWARD FOR

Select FirstName, LastName, PhotoPath from Employees where City = @CityIn order by FirstName

OPEN EmployeeCursor
FETCH NEXT FROM EmployeeCursor
INTO @FName, @LName, @PhotoPath

WHILE @@FETCH_STATUS = 0
BEGIN

     INSERT INTO @people VALUES(@FName,@LName,@PhotoPath)
     
     FETCH NEXT FROM EmployeeCursor
     INTO @FName, @LName, @PhotoPath
END

SELECT * FROM @people

CLOSE EmployeeCursor
DEALLOCATE EmployeeCursor

END;


CREATE PROCEDURE sp_employees_rownum   
   
 AS BEGIN
SELECT * 
FROM
(
SELECT Row_Number() over(order by p.firstname desc) AS ROWNUM,
p.* FROM Employees p
) a
WHERE a.ROWNUM>=2 AND a.ROWNUM<=4
END;


CREATE PROCEDURE sp_employees_rank   
   
 AS BEGIN

select e.Title, e.EmployeeID, e.FirstName, e.Salary,
RANK() OVER (Partition by e.Title Order By e.Title) AS RANKS
FROM Employees e 

END;


CREATE PROCEDURE sp_employees_rollup   
   
 AS BEGIN

SELECT City ,Sum(Salary) Salary_By_City FROM employees
GROUP BY City WITH ROLLUP

END;


CREATE PROCEDURE Ten_Most_Expensive_Products   
   
 AS SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC;


CREATE PROCEDURE Employee_Sales_by_Country   
   
 AS SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN 
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date;


CREATE PROCEDURE Sales_by_Year   
   
 AS SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date;


CREATE PROCEDURE CustOrdersDetail   
   
 AS SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
FROM Products P, [Order Details] Od
WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID;


CREATE PROCEDURE CustOrdersOrders   
   
 AS SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
FROM Orders
WHERE CustomerID = @CustomerID
ORDER BY OrderID;


CREATE PROCEDURE CustOrderHist   
   
 AS SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName;


CREATE PROCEDURE SalesByCategory   
   
 AS IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998' 
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [Order Details] OD, Orders O, Products P, Categories C
WHERE OD.OrderID = O.OrderID 
	AND OD.ProductID = P.ProductID 
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName;

CREATE FUNCTION LookByFName (  )  
  
  
AS RETURN SELECT * 
FROM [Employees] 
WHERE LEFT(FirstName, 1) =  @FirstLetter



;

CREATE FUNCTION DateOnly (  )  
  
  
AS BEGIN
	DECLARE @MyOutput varchar(10)
	SET @MyOutput = CONVERT(varchar(10),@InDateTime,101)
	RETURN @MyOutput
END;

CREATE FUNCTION MyRound (  )  
  
  
AS BEGIN
Declare @x decimal;
Declare @i int;
Declare @ix int; 

Set @x=@Operand*power(10,@Places);
Set @i=@x;


IF((@x-@i)>=0.5)
 BEGIN
 	  SET @ix=1
 END
ELSE
 BEGIN 
	SET @ix=0;
 END
	
Set @x=@i+@ix;
Set @x=@x/power(10,@Places);

Return(@x);
END;

CREATE  TRIGGER tD_Categories AFTER DELETE ON Categories
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Products WHERE Products.CategoryID = old.CategoryID) > 0)
    /* erwin Builtin Trigger */
    /* Categories  Products on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="000083dd", PARENT_OWNER="", PARENT_TABLE="Categories"
    CHILD_OWNER="", CHILD_TABLE="Products"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Products_Categories", FK_COLUMNS="CategoryID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Categories because Products exists.')
 !!

CREATE  TRIGGER tU_Categories NO CASCADE BEFORE UPDATE ON Categories
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Categories WHERE Categories.CategoryID <> new.CategoryID) > 0) AND
((SELECT count(*) FROM Products WHERE Products.CategoryID = old.CategoryID) > 0))
  /* erwin Builtin Trigger */
  /* Categories  Products on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00008598", PARENT_OWNER="", PARENT_TABLE="Categories"
    CHILD_OWNER="", CHILD_TABLE="Products"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Products_Categories", FK_COLUMNS="CategoryID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Categories because Products exists.')
 !!


CREATE  TRIGGER tI_CustomerCustome AFTER INSERT ON CustomerCustomerDemo
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Customers WHERE new.CustomerID = Customers.CustomerID) = 0)
)
  /* erwin Builtin Trigger */
  /* Customers  CustomerCustomerDemo on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0000995f", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo_Customers", FK_COLUMNS="CustomerID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert CustomerCustomerDemo because Customers does not exist.')
 !!

CREATE  TRIGGER tI_CustomerCustom2 AFTER INSERT ON CustomerCustomerDemo
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM CustomerDemographics WHERE new.CustomerTypeID = CustomerDemographics.CustomerTypeID) = 0)
)
  /* erwin Builtin Trigger */
  /* CustomerDemographics  CustomerCustomerDemo on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a5b8", PARENT_OWNER="", PARENT_TABLE="CustomerDemographics"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo", FK_COLUMNS="CustomerTypeID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert CustomerCustomerDemo because CustomerDemographics does not exist.')
 !!

CREATE  TRIGGER tU_CustomerCustome NO CASCADE BEFORE UPDATE ON CustomerCustomerDemo
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Customers WHERE new.CustomerID = Customers.CustomerID) = 0)
)
  /* erwin Builtin Trigger */
  /* Customers  CustomerCustomerDemo on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000993e", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo_Customers", FK_COLUMNS="CustomerID" */
       SIGNAL SQLSTATE '75001' ('Cannot update CustomerCustomerDemo because Customers does not exist.')
 !!

CREATE  TRIGGER tU_CustomerCustom2 NO CASCADE BEFORE UPDATE ON CustomerCustomerDemo
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM CustomerDemographics WHERE new.CustomerTypeID = CustomerDemographics.CustomerTypeID) = 0)
)
  /* erwin Builtin Trigger */
  /* CustomerDemographics  CustomerCustomerDemo on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a808", PARENT_OWNER="", PARENT_TABLE="CustomerDemographics"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo", FK_COLUMNS="CustomerTypeID" */
       SIGNAL SQLSTATE '75001' ('Cannot update CustomerCustomerDemo because CustomerDemographics does not exist.')
 !!


CREATE  TRIGGER tD_CustomerDemogra AFTER DELETE ON CustomerDemographics
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM CustomerCustomerDemo WHERE CustomerCustomerDemo.CustomerTypeID = old.CustomerTypeID) > 0)
    /* erwin Builtin Trigger */
    /* CustomerDemographics  CustomerCustomerDemo on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00009e6e", PARENT_OWNER="", PARENT_TABLE="CustomerDemographics"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo", FK_COLUMNS="CustomerTypeID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete CustomerDemographics because CustomerCustomerDemo exists.')
 !!

CREATE  TRIGGER tU_CustomerDemogra NO CASCADE BEFORE UPDATE ON CustomerDemographics
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM CustomerDemographics WHERE CustomerDemographics.CustomerTypeID <> new.CustomerTypeID) > 0) AND
((SELECT count(*) FROM CustomerCustomerDemo WHERE CustomerCustomerDemo.CustomerTypeID = old.CustomerTypeID) > 0))
  /* erwin Builtin Trigger */
  /* CustomerDemographics  CustomerCustomerDemo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000a2c8", PARENT_OWNER="", PARENT_TABLE="CustomerDemographics"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo", FK_COLUMNS="CustomerTypeID" */
       SIGNAL SQLSTATE '75001' ('Cannot update CustomerDemographics because CustomerCustomerDemo exists.')
 !!


CREATE  TRIGGER tD_Customers AFTER DELETE ON Customers
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Orders WHERE Orders.CustomerID = old.CustomerID) > 0)
    /* erwin Builtin Trigger */
    /* Customers  Orders on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="0000904b", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Customers", FK_COLUMNS="CustomerID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Customers because Orders exists.')
 !!

CREATE  TRIGGER tD_Customers2 AFTER DELETE ON Customers
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM CustomerCustomerDemo WHERE CustomerCustomerDemo.CustomerID = old.CustomerID) > 0)
    /* erwin Builtin Trigger */
    /* Customers  CustomerCustomerDemo on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="0000982b", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo_Customers", FK_COLUMNS="CustomerID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Customers because CustomerCustomerDemo exists.')
 !!

CREATE  TRIGGER tU_Customers NO CASCADE BEFORE UPDATE ON Customers
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Customers WHERE Customers.CustomerID <> new.CustomerID) > 0) AND
((SELECT count(*) FROM Orders WHERE Orders.CustomerID = old.CustomerID) > 0))
  /* erwin Builtin Trigger */
  /* Customers  Orders on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000088dc", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Customers", FK_COLUMNS="CustomerID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Customers because Orders exists.')
 !!

CREATE  TRIGGER tU_Customers2 NO CASCADE BEFORE UPDATE ON Customers
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Customers WHERE Customers.CustomerID <> new.CustomerID) > 0) AND
((SELECT count(*) FROM CustomerCustomerDemo WHERE CustomerCustomerDemo.CustomerID = old.CustomerID) > 0))
  /* erwin Builtin Trigger */
  /* Customers  CustomerCustomerDemo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00009841", PARENT_OWNER="", PARENT_TABLE="Customers"
    CHILD_OWNER="", CHILD_TABLE="CustomerCustomerDemo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_CustomerCustomerDemo_Customers", FK_COLUMNS="CustomerID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Customers because CustomerCustomerDemo exists.')
 !!


CREATE  TRIGGER tD_Employees AFTER DELETE ON Employees
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Orders WHERE Orders.EmployeeID = old.EmployeeID) > 0)
    /* erwin Builtin Trigger */
    /* Employees  Orders on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="000086bd", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Employees", FK_COLUMNS="EmployeeID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Employees because Orders exists.')
 !!

CREATE  TRIGGER tD_Employees2 AFTER DELETE ON Employees
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM EmployeeTerritories WHERE EmployeeTerritories.EmployeeID = old.EmployeeID) > 0)
    /* erwin Builtin Trigger */
    /* Employees  EmployeeTerritories on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00009f97", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Employees", FK_COLUMNS="EmployeeID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Employees because EmployeeTerritories exists.')
 !!

CREATE  TRIGGER tD_Employees3 AFTER DELETE ON Employees
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Employees WHERE Employees.ReportsTo = old.EmployeeID) > 0)
    /* erwin Builtin Trigger */
    /* Employees  Employees on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00008c66", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="Employees"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employees_Employees", FK_COLUMNS="ReportsTo" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Employees because Employees exists.')
 !!

CREATE  TRIGGER tI_Employees AFTER INSERT ON Employees
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Employees
      SET
        Employees.ReportsTo = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Employees
            WHERE
              new.ReportsTo = Employees.EmployeeID)
 !!

CREATE  TRIGGER tU_Employees NO CASCADE BEFORE UPDATE ON Employees
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Employees WHERE Employees.EmployeeID <> new.EmployeeID) > 0) AND
((SELECT count(*) FROM Orders WHERE Orders.EmployeeID = old.EmployeeID) > 0))
  /* erwin Builtin Trigger */
  /* Employees  Orders on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000818d", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Employees", FK_COLUMNS="EmployeeID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Employees because Orders exists.')
 !!

CREATE  TRIGGER tU_Employees2 NO CASCADE BEFORE UPDATE ON Employees
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Employees WHERE Employees.EmployeeID <> new.EmployeeID) > 0) AND
((SELECT count(*) FROM EmployeeTerritories WHERE EmployeeTerritories.EmployeeID = old.EmployeeID) > 0))
  /* erwin Builtin Trigger */
  /* Employees  EmployeeTerritories on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00009f11", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Employees", FK_COLUMNS="EmployeeID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Employees because EmployeeTerritories exists.')
 !!

CREATE  TRIGGER tU_Employees3 NO CASCADE BEFORE UPDATE ON Employees
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Employees WHERE Employees.EmployeeID <> new.EmployeeID) > 0) AND
((SELECT count(*) FROM Employees WHERE Employees.ReportsTo = old.EmployeeID) > 0))
  /* erwin Builtin Trigger */
  /* Employees  Employees on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00008cc2", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="Employees"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employees_Employees", FK_COLUMNS="ReportsTo" */
       SIGNAL SQLSTATE '75001' ('Cannot update Employees because Employees exists.')
 !!

CREATE  TRIGGER tU_Employees4 NO CASCADE BEFORE UPDATE ON Employees
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.ReportsTo = NULL
 !!


CREATE  TRIGGER tI_EmployeeTerrito AFTER INSERT ON EmployeeTerritories
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Employees WHERE new.EmployeeID = Employees.EmployeeID) = 0)
)
  /* erwin Builtin Trigger */
  /* Employees  EmployeeTerritories on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a211", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Employees", FK_COLUMNS="EmployeeID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert EmployeeTerritories because Employees does not exist.')
 !!

CREATE  TRIGGER tI_EmployeeTerrit2 AFTER INSERT ON EmployeeTerritories
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Territories WHERE new.TerritoryID = Territories.TerritoryID) = 0)
)
  /* erwin Builtin Trigger */
  /* Territories  EmployeeTerritories on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a0c2", PARENT_OWNER="", PARENT_TABLE="Territories"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Territories", FK_COLUMNS="TerritoryID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert EmployeeTerritories because Territories does not exist.')
 !!

CREATE  TRIGGER tU_EmployeeTerrito NO CASCADE BEFORE UPDATE ON EmployeeTerritories
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Employees WHERE new.EmployeeID = Employees.EmployeeID) = 0)
)
  /* erwin Builtin Trigger */
  /* Employees  EmployeeTerritories on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a286", PARENT_OWNER="", PARENT_TABLE="Employees"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Employees", FK_COLUMNS="EmployeeID" */
       SIGNAL SQLSTATE '75001' ('Cannot update EmployeeTerritories because Employees does not exist.')
 !!

CREATE  TRIGGER tU_EmployeeTerrit2 NO CASCADE BEFORE UPDATE ON EmployeeTerritories
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Territories WHERE new.TerritoryID = Territories.TerritoryID) = 0)
)
  /* erwin Builtin Trigger */
  /* Territories  EmployeeTerritories on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000a493", PARENT_OWNER="", PARENT_TABLE="Territories"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Territories", FK_COLUMNS="TerritoryID" */
       SIGNAL SQLSTATE '75001' ('Cannot update EmployeeTerritories because Territories does not exist.')
 !!


CREATE  TRIGGER tI_Order_Details AFTER INSERT ON Order_Details
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Products WHERE new.ProductID = Products.ProductID) = 0)
)
  /* erwin Builtin Trigger */
  /* Products  Order_Details on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="00009772", PARENT_OWNER="", PARENT_TABLE="Products"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Products", FK_COLUMNS="ProductID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert Order_Details because Products does not exist.')
 !!

CREATE  TRIGGER tI_Order_Details2 AFTER INSERT ON Order_Details
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Orders WHERE new.OrderID = Orders.OrderID) = 0)
)
  /* erwin Builtin Trigger */
  /* Orders  Order_Details on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0000933f", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Orders", FK_COLUMNS="OrderID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert Order_Details because Orders does not exist.')
 !!

CREATE  TRIGGER tU_Order_Details NO CASCADE BEFORE UPDATE ON Order_Details
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Products WHERE new.ProductID = Products.ProductID) = 0)
)
  /* erwin Builtin Trigger */
  /* Products  Order_Details on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="000096b5", PARENT_OWNER="", PARENT_TABLE="Products"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Products", FK_COLUMNS="ProductID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Order_Details because Products does not exist.')
 !!

CREATE  TRIGGER tU_Order_Details2 NO CASCADE BEFORE UPDATE ON Order_Details
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Orders WHERE new.OrderID = Orders.OrderID) = 0)
)
  /* erwin Builtin Trigger */
  /* Orders  Order_Details on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00009240", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Orders", FK_COLUMNS="OrderID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Order_Details because Orders does not exist.')
 !!


CREATE  TRIGGER tD_Orders AFTER DELETE ON Orders
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Order_Details WHERE Order_Details.OrderID = old.OrderID) > 0)
    /* erwin Builtin Trigger */
    /* Orders  Order_Details on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00009192", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Orders", FK_COLUMNS="OrderID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Orders because Order_Details exists.')
 !!

CREATE  TRIGGER tI_Orders AFTER INSERT ON Orders
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Orders
      SET
        Orders.ShipVia = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Shippers
            WHERE
              new.ShipVia = Shippers.ShipperID)
 !!

CREATE  TRIGGER tI_Orders2 AFTER INSERT ON Orders
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Orders
      SET
        Orders.EmployeeID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Employees
            WHERE
              new.EmployeeID = Employees.EmployeeID)
 !!

CREATE  TRIGGER tI_Orders3 AFTER INSERT ON Orders
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Orders
      SET
        Orders.CustomerID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Customers
            WHERE
              new.CustomerID = Customers.CustomerID)
 !!

CREATE  TRIGGER tU_Orders NO CASCADE BEFORE UPDATE ON Orders
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Orders WHERE Orders.OrderID <> new.OrderID) > 0) AND
((SELECT count(*) FROM Order_Details WHERE Order_Details.OrderID = old.OrderID) > 0))
  /* erwin Builtin Trigger */
  /* Orders  Order_Details on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00008e28", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Orders", FK_COLUMNS="OrderID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Orders because Order_Details exists.')
 !!

CREATE  TRIGGER tU_Orders2 NO CASCADE BEFORE UPDATE ON Orders
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.ShipVia = NULL
 !!

CREATE  TRIGGER tU_Orders3 NO CASCADE BEFORE UPDATE ON Orders
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.EmployeeID = NULL
 !!

CREATE  TRIGGER tU_Orders4 NO CASCADE BEFORE UPDATE ON Orders
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.CustomerID = NULL
 !!


CREATE  TRIGGER tD_Products AFTER DELETE ON Products
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Order_Details WHERE Order_Details.ProductID = old.ProductID) > 0)
    /* erwin Builtin Trigger */
    /* Products  Order_Details on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00009264", PARENT_OWNER="", PARENT_TABLE="Products"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Products", FK_COLUMNS="ProductID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Products because Order_Details exists.')
 !!

CREATE  TRIGGER tI_Products AFTER INSERT ON Products
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Products
      SET
        Products.SupplierID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Suppliers
            WHERE
              new.SupplierID = Suppliers.SupplierID)
 !!

CREATE  TRIGGER tI_Products2 AFTER INSERT ON Products
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
    UPDATE Products
      SET
        Products.CategoryID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Categories
            WHERE
              new.CategoryID = Categories.CategoryID)
 !!

CREATE  TRIGGER tU_Products NO CASCADE BEFORE UPDATE ON Products
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Products WHERE Products.ProductID <> new.ProductID) > 0) AND
((SELECT count(*) FROM Order_Details WHERE Order_Details.ProductID = old.ProductID) > 0))
  /* erwin Builtin Trigger */
  /* Products  Order_Details on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00009557", PARENT_OWNER="", PARENT_TABLE="Products"
    CHILD_OWNER="", CHILD_TABLE="Order_Details"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Details_Products", FK_COLUMNS="ProductID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Products because Order_Details exists.')
 !!

CREATE  TRIGGER tU_Products2 NO CASCADE BEFORE UPDATE ON Products
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.SupplierID = NULL
 !!

CREATE  TRIGGER tU_Products3 NO CASCADE BEFORE UPDATE ON Products
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
      SET new.CategoryID = NULL
 !!


CREATE  TRIGGER tD_Region AFTER DELETE ON Region
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Territories WHERE Territories.RegionID = old.RegionID) > 0)
    /* erwin Builtin Trigger */
    /* Region  Territories on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00008bf9", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Territories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Territories_Region", FK_COLUMNS="RegionID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Region because Territories exists.')
 !!

CREATE  TRIGGER tU_Region NO CASCADE BEFORE UPDATE ON Region
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Region WHERE Region.RegionID <> new.RegionID) > 0) AND
((SELECT count(*) FROM Territories WHERE Territories.RegionID = old.RegionID) > 0))
  /* erwin Builtin Trigger */
  /* Region  Territories on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00008949", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Territories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Territories_Region", FK_COLUMNS="RegionID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Region because Territories exists.')
 !!


CREATE  TRIGGER tD_Shippers AFTER DELETE ON Shippers
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Orders WHERE Orders.ShipVia = old.ShipperID) > 0)
    /* erwin Builtin Trigger */
    /* Shippers  Orders on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00008189", PARENT_OWNER="", PARENT_TABLE="Shippers"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Shippers", FK_COLUMNS="ShipVia" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Shippers because Orders exists.')
 !!

CREATE  TRIGGER tU_Shippers NO CASCADE BEFORE UPDATE ON Shippers
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Shippers WHERE Shippers.ShipperID <> new.ShipperID) > 0) AND
((SELECT count(*) FROM Orders WHERE Orders.ShipVia = old.ShipperID) > 0))
  /* erwin Builtin Trigger */
  /* Shippers  Orders on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000844c", PARENT_OWNER="", PARENT_TABLE="Shippers"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Orders_Shippers", FK_COLUMNS="ShipVia" */
       SIGNAL SQLSTATE '75001' ('Cannot update Shippers because Orders exists.')
 !!


CREATE  TRIGGER tD_Suppliers AFTER DELETE ON Suppliers
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM Products WHERE Products.SupplierID = old.SupplierID) > 0)
    /* erwin Builtin Trigger */
    /* Suppliers  Products on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="00008b86", PARENT_OWNER="", PARENT_TABLE="Suppliers"
    CHILD_OWNER="", CHILD_TABLE="Products"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Products_Suppliers", FK_COLUMNS="SupplierID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Suppliers because Products exists.')
 !!

CREATE  TRIGGER tU_Suppliers NO CASCADE BEFORE UPDATE ON Suppliers
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Suppliers WHERE Suppliers.SupplierID <> new.SupplierID) > 0) AND
((SELECT count(*) FROM Products WHERE Products.SupplierID = old.SupplierID) > 0))
  /* erwin Builtin Trigger */
  /* Suppliers  Products on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00008c91", PARENT_OWNER="", PARENT_TABLE="Suppliers"
    CHILD_OWNER="", CHILD_TABLE="Products"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Products_Suppliers", FK_COLUMNS="SupplierID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Suppliers because Products exists.')
 !!


CREATE  TRIGGER tD_Territories AFTER DELETE ON Territories
   REFERENCING OLD AS OLD FOR EACH ROW MODE DB2SQL
WHEN ((SELECT count(*) FROM EmployeeTerritories WHERE EmployeeTerritories.TerritoryID = old.TerritoryID) > 0)
    /* erwin Builtin Trigger */
    /* Territories  EmployeeTerritories on parent delete no action */
  /* ERWIN_RELATION:CHECKSUM="0000a294", PARENT_OWNER="", PARENT_TABLE="Territories"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Territories", FK_COLUMNS="TerritoryID" */
     SIGNAL SQLSTATE '75001' ('Cannot delete Territories because EmployeeTerritories exists.')
 !!

CREATE  TRIGGER tI_Territories AFTER INSERT ON Territories
   REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Region WHERE new.RegionID = Region.RegionID) = 0)
)
  /* erwin Builtin Trigger */
  /* Region  Territories on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="00008a1d", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Territories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Territories_Region", FK_COLUMNS="RegionID" */
       SIGNAL SQLSTATE '75001' ('Cannot insert Territories because Region does not exist.')
 !!

CREATE  TRIGGER tU_Territories NO CASCADE BEFORE UPDATE ON Territories
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Territories WHERE Territories.TerritoryID <> new.TerritoryID) > 0) AND
((SELECT count(*) FROM EmployeeTerritories WHERE EmployeeTerritories.TerritoryID = old.TerritoryID) > 0))
  /* erwin Builtin Trigger */
  /* Territories  EmployeeTerritories on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00009d1c", PARENT_OWNER="", PARENT_TABLE="Territories"
    CHILD_OWNER="", CHILD_TABLE="EmployeeTerritories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_EmployeeTerritories_Territories", FK_COLUMNS="TerritoryID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Territories because EmployeeTerritories exists.')
 !!

CREATE  TRIGGER tU_Territories2 NO CASCADE BEFORE UPDATE ON Territories
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW MODE DB2SQL
WHEN (((SELECT count(*) FROM Region WHERE new.RegionID = Region.RegionID) = 0)
)
  /* erwin Builtin Trigger */
  /* Region  Territories on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00008cab", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Territories"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Territories_Region", FK_COLUMNS="RegionID" */
       SIGNAL SQLSTATE '75001' ('Cannot update Territories because Region does not exist.')
 !!


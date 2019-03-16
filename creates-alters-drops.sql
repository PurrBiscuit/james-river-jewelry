/* The order of the DROP TABLE statements matters in this file;
this ensures that the child tables in the foreign key constraints
are dropped before the parents tables are. */

IF OBJECT_ID('dbo.TAX_RATES', 'U') IS NOT NULL
DROP TABLE dbo.TAX_RATES;

CREATE TABLE TAX_RATES(
	TaxRateID 				uniqueidentifier 	NOT NULL,
	TaxRateDescription 		varchar(100) 		NOT NULL,
	TaxRatePercentage 		tinyint 			NOT NULL,
	CONSTRAINT PK_TaxRateID PRIMARY KEY(TaxRateID)
);

IF OBJECT_ID('dbo.ACTIVE_REWARDS', 'U') IS NOT NULL
DROP TABLE dbo.ACTIVE_REWARDS;

CREATE TABLE ACTIVE_REWARDS(
	ActiveRewardID 		uniqueidentifier 	NOT NULL,
	ActiveCustomerID 	uniqueidentifier 	NOT NULL,
	ActiveDateEarned 	date 				NOT NULL,
	ActiveAmount 		smallint 			NOT NULL,
	ExpiryDate 			date 				NOT NULL,
	CONSTRAINT PK_ActiveRewardID PRIMARY KEY(ActiveRewardID)
);

IF OBJECT_ID('dbo.HISTORIC_REWARDS', 'U') IS NOT NULL
DROP TABLE dbo.HISTORIC_REWARDS;

CREATE TABLE HISTORIC_REWARDS(
	HistoricRewardID 	uniqueidentifier 	NOT NULL,
	HistoricCustomerID 	uniqueidentifier 	NOT NULL,
	HistoricDateEarned 	date 				NOT NULL,
	HistoricAmount 		smallint 			NOT NULL,
	DateMigrated 		date 				NOT NULL,
	Expired 			bit 				NOT NULL 	DEFAULT 0,
	CONSTRAINT PK_HistoricRewardID PRIMARY KEY(HistoricRewardID)
);

IF OBJECT_ID('dbo.CUSTOMER_PREFERENCES', 'U') IS NOT NULL
DROP TABLE dbo.CUSTOMER_PREFERENCES;

CREATE TABLE CUSTOMER_PREFERENCES(
	CustomerID 			uniqueidentifier 	NOT NULL,
	ProductTypeID 		uniqueidentifier 	NOT NULL,
	PreferenceWeight 	tinyint 			NULL,
	Artisan 			bit 				NOT NULL 	DEFAULT 1,
	Manufactured 		bit 				NOT NULL 	DEFAULT 0,
	CONSTRAINT PK_CustomerPreferences PRIMARY KEY(CustomerID,ProductTypeID)
);

IF OBJECT_ID('dbo.ARTIST_COMMISSION_HISTORY', 'U') IS NOT NULL
DROP TABLE dbo.ARTIST_COMMISSION_HISTORY;

CREATE TABLE ARTIST_COMMISSION_HISTORY(
	ArtistCommissionHistoryID 				uniqueidentifier 	NOT NULL,
	ArtistID 								uniqueidentifier 	NOT NULL,
	ArtistCommissionHistoryBaseCommission 	tinyint 			NOT NULL,
	ArtistCommissionHistoryDateModified 	datetime 			NOT NULL,
	ArtistCommissionHistoryComments 		varchar(500) 		NULL,
	CONSTRAINT PK_ArtistCommissionHistoryID PRIMARY KEY(ArtistCommissionHistoryID)
);

IF OBJECT_ID('dbo.ORDER_DETAILS', 'U') IS NOT NULL
DROP TABLE dbo.ORDER_DETAILS;

CREATE TABLE ORDER_DETAILS(
	ProductID 			uniqueidentifier 	NOT NULL,
	OrderID 			uniqueidentifier 	NOT NULL,
	OrderLineNumber 	tinyint 			NOT NULL,
	QuantityOrdered 	smallint 			NOT NULL 	DEFAULT 1,
	PriceEach 			smallmoney 			NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY(ProductID,OrderID)
);

IF OBJECT_ID('dbo.ORDERS', 'U') IS NOT NULL
DROP TABLE dbo.ORDERS;

CREATE TABLE ORDERS(
	OrderID 		uniqueidentifier 	NOT NULL,
	CustomerID 		uniqueidentifier 	NOT NULL,
	EmployeeID 		uniqueidentifier 	NOT NULL,
	InvoiceNumber 	int 				NOT NULL,
	OrderDate 		datetime 			NOT NULL,
	PreTaxTotal 	smallmoney 			NOT NULL,
	TaxAmount 		smallmoney 			NOT NULL,
	OrderTotal 		smallmoney 			NOT NULL,
	CONSTRAINT PK_OrderID PRIMARY KEY(OrderID),
	CONSTRAINT AK_InvoiceNumber UNIQUE(InvoiceNumber)
);

IF OBJECT_ID('dbo.MANUFACTURED_PURCHASE_HISTORY', 'U') IS NOT NULL
DROP TABLE dbo.MANUFACTURED_PURCHASE_HISTORY;

CREATE TABLE MANUFACTURED_PURCHASE_HISTORY(
	ManufacturedPurchaseHistoryID 				uniqueidentifier 	NOT NULL,
	ProductID 									uniqueidentifier 	NOT NULL,
	ManufacturedPurchaseHistoryDatePurchased 	datetime 			NOT NULL,
	ManufacturedPurchaseHistoryQuantity 		smallint 			NOT NULL,
	ManufacturedPurchaseHistoryPurchasePrice 	smallmoney 			NOT NULL,
	ManufacturedPurchaseHistoryDateReceived 	datetime 			NULL,
	CONSTRAINT PK_ManufacturedPurchaseHistoryID PRIMARY KEY(ManufacturedPurchaseHistoryID)
);

IF OBJECT_ID('dbo.ARTISAN_PRODUCTS_COMMISSION_HISTORY', 'U') IS NOT NULL
DROP TABLE dbo.ARTISAN_PRODUCTS_COMMISSION_HISTORY;

CREATE TABLE ARTISAN_PRODUCTS_COMMISSION_HISTORY(
	ArtisanProductsCommissionHistoryID 				uniqueidentifier 	NOT NULL,
	ProductID 										uniqueidentifier 	NOT NULL,
	ArtisanProductsCommissionHistoryCommission 		tinyint 			NOT NULL,
	ArtisanProductsCommissionHistoryDateModified 	datetime 			NOT NULL,
	ArtisanProductsCommissionHistoryComments 		varchar(500) 		NULL,
	CONSTRAINT PK_ArtisanProductsCommissionHistoryID PRIMARY KEY(ArtisanProductsCommissionHistoryID)
);

IF OBJECT_ID('dbo.PRODUCT_PRICE_HISTORY', 'U') IS NOT NULL
DROP TABLE dbo.PRODUCT_PRICE_HISTORY;

CREATE TABLE PRODUCT_PRICE_HISTORY(
	ProductPriceHistoryID 				uniqueidentifier 	NOT NULL,
	ProductID 							uniqueidentifier 	NOT NULL,
	ProductPriceHistoryUnitPrice 		smallmoney 			NOT NULL,
	ProductPriceHistoryDateModified 	datetime 			NOT NULL,
	ProductPriceHistoryComments 		varchar(500) 		NULL,
	CONSTRAINT PK_ProductPriceHistory PRIMARY KEY(ProductPriceHistoryID)
);

IF OBJECT_ID('dbo.ARTISAN_PRODUCTS', 'U') IS NOT NULL
DROP TABLE dbo.ARTISAN_PRODUCTS;

CREATE TABLE ARTISAN_PRODUCTS(
	ProductID 						uniqueidentifier 	NOT NULL,
	ArtistID 						uniqueidentifier 	NOT NULL,
	ArtisanProductCommission 		tinyint 			NOT NULL,
	ArtisanProductDateReceived 		datetime 			NOT NULL,
	ArtisanProductDateListed 		datetime 			NULL,
	ArtisanProductDatePurchased 	datetime 			NULL,
	CONSTRAINT PK_ArtisanProductID PRIMARY KEY(ProductID)
);

IF OBJECT_ID('dbo.MANUFACTURED_PRODUCTS', 'U') IS NOT NULL
DROP TABLE dbo.MANUFACTURED_PRODUCTS;

CREATE TABLE MANUFACTURED_PRODUCTS(
	ProductID 			uniqueidentifier 	NOT NULL,
	ManufacturerID 		uniqueidentifier 	NOT NULL,
	QuantityInStock 	smallint 			NOT NULL 	DEFAULT 0,
	MSRP 				smallmoney 			NULL,
	CONSTRAINT PK_ManufacturedProductID PRIMARY KEY(ProductID)
);

IF OBJECT_ID('dbo.PRODUCTS', 'U') IS NOT NULL
DROP TABLE dbo.PRODUCTS;

CREATE TABLE PRODUCTS(
	ProductID 			uniqueidentifier 	NOT NULL,
	ProductTypeID 		uniqueidentifier 	NOT NULL,
	ProductName 		varchar(200) 		NOT NULL,
	UnitPrice 			smallmoney 			NOT NULL,
	IsManufactured 		bit 				NOT NULL 	DEFAULT 0,
	CONSTRAINT PK_ProductID PRIMARY KEY(ProductID)
);

IF OBJECT_ID('dbo.PRODUCT_TYPES', 'U') IS NOT NULL
DROP TABLE dbo.PRODUCT_TYPES;

CREATE TABLE PRODUCT_TYPES(
	ProductTypeID 		uniqueidentifier 	NOT NULL,
	ProductTypeName 	varchar(100) 		NOT NULL,
	CONSTRAINT PK_ProductTypeID PRIMARY KEY(ProductTypeID)
);

IF OBJECT_ID('dbo.CUSTOMERS', 'U') IS NOT NULL
DROP TABLE dbo.CUSTOMERS;

CREATE TABLE CUSTOMERS(
	CustomerID 					uniqueidentifier 	NOT NULL,
	CustomerFirstName 			varchar(100) 		NOT NULL,
	CustomerLastName 			varchar(100) 		NOT NULL,
	CustomerStreetAddress 		varchar(250) 		NULL,
	CustomerStreetAddress2 		varchar(250) 		NULL,
	CustomerCity 				varchar(100) 		NULL,
	CustomerState 				varchar(2) 			NULL,
	CustomerZip 				varchar(10) 		NULL,
	CustomerPhone 				varchar(12) 		NULL,
	CustomerEmail 				varchar(80) 		NOT NULL,
	IsEmailVerified 			bit 				NOT NULL 	DEFAULT 0,
	Gender 						varchar(1) 			NULL,
	BirthDate 					date 				NULL,
	CustomerDateCreated 		datetime 			NOT NULL,
	CustomerDateLastModified 	datetime 			NOT NULL,
	CONSTRAINT PK_CustomerID PRIMARY KEY(CustomerID)
);

IF OBJECT_ID('dbo.ARTISTS', 'U') IS NOT NULL
DROP TABLE dbo.ARTISTS;

CREATE TABLE ARTISTS(
	ArtistID uniqueidentifier NOT NULL,
	ArtistFirstName 		varchar(100) 	NOT NULL,
	ArtistLastName 			varchar(100) 	NOT NULL,
	ArtistStreetAddress 	varchar(250) 	NOT NULL,
	ArtistStreetAddress2 	varchar(250) 	NULL,
	ArtistStreetAddress3 	varchar(250) 	NULL,
	ArtistCity 				varchar(100) 	NOT NULL,
	Region 					varchar(80) 	NULL,
	PostalCode 				varchar(50) 	NOT NULL,
	County 					varchar(80) 	NULL,
	Country 				varchar(2) 		NOT NULL,
	ArtistPhone 			varchar(25) 	NULL,
	ArtistEmail 			varchar(80) 	NOT NULL,
	BaseCommission 			tinyint 		NOT NULL 	DEFAULT 60,
	ArtistDateCreated 		datetime 		NOT NULL,
	ArtistDateLastModified 	datetime 		NOT NULL,
	CONSTRAINT PK_ArtistID PRIMARY KEY(ArtistID)
);

IF OBJECT_ID('dbo.MANUFACTURERS', 'U') IS NOT NULL
DROP TABLE dbo.MANUFACTURERS;

CREATE TABLE MANUFACTURERS(
	ManufacturerID 					uniqueidentifier 	NOT NULL,
	ManufacturerName 				varchar(200) 		NOT NULL,
	ManufacturerStreetAddress 		varchar(250) 		NOT NULL,
	ManufacturerStreetAddress2 		varchar(250) 		NULL,
	ManufacturerCity 				varchar(100) 		NOT NULL,
	ManufacturerState 				varchar(2) 			NOT NULL,
	ManufacturerZip 				varchar(10) 		NOT NULL,
	ManufacturerPhone 				varchar(12) 		NOT NULL,
	ManufacturerEmail 				varchar(80) 		NOT NULL,
	ContactName 					varchar(100) 		NULL,
	ManufacturerDateCreated 		datetime 			NOT NULL,
	ManufacturerDateLastModified 	datetime 			NOT NULL,
	CONSTRAINT PK_ManufacturerID PRIMARY KEY(ManufacturerID)
);

IF OBJECT_ID('dbo.EMPLOYEES', 'U') IS NOT NULL
DROP TABLE dbo.EMPLOYEES;

CREATE TABLE EMPLOYEES(
	EmployeeID 					uniqueidentifier 	NOT NULL,
	EmployeeFirstName 			varchar(100) 		NOT NULL,
	EmployeeLastName 			varchar(100) 		NOT NULL,
	RoleID 						uniqueidentifier 	NOT NULL,
	HireDate 					date 				NOT NULL,
	IsCurrentlyEmployed 		bit 				NOT NULL 	DEFAULT 1,
	EmployeeStreetAddress 		varchar(250) 		NOT NULL,
	EmployeeStreetAddress2 		varchar(250) 		NULL,
	EmployeeCity 				varchar(100) 		NOT NULL,
	EmployeeState 				varchar(2) 			NOT NULL,
	EmployeeZip 				varchar(10) 		NOT NULL,
	EmployeePhone 				varchar(12) 		NOT NULL,
	EmployeeEmail 				varchar(80) 		NOT NULL,
	EmployeeDateCreated 		datetime 			NOT NULL,
	EmployeeDateLastModified 	datetime 			NOT NULL,
	CONSTRAINT PK_EmployeeID PRIMARY KEY(EmployeeID)
);

IF OBJECT_ID('dbo.LOOKUP_STATES', 'U') IS NOT NULL
DROP TABLE dbo.LOOKUP_STATES;

CREATE TABLE LOOKUP_STATES(
	State 		varchar(2) 	NOT NULL,
	StateName 	varchar(30) NOT NULL,
	CONSTRAINT PK_State PRIMARY KEY(State)
);

IF OBJECT_ID('dbo.LOOKUP_COUNTRIES', 'U') IS NOT NULL
DROP TABLE dbo.LOOKUP_COUNTRIES;

CREATE TABLE LOOKUP_COUNTRIES(
	Country 		varchar(2) 		NOT NULL,
	CountryName 	varchar(100) 	NOT NULL,
	CONSTRAINT PK_Country PRIMARY KEY(Country)
);

IF OBJECT_ID('dbo.LOOKUP_EMPLOYEE_ROLES', 'U') IS NOT NULL
DROP TABLE dbo.LOOKUP_EMPLOYEE_ROLES;

CREATE TABLE LOOKUP_EMPLOYEE_ROLES(
	RoleID 		uniqueidentifier 	NOT NULL,
	RoleName 	varchar(50) 		NOT NULL,
	IsAdmin 	bit 				NOT NULL 	DEFAULT 0,
	CONSTRAINT PK_EmployeeRoleID PRIMARY KEY(RoleID)
);

ALTER TABLE ACTIVE_REWARDS
ADD CONSTRAINT FK_ActiveCustomerID
FOREIGN KEY (ActiveCustomerID) REFERENCES CUSTOMERS(CustomerID);

ALTER TABLE ARTISAN_PRODUCTS
ADD CONSTRAINT FK_ArtisanProductsArtistID
FOREIGN KEY (ArtistID) REFERENCES ARTISTS(ArtistID);

ALTER TABLE ARTISAN_PRODUCTS
ADD CONSTRAINT FK_ArtisanProductsProductID
FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID);

ALTER TABLE ARTISAN_PRODUCTS_COMMISSION_HISTORY
ADD CONSTRAINT FK_ArtisanProductsCommissionHistoryProductID
FOREIGN KEY (ProductID) REFERENCES ARTISAN_PRODUCTS(ProductID);

ALTER TABLE ARTIST_COMMISSION_HISTORY
ADD CONSTRAINT FK_ArtistCommissionHistoryProductID
FOREIGN KEY (ArtistID) REFERENCES ARTISTS(ArtistID);

ALTER TABLE ARTISTS
ADD CONSTRAINT FK_ArtistCountry
FOREIGN KEY (Country) REFERENCES LOOKUP_COUNTRIES(Country);

ALTER TABLE CUSTOMER_PREFERENCES
ADD CONSTRAINT FK_CustomerPreferencesCustomerID
FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID);

ALTER TABLE CUSTOMER_PREFERENCES
ADD CONSTRAINT FK_CustomerPreferencesProductTypeID
FOREIGN KEY (ProductTypeID) REFERENCES PRODUCT_TYPES(ProductTypeID);

ALTER TABLE CUSTOMERS
ADD CONSTRAINT FK_CustomerState
FOREIGN KEY (CustomerState) REFERENCES LOOKUP_STATES(State);

ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EmployeeState
FOREIGN KEY (EmployeeState) REFERENCES LOOKUP_STATES(State);

ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EmployeeRoleID
FOREIGN KEY (RoleID) REFERENCES LOOKUP_EMPLOYEE_ROLES(RoleID);

ALTER TABLE HISTORIC_REWARDS
ADD CONSTRAINT FK_HistoricCustomerID
FOREIGN KEY (HistoricCustomerID) REFERENCES CUSTOMERS(CustomerID);

ALTER TABLE MANUFACTURERS
ADD CONSTRAINT FK_ManufacturerState
FOREIGN KEY (ManufacturerState) REFERENCES LOOKUP_STATES(State);

ALTER TABLE MANUFACTURED_PRODUCTS
ADD CONSTRAINT FK_ManufacturedProductsManufacturerID
FOREIGN KEY (ManufacturerID) REFERENCES MANUFACTURERS(ManufacturerID);

ALTER TABLE MANUFACTURED_PRODUCTS
ADD CONSTRAINT FK_ManufacturedProductsProductID
FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID);

ALTER TABLE MANUFACTURED_PURCHASE_HISTORY
ADD CONSTRAINT FK_ManufacturedPurchaseHistoryProductID
FOREIGN KEY (ProductID) REFERENCES MANUFACTURED_PRODUCTS(ProductID);

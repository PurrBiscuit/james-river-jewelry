DROP TABLE IF EXISTS ACTIVE_REWARDS;

CREATE TABLE ACTIVE_REWARDS(
	ActiveRewardID uniqueidentifier NOT NULL,
	ActiveCustomerID uniqueidentifier NOT NULL,
	ActiveDateEarned date NOT NULL,
	ActiveAmount smallint NOT NULL,
	ExpiryDate date NOT NULL,
	CONSTRAINT PK_ActiveRewardID PRIMARY KEY(ActiveRewardID)
);

DROP TABLE IF EXISTS HISTORIC_REWARDS;

CREATE TABLE HISTORIC_REWARDS(
	HistoricRewardID uniqueidentifier NOT NULL,
	HistoricCustomerID uniqueidentifier NOT NULL,
	HistoricDateEarned date NOT NULL,
	HistoricAmount smallint NOT NULL,
	DateMigrated date NOT NULL,
	Expired bit NOT NULL,
	CONSTRAINT PK_HistoricRewardID PRIMARY KEY(HistoricRewardID)
);

DROP TABLE IF EXISTS LOOKUP_STATES;

CREATE TABLE LOOKUP_STATES(
	State varchar(2) NOT NULL,
	StateName varchar(30) NOT NULL,
	CONSTRAINT PK_State PRIMARY KEY(State)
);

DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE CUSTOMERS(
	CustomerID uniqueidentifier NOT NULL,
	CustomerFirstName varchar(100) NOT NULL,
	CustomerLastName varchar(100) NOT NULL,
	CustomerStreetAddress varchar(250) NULL,
	CustomerStreetAddress2 varchar(250) NULL,
	CustomerCity varchar(100) NULL,
	CustomerState varchar(2) NULL,
	CustomerZip varchar(10) NULL,
	CustomerPhone varchar(12) NULL,
	CustomerEmail varchar(80) NOT NULL,
	IsEmailVerified bit NOT NULL,
	Gender varchar(1) NULL,
	BirthDate date NULL,
	CustomerDateCreated datetime NOT NULL,
	CustomerDateLastModified datetime NOT NULL,
	CONSTRAINT PK_CustomerID PRIMARY KEY(CustomerID)
);

DROP TABLE IF EXISTS ORDERS;

CREATE TABLE ORDERS(
	OrderID int IDENTITY(1000,1),
	CustomerID uniqueidentifier NOT NULL,
	EmployeeID uniqueidentifier NOT NULL,
	OrderDate datetime NOT NULL,
	PreTaxTotal smallmoney NOT NULL,
	TaxAmount smallmoney NOT NULL,
	OrderTotal smallmoney NOT NULL,
	CONSTRAINT PK_OrderID PRIMARY KEY(OrderID)
);

DROP TABLE IF EXISTS CUSTOMER_PREFERENCES;

CREATE TABLE CUSTOMER_PREFERENCES(
	CustomerID uniqueidentifier NOT NULL,
	ProductTypeID uniqueidentifier NOT NULL,
	PreferenceWeight tinyint NULL,
	Artisan bit NOT NULL,
	Manufactured bit NOT NULL,
	CONSTRAINT PK_CustomerPreferences PRIMARY KEY(CustomerID,ProductTypeID)
);

DROP TABLE IF EXISTS PRODUCT_TYPES;

CREATE TABLE PRODUCT_TYPES(
	ProductTypeID uniqueidentifier NOT NULL,
	ProductTypeName varchar(100) NOT NULL,
	CONSTRAINT PK_ProductTypeID PRIMARY KEY(ProductTypeID)
);

DROP TABLE IF EXISTS ARTISTS;

CREATE TABLE ARTISTS(
	ArtistID uniqueidentifier NOT NULL,
	ArtistFirstName varchar(100) NOT NULL,
	ArtistLastName varchar(100) NOT NULL,
	ArtistStreetAddress varchar(250) NOT NULL,
	ArtistStreetAddress2 varchar(250) NULL,
	ArtistStreetAddress3 varchar(250) NULL,
	ArtistCity varchar(100) NOT NULL,
	Region varchar(80) NULL,
	PostalCode varchar(50) NOT NULL,
	County varchar(80) NULL,
	Country varchar(2) NOT NULL,
	ArtistPhone varchar(25) NULL,
	ArtistEmail varchar(80) NOT NULL,
	BaseCommission tinyint NOT NULL,
	ArtistDateCreated datetime NOT NULL,
	ArtistDateLastModified datetime NOT NULL,
	CONSTRAINT PK_ArtistID PRIMARY KEY(ArtistID)
);

DROP TABLE IF EXISTS LOOKUP_COUNTRIES;

CREATE TABLE LOOKUP_COUNTRIES(
	Country varchar(2) NOT NULL,
	CountryName varchar(100) NOT NULL,
	CONSTRAINT PK_Country PRIMARY KEY(Country)
);

DROP TABLE IF EXISTS ARTIST_COMMISSION_HISTORY;

CREATE TABLE ARTIST_COMMISSION_HISTORY(
	ArtistCommissionHistoryID uniqueidentifier NOT NULL,
	ArtistID uniqueidentifier NOT NULL,
	ArtistCommissionHistoryBaseCommission tinyint NOT NULL,
	ArtistCommissionHistoryDateModified datetime NOT NULL,
	ArtistCommissionHistoryComments varchar(500) NULL,
	CONSTRAINT PK_ArtistCommissionHistoryID PRIMARY KEY(ArtistCommissionHistoryID)
);

DROP TABLE IF EXISTS ORDER_DETAILS;

CREATE TABLE ORDER_DETAILS(
	ProductID uniqueidentifier NOT NULL,
	OrderID int NOT NULL,
	OrderLineNumber tinyint NOT NULL,
	QuantityOrdered smallint NOT NULL,
	PriceEach smallmoney NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY(ProductID,OrderID)
);

DROP TABLE IF EXISTS PRODUCTS;

CREATE TABLE PRODUCTS(
	ProductID uniqueidentifier NOT NULL,
	ProductTypeID uniqueidentifier NOT NULL,
	ProductName varchar(200) NOT NULL,
	UnitPrice smallmoney NOT NULL,
	IsManufactured bit NOT NULL,
	CONSTRAINT PK_ProductID PRIMARY KEY(ProductID)
);

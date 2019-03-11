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

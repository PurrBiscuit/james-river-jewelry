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
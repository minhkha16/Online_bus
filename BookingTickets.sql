USE MASTER
GO

DROP DATABASE IF EXISTS BOOKINGTICKET
CREATE DATABASE BOOKINGTICKET
GO

USE BOOKINGTICKET
GO

DROP TABLE IF EXISTS Account
CREATE TABLE Account
(
	Id INT PRIMARY KEY IDENTITY,
	FullName VARCHAR(50) ,
	DoB DateTime ,
	[Address] VARCHAR(50) ,
	Email VARCHAR(50),
	[Password] VARCHAR(250) ,
	Phone VARCHAR(20) ,
	[Level] TINYINT ,
	[Status] bit ,
	SecurityCode varchar(10),
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS CategoryCar
CREATE TABLE CategoryCar
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS Chair
CREATE TABLE Chair
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS Car
CREATE TABLE Car
(
	LicensePlates VARCHAR(20) PRIMARY KEY,
	NameCar VARCHAR(80),
	RegistrationDate Date Default GETDATE(),
	IdCategory INT ,
	CreateAt DATE Default GETDATE(),
	UpdateAt DATE Default GETDATE(),
)
GO

DROP TABLE IF EXISTS ChairCar
CREATE TABLE ChairCar
(
	Id INT PRIMARY KEY IDENTITY,
	[Status] BIT,
	Price INT,
	IdChair INT,
	IdAccount INT,
	IdTimeLine Int,
	IdCar VARCHAR(20),
	DateBook Date,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

GO

DROP TABLE IF EXISTS InvoiceCar
CREATE TABLE InvoiceCar
(
	Id INT PRIMARY KEY IDENTITY,
	[Date] Date,
	Note VARCHAR(250) ,
	Total INT,
	IdAccount INT,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS Freeway
CREATE TABLE Freeway
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) ,
	IdFrom INT ,
	IdTo INT ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS PlaceFrom
CREATE TABLE PlaceFrom
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) ,
)
GO
DROP TABLE IF EXISTS PlaceTo
CREATE TABLE PlaceTo
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) ,
)
GO


DROP TABLE IF EXISTS [TimeLine]
CREATE TABLE [TimeLine]
(
	Id INT PRIMARY KEY IDENTITY,
	[Line] VARCHAR(50) ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

------------------------------------------------DISCOUNT
DROP TABLE IF EXISTS Discount
CREATE TABLE Discount
(
	Id INT PRIMARY KEY IDENTITY,
	Content VARCHAR(250) ,
	Price INT ,
	[Status] bit , 
	DateEnd Date ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS DiscountDetail
CREATE TABLE DiscountDetail
(
	Id INT PRIMARY KEY IDENTITY,
	IdAccount INT ,
	IdDiscount INT ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

--------------------------------------------------DISCOUNT

DROP TABLE IF EXISTS Shipping
CREATE TABLE Shipping
(
	Id INT PRIMARY KEY IDENTITY,
Pakage VARCHAR(50) ,
	[Weight] INT default 0,
	Price INT default 0,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS InvoiceShipping
CREATE TABLE InvoiceShipping
(
	Id INT PRIMARY KEY IDENTITY,
	--Recipient
	RecipientName VARCHAR(50) ,
	RecipientPhone VARCHAR(20) ,
	RecipientAddress VARCHAR(20) ,
	--Delivery
	DeliveryName VARCHAR(50) ,
	DeliveryPhone VARCHAR(20) ,
	DeliveryAddress VARCHAR(20) ,
	IdAccount INT ,
	IdShipping INT ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS WorkSchedule
CREATE TABLE WorkSchedule
(
	Id INT PRIMARY KEY IDENTITY,
	WorkDay DATE ,
	IdTimeLine INT ,
	IdFreeway INT ,
	IdAccount INT ,
	IdCar VARCHAR(20) ,
	[Status] VARCHAR(50),
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)
GO

DROP TABLE IF EXISTS InvoiceDetailCar
CREATE TABLE InvoiceDetailCar
(
	Id INT PRIMARY KEY IDENTITY,
	IdChairCar INT ,
	IdIvoiceCar INT ,
	Quantity INT ,
	CreateAt Date Default GETDATE(),
	UpdateAt Date Default GETDATE(),
)


ALTER TABLE WorkSchedule
ADD CONSTRAINT FK_WorkSchedule_Account
FOREIGN KEY(IdAccount)
REFERENCES Account(Id)
GO

ALTER TABLE WorkSchedule
ADD CONSTRAINT FK_WorkSchedule_TimeLine
FOREIGN KEY(IdTimeLine)
REFERENCES [TimeLine](Id)
GO

ALTER TABLE WorkSchedule
ADD CONSTRAINT FK_WorkSchedule_Freeway
FOREIGN KEY(IdFreeway)
REFERENCES Freeway(Id)
GO

ALTER TABLE Freeway
ADD CONSTRAINT FK_Freeway_PlaceFrom
FOREIGN KEY(IdFrom)
REFERENCES PlaceFrom(Id)
GO

ALTER TABLE Freeway
ADD CONSTRAINT FK_Freeway_PlaceTo
FOREIGN KEY(IdTo)
REFERENCES PlaceTo(Id)
GO

ALTER TABLE WorkSchedule
ADD CONSTRAINT FK_WorkSchedule_Car
FOREIGN KEY(IdCar)
REFERENCES Car(LicensePlates)
GO

ALTER TABLE Car
ADD CONSTRAINT FK_Car_Category_Car
FOREIGN KEY(IdCategory)
REFERENCES CategoryCar(Id)
GO

ALTER TABLE ChairCar
ADD CONSTRAINT FK_ChairCar_Car
FOREIGN KEY(IdCar)
REFERENCES Car(LicensePlates)
GO

ALTER TABLE ChairCar
ADD CONSTRAINT FK_ChairCar_Chair
FOREIGN KEY(IdChair)
REFERENCES Chair(Id)
GO

ALTER TABLE ChairCar
ADD CONSTRAINT FK_ChairCar_TimeLine
FOREIGN KEY(IdTimeLine)
REFERENCES TimeLine(Id)
GO


ALTER TABLE InvoiceDetailCar
ADD CONSTRAINT FK_InvoiceDetailCar_ChairCar
FOREIGN KEY (IdChairCar)
REFERENCES ChairCar(Id)
GO

ALTER TABLE InvoiceDetailCar
ADD CONSTRAINT FK_InvoiceDetailCar_InvoiceCar
FOREIGN KEY(IdIvoiceCar)
REFERENCES InvoiceCar(Id)
GO

ALTER TABLE InvoiceCar
ADD CONSTRAINT FK_InvoiceCar_Account
FOREIGN KEY(IdAccount)
REFERENCES Account(Id)
GO

ALTER TABLE InvoiceShipping
ADD CONSTRAINT FK_InvoiceShipping_Account
FOREIGN KEY(IdAccount)
REFERENCES Account(Id)
GO

ALTER TABLE InvoiceShipping
ADD CONSTRAINT FK_InvoiceShipping_Shipping
FOREIGN KEY(IdShipping)
REFERENCES Shipping(Id)
GO

ALTER TABLE DiscountDetail
ADD CONSTRAINT FK_DiscountDetail_Account
FOREIGN KEY(IdAccount)
REFERENCES Account(Id)
GO

ALTER TABLE DiscountDetail
ADD CONSTRAINT FK_DiscountDetail_Discount
FOREIGN KEY(IdDiscount)
REFERENCES Discount(Id)
GO
CREATE DATABASE Circle_JavaProject2
GO

USE Circle_JavaProject2
GO

CREATE TABLE Notification (
	NotiNo INT IDENTITY PRIMARY KEY,
	NotiSubject VARCHAR(255),
	NotiContent VARCHAR(255) 
)
GO

CREATE TABLE Shelf (
	ShelfNo INT IDENTITY PRIMARY KEY,
	Location VARCHAR(255) 
)
GO

CREATE TABLE BookDetail (
	BookNo INT IDENTITY PRIMARY KEY,
	Title VARCHAR(255),
	Publisher VARCHAR(255),
	Author VARCHAR(100),
	ISBN VARCHAR(13),
	Pages INT,
	ShelfNo INT REFERENCES Shelf (ShelfNo),
	YPublished DATE,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Category (
	CategoryNo INT IDENTITY PRIMARY KEY,
	BookNo INT REFERENCES BookDetail(BookNo),
	CategoryName VARCHAR(100)
)
GO

CREATE TABLE BookItem (
	BookItemNo INT IDENTITY,
	BookNo INT REFERENCES BookDetail (BookNo),
	BookID VARCHAR(10) PRIMARY KEY,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Account (
	AccountNo INT IDENTITY,
	AccountName VARCHAR(100),
	LibraryID VARCHAR(10) PRIMARY KEY,
	Password VARCHAR(20),
	IsAdmin BIT,
	DJoined DATE  DEFAULT GETDATE(),
	DExpired DATE,
	Point INT DEFAULT 100,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE ImageLink (
	ImgNo INT IDENTITY PRIMARY KEY,
	BookNo INT REFERENCES BookDetail (BookNo),
	Link VARCHAR(255),
	IsCover BIT,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Reservation (
	ReserveNo INT IDENTITY PRIMARY KEY,
	LibraryID VARCHAR(10) REFERENCES Account (LibraryID),
	BookID VARCHAR(10) REFERENCES BookItem (BookID),
	DReserve DATE,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE LendingHistory (
	LendNo INT IDENTITY PRIMARY KEY,
	LibraryID VARCHAR(10) REFERENCES Account (LibraryID),
	BookID VARCHAR(10) REFERENCES BookItem (BookID),
	DIssued DATE DEFAULT GETDATE(),
	D_EstReturn DATE DEFAULT DATEADD(day, 30, GETDATE()),
	DReturned DATE,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Fine (
	FineNo INT IDENTITY PRIMARY KEY,
	LendNo INT REFERENCES LendingHistory (LendNo),
	OverduedDate INT,
	FineAmount INT 
)
GO

CREATE TRIGGER InsertNewBook ON BookDetail
INSTEAD OF INSERT
AS BEGIN
	INSERT INTO BookDetail(Title, Publisher, Author, ISBN, Pages)
	SELECT i.Title, i.Publisher, i.Author, i.ISBN, i.Pages
	FROM inserted i
	WHERE i.ISBN NOT IN (SELECT ISBN FROM BookDetail)
END
GO

CREATE TRIGGER DeleteBook ON BookDetail
INSTEAD OF DELETE
AS BEGIN
	UPDATE BookDetail
	SET Status = 0;
END
GO

CREATE PROC DisplayAllBook
AS BEGIN
	SELECT * FROM BookDetail
END
GO

CREATE PROC DisplayBookCover (@BookNo int)
AS BEGIN
	SELECT * FROM ImageLink
	WHERE BookNo = @BookNo AND IsCover = 1
END
GO

CREATE TRIGGER FineBook ON Fine
FOR INSERT
AS BEGIN

	INSERT INTO Fine(LendNo, OverduedDate, FineAmount)
	SELECT LendNo, DATEDIFF(day, GETDATE(), DIssued), DATEDIFF(day, GETDATE(), D_EstReturn)*5
	FROM LendingHistory
	WHERE DATEDIFF(day, GETDATE(), DIssued) > 30 AND Status = 1 AND LendNo NOT IN (SELECT LendNo FROM Fine)
END
GO

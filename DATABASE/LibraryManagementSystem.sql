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
	Copies INT DEFAULT 1,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Category (
	CategoryNo INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(100)
)
GO

CREATE TABLE BookCategory (
	CategoryNo INT REFERENCES Category(CategoryNo),
	BookNo INT REFERENCES BookDetail(BookNo)
	PRIMARY KEY (CategoryNo, BookNo)
)
GO

CREATE TABLE BookItem (
	BookItemNo INT IDENTITY,
	BookNo INT REFERENCES BookDetail (BookNo),
	BookID VARCHAR(15) PRIMARY KEY,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE BookDescription (
	BookNo INT REFERENCES BookDetail(BookNo) PRIMARY KEY,
	Description VARCHAR(max) NOT NULL
)
GO

CREATE TABLE Account (
	AccountNo INT IDENTITY,
	AccountName VARCHAR(100),
	LibraryID VARCHAR(10) PRIMARY KEY,
	Password VARCHAR(20),
	Email VARCHAR(255),
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
	BookID VARCHAR(15) REFERENCES BookItem (BookID),
	DReserve DATE,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE LendingHistory (
	LendNo INT IDENTITY PRIMARY KEY,
	LibraryID VARCHAR(10) REFERENCES Account (LibraryID),
	BookID VARCHAR(15) REFERENCES BookItem (BookID),
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
	INSERT INTO BookDetail(Title, Publisher, YPublished, ShelfNo, Author, ISBN, Pages)
	SELECT i.Title, i.Publisher, i.YPublished, i.ShelfNo, i.Author, i.ISBN, i.Pages
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
	SELECT Link FROM ImageLink
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

CREATE TRIGGER DefineBookID ON BookItem
FOR INSERT
AS BEGIN
	DECLARE @BookNo INT,
			@YAdd DATE,
			@MAdd DATE,
			@Count INT,
			@Copies INT,
			@BookID VARCHAR(10)
	
	SET @YAdd = RIGHT(YEAR(GETDATE()),4);
	SET @MAdd = RIGHT(MONTH(GETDATE()),2);
	SET @Count = 1;
	SET @Copies = (SELECT Copies FROM BookDetail);
	
	WHILE (@Count <= @Copies)
	BEGIN
		SET @BookID = CONCAT(@YAdd,@MAdd,'-',@BookNo, '-', @Count);
		INSERT INTO BookItem(BookID) VALUES (@BookID);

		SET @Count = @Count +1;
	END
END
GO

CREATE TRIGGER DefineLibraryID ON Account
FOR INSERT
AS BEGIN
	DECLARE @AccountNo INT,
			@YAdd DATE,
			@MAdd DATE,
			@Char VARCHAR(3),
			@Index INT,
			@Count INT,
			@LibraryID VARCHAR(10)

	SET @Count = @AccountNo%999 + 1;
	SET @Index = @AccountNo/999;
	SET @Char = CHAR(65 + @Index);
	SET @YAdd = RIGHT(YEAR(GETDATE()),4);
	SET @MAdd = RIGHT(MONTH(GETDATE()),2);
	SET @LibraryID = CONCAT(@YAdd,@MAdd,@Char,@Count);

	INSERT INTO Account(LibraryID) VALUES (@LibraryID)
END
GO

CREATE PROC LoadCategory
AS BEGIN
	SELECT * FROM Category
	ORDER BY CategoryName ASC
END
GO	

CREATE PROC ShelfLocation (@ShelfNo int)
AS BEGIN
	SELECT Location FROM Shelf
	WHERE ShelfNo = @ShelfNo
END
GO

/*========= TABLE CATEGORY =========*/
INSERT INTO Category(CategoryName) VALUES ('Architecture')
INSERT INTO Category(CategoryName) VALUES ('Arts & Photography')
INSERT INTO Category(CategoryName) VALUES ('Biograpies & Memoir')
INSERT INTO Category(CategoryName) VALUES ('Business & Investing')
INSERT INTO Category(CategoryName) VALUES ('Children''s Book')
INSERT INTO Category(CategoryName) VALUES ('Computers & Technology')
INSERT INTO Category(CategoryName) VALUES ('Cookbooks, Foods & Wines')
INSERT INTO Category(CategoryName) VALUES ('Crafts, Hobbies & Home')
INSERT INTO Category(CategoryName) VALUES ('Drawing & Painting')
INSERT INTO Category(CategoryName) VALUES ('Fashion')
INSERT INTO Category(CategoryName) VALUES ('History')
INSERT INTO Category(CategoryName) VALUES ('Humor & Entertainment')
INSERT INTO Category(CategoryName) VALUES ('Law')
INSERT INTO Category(CategoryName) VALUES ('Literature & Fiction')
INSERT INTO Category(CategoryName) VALUES ('Medical Books')
INSERT INTO Category(CategoryName) VALUES ('Music')
INSERT INTO Category(CategoryName) VALUES ('Mystery, Thriller & Suspense')
INSERT INTO Category(CategoryName) VALUES ('Politcal & Social Sciences')
INSERT INTO Category(CategoryName) VALUES ('Self-Help')
INSERT INTO Category(CategoryName) VALUES ('Reference')
INSERT INTO Category(CategoryName) VALUES ('Romance')
INSERT INTO Category(CategoryName) VALUES ('Sci-Fi & Fantasy')
INSERT INTO Category(CategoryName) VALUES ('Science & Math')
INSERT INTO Category(CategoryName) VALUES ('Sports & Outdoors')
INSERT INTO Category(CategoryName) VALUES ('Textbook & Workbook')
INSERT INTO Category(CategoryName) VALUES ('Travel')

/*========= TABLE SHELF =========*/
INSERT INTO Shelf(Location) VALUES ('A-01')
INSERT INTO Shelf(Location) VALUES ('A-02')
INSERT INTO Shelf(Location) VALUES ('A-03')
INSERT INTO Shelf(Location) VALUES ('A-04')
INSERT INTO Shelf(Location) VALUES ('B-01')
INSERT INTO Shelf(Location) VALUES ('B-02')
INSERT INTO Shelf(Location) VALUES ('B-03')
INSERT INTO Shelf(Location) VALUES ('B-04')
INSERT INTO Shelf(Location) VALUES ('C-01')
INSERT INTO Shelf(Location) VALUES ('C-02')
INSERT INTO Shelf(Location) VALUES ('C-03')
INSERT INTO Shelf(Location) VALUES ('C-04')
INSERT INTO Shelf(Location) VALUES ('D-01')
INSERT INTO Shelf(Location) VALUES ('D-02')
INSERT INTO Shelf(Location) VALUES ('D-03')
INSERT INTO Shelf(Location) VALUES ('D-04')
INSERT INTO Shelf(Location) VALUES ('E-01')
INSERT INTO Shelf(Location) VALUES ('E-02')
INSERT INTO Shelf(Location) VALUES ('E-03')
INSERT INTO Shelf(Location) VALUES ('E-04')
INSERT INTO Shelf(Location) VALUES ('FA-01')
INSERT INTO Shelf(Location) VALUES ('F-02')
INSERT INTO Shelf(Location) VALUES ('F-03')
INSERT INTO Shelf(Location) VALUES ('F-04')


/*========= TABLE BOOKDETAIL =========*/
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. “Uncle Bob” Martin', 'Pearson', '2008-08-11', '9780132350884', 464, 2, 1)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Bach: Music in the Castle of Heaven', 'John Eliot Gardiner', 'Vintage', '2015-03-03', '9781400031436', 672, 2, 2)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('The LSAT Trainer: A Remarkable Self-Study Guide For The Self-Driven Student', 'Mike Kim', 'Artisanal Publishing', '2017-04-02', '9780989081535', 598, 3, 2)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Outliers: The Story of Success', 'Malcolm Gladwell', 'Back Bay Books', '2011-06-07', '9780316017930', 336, 3, 4)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('The Little Prince', 'Antoine de Saint-Exupéry', 'Mariner Books', '2000-05-15', '9780156012195', 96, 2, 3)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('The Body Keeps the Score: Brain, Mind, and Body in the Healing of Trauma', 'Bessel van der Kolk M.D.', 'Penguin Books', '2015-09-08', '9780143127741', 464, 2, 1)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('A Challenge For The Actor', 'Uta Hagen', 'Charles Scribner''s Sons', '1991-08-21', '9780684190402', 336, 1, 2)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Bushcraft 101: A Field Guide to the Art of Wilderness Survival', 'Dave Canterbury', 'Adams Media', '2004-09-01', '9781440579776', 256, 2, 3)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Everything You Need to Ace World History in One Big Fat Notebook: The Complete Middle School Study Guide', 'Workman Publishing', 'Workman Publishing', '2016-08-09', '9780761160946', 528, 1, 1)
INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, Copies, ShelfNo) VALUES ('Salt, Fat, Acid, Heat: Mastering the Elements of Good Cooking', 'Samin Nosrat', 'Simon and Schuster', '2017-04-25', '9781476753836', 480, 2, 3)


/*========= TABLE IMAGELINK =========*/
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo1_Cover.png', 1, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo1_img1.jpg', 1, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo1_img2.png', 1, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo2_Cover.jpg', 2, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo2_img1.jpg', 2, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo2_img2.jpg', 2, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo3_Cover.png', 3, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo3_img1.png', 3, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo3_img2.png', 3, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo4_Cover.jpg', 4, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo4_img1.jpg', 4, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo4_img2.jpg', 4, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo5_Cover.jpg', 5, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo5_img1.jpg', 5, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo5_img2.jpg', 5, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo6_Cover.jpg', 6, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo6_img1.jpg', 6, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo6_img2.jpg', 6, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo7_Cover.jpg', 7, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo7_img1.jpg', 7, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo7_img2.jpg', 7, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo8_Cover.jpg', 8, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo8_img1.jpg', 8, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo8_img7.jpg', 8, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo9_Cover.jpg', 9, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo9_img1.jpg', 9, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo9_img2.jpg', 9, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo10_Cover.jpg', 10, 1)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo10_img1.jpg', 10, 0)
INSERT INTO ImageLink(Link, BookNo, IsCover) VALUES ('image\books\BookNo10_img2.jpg', 10, 0)

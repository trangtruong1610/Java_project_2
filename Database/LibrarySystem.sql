CREATE DATABASE LibrarySystem
GO

USE LibrarySystem
GO

CREATE TABLE Shelf (
	ShelfNo INT IDENTITY PRIMARY KEY,
	ShelfName VARCHAR(10),
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Category (
	CategoryNo INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(100)
)
GO

CREATE TABLE BookDetail (
	BookNo INT IDENTITY PRIMARY KEY,
	Title VARCHAR(255),
	Author VARCHAR(100),
	Publisher VARCHAR(255),
	YPublished DATE,
	ISBN VARCHAR(13),
	ShelfNo INT REFERENCES Shelf(ShelfNo),
	Pages INT,
	Description VARCHAR(MAX),
	Status BIT DEFAULT 1
)
GO

CREATE TABLE BookCategory (
	BookNo INT REFERENCES BookDetail(BookNo),
	CategoryNo INT REFERENCES Category(CategoryNo),
	PRIMARY KEY (BookNo, CategoryNo)
)
GO

CREATE TABLE ImageLink (
	ImgNo INT IDENTITY PRIMARY KEY,
	ImgLink IMAGE,
	BookNo INT REFERENCES BookDetail(BookNo),
	IsCover BIT,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE BookItem (
	ItemNo INT IDENTITY PRIMARY KEY,
	BookNo INT REFERENCES BookDetail(BookNo),
	BookID VARCHAR(15),
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Account (
	AccountNo INT IDENTITY PRIMARY KEY,
	AccountName VARCHAR(100),
	LibraryID VARCHAR(20),
	Password VARCHAR(20),
	IsAdmin BIT DEFAULT 0,
	DJoined DATE DEFAULT GETDATE(),
	DExpired DATE,
	Points INT DEFAULT 100,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Reservation (
	ReserveNo INT IDENTITY PRIMARY KEY,
	AccountNo INT REFERENCES Account(AccountNo),
	ItemNo INT REFERENCES BookItem(ItemNo),
	DReserve DATE DEFAULT GETDATE(),
	Status BIT DEFAULT 1
)
GO

CREATE TABLE LendingHistory (
	LendNo INT IDENTITY PRIMARY KEY,
	ReserveNo INT REFERENCES Reservation(ReserveNo),
	AccountNo INT REFERENCES Account(AccountNo),
	ItemNo INT REFERENCES BookItem(ItemNo),
	DIssued DATE DEFAULT GETDATE(),
	DReturned DATE,
	Status BIT DEFAULT 1
)
GO

CREATE TABLE Fine (
	FineNo INT IDENTITY PRIMARY KEY,
	LendNo INT REFERENCES LendingHistory(LendNo),
	OverdueDate INT,
	FineAmt INT
)
GO

/*====== TRIGGERS ======*/
CREATE TRIGGER setExpiration ON Account
AFTER INSERT
AS BEGIN
	UPDATE Account
	SET DExpired = DATEADD(YEAR, 4, DJoined)
END
GO

/*====== PROCEDURES ======*/
CREATE PROC getAllBook
AS BEGIN
	SELECT * FROM BookDetail
END
GO

CREATE PROC getAllCategory
AS BEGIN
	SELECT * FROM Category
END
GO

CREATE PROC getBookCover (@BookNo INT)
AS BEGIN
	SELECT ImgLink FROM ImageLink
	WHERE BookNo = @BookNo AND IsCover = 1
END
GO

CREATE PROC getBookbyGenre
@Category VARCHAR(4000)
AS BEGIN
	SELECT BD.BookNo, BD.Title, BD.Author, BD.Publisher, BD.YPublished, BD.ISBN, BD.ShelfNo, BD.Description, BD.Pages, BD.Status FROM BookDetail BD JOIN BookCategory BC ON BD.BookNo = BC.BookNo JOIN Category C ON C.CategoryNo = BC.CategoryNo
	WHERE C.CategoryName IN (SELECT * FROM string_split(@Category, ','))
END
GO

CREATE PROC getBookRecord (@BookNo INT)
AS BEGIN
	SELECT * FROM BookDetail
	WHERE BookNo = @BookNo
END
GO

CREATE PROC getShelfLocation (@ShelfNo INT)
AS BEGIN
	SELECT ShelfName FROM Shelf
	WHERE ShelfNo = @ShelfNo
END
GO

CREATE PROC getBookImg (@BookNo INT)
AS BEGIN
	SELECT * FROM ImageLink
	WHERE BookNo = @BookNo
END
GO

CREATE PROC getBookItem (@BookNo INT)
AS BEGIN
	SELECT * FROM BookItem
	WHERE BookNo = @BookNo
END
GO

CREATE PROC getAccountInFo(@AccountName VARCHAR(100))
AS BEGIN
	SELECT * FROM Account
	WHERE AccountName = @AccountName
END
GO

CREATE PROC getItemNo(@BookID VARCHAR(15))
AS BEGIN
	SELECT ItemNo FROM BookItem
	WHERE BookID = @BookID
END
GO

CREATE PROC reserveBook(@ItemNo INT, @AccountNo INT)
AS BEGIN
	INSERT INTO Reservation(ItemNo, AccountNo, DReserve)
	VALUES (@ItemNo, @AccountNo, GETDATE())
END
GO

CREATE PROC getaccountName(@AccountNo INT)
AS BEGIN
	SELECT AccountName FROM Account
	WHERE AccountNo = @AccountNo
END
GO

CREATE PROC getAllShelf
AS BEGIN
	SELECT * FROM Shelf
END
GO

CREATE PROC getShelfNo(@ShelfName VARCHAR(10))
AS BEGIN
	SELECT ShelfNo FROM Shelf
	WHERE ShelfName = @ShelfName
END
GO

CREATE PROC addBookCover(@bookCover IMAGE, @BookNo INT)
AS BEGIN
	INSERT INTO ImageLink(ImgLink, BookNo, IsCover) VALUES (@bookCover, @BookNo, 1)
END
GO

CREATE PROC addBookImg(@img IMAGE, @BookNo INT)
AS BEGIN
	INSERT INTO ImageLink(ImgLink, BookNo, IsCover) VALUES (@img, @BookNo, 0)
END
GO

CREATE PROC addNewBook (@Title VARCHAR(255), @Author VARCHAR(100), @Publisher VARCHAR(255), @ISBN VARCHAR(13), @YPubished DATE, @Description VARCHAR(MAX), @Page INT, @ShelfNo INT)
AS BEGIN
	INSERT INTO BookDetail(Title, Author, Publisher, ISBN, YPublished, Description, Pages, ShelfNo)
	VALUES (@Title, @Author, @Publisher, @ISBN, @YPubished, @Description, @Page, @ShelfNo)
END
GO

CREATE PROC getBookNo (@ISBN VARCHAR(13))
AS BEGIN
	SELECT BookNo FROM BookDetail
	WHERE ISBN = @ISBN
END
GO

CREATE PROC addBookGenre(@GenreNo INT, @BookNo INT)
AS BEGIN
	INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (@BookNo, @GenreNo)
END
GO

CREATE PROC getBookCategory(@GenreName VARCHAR(100))
AS BEGIN
	SELECT CategoryNo FROM Category WHERE CategoryName = @GenreName
END
GO

CREATE PROC AddCopy(@BookNo INT, @BookID VARCHAR(15))
AS BEGIN
	INSERT INTO BookItem(BookNo, BookID)
	VALUES (@BookNo, @BookID)
END
GO

CREATE PROC getBookCopy(@BookNo INT)
AS BEGIN
	SELECT COUNT(*) AS noCopy
	FROM BookItem WHERE BookNo = @BookNo
END
GO

CREATE PROC deleteCopy(@bookID VARCHAR(15))
AS BEGIN 
	DELETE BookItem
	WHERE BookID = @BookID
END
GO

CREATE PROC deleteBook(@BookNo INT)
AS BEGIN
	DELETE ImageLink WHERE BookNo = @BookNo

	DELETE BookItem WHERE BookNo = @BookNo
	
	DELETE BookCategory WHERE BookNo = @BookNo
	
	DELETE BookDetail WHERE BookNo = @BookNo
END
GO

CREATE PROC getAllReservation
AS BEGIN
	SELECT * FROM Reservation
END
GO

CREATE PROC getAllLendingHistory
AS BEGIN
	SELECT * FROM LendingHistory lh 
END
GO

CREATE PROC ReturnLending(@LendNo INT, @DReturned Date)
AS BEGIN
	UPDATE LendingHistory 
	SET DReturned = @DReturned, Status = 0 WHERE LendNo = @LendNo
END
GO

CREATE PROC getLibraryID(@AccNo INT)
AS BEGIN
	SELECT LibraryID FROM Account WHERE AccountNo  = @AccNo
END
GO

CREATE PROC getBookID(@BookID INT)
AS BEGIN
	SELECT BookID FROM BookItem bi WHERE BookNo = @BookID
END
GO

CREATE PROC DeleteRequest(@Id INT)
AS BEGIN
	DELETE FROM Reservation WHERE ReserveNo = @Id
END
GO

CREATE PROC getReservationInfo(@Id INT)
AS BEGIN
	SELECT * from Reservation r where ReserveNo = @Id
END
GO

CREATE PROC InsertLending(@ReverseNo INT, @AccountNo INT, @ItemNo INT)
AS BEGIN
	INSERT into LendingHistory(ReserveNo , AccountNo, ItemNo) values (@ReverseNo, @AccountNo, @ItemNo)
	
	UPDATE Reservation 
	SET Status = 0 WHERE ReserveNo = @ReverseNo

	UPDATE BookItem
	SET Status = 0 WHERE ItemNo = @ItemNo
END
GO

CREATE PROC getImgLink(@BookNo INT)
AS BEGIN
	SELECT ImgLink FROM ImageLink
	WHERE BookNo = @BookNo AND IsCover = 0
END
GO

CREATE PROC getCurrentGenre(@BookNo INT)
AS BEGIN
	SELECT DISTINCT CategoryName FROM Category C JOIN BookCategory B ON C.CategoryNo = B.CategoryNo JOIN BookCategory A ON A.BookNo = B.BookNo
	WHERE B.BookNo = @BookNo
END
GO

CREATE PROC updateBook(@BookNo INT, @Title VARCHAR(255), @Author VARCHAR(100), @Publisher VARCHAR(255), @ISBN VARCHAR(13), @YPubished DATE, @Description VARCHAR(MAX), @Page INT, @ShelfNo INT, @Cover IMAGE)
AS BEGIN
	UPDATE BookDetail
	SET Title = @Title, Author = @Author, Publisher = @Publisher, ISBN = @ISBN, YPublished = @YPubished, Description  = @Description, Pages = @Page, ShelfNo = @ShelfNo
	WHERE BookNo = @BookNo

	UPDATE ImageLink
	SET ImgLink = @Cover
	WHERE BookNo = @BookNo AND IsCover = 1
END
GO

CREATE PROC deleteImage(@ImageNo INT)
AS BEGIN
	DELETE ImageLink
	WHERE ImgNo = @ImageNo
END
GO

CREATE PROC getGenreNo(@bookNo INT)
AS BEGIN
	SELECT CategoryNo FROM BookCategory
	WHERE BookNo = @bookNo
END
GO

CREATE PROC updateBookGenreDiff(@bookNo INT, @cateNo INT)
AS BEGIN
	DELETE BookCategory WHERE BookNo = @bookNo
	INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (@bookNo, @cateNo)
END
GO

CREATE PROC getImgNo(@bookNo INT)
AS BEGIN
	SELECT ImgNo FROM ImageLink
	WHERE bookNo = @bookNo AND IsCover = 0
END
GO

/*====== DATABASE INSERT ======*/
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
GO

INSERT INTO Shelf(ShelfName) VALUES ('A-01')
INSERT INTO Shelf(ShelfName) VALUES ('A-02')
INSERT INTO Shelf(ShelfName) VALUES ('A-03')
INSERT INTO Shelf(ShelfName) VALUES ('B-01')
INSERT INTO Shelf(ShelfName) VALUES ('B-02')
INSERT INTO Shelf(ShelfName) VALUES ('B-03')
INSERT INTO Shelf(ShelfName) VALUES ('C-01')
INSERT INTO Shelf(ShelfName) VALUES ('C-02')
INSERT INTO Shelf(ShelfName) VALUES ('C-03')
INSERT INTO Shelf(ShelfName) VALUES ('D-01')
INSERT INTO Shelf(ShelfName) VALUES ('D-02')
INSERT INTO Shelf(ShelfName) VALUES ('D-03')
GO

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. “Uncle Bob” Martin', 'Pearson', '2008-08-11', '9780132350884', 464, 1, 'Even bad code can function. But if code isn’t clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code. But it doesn’t have to be that way.
Noted software expert Robert C. Martin presents a revolutionary paradigm with Clean Code: A Handbook of Agile Software Craftsmanship . Martin has teamed up with his colleagues from Object Mentor to distill their best agile practice of cleaning code “on the fly” into a book that will instill within you the values of a software craftsman and make you a better programmer—but only if you work at it.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (1, 6)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (1,  CONVERT(IMAGE, CAST('image\books\BookNo1_Cover.png' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (1,  CONVERT(IMAGE, CAST('image\books\BookNo1_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (1,  CONVERT(IMAGE, CAST('image\books\BookNo1_img2.png' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Bach: Music in the Castle of Heaven', 'John Eliot Gardiner', 'Vintage', '2015-03-03', '9781400031436', 672, 2, 'Johann Sebastian Bach is one of the most unfathomable composers in theHistory of music. How can such sublime work have been produced by a man who seems so ordinary, so opaque—and occasionally so intemperate?
John Eliot Gardiner grew up passing one of the only two authentic portraits of Bach every day on the stairs of his parents’ house, where it hung for safety during World War II. He has been studying and performing Bach ever since, and is now regarded as one of the composer’s greatest living interpreters. The fruits of this lifetime’s immersion are distilled in this remarkable book, grounded in the most recent Bach scholarship but moving far beyond it, and explaining in wonderful detail the ideas on which Bach drew, how he worked, how his music is constructed, how it achieves its effects—and what it can tell us about Bach the man.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (2, 2)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (2, 3)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (2,  CONVERT(IMAGE, CAST('image\books\BookNo2_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (2,  CONVERT(IMAGE, CAST('image\books\BookNo2_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (2,  CONVERT(IMAGE, CAST('image\books\BookNo2_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('The LSAT Trainer: A Remarkable Self-Study Guide For The Self-Driven Student', 'Mike Kim', 'Artisanal Publishing', '2017-04-02', '9780989081535', 598, 2, 'The LSAT Trainer is an LSAT prep book specifically designed for self-motivated self-study students who are seeking significant score improvement on the Law School Admission Test. It is simple, smart, and remarkably effective.
Teachers, students, and reviewers all agree: The LSAT Trainer is the most advanced and effective LSAT prep product available today. Whether you are new to the LSAT or have been studying for a while, you will find invaluable benefit in the Trainer''s teachings, strategies, drills, and solutions.
The LSAT Trainer includes:
- over 200 official LSAT questions and real-time solutions
- simple and battle-tested strategies for every type of Logical Reasoning question, Reading Comprehension question, and Logic Game 
- over 30 original and unique drills designed to help develop LSAT-specific skills and habits
access to a variety of free study schedules, notebook organizers, and much more.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (3, 13)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (3, 25)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (3,  CONVERT(IMAGE, CAST('image\books\BookNo3_Cover.png' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (3,  CONVERT(IMAGE, CAST('image\books\BookNo3_img1.png' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (3,  CONVERT(IMAGE, CAST('image\books\BookNo3_img2.png' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Outliers: The Story of Success', 'Malcolm Gladwell', 'Back Bay Books', '2011-06-07', '9780316017930', 336, 4, 'In this stunning new book, Malcolm Gladwell takes us on an intellectual journey through the world of "outliers"--the best and the brightest, the most famous and the most successful. He asks the question: what makes high-achievers different?
His answer is that we pay too much attention to what successful people are like, and too little attention to where they are from: that is, their culture, their family, their generation, and the idiosyncratic experiences of their upbringing. Along the way he explains the secrets of software billionaires, what it takes to be a great soccer player, why Asians are good at math, and what made the Beatles the greatest rock band.
Brilliant and entertaining, Outliers is a landmark work that will simultaneously delight and illuminate.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (4, 4)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (4, 20)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (4, 19)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (4,  CONVERT(IMAGE, CAST('image\books\BookNo4_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (4,  CONVERT(IMAGE, CAST('image\books\BookNo4_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (4,  CONVERT(IMAGE, CAST('image\books\BookNo4_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('The Little Prince', 'Antoine de Saint-Exupéry', 'Mariner Books', '2000-05-15', '9780156012195', 96, 3, 'Few stories are as widely read and as universally cherished by children and adults alike as The Little Prince. Richard Howard''s translation of the beloved classic beautifully reflects Saint-Exupéry''s unique and gifted style. Howard, an acclaimed poet and one of the preeminent translators of our time, has excelled in bringing the English text as close as possible to the French, in language, style, and most important, spirit. The artwork in this edition has been restored to match in detail and in color Saint-Exupéry''s original artwork. Combining Richard Howard''s translation with restored original art, this definitive English-language edition of The Little Prince will capture the hearts of readers of all ages.
This title has been selected as a Common Core Text Exemplar (Grades 4-5, Stories).')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (5, 21)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (5, 22)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (5, 14)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (5,  CONVERT(IMAGE, CAST('image\books\BookNo5_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (5,  CONVERT(IMAGE, CAST('image\books\BookNo5_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (5,  CONVERT(IMAGE, CAST('image\books\BookNo5_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('The Body Keeps the Score: Brain, Mind, and Body in the Healing of Trauma', 'Bessel van der Kolk M.D.', 'Penguin Books', '2015-09-08', '9780143127741', 464, 1, 'Trauma is a fact of life. Veterans and their families deal with the painful aftermath of combat; one in five Americans has been molested; one in four grew up with alcoholics; one in three couples have engaged in physical violence. Dr. Bessel van der Kolk, one of the world’s foremost experts on trauma, has spent over three decades working with survivors. In The Body Keeps the Score, he uses recent scientific advances to show how trauma literally reshapes both body and brain, compromising sufferers’ capacities for pleasure, engagement, self-control, and trust. He explores innovative treatments—from neurofeedback and meditation to sports, drama, and yoga—that offer new paths to recovery by activating the brain’s natural neuroplasticity. Based on Dr. van der Kolk’s own research and that of other leading specialists, The Body Keeps the Score exposes the tremendous power of our relationships both to hurt and to heal—and offers new hope for reclaiming lives.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (6, 15)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (6,  CONVERT(IMAGE, CAST('image\books\BookNo6_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (6,  CONVERT(IMAGE, CAST('image\books\BookNo6_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (6,  CONVERT(IMAGE, CAST('image\books\BookNo6_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('A Challenge For The Actor', 'Uta Hagen', 'Charles Scribner''s Sons', '1991-08-21', '9780684190402', 336, 2, 'Theoretically, the actor ought to be more sound in mind and body than other people, since he learns to understand the psychological problems of human beings when putting his own passions, his loves, fears, and rages to work in the service of the characters he plays. He will learn to face himself, to hide nothing from himself -- and to do so takes an insatiable curiosity about the human condition.
from the Prologue')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (7, 12)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (7, 20)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (7, 2)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (7,  CONVERT(IMAGE, CAST('image\books\BookNo7_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (7,  CONVERT(IMAGE, CAST('image\books\BookNo7_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (7,  CONVERT(IMAGE, CAST('image\books\BookNo7_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Bushcraft 101: A Field Guide to the Art of Wilderness Survival', 'Dave Canterbury', 'Adams Media', '2004-09-01', '9781440579776', 256, 3, '“With advice on not just getting along, but truly reconnecting with the great outdoors, Dave Canterbury’s treasure trove of world-renowned wisdom and experience comes to life within these pages.” —Bustle
The ultimate resource for experiencing the backcountry!
Written by survivalist expert Dave Canterbury, Bushcraft 101 gets you ready for your next backcountry trip with advice on making the most of your time outdoors. Based on the 5Cs of Survivability--cutting tools, covering, combustion devices, containers, and cordages--this valuable guide offers only the most important survival skills to help you craft resources from your surroundings and truly experience the beauty and thrill of the wilderness.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (8, 24)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (8, 8)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (8, 19)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (8,  CONVERT(IMAGE, CAST('image\books\BookNo8_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (8,  CONVERT(IMAGE, CAST('image\books\BookNo8_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (8,  CONVERT(IMAGE, CAST('image\books\BookNo8_img7.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Everything You Need to Ace WorldHistory in One Big Fat Notebook: The Complete Middle School Study Guide', 'Workman Publishing', 'Workman Publishing', '2016-08-09', '9780761160946', 528, 1, 'It’s the revolutionary worldHistory study guide just for middle school students from the brains behind Brain Quest.
Everything You Need to Ace WorldHistory . . . kicks off with the Paleolithic Era and transports the reader to ancient civilizations—from Africa and beyond; the middle ages across the world; the Renaissance; the age of exploration and colonialism, revolutions, and the modern world and the wars and movements that shaped it.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (9, 5)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (9, 11)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (9,  CONVERT(IMAGE, CAST('image\books\BookNo9_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (9,  CONVERT(IMAGE, CAST('image\books\BookNo9_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (9,  CONVERT(IMAGE, CAST('image\books\BookNo9_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Salt, Fat, Acid, Heat: Mastering the Elements of Good Cooking', 'Samin Nosrat', 'Simon and Schuster', '2017-04-25', '9781476753836', 480, 3, 'Now a Netflix series!
New York Times Bestseller and Winner of the 2018 James Beard Award for Best General Cookbook and multiple IACP Cookbook Awards
Named one of the Best Books of 2017 by: NPR, BuzzFeed, The Atlantic, The Washington Post, Chicago Tribune, Rachel Ray Every Day, San Francisco Chronicle, Vice Munchies, Elle.com, Glamour, Eater, Newsday, Minneapolis Star Tribune, The Seattle Times, Tampa Bay Times, Tasting Table, Modern Farmer, Publishers Weekly, and more.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (10, 7)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (10, 20)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (10, 8)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (10,  CONVERT(IMAGE, CAST('image\books\BookNo10_Cover.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (10,  CONVERT(IMAGE, CAST('image\books\BookNo10_img1.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (10,  CONVERT(IMAGE, CAST('image\books\BookNo10_img2.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Milkman: A Novel', 'Anna Burns', 'Graywolf Press', '2018-12-4', '9781644450000', 360, 7, 'Winner of the Man Booker Prize
“Everything about this novel rings true. . . . Original, funny, disarmingly oblique and unique.”―The Guardian
In an unnamed city, middle sister stands out for the wrong reasons. She reads while walking, for one. And she has been taking French night classes downtown. So when a local paramilitary known as the milkman begins pursuing her, she suddenly becomes “interesting,” the last thing she ever wanted to be. Despite middle sister’s attempts to avoid him―and to keep her mother from finding out about her maybe-boyfriend―rumors spread and the threat of violence lingers. Milkman is a story of the way inaction can have enormous repercussions, in a time when the wrong flag, wrong religion, or even a sunset can be subversive. Told with ferocious energy and sly, wicked humor, Milkman establishes Anna Burns as one of the most consequential voices of our day.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (11, 14)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (11,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/41eOX0cBT8L._SX331_BO1,204,203,200_.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (11,  CONVERT(IMAGE, CAST('https://www.dw.com/image/45914984_303.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (11,  CONVERT(IMAGE, CAST('https://s3-eu-west-1.amazonaws.com/tra-rgfe/assets/2157/large_Reading_group_quote.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Two Whats?! and a Wow! Think & Tinker Playbook', 'Mindy Thomas, Guy Raz', 'Houghton Mifflin Harcourt', '2020-06-30', '9780358513209', 80, 8, 'From the creators of the #1 kids podcast Wow in the World comes an interactive, science-based activity book based on their daily game show, Two Whats?! and a Wow!
Choose between three unbelievable science statements to identify the true wow fact from the fallacies—and then learn the why and how behind the wow! But that’s not all! After each round, tackle a STEAM-based challenge using a few household items and a lot of creativity. And discover even more science fun in the sidebars, which are filled with brain-bursting facts and figures.
Packed with Wow in the World’s signature, family-friendly humor and fascinating science facts, the Two Whats?! and a Wow! Think & Tinker Playbook will provide hours of learning, laughs, and wows.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (12, 5)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (12,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/51A6DwSVz9L._SX311_BO1,204,203,200_.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (12,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/5106q2yHykL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('The Design of Everyday Things: Revised and Expanded Edition', 'Don Norman', 'Basic Books', '2013-11-05', '9780465050659', 368, 2, 'Design doesn''t have to complicated, which is why this guide to human-centered design shows that usability is just as important as aesthetics.
Even the smartest among us can feel inept as we fail to figure out which light switch or oven burner to turn on, or whether to push, pull, or slide a door.
The fault, argues this ingenious -- even liberating -- book, lies not in ourselves, but in product design that ignores the needs of users and the principles of cognitive psychology. The problems range from ambiguous and hidden controls to arbitrary relationships between controls and functions, coupled with a lack of feedback or other assistance and unreasonable demands on memorization.
The Design of Everyday Things shows that good, usable design is possible. The rules are simple: make things visible, exploit natural relationships that couple function and control, and make intelligent use of constraints. The goal: guide the user effortlessly to the right action on the right control at the right time.
The Design of Everyday Things is a powerful primer on how -- and why -- some products satisfy customers while others only frustrate them.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (13, 2)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (13,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81zpLhP1gWL.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (13,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91bm17a2jFL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (13,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/31Al3DpuK-L.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Emotional Design: Why We Love (or Hate) Everyday Things', 'Don Norman', 'Basic Books', '2005-05-11', '9780465051359', 257, 2, 'Why attractive things work better and other crucial insights into human-centered design
Emotions are inseparable from how we humans think, choose, and act. In Emotional Design, cognitive scientist Don Norman shows how the principles of human psychology apply to the invention and design of new technologies and products. In The Design of Everyday Things, Norman made the definitive case for human-centered design, showing that good design demanded that the user''s must take precedence over a designer''s aesthetic if anything, from light switches to airplanes, was going to work as the user needed. In this book, he takes his thinking several steps farther, showing that successful design must incorporate not just what users need, but must address our minds by attending to our visceral reactions, to our behavioral choices, and to the stories we want the things in our lives to tell others about ourselves. Good human-centered design isn''t just about making effective tools that are straightforward to use; it''s about making affective tools that mesh well with our emotions and help us express our identities and support our social lives. From roller coasters to robots, sports cars to smart phones, attractive things work better. Whether designer or consumer, user or inventor, this book is the definitive guide to making Norman''s insights work for you.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (14, 2)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (14,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/41MTiz-I5HL._SX326_BO1,204,203,200_.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (14,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81GVJ8wruEL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Homebody: A Guide to Creating Spaces You Never Want to Leave', 'Joanna Gaines', 'Harper Design', '2018-11-06', '9780062801982', 352, 2, '#1 New York Times Bestseller
In Homebody: A Guide to Creating Spaces You Never Want to Leave, Joanna Gaines walks you through how to create a home that reflects the personalities and stories of the people who live there. Using examples from her own farmhouse as well as a range of other homes, this comprehensive guide will help you assess your priorities and instincts, as well as your likes and dislikes, with practical steps for navigating and embracing your authentic design style. Room by room, Homebody gives you an in-depth look at how these styles are implemented as well as how to blend the looks you''re drawn to in order to create spaces that feel distinctly yours. A removable design template at the back of the book offers a step-by-step guide to planning and sketching out your own design plans. The insight shared in Homebody will instill in you the confidence to thoughtfully create spaces you never want to leave.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (15, 2)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (15, 8)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/51PfPNbYWLL._SX391_BO1,204,203,200_.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81RStaYAlYL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81xytDU1lFL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81qESkH44SL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81zi+tlOphL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81wYn88tsaL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81cSliF7ldL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/917JV4NY8mL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81r2YN66SIL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (15,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/71ZaXI4ioaL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('How to Make Resin Jewellery: With over 50 inspirational step-by-step projects', 'Sara Naumann', 'Search Press Limited', '2017-03-13', '9781781263853', 96, 2, 'Resin jewellery first started in the US around 6 years ago and has now become one of the fastest-growing trends in jewellery making. The technique is very simple you simply mix the two-part resin together and pour into a bezel or pendant. Rings, pendants, brooches, cufflinks, hairpins and bracelets are all easy to make and look incredibly professional when done. 
In this inspiring book, well-known crafter Sara Naumann shows you just how easy and quick resin jewellery is to make, using minimal equipment and readily available products, and provides over 50 fabulous projects for you to try. You can add numerous items to the resin to achieve different effects. You can place paper in the bezels to act as a background to the resin such as old book paper, map paper, scrapbook paper and photographs. Paper can also be painted, stencilled, or layered with washi tape before being coated with resin. Try sheet music for a vintage vibe, or origami papers for a fresh, contemporary look. 
In addition, you can also immerse various items in the resin before it cures, such as dried flowers and leaves, feathers, shells, beads and charms, or try adding glitter, coloured inks, nail polish and virtually anything else you can think of. 
The versatility of resin jewellery is awe-inspiring, providing papercrafters as well as jewellery-makers with all the skills and inspiration they need to design and make their own stunning pieces.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (16, 8)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (16,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81lXiyTY71L.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (16,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/51344sS+wZL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('George Washington''s Secret Six: The Spy Ring That Saved the American Revolution', 'Brian Kilmeade, Don Yaeger', 'Sentinel', '2016-10-18', '9780143130604', 320, 10, 'When George Washington beat a hasty retreat from New York City in August 1776, many thought the American Revolution might soon be over. Instead, Washington rallied—thanks in large part to a little-known, top-secret group called the Culper Spy Ring. He realized that he couldn’t defeat the British with military might, so he recruited a sophisticated and deeply secretive intelligence network to infiltrate New York.
Drawing on extensive research, Brian Kilmeade and Don Yaeger have offered fascinating portraits of these spies: a reserved Quaker merchant, a tavern keeper, a brash young longshoreman, a curmudgeonly Long Island bachelor, a coffeehouse owner, and a mysterious woman. Long unrecognized, the secret six are finally receiving their due among the pantheon of American heroes.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (17, 3)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (17,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91gYaUzAJyL.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (17,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/41tjM5cTBXL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('A Manual for Writers of Research Papers, Theses, and Dissertations, Ninth Edition: Chicago Style for Students and Researchers', 'Kate L. Turabian', 'University of Chicago Press', '2018-03-26', '9780226430577', 464, 9, 'When Kate L. Turabian first put her famous guidelines to paper, she could hardly have imagined the world in which today''s students would be conducting research. Yet while the ways in which we research and compose papers may have changed, the fundamentals remain the same: writers need to have a strong research question, construct an evidence-based argument, cite their sources, and structure their work in a logical way. A Manual for Writers of Research Papers, Theses, and Dissertations--also known as "Turabian"--remains one of the most popular books for writers because of its timeless focus on achieving these goals. This new edition filters decades of expertise into modern standards. While previous editions incorporated digital forms of research and writing, this edition goes even further to build information literacy, recognizing that most students will be doing their work largely or entirely online and on screens. Chapters include updated advice on finding, evaluating, and citing a wide range of digital sources and also recognize the evolving use of software for citation management, graphics, and paper format and submission. The ninth edition is fully aligned with the recently released Chicago Manual of Style, 17th edition, as well as with the latest edition of The Craft of Research. Teachers and users of the previous editions will recognize the familiar three-part structure. Part 1 covers every step of the research and writing process, including drafting and revising. Part 2 offers a comprehensive guide to Chicago''s two methods of source citation: notes-bibliography and author-date. Part 3 gets into matters of editorial style and the correct way to present quotations and visual material. Manual for Writers also covers an issue familiar to writers of all levels: how to conquer the fear of tackling a major writing project. Through eight decades and millions of copies, A Manual for Writers has helped generations shape their ideas into compelling research papers. This new edition will continue to be the gold standard for college and graduate students in virtually all academic disciplines.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (18, 18)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (18,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/61nVJ0ZerZL.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (18,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/71l7GYKeV4L.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (18,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/31bzDt2YE-L.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Workman Publishing Everything You Need to Ace English Language Arts in One Big Fat Notebook (Big Fat Notebooks)', 'Workman Publishing', 'Workman Publishing Company', '2016-08-09', '9780761160915', 512, 12, 'It s the revolutionary English language arts study guide just for middle school students from the brains behind Brain Quest. Everything You Need to Ace English Language Arts . . . takes students from grammar to reading comprehension to writing with ease, including parts of speech, active and passive verbs, Greek and Latin roots and affixes; nuances in word meanings; textual analysis, authorship, structure, and other skills for reading fiction and nonfiction; and writing arguments, informative texts, and narratives. The BIG FAT NOTEBOOK™ series is built on a simple and irresistible conceit borrowing the notes from the smartest kid in class. There are five books in all, and each is the only book you need for each main subject taught in middle school: Math, Science, AmericanHistory, English Language Arts, and WorldHistory. Inside the reader will find every subject s key concepts, easily digested and summarized. The BIG FAT NOTEBOOKS meet Common Core State Standards, Next Generation Science Standards, and stateHistory standards, and are vetted by National and State Teacher of the Year Award winning teachers. They make learning fun, and are the perfect next step for every kid who grew up on Brain Quest.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (19, 20)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (19, 25)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/51fwbg9NCJL.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91rheeE5CRL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/913-gUrq8yL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91VCnS6dC8L.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91XZRrXNapL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/91gq1UlkxZL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/918k5W4XhpL.jpg' AS VARBINARY(MAX)),2), 0)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (19,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/31BtL-hi5VL.jpg' AS VARBINARY(MAX)),2), 0)

INSERT INTO BookDetail(Title, Author, Publisher, YPublished, ISBN, Pages, ShelfNo, Description) VALUES ('Hidden Figures: The American Dream and the Untold Story of the Black Women Mathematicians Who Helped Win the Space Race', 'Margot Lee Shetterly', 'William Morrow', '2016-12-06', '9780062363602', 368, 12, 'The #1 New York Times bestseller
The phenomenal true story of the black female mathematicians at NASA whose calculations helped fuel some of America’s greatest achievements in space. Now a major motion picture starring Taraji P. Henson, Octavia Spencer, Janelle Monae, Kirsten Dunst, and Kevin Costner.
Before John Glenn orbited the earth, or Neil Armstrong walked on the moon, a group of dedicated female mathematicians known as “human computers” used pencils, slide rules and adding machines to calculate the numbers that would launch rockets, and astronauts, into space.
Among these problem-solvers were a group of exceptionally talented African American women, some of the brightest minds of their generation. Originally relegated to teaching math in the South’s segregated public schools, they were called into service during the labor shortages of World War II, when America’s aeronautics industry was in dire need of anyone who had the right stuff. Suddenly, these overlooked math whizzes had a shot at jobs worthy of their skills, and they answered Uncle Sam’s call, moving to Hampton, Virginia and the fascinating, high-energy world of the Langley Memorial Aeronautical Laboratory.
Even as Virginia’s Jim Crow laws required them to be segregated from their white counterparts, the women of Langley’s all-black “West Computing” group helped America achieve one of the things it desired most: a decisive victory over the Soviet Union in the Cold War, and complete domination of the heavens.
Starting in World War II and moving through to the Cold War, the Civil Rights Movement and the Space Race, Hidden Figures follows the interwoven accounts of Dorothy Vaughan, Mary Jackson, Katherine Johnson and Christine Darden, four African American women who participated in some of NASA’s greatest successes. It chronicles their careers over nearly three decades they faced challenges, forged alliances and used their intellect to change their own lives, and their country’s future.')
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (20, 3)
INSERT INTO BookCategory(BookNo, CategoryNo) VALUES (20, 11)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (20,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/71G0QMOpDNL.jpg' AS VARBINARY(MAX)),2), 1)
INSERT INTO ImageLink(BookNo, ImgLink, IsCover) VALUES (20,  CONVERT(IMAGE, CAST('https://images-na.ssl-images-amazon.com/images/I/81dfit9kYpL.jpg' AS VARBINARY(MAX)),2), 0)


INSERT INTO BookItem(BookNo, BookID) VALUES (1,'200812-0001-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (1,'201106-0001-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (1,'201506-0001-03')
INSERT INTO BookItem(BookNo, BookID) VALUES (2,'201506-0002-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (2,'201603-0002-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (2,'201806-0002-03')
INSERT INTO BookItem(BookNo, BookID) VALUES (3,'201712-0003-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (3,'201712-0003-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (4,'201112-0004-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (4,'201206-0004-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (4,'201506-0004-03')
INSERT INTO BookItem(BookNo, BookID) VALUES (5,'201512-0005-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (6,'201512-0006-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (6,'201603-0006-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (7,'200309-0007-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (8,'201009-0008-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (8,'201503-0008-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (9,'201706-0009-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (9,'201706-0009-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (10,'201706-0010-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (10,'201706-0010-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (11,'201812-0011-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (11,'201909-0011-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (12,'202006-0012-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (13,'201506-0013-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (13,'2019012-0013-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (14,'200509-0014-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (14,'201506-0014-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (15,'201812-0015-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (15,'201906-0015-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (16,'201306-0016-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (16,'201503-0016-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (17,'201612-0017-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (18,'201812-0018-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (18,'201812-0018-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (19,'201609-0019-01')
INSERT INTO BookItem(BookNo, BookID) VALUES (19,'201609-0019-02')
INSERT INTO BookItem(BookNo, BookID) VALUES (20,'201612-0020-01')

INSERT INTO Account(AccountName, LibraryID, Password, IsAdmin) VALUES ('Admin', 'Admin123', 'test123', 1)
INSERT INTO Account(AccountName, LibraryID, Password) VALUES ('Student345', '202005-V0034', 'test@234')
INSERT INTO Account(AccountName, LibraryID, Password) VALUES ('Student678', '201805-C0014', 'test@234')

INSERT INTO Reservation(AccountNo, ItemNo) VALUES (1,3)
INSERT INTO Reservation(AccountNo, ItemNo) VALUES (3,4)
INSERT INTO Reservation(AccountNo, ItemNo) VALUES (2,5)
INSERT INTO Reservation(AccountNo, ItemNo) VALUES (3,15)
INSERT INTO Reservation(AccountNo, ItemNo) VALUES (2,18)
GO

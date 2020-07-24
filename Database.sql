USE [master]
GO
/****** Object:  Database [LibrarySystem_test]    Script Date: 7/24/2020 4:11:28 PM ******/
CREATE DATABASE [LibrarySystem_test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibrarySystem_test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LibrarySystem_test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibrarySystem_test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LibrarySystem_test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LibrarySystem_test] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibrarySystem_test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibrarySystem_test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LibrarySystem_test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibrarySystem_test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibrarySystem_test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LibrarySystem_test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibrarySystem_test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LibrarySystem_test] SET  MULTI_USER 
GO
ALTER DATABASE [LibrarySystem_test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibrarySystem_test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibrarySystem_test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibrarySystem_test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibrarySystem_test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibrarySystem_test] SET QUERY_STORE = OFF
GO
USE [LibrarySystem_test]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountNo] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](100) NULL,
	[LibraryID] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
	[IsAdmin] [bit] NULL,
	[DJoined] [date] NULL,
	[DExpired] [date] NULL,
	[Point] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCategory]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategory](
	[BookNo] [int] NOT NULL,
	[CategoryNo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookNo] ASC,
	[CategoryNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookDetail]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookDetail](
	[BookNo] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](255) NULL,
	[Author] [varchar](100) NULL,
	[Publisher] [varchar](255) NULL,
	[YPublished] [date] NULL,
	[ISBN] [varchar](13) NULL,
	[ShelfNo] [int] NULL,
	[Pages] [int] NULL,
	[Description] [varchar](max) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookItem]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookItem](
	[ItemNo] [int] IDENTITY(1,1) NOT NULL,
	[BookNo] [int] NULL,
	[BookID] [varchar](15) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryNo] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fine]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fine](
	[FineNo] [int] IDENTITY(1,1) NOT NULL,
	[LendNo] [int] NULL,
	[OverdueDate] [int] NULL,
	[FineAmt] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FineNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImageLink]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageLink](
	[ImgNo] [int] IDENTITY(1,1) NOT NULL,
	[ImgLink] [image] NULL,
	[BookNo] [int] NULL,
	[IsCover] [bit] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ImgNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LendingHistory]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendingHistory](
	[LendNo] [int] IDENTITY(1,1) NOT NULL,
	[AccountNo] [int] NULL,
	[ItemNo] [int] NULL,
	[DIssued] [date] NULL,
	[DReturned] [date] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[LendNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[ReserveNo] [int] IDENTITY(1,1) NOT NULL,
	[AccountNo] [int] NULL,
	[ItemNo] [int] NULL,
	[DReserve] [date] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReserveNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shelf]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shelf](
	[ShelfNo] [int] IDENTITY(1,1) NOT NULL,
	[ShelfName] [varchar](10) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ShelfNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (1, N'Student123', N'202001-A0134', N'test123', 1, CAST(N'2020-07-20' AS Date), CAST(N'2024-07-20' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (33, N'Student567', N'123456-A1234', N'aaaabbbb', 0, CAST(N'2020-07-16' AS Date), CAST(N'2024-07-16' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (34, N'Student666', N'888888-A7776', N'aaaaaaaaaaaa', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (35, N'Student111', N'999999-U9999', N'dddddddddddddddddd', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 0, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (36, N'Student5556', N'888888-I9999', N'aaaaaaaaaaaa', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 0, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (37, N'Student112', N'888888-U8823', N'nnnnnnnnnnnnnnnnn', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 200, 0)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (38, N'', N'', N'2020-07-24', 0, CAST(N'2020-07-24' AS Date), CAST(N'2024-07-24' AS Date), 0, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (39, N'Student000', N'999900-D8888', N'qqqqqqqqqq', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 0, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (41, N'Student888', N'444444-D4444', N'ooooooooooooooooo', 0, CAST(N'2020-07-21' AS Date), CAST(N'2024-07-21' AS Date), 0, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (44, N'Student115', N'123456-A1234', N'aaaaaaaaaa', 0, CAST(N'2020-07-24' AS Date), CAST(N'2024-07-24' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (45, N'Student456', N'123456-B1234', N'aaaaaaaaaaaaa', 0, CAST(N'2020-07-29' AS Date), CAST(N'2024-07-29' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (46, N'Student555', N'111111-G5555', N'ffffffff', 0, CAST(N'2020-07-24' AS Date), CAST(N'2024-07-24' AS Date), 100, 1)
INSERT [dbo].[Account] ([AccountNo], [AccountName], [LibraryID], [Password], [IsAdmin], [DJoined], [DExpired], [Point], [Status]) VALUES (47, N'Student660', N'111111-A5555', N'aaaaaaaaaaaaaa', 0, CAST(N'2020-07-29' AS Date), CAST(N'2024-07-29' AS Date), 100, 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (1, 6)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (2, 2)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (2, 3)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (3, 13)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (3, 25)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (4, 4)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (4, 19)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (4, 20)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (5, 14)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (5, 21)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (5, 22)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (6, 15)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (7, 2)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (7, 12)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (7, 20)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (8, 8)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (8, 19)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (8, 24)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (9, 5)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (9, 11)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (10, 7)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (10, 8)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (10, 20)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (11, 14)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (12, 5)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (13, 2)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (14, 2)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (15, 2)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (15, 8)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (16, 8)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (17, 3)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (18, 18)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (19, 20)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (19, 25)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (20, 3)
INSERT [dbo].[BookCategory] ([BookNo], [CategoryNo]) VALUES (20, 11)
GO
SET IDENTITY_INSERT [dbo].[BookDetail] ON 

INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (1, N'Clean Code: A Handbook of Agile Software Craftsmanship', N'Robert C. “Uncle Bob” Martin', N'Pearson', CAST(N'2008-08-11' AS Date), N'9780132350884', 1, 464, N'Even bad code can function. But if code isn’t clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code. But it doesn’t have to be that way.
Noted software expert Robert C. Martin presents a revolutionary paradigm with Clean Code: A Handbook of Agile Software Craftsmanship . Martin has teamed up with his colleagues from Object Mentor to distill their best agile practice of cleaning code “on the fly” into a book that will instill within you the values of a software craftsman and make you a better programmer—but only if you work at it.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (2, N'Bach: Music in the Castle of Heaven', N'John Eliot Gardiner', N'Vintage', CAST(N'2015-03-03' AS Date), N'9781400031436', 2, 672, N'Johann Sebastian Bach is one of the most unfathomable composers in theHistory of music. How can such sublime work have been produced by a man who seems so ordinary, so opaque—and occasionally so intemperate?
John Eliot Gardiner grew up passing one of the only two authentic portraits of Bach every day on the stairs of his parents’ house, where it hung for safety during World War II. He has been studying and performing Bach ever since, and is now regarded as one of the composer’s greatest living interpreters. The fruits of this lifetime’s immersion are distilled in this remarkable book, grounded in the most recent Bach scholarship but moving far beyond it, and explaining in wonderful detail the ideas on which Bach drew, how he worked, how his music is constructed, how it achieves its effects—and what it can tell us about Bach the man.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (3, N'The LSAT Trainer: A Remarkable Self-Study Guide For The Self-Driven Student', N'Mike Kim', N'Artisanal Publishing', CAST(N'2017-04-02' AS Date), N'9780989081535', 2, 598, N'The LSAT Trainer is an LSAT prep book specifically designed for self-motivated self-study students who are seeking significant score improvement on the Law School Admission Test. It is simple, smart, and remarkably effective.
Teachers, students, and reviewers all agree: The LSAT Trainer is the most advanced and effective LSAT prep product available today. Whether you are new to the LSAT or have been studying for a while, you will find invaluable benefit in the Trainer''s teachings, strategies, drills, and solutions.
The LSAT Trainer includes:
- over 200 official LSAT questions and real-time solutions
- simple and battle-tested strategies for every type of Logical Reasoning question, Reading Comprehension question, and Logic Game 
- over 30 original and unique drills designed to help develop LSAT-specific skills and habits
access to a variety of free study schedules, notebook organizers, and much more.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (4, N'Outliers: The Story of Success', N'Malcolm Gladwell', N'Back Bay Books', CAST(N'2011-06-07' AS Date), N'9780316017930', 4, 336, N'In this stunning new book, Malcolm Gladwell takes us on an intellectual journey through the world of "outliers"--the best and the brightest, the most famous and the most successful. He asks the question: what makes high-achievers different?
His answer is that we pay too much attention to what successful people are like, and too little attention to where they are from: that is, their culture, their family, their generation, and the idiosyncratic experiences of their upbringing. Along the way he explains the secrets of software billionaires, what it takes to be a great soccer player, why Asians are good at math, and what made the Beatles the greatest rock band.
Brilliant and entertaining, Outliers is a landmark work that will simultaneously delight and illuminate.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (5, N'The Little Prince', N'Antoine de Saint-Exupéry', N'Mariner Books', CAST(N'2000-05-15' AS Date), N'9780156012195', 3, 96, N'Few stories are as widely read and as universally cherished by children and adults alike as The Little Prince. Richard Howard''s translation of the beloved classic beautifully reflects Saint-Exupéry''s unique and gifted style. Howard, an acclaimed poet and one of the preeminent translators of our time, has excelled in bringing the English text as close as possible to the French, in language, style, and most important, spirit. The artwork in this edition has been restored to match in detail and in color Saint-Exupéry''s original artwork. Combining Richard Howard''s translation with restored original art, this definitive English-language edition of The Little Prince will capture the hearts of readers of all ages.
This title has been selected as a Common Core Text Exemplar (Grades 4-5, Stories).', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (6, N'The Body Keeps the Score: Brain, Mind, and Body in the Healing of Trauma', N'Bessel van der Kolk M.D.', N'Penguin Books', CAST(N'2015-09-08' AS Date), N'9780143127741', 1, 464, N'Trauma is a fact of life. Veterans and their families deal with the painful aftermath of combat; one in five Americans has been molested; one in four grew up with alcoholics; one in three couples have engaged in physical violence. Dr. Bessel van der Kolk, one of the world’s foremost experts on trauma, has spent over three decades working with survivors. In The Body Keeps the Score, he uses recent scientific advances to show how trauma literally reshapes both body and brain, compromising sufferers’ capacities for pleasure, engagement, self-control, and trust. He explores innovative treatments—from neurofeedback and meditation to sports, drama, and yoga—that offer new paths to recovery by activating the brain’s natural neuroplasticity. Based on Dr. van der Kolk’s own research and that of other leading specialists, The Body Keeps the Score exposes the tremendous power of our relationships both to hurt and to heal—and offers new hope for reclaiming lives.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (7, N'A Challenge For The Actor', N'Uta Hagen', N'Charles Scribner''s Sons', CAST(N'1991-08-21' AS Date), N'9780684190402', 2, 336, N'Theoretically, the actor ought to be more sound in mind and body than other people, since he learns to understand the psychological problems of human beings when putting his own passions, his loves, fears, and rages to work in the service of the characters he plays. He will learn to face himself, to hide nothing from himself -- and to do so takes an insatiable curiosity about the human condition.
from the Prologue', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (8, N'Bushcraft 101: A Field Guide to the Art of Wilderness Survival', N'Dave Canterbury', N'Adams Media', CAST(N'2004-09-01' AS Date), N'9781440579776', 3, 256, N'“With advice on not just getting along, but truly reconnecting with the great outdoors, Dave Canterbury’s treasure trove of world-renowned wisdom and experience comes to life within these pages.” —Bustle
The ultimate resource for experiencing the backcountry!
Written by survivalist expert Dave Canterbury, Bushcraft 101 gets you ready for your next backcountry trip with advice on making the most of your time outdoors. Based on the 5Cs of Survivability--cutting tools, covering, combustion devices, containers, and cordages--this valuable guide offers only the most important survival skills to help you craft resources from your surroundings and truly experience the beauty and thrill of the wilderness.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (9, N'Everything You Need to Ace WorldHistory in One Big Fat Notebook: The Complete Middle School Study Guide', N'Workman Publishing', N'Workman Publishing', CAST(N'2016-08-09' AS Date), N'9780761160946', 1, 528, N'It’s the revolutionary worldHistory study guide just for middle school students from the brains behind Brain Quest.
Everything You Need to Ace WorldHistory . . . kicks off with the Paleolithic Era and transports the reader to ancient civilizations—from Africa and beyond; the middle ages across the world; the Renaissance; the age of exploration and colonialism, revolutions, and the modern world and the wars and movements that shaped it.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (10, N'Salt, Fat, Acid, Heat: Mastering the Elements of Good Cooking', N'Samin Nosrat', N'Simon and Schuster', CAST(N'2017-04-25' AS Date), N'9781476753836', 3, 480, N'Now a Netflix series!
New York Times Bestseller and Winner of the 2018 James Beard Award for Best General Cookbook and multiple IACP Cookbook Awards
Named one of the Best Books of 2017 by: NPR, BuzzFeed, The Atlantic, The Washington Post, Chicago Tribune, Rachel Ray Every Day, San Francisco Chronicle, Vice Munchies, Elle.com, Glamour, Eater, Newsday, Minneapolis Star Tribune, The Seattle Times, Tampa Bay Times, Tasting Table, Modern Farmer, Publishers Weekly, and more.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (11, N'Milkman: A Novel', N'Anna Burns', N'Graywolf Press', CAST(N'2018-12-04' AS Date), N'9781644450000', 7, 360, N'Winner of the Man Booker Prize
“Everything about this novel rings true. . . . Original, funny, disarmingly oblique and unique.”?The Guardian
In an unnamed city, middle sister stands out for the wrong reasons. She reads while walking, for one. And she has been taking French night classes downtown. So when a local paramilitary known as the milkman begins pursuing her, she suddenly becomes “interesting,” the last thing she ever wanted to be. Despite middle sister’s attempts to avoid him?and to keep her mother from finding out about her maybe-boyfriend?rumors spread and the threat of violence lingers. Milkman is a story of the way inaction can have enormous repercussions, in a time when the wrong flag, wrong religion, or even a sunset can be subversive. Told with ferocious energy and sly, wicked humor, Milkman establishes Anna Burns as one of the most consequential voices of our day.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (12, N'Two Whats?! and a Wow! Think & Tinker Playbook', N'Mindy Thomas, Guy Raz', N'Houghton Mifflin Harcourt', CAST(N'2020-06-30' AS Date), N'9780358513209', 8, 80, N'From the creators of the #1 kids podcast Wow in the World comes an interactive, science-based activity book based on their daily game show, Two Whats?! and a Wow!
Choose between three unbelievable science statements to identify the true wow fact from the fallacies—and then learn the why and how behind the wow! But that’s not all! After each round, tackle a STEAM-based challenge using a few household items and a lot of creativity. And discover even more science fun in the sidebars, which are filled with brain-bursting facts and figures.
Packed with Wow in the World’s signature, family-friendly humor and fascinating science facts, the Two Whats?! and a Wow! Think & Tinker Playbook will provide hours of learning, laughs, and wows.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (13, N'The Design of Everyday Things: Revised and Expanded Edition', N'Don Norman', N'Basic Books', CAST(N'2013-11-05' AS Date), N'9780465050659', 2, 368, N'Design doesn''t have to complicated, which is why this guide to human-centered design shows that usability is just as important as aesthetics.
Even the smartest among us can feel inept as we fail to figure out which light switch or oven burner to turn on, or whether to push, pull, or slide a door.
The fault, argues this ingenious -- even liberating -- book, lies not in ourselves, but in product design that ignores the needs of users and the principles of cognitive psychology. The problems range from ambiguous and hidden controls to arbitrary relationships between controls and functions, coupled with a lack of feedback or other assistance and unreasonable demands on memorization.
The Design of Everyday Things shows that good, usable design is possible. The rules are simple: make things visible, exploit natural relationships that couple function and control, and make intelligent use of constraints. The goal: guide the user effortlessly to the right action on the right control at the right time.
The Design of Everyday Things is a powerful primer on how -- and why -- some products satisfy customers while others only frustrate them.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (14, N'Emotional Design: Why We Love (or Hate) Everyday Things', N'Don Norman', N'Basic Books', CAST(N'2005-05-11' AS Date), N'9780465051359', 2, 257, N'Why attractive things work better and other crucial insights into human-centered design
Emotions are inseparable from how we humans think, choose, and act. In Emotional Design, cognitive scientist Don Norman shows how the principles of human psychology apply to the invention and design of new technologies and products. In The Design of Everyday Things, Norman made the definitive case for human-centered design, showing that good design demanded that the user''s must take precedence over a designer''s aesthetic if anything, from light switches to airplanes, was going to work as the user needed. In this book, he takes his thinking several steps farther, showing that successful design must incorporate not just what users need, but must address our minds by attending to our visceral reactions, to our behavioral choices, and to the stories we want the things in our lives to tell others about ourselves. Good human-centered design isn''t just about making effective tools that are straightforward to use; it''s about making affective tools that mesh well with our emotions and help us express our identities and support our social lives. From roller coasters to robots, sports cars to smart phones, attractive things work better. Whether designer or consumer, user or inventor, this book is the definitive guide to making Norman''s insights work for you.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (15, N'Homebody: A Guide to Creating Spaces You Never Want to Leave', N'Joanna Gaines', N'Harper Design', CAST(N'2018-11-06' AS Date), N'9780062801982', 2, 352, N'#1 New York Times Bestseller
In Homebody: A Guide to Creating Spaces You Never Want to Leave, Joanna Gaines walks you through how to create a home that reflects the personalities and stories of the people who live there. Using examples from her own farmhouse as well as a range of other homes, this comprehensive guide will help you assess your priorities and instincts, as well as your likes and dislikes, with practical steps for navigating and embracing your authentic design style. Room by room, Homebody gives you an in-depth look at how these styles are implemented as well as how to blend the looks you''re drawn to in order to create spaces that feel distinctly yours. A removable design template at the back of the book offers a step-by-step guide to planning and sketching out your own design plans. The insight shared in Homebody will instill in you the confidence to thoughtfully create spaces you never want to leave.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (16, N'How to Make Resin Jewellery: With over 50 inspirational step-by-step projects', N'Sara Naumann', N'Search Press Limited', CAST(N'2017-03-13' AS Date), N'9781781263853', 2, 96, N'Resin jewellery first started in the US around 6 years ago and has now become one of the fastest-growing trends in jewellery making. The technique is very simple you simply mix the two-part resin together and pour into a bezel or pendant. Rings, pendants, brooches, cufflinks, hairpins and bracelets are all easy to make and look incredibly professional when done. 
In this inspiring book, well-known crafter Sara Naumann shows you just how easy and quick resin jewellery is to make, using minimal equipment and readily available products, and provides over 50 fabulous projects for you to try. You can add numerous items to the resin to achieve different effects. You can place paper in the bezels to act as a background to the resin such as old book paper, map paper, scrapbook paper and photographs. Paper can also be painted, stencilled, or layered with washi tape before being coated with resin. Try sheet music for a vintage vibe, or origami papers for a fresh, contemporary look. 
In addition, you can also immerse various items in the resin before it cures, such as dried flowers and leaves, feathers, shells, beads and charms, or try adding glitter, coloured inks, nail polish and virtually anything else you can think of. 
The versatility of resin jewellery is awe-inspiring, providing papercrafters as well as jewellery-makers with all the skills and inspiration they need to design and make their own stunning pieces.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (17, N'George Washington''s Secret Six: The Spy Ring That Saved the American Revolution', N'Brian Kilmeade, Don Yaeger', N'Sentinel', CAST(N'2016-10-18' AS Date), N'9780143130604', 10, 320, N'When George Washington beat a hasty retreat from New York City in August 1776, many thought the American Revolution might soon be over. Instead, Washington rallied—thanks in large part to a little-known, top-secret group called the Culper Spy Ring. He realized that he couldn’t defeat the British with military might, so he recruited a sophisticated and deeply secretive intelligence network to infiltrate New York.
Drawing on extensive research, Brian Kilmeade and Don Yaeger have offered fascinating portraits of these spies: a reserved Quaker merchant, a tavern keeper, a brash young longshoreman, a curmudgeonly Long Island bachelor, a coffeehouse owner, and a mysterious woman. Long unrecognized, the secret six are finally receiving their due among the pantheon of American heroes.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (18, N'A Manual for Writers of Research Papers, Theses, and Dissertations, Ninth Edition: Chicago Style for Students and Researchers', N'Kate L. Turabian', N'University of Chicago Press', CAST(N'2018-03-26' AS Date), N'9780226430577', 9, 464, N'When Kate L. Turabian first put her famous guidelines to paper, she could hardly have imagined the world in which today''s students would be conducting research. Yet while the ways in which we research and compose papers may have changed, the fundamentals remain the same: writers need to have a strong research question, construct an evidence-based argument, cite their sources, and structure their work in a logical way. A Manual for Writers of Research Papers, Theses, and Dissertations--also known as "Turabian"--remains one of the most popular books for writers because of its timeless focus on achieving these goals. This new edition filters decades of expertise into modern standards. While previous editions incorporated digital forms of research and writing, this edition goes even further to build information literacy, recognizing that most students will be doing their work largely or entirely online and on screens. Chapters include updated advice on finding, evaluating, and citing a wide range of digital sources and also recognize the evolving use of software for citation management, graphics, and paper format and submission. The ninth edition is fully aligned with the recently released Chicago Manual of Style, 17th edition, as well as with the latest edition of The Craft of Research. Teachers and users of the previous editions will recognize the familiar three-part structure. Part 1 covers every step of the research and writing process, including drafting and revising. Part 2 offers a comprehensive guide to Chicago''s two methods of source citation: notes-bibliography and author-date. Part 3 gets into matters of editorial style and the correct way to present quotations and visual material. Manual for Writers also covers an issue familiar to writers of all levels: how to conquer the fear of tackling a major writing project. Through eight decades and millions of copies, A Manual for Writers has helped generations shape their ideas into compelling research papers. This new edition will continue to be the gold standard for college and graduate students in virtually all academic disciplines.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (19, N'Workman Publishing Everything You Need to Ace English Language Arts in One Big Fat Notebook (Big Fat Notebooks)', N'Workman Publishing', N'Workman Publishing Company', CAST(N'2016-08-09' AS Date), N'9780761160915', 12, 512, N'It s the revolutionary English language arts study guide just for middle school students from the brains behind Brain Quest. Everything You Need to Ace English Language Arts . . . takes students from grammar to reading comprehension to writing with ease, including parts of speech, active and passive verbs, Greek and Latin roots and affixes; nuances in word meanings; textual analysis, authorship, structure, and other skills for reading fiction and nonfiction; and writing arguments, informative texts, and narratives. The BIG FAT NOTEBOOK™ series is built on a simple and irresistible conceit borrowing the notes from the smartest kid in class. There are five books in all, and each is the only book you need for each main subject taught in middle school: Math, Science, AmericanHistory, English Language Arts, and WorldHistory. Inside the reader will find every subject s key concepts, easily digested and summarized. The BIG FAT NOTEBOOKS meet Common Core State Standards, Next Generation Science Standards, and stateHistory standards, and are vetted by National and State Teacher of the Year Award winning teachers. They make learning fun, and are the perfect next step for every kid who grew up on Brain Quest.', 1)
INSERT [dbo].[BookDetail] ([BookNo], [Title], [Author], [Publisher], [YPublished], [ISBN], [ShelfNo], [Pages], [Description], [Status]) VALUES (20, N'Hidden Figures: The American Dream and the Untold Story of the Black Women Mathematicians Who Helped Win the Space Race', N'Margot Lee Shetterly', N'William Morrow', CAST(N'2016-12-06' AS Date), N'9780062363602', 12, 368, N'The #1 New York Times bestseller
The phenomenal true story of the black female mathematicians at NASA whose calculations helped fuel some of America’s greatest achievements in space. Now a major motion picture starring Taraji P. Henson, Octavia Spencer, Janelle Monae, Kirsten Dunst, and Kevin Costner.
Before John Glenn orbited the earth, or Neil Armstrong walked on the moon, a group of dedicated female mathematicians known as “human computers” used pencils, slide rules and adding machines to calculate the numbers that would launch rockets, and astronauts, into space.
Among these problem-solvers were a group of exceptionally talented African American women, some of the brightest minds of their generation. Originally relegated to teaching math in the South’s segregated public schools, they were called into service during the labor shortages of World War II, when America’s aeronautics industry was in dire need of anyone who had the right stuff. Suddenly, these overlooked math whizzes had a shot at jobs worthy of their skills, and they answered Uncle Sam’s call, moving to Hampton, Virginia and the fascinating, high-energy world of the Langley Memorial Aeronautical Laboratory.
Even as Virginia’s Jim Crow laws required them to be segregated from their white counterparts, the women of Langley’s all-black “West Computing” group helped America achieve one of the things it desired most: a decisive victory over the Soviet Union in the Cold War, and complete domination of the heavens.
Starting in World War II and moving through to the Cold War, the Civil Rights Movement and the Space Race, Hidden Figures follows the interwoven accounts of Dorothy Vaughan, Mary Jackson, Katherine Johnson and Christine Darden, four African American women who participated in some of NASA’s greatest successes. It chronicles their careers over nearly three decades they faced challenges, forged alliances and used their intellect to change their own lives, and their country’s future.', 1)
SET IDENTITY_INSERT [dbo].[BookDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[BookItem] ON 

INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (1, 1, N'200812-0001-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (2, 1, N'201106-0001-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (3, 1, N'201506-0001-03', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (4, 2, N'201506-0002-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (5, 2, N'201603-0002-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (6, 2, N'201806-0002-03', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (7, 3, N'201712-0003-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (8, 3, N'201712-0003-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (9, 4, N'201112-0004-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (10, 4, N'201206-0004-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (11, 4, N'201506-0004-03', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (12, 5, N'201512-0005-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (13, 6, N'201512-0006-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (14, 6, N'201603-0006-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (15, 7, N'200309-0007-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (16, 8, N'201009-0008-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (17, 8, N'201503-0008-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (18, 9, N'201706-0009-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (19, 9, N'201706-0009-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (20, 10, N'201706-0010-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (21, 10, N'201706-0010-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (22, 11, N'201812-0011-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (23, 11, N'201909-0011-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (24, 12, N'202006-0012-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (25, 13, N'201506-0013-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (26, 13, N'2019012-0013-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (27, 14, N'200509-0014-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (28, 14, N'201506-0014-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (29, 15, N'201812-0015-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (30, 15, N'201906-0015-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (31, 16, N'201306-0016-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (32, 16, N'201503-0016-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (33, 17, N'201612-0017-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (34, 18, N'201812-0018-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (35, 18, N'201812-0018-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (36, 19, N'201609-0019-01', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (37, 19, N'201609-0019-02', 1)
INSERT [dbo].[BookItem] ([ItemNo], [BookNo], [BookID], [Status]) VALUES (38, 20, N'201612-0020-01', 1)
SET IDENTITY_INSERT [dbo].[BookItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (1, N'Architecture')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (2, N'Arts & Photography')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (3, N'Biograpies & Memoir')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (4, N'Business & Investing')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (5, N'Children''s Book')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (6, N'Computers & Technology')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (7, N'Cookbooks, Foods & Wines')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (8, N'Crafts, Hobbies & Home')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (9, N'Drawing & Painting')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (10, N'Fashion')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (11, N'History')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (12, N'Humor & Entertainment')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (13, N'Law')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (14, N'Literature & Fiction')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (15, N'Medical Books')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (16, N'Music')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (17, N'Mystery, Thriller & Suspense')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (18, N'Politcal & Social Sciences')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (19, N'Self-Help')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (20, N'Reference')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (21, N'Romance')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (22, N'Sci-Fi & Fantasy')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (23, N'Science & Math')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (24, N'Sports & Outdoors')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (25, N'Textbook & Workbook')
INSERT [dbo].[Category] ([CategoryNo], [CategoryName]) VALUES (26, N'Travel')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[ImageLink] ON 

INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (1, 0x696D6167655C626F6F6B735C426F6F6B4E6F315F436F7665722E706E67, 1, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (2, 0x696D6167655C626F6F6B735C426F6F6B4E6F315F696D67312E6A7067, 1, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (3, 0x696D6167655C626F6F6B735C426F6F6B4E6F315F696D67322E706E67, 1, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (4, 0x696D6167655C626F6F6B735C426F6F6B4E6F325F436F7665722E6A7067, 2, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (5, 0x696D6167655C626F6F6B735C426F6F6B4E6F325F696D67312E6A7067, 2, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (6, 0x696D6167655C626F6F6B735C426F6F6B4E6F325F696D67322E6A7067, 2, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (7, 0x696D6167655C626F6F6B735C426F6F6B4E6F335F436F7665722E706E67, 3, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (8, 0x696D6167655C626F6F6B735C426F6F6B4E6F335F696D67312E706E67, 3, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (9, 0x696D6167655C626F6F6B735C426F6F6B4E6F335F696D67322E706E67, 3, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (10, 0x696D6167655C626F6F6B735C426F6F6B4E6F345F436F7665722E6A7067, 4, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (11, 0x696D6167655C626F6F6B735C426F6F6B4E6F345F696D67312E6A7067, 4, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (12, 0x696D6167655C626F6F6B735C426F6F6B4E6F345F696D67322E6A7067, 4, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (13, 0x696D6167655C626F6F6B735C426F6F6B4E6F355F436F7665722E6A7067, 5, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (14, 0x696D6167655C626F6F6B735C426F6F6B4E6F355F696D67312E6A7067, 5, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (15, 0x696D6167655C626F6F6B735C426F6F6B4E6F355F696D67322E6A7067, 5, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (16, 0x696D6167655C626F6F6B735C426F6F6B4E6F365F436F7665722E6A7067, 6, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (17, 0x696D6167655C626F6F6B735C426F6F6B4E6F365F696D67312E6A7067, 6, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (18, 0x696D6167655C626F6F6B735C426F6F6B4E6F365F696D67322E6A7067, 6, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (19, 0x696D6167655C626F6F6B735C426F6F6B4E6F375F436F7665722E6A7067, 7, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (20, 0x696D6167655C626F6F6B735C426F6F6B4E6F375F696D67312E6A7067, 7, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (21, 0x696D6167655C626F6F6B735C426F6F6B4E6F375F696D67322E6A7067, 7, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (22, 0x696D6167655C626F6F6B735C426F6F6B4E6F385F436F7665722E6A7067, 8, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (23, 0x696D6167655C626F6F6B735C426F6F6B4E6F385F696D67312E6A7067, 8, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (24, 0x696D6167655C626F6F6B735C426F6F6B4E6F385F696D67372E6A7067, 8, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (25, 0x696D6167655C626F6F6B735C426F6F6B4E6F395F436F7665722E6A7067, 9, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (26, 0x696D6167655C626F6F6B735C426F6F6B4E6F395F696D67312E6A7067, 9, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (27, 0x696D6167655C626F6F6B735C426F6F6B4E6F395F696D67322E6A7067, 9, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (28, 0x696D6167655C626F6F6B735C426F6F6B4E6F31305F436F7665722E6A7067, 10, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (29, 0x696D6167655C626F6F6B735C426F6F6B4E6F31305F696D67312E6A7067, 10, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (30, 0x696D6167655C626F6F6B735C426F6F6B4E6F31305F696D67322E6A7067, 10, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (31, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3431654F5830634254384C2E5F53583333315F424F312C3230342C3230332C3230305F2E6A7067, 11, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (32, 0x68747470733A2F2F7777772E64772E636F6D2F696D6167652F34353931343938345F3330332E6A7067, 11, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (33, 0x68747470733A2F2F73332D65752D776573742D312E616D617A6F6E6177732E636F6D2F7472612D726766652F6173736574732F323135372F6C617267655F52656164696E675F67726F75705F71756F74652E6A7067, 11, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (34, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F35314136447753567A394C2E5F53583331315F424F312C3230342C3230332C3230305F2E6A7067, 12, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (35, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3531303671327948796B4C2E6A7067, 12, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (36, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38317A704C68503167574C2E6A7067, 13, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (37, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931626D313761326A464C2E6A7067, 13, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (38, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3331416C334470754B2D4C2E6A7067, 13, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (39, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F34314D54697A2D4935484C2E5F53583332365F424F312C3230342C3230332C3230305F2E6A7067, 14, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (40, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F383147564A38777275454C2E6A7067, 14, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (41, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F35315066504E6259574C4C2E5F53583339315F424F312C3230342C3230332C3230305F2E6A7067, 15, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (42, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38315253746159416C594C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (43, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38317879744455316C464C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (44, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38317145536B483434534C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (45, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38317A692B746C4F70684C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (46, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F383177596E38387473614C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (47, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F383163536C6946376C644C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (48, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931374A56344E59386D4C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (49, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38317232594E363653494C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (50, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F37315A61584934696F614C2E6A7067, 15, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (51, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F38316C586979545937314C2E6A7067, 16, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (52, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F353133343473532B775A4C2E6A7067, 16, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (53, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931675961557A414A794C2E6A7067, 17, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (54, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3431746A4D35635442584C2E6A7067, 17, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (55, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F36316E564A305A65725A4C2E6A7067, 18, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (56, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F37316C3747594B6556344C2E6A7067, 18, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (57, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3331627A44743259452D4C2E6A7067, 18, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (58, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F353166776267394E434A4C2E6A7067, 19, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (59, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F393172686565453543524C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (60, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931332D6755727138794C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (61, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F393156436E53366443384C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (62, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931585A5272584E61704C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (63, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931677131556C6B785A4C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (64, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F3931386B3557345868704C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (65, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F333142744C2D686935564C2E6A7067, 19, 0, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (66, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F37314730514D4F70444E4C2E6A7067, 20, 1, 1)
INSERT [dbo].[ImageLink] ([ImgNo], [ImgLink], [BookNo], [IsCover], [Status]) VALUES (67, 0x68747470733A2F2F696D616765732D6E612E73736C2D696D616765732D616D617A6F6E2E636F6D2F696D616765732F492F383164666974396B59704C2E6A7067, 20, 0, 1)
SET IDENTITY_INSERT [dbo].[ImageLink] OFF
GO
SET IDENTITY_INSERT [dbo].[LendingHistory] ON 

INSERT [dbo].[LendingHistory] ([LendNo], [AccountNo], [ItemNo], [DIssued], [DReturned], [Status]) VALUES (6, 33, 9, CAST(N'2020-01-01' AS Date), CAST(N'2020-01-07' AS Date), 1)
SET IDENTITY_INSERT [dbo].[LendingHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Shelf] ON 

INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (1, N'A-01', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (2, N'A-02', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (3, N'A-03', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (4, N'B-01', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (5, N'B-02', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (6, N'B-03', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (7, N'C-01', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (8, N'C-02', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (9, N'C-03', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (10, N'D-01', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (11, N'D-02', 1)
INSERT [dbo].[Shelf] ([ShelfNo], [ShelfName], [Status]) VALUES (12, N'D-03', 1)
SET IDENTITY_INSERT [dbo].[Shelf] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (getdate()) FOR [DJoined]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((100)) FOR [Point]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[BookDetail] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[BookItem] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ImageLink] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[LendingHistory] ADD  DEFAULT (getdate()) FOR [DIssued]
GO
ALTER TABLE [dbo].[LendingHistory] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Reservation] ADD  DEFAULT (getdate()) FOR [DReserve]
GO
ALTER TABLE [dbo].[Reservation] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Shelf] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[BookCategory]  WITH CHECK ADD FOREIGN KEY([BookNo])
REFERENCES [dbo].[BookDetail] ([BookNo])
GO
ALTER TABLE [dbo].[BookCategory]  WITH CHECK ADD FOREIGN KEY([CategoryNo])
REFERENCES [dbo].[Category] ([CategoryNo])
GO
ALTER TABLE [dbo].[BookDetail]  WITH CHECK ADD FOREIGN KEY([ShelfNo])
REFERENCES [dbo].[Shelf] ([ShelfNo])
GO
ALTER TABLE [dbo].[BookItem]  WITH CHECK ADD FOREIGN KEY([BookNo])
REFERENCES [dbo].[BookDetail] ([BookNo])
GO
ALTER TABLE [dbo].[Fine]  WITH CHECK ADD FOREIGN KEY([LendNo])
REFERENCES [dbo].[LendingHistory] ([LendNo])
GO
ALTER TABLE [dbo].[ImageLink]  WITH CHECK ADD FOREIGN KEY([BookNo])
REFERENCES [dbo].[BookDetail] ([BookNo])
GO
ALTER TABLE [dbo].[LendingHistory]  WITH CHECK ADD FOREIGN KEY([AccountNo])
REFERENCES [dbo].[Account] ([AccountNo])
GO
ALTER TABLE [dbo].[LendingHistory]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[BookItem] ([ItemNo])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([AccountNo])
REFERENCES [dbo].[Account] ([AccountNo])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[BookItem] ([ItemNo])
GO
/****** Object:  StoredProcedure [dbo].[getAccountInFo]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getAccountInFo](@LibraryID VARCHAR(10))
AS BEGIN
	SELECT * FROM Account
	WHERE LibraryID = @LibraryID
END
GO
/****** Object:  StoredProcedure [dbo].[getAllBook]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*====== PROCEDURES ======*/
CREATE PROC [dbo].[getAllBook]
AS BEGIN
	SELECT * FROM BookDetail
END
GO
/****** Object:  StoredProcedure [dbo].[getAllCategory]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getAllCategory]
AS BEGIN
	SELECT * FROM Category
END
GO
/****** Object:  StoredProcedure [dbo].[getBookbyGenre]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getBookbyGenre]
AS BEGIN
	DECLARE @Category TABLE(CategoryName VARCHAR)
	SELECT BD.BookNo, BD.Title, BD.Author, BD.Publisher, BD.YPublished, BD.ISBN, BD.ShelfNo, BD.Description, BD.Status FROM BookDetail BD JOIN BookCategory BC ON BD.BookNo = BC.BookNo JOIN Category C ON C.CategoryNo = BC.CategoryNo
	WHERE C.CategoryName IN (SELECT CategoryName FROM @Category)
END
GO
/****** Object:  StoredProcedure [dbo].[getBookCover]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getBookCover] (@BookNo INT)
AS BEGIN
	SELECT ImgLink FROM ImageLink
	WHERE BookNo = @BookNo AND IsCover = 1
END
GO
/****** Object:  StoredProcedure [dbo].[getBookImg]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getBookImg] (@BookNo INT)
AS BEGIN
	SELECT * FROM ImageLink
	WHERE BookNo = @BookNo
END
GO
/****** Object:  StoredProcedure [dbo].[getBookItem]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getBookItem] (@BookNo INT)
AS BEGIN
	SELECT * FROM BookItem
	WHERE BookNo = @BookNo
END
GO
/****** Object:  StoredProcedure [dbo].[getBookRecord]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getBookRecord] (@BookNo INT)
AS BEGIN
	SELECT * FROM BookDetail
	WHERE BookNo = @BookNo
END
GO
/****** Object:  StoredProcedure [dbo].[getItemNo]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getItemNo](@BookID VARCHAR(15))
AS BEGIN
	SELECT * FROM BookItem
	WHERE BookID = @BookID
END
GO
/****** Object:  StoredProcedure [dbo].[getShelfLocation]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getShelfLocation] (@ShelfNo INT)
AS BEGIN
	SELECT ShelfName FROM Shelf
	WHERE ShelfNo = @ShelfNo
END
GO
/****** Object:  StoredProcedure [dbo].[reserveBook]    Script Date: 7/24/2020 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[reserveBook](@ItemNo INT, @AccountNo INT)
AS BEGIN
	INSERT INTO Reservation(ItemNo, AccountNo, DReserve)
	VALUES (@ItemNo, @AccountNo, GETDATE())
END
GO
USE [master]
GO
ALTER DATABASE [LibrarySystem_test] SET  READ_WRITE 
GO

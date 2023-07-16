USE master;
GO

CREATE DATABASE Bookshelf;
GO

USE Bookshelf;
GO

CREATE TABLE dbo.Shelfs (
    ShelfID INT PRIMARY KEY IDENTITY(1, 1),
    ShelfName NVARCHAR(64) UNIQUE
);
GO

CREATE TABLE dbo.Generes (
    GenereID INT PRIMARY KEY IDENTITY(1, 1),
    GenereName NVARCHAR(32) UNIQUE
);
GO

CREATE TABLE dbo.Books (
    BookID INT PRIMARY KEY IDENTITY(1, 1),
    Title NVARCHAR(128) NOT NULL,
    PurchaseDate DATE NOT NULL,
    GenereID INT NOT NULL,
    ReadCount INT NOT NULL DEFAULT 0,
    ShelfID INT NOT NULL,

    CONSTRAINT CHK_Books_PurchaseDate CHECK (PurchaseDate <= GETDATE()),

    CONSTRAINT CHK_Books_ReadCount CHECK (ReadCount >= 0),

    CONSTRAINT FK_Books_Generes FOREIGN KEY (GenereID)
    REFERENCES dbo.Generes(GenereID),

    CONSTRAINT FK_Books_Shelfs FOREIGN KEY (ShelfID)
    REFERENCES dbo.Shelfs(ShelfID)
);
GO

CREATE TABLE dbo.Authors (
    AuthorID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(32) NOT NULL,
    LastName NVARCHAR(32),

    UNIQUE(FirstName, LastName)
);
GO

CREATE TABLE dbo.BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,

    PRIMARY KEY(BookID, AuthorID),

    CONSTRAINT FK_BookAuthors_Books FOREIGN KEY (BookID)
    REFERENCES dbo.Books(BookID),

    CONSTRAINT FK_BookAuthors_Authors FOREIGN KEY (AuthorID)
    REFERENCES dbo.Authors(AuthorID)
);
GO

INSERT INTO dbo.Shelfs (ShelfName)
VALUES ('Półka 1'), ('Półka 2'), ('Półka 3');

INSERT INTO dbo.Generes (GenereName)
VALUES ('Fantasy'), ('Sci-Fi'), ('Romans'), ('Kryminał');

INSERT INTO dbo.Books (Title, PurchaseDate, GenereID, ReadCount, ShelfID)
VALUES ('Harry Potter and the Philosopher''s Stone', '2022-01-15', 1, 5, 1),
('Dune', '2021-12-10', 2, 3, 1),
('Pride and Prejudice', '2023-05-02', 3, 1, 2),
('The Girl with the Dragon Tattoo', '2023-02-28', 4, 2, 2),
('The Hobbit', '2022-03-20', 1, 4, 3);

INSERT INTO dbo.Authors (FirstName, LastName)
VALUES ('J.K.', 'Rowling'),
('Frank', 'Herbert'),
('Jane', 'Austen'),
('Stieg', 'Larsson'),
('J.R.R.', 'Tolkien');

INSERT INTO dbo.BookAuthors (BookID, AuthorID)
VALUES (1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
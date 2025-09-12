CREATE DATABASE Personal_Finance_Bot_Web;
GO

USE Personal_Finance_Bot_Web;
GO

-- Bảng Người dùng
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100),
	Phone NVARCHAR(15) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng Danh mục chi tiêu (ăn uống, học tập, giải trí, ...)
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

-- Bảng Giao dịch (chi tiêu hoặc thu nhập)
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CategoryID INT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Type NVARCHAR(10) CHECK (Type IN ('Income','Expense')),
    Note NVARCHAR(255),
    TransactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Bảng Ngân sách (đặt giới hạn chi tiêu cho từng danh mục)
CREATE TABLE Budgets (
    BudgetID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CategoryID INT NOT NULL,
    LimitAmount DECIMAL(18,2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Bảng Bot Logs (lưu tin nhắn mà user chat với bot)
CREATE TABLE BotLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Message NVARCHAR(MAX),
    BotResponse NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
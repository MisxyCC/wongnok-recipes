DROP DATABASE IF EXISTS FoodRecipeDB;
GO

-- Create the database
CREATE DATABASE FoodRecipeDB;
GO

-- Switch to the newly created database context
USE FoodRecipeDB;
GO

-- Table: User
-- Stores information about users
CREATE TABLE [User] (
    UserUUID NVARCHAR(255) NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Username NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME2 NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (UserUUID)
);
GO

-- Table: Difficulty
-- Stores different difficulty levels for recipes
CREATE TABLE Difficulty (
    DifficultyUUID NVARCHAR(255) NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Difficulty PRIMARY KEY (DifficultyUUID)
);
GO

-- Table: TimeUsed
-- Stores categories for time taken to prepare recipes
CREATE TABLE TimeUsed (
    TimeUUID NVARCHAR(255) NOT NULL,
    TimeUsed NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TimeUsed PRIMARY KEY (TimeUUID)
);
GO

-- Table: FoodReceipt
-- Stores details about food recipes
CREATE TABLE FoodReceipt (
    FoodUUID NVARCHAR(255) NOT NULL,
    UserUUID NVARCHAR(255) NULL,         
    Name NVARCHAR(255) NOT NULL,
    ImageUrl NVARCHAR(255) NULL,          
    Ingredients NVARCHAR(MAX) NOT NULL,    
    DifficultyID NVARCHAR(255) NOT NULL,  
    Steps NVARCHAR(MAX) NOT NULL,          
    TimeID NVARCHAR(255) NOT NULL,         
    LastUpdated DATETIME2 NOT NULL,
    CONSTRAINT PK_FoodReceipåt PRIMARY KEY (FoodUUID)
);
GO

-- Table: Review
-- Stores user reviews for food recipes
CREATE TABLE Review (
    ReviewUUID NVARCHAR(255) NOT NULL,
    FoodReceiptUUID NVARCHAR(255) NOT NULL, 
    Details NVARCHAR(MAX) NOT NULL,        
    Rating TINYINT NOT NULL,               
    LastUpdated DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,      
    CONSTRAINT PK_Review PRIMARY KEY (ReviewUUID),
    CONSTRAINT CK_Rating CHECK (Rating >= 1 AND Rating <= 5)
);
GO


-- Foreign Key: FoodReceipt.UserUUID -> User.UserUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_User FOREIGN KEY (UserUUID)
REFERENCES [User](UserUUID)
ON DELETE SET NULL
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipt.DifficultyID -> Difficulty.DifficultyUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_Difficulty FOREIGN KEY (DifficultyID)
REFERENCES Difficulty(DifficultyUUID)
ON DELETE NO ACTION
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipt.TimeID -> TimeUsed.TimeUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_TimeUsed FOREIGN KEY (TimeID)
REFERENCES TimeUsed(TimeUUID)
ON DELETE NO ACTION
ON UPDATE CASCADE;
GO

-- Foreign Key: Review.FoodReceiptUUID -> FoodReceipt.FoodUUID (Added this FK as it's logically necessary for a review)
ALTER TABLE Review
ADD CONSTRAINT FK_Review_FoodReceipt FOREIGN KEY (FoodReceiptUUID)
REFERENCES FoodReceipt(FoodUUID)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO

-- Foreign Key: Review.UpdatedBy -> User.UserUUID
ALTER TABLE Review
ADD CONSTRAINT FK_Review_User FOREIGN KEY (UpdatedBy)
REFERENCES [User](UserUUID)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO

PRINT 'Database FoodRecipeDB and tables created successfully with foreign key constraints.';
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
    Password NVARCHAR(255) NOT NULL, -- In a real application, passwords should be hashed
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
    TimeUsed NVARCHAR(255) NOT NULL, -- e.g., '30 minutes', '1 hour'
    CONSTRAINT PK_TimeUsed PRIMARY KEY (TimeUUID)
);
GO

-- Table: FoodReceipt
-- Stores details about food recipes
CREATE TABLE FoodReceipt (
    FoodUUID NVARCHAR(255) NOT NULL,
    UserUUID NVARCHAR(255) NULL,          -- Foreign Key to User table, can be NULL if recipe is anonymous or system-generated
    Name NVARCHAR(255) NOT NULL,
    ImageUrl NVARCHAR(255) NULL,          -- URL of the food image, can be NULL
    Ingredients NVARCHAR(MAX) NOT NULL,    -- Changed from nvarchar(512) to NVARCHAR(MAX) for longer ingredient lists
    DifficultyID NVARCHAR(255) NOT NULL,  -- Foreign Key to Difficulty table
    Steps NVARCHAR(MAX) NOT NULL,          -- Changed from nvarchar(512) to NVARCHAR(MAX) for detailed steps
    TimeID NVARCHAR(255) NOT NULL,         -- Foreign Key to TimeUsed table
    LastUpdated DATETIME2 NOT NULL,
    CONSTRAINT PK_FoodReceipåt PRIMARY KEY (FoodUUID)
);
GO

-- Table: Review
-- Stores user reviews for food recipes
CREATE TABLE Review (
    ReviewUUID NVARCHAR(255) NOT NULL,
    FoodReceiptUUID NVARCHAR(255) NOT NULL, -- Foreign Key to FoodReceipt table (assuming a review is FOR a FoodReceipt)
    Details NVARCHAR(MAX) NOT NULL,        -- Changed from nvarchar(255) to NVARCHAR(MAX) for longer reviews
    Rating TINYINT NOT NULL,               -- Rating, e.g., 1 to 5
    LastUpdated DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,      -- Foreign Key to User table (user who wrote/updated the review)
    CONSTRAINT PK_Review PRIMARY KEY (ReviewUUID),
    CONSTRAINT CK_Rating CHECK (Rating >= 1 AND Rating <= 5) -- Example check constraint for rating
);
GO

-- Add Foreign Key Constraints

-- Foreign Key: FoodReceipt.UserUUID -> User.UserUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_User FOREIGN KEY (UserUUID)
REFERENCES [User](UserUUID)
ON DELETE SET NULL -- Or ON DELETE NO ACTION / CASCADE depending on requirements
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipt.DifficultyID -> Difficulty.DifficultyUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_Difficulty FOREIGN KEY (DifficultyID)
REFERENCES Difficulty(DifficultyUUID)
ON DELETE NO ACTION -- Or SET NULL if a recipe can exist without a difficulty after deletion
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipt.TimeID -> TimeUsed.TimeUUID
ALTER TABLE FoodReceipt
ADD CONSTRAINT FK_FoodReceipt_TimeUsed FOREIGN KEY (TimeID)
REFERENCES TimeUsed(TimeUUID)
ON DELETE NO ACTION -- Or SET NULL if a recipe can exist without a time category after deletion
ON UPDATE CASCADE;
GO

-- Foreign Key: Review.FoodReceiptUUID -> FoodReceipt.FoodUUID (Added this FK as it's logically necessary for a review)
ALTER TABLE Review
ADD CONSTRAINT FK_Review_FoodReceipt FOREIGN KEY (FoodReceiptUUID)
REFERENCES FoodReceipt(FoodUUID)
ON DELETE CASCADE -- If a recipe is deleted, its reviews are also deleted
ON UPDATE CASCADE;
GO

-- Foreign Key: Review.UpdatedBy -> User.UserUUID
ALTER TABLE Review
ADD CONSTRAINT FK_Review_User FOREIGN KEY (UpdatedBy)
REFERENCES [User](UserUUID)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO

-- Verify the tables and constraints (Optional informational queries)
/*
SELECT 
    TABLE_NAME
FROM 
    INFORMATION_SCHEMA.TABLES 
WHERE 
    TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='FoodRecipeDB';

SELECT 
    CONSTRAINT_NAME, 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_TYPE
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE 
    tc.TABLE_CATALOG='FoodRecipeDB'
ORDER BY
    TABLE_NAME, CONSTRAINT_TYPE;

EXEC sp_help '[User]';
EXEC sp_help 'Difficulty';
EXEC sp_help 'TimeUsed';
EXEC sp_help 'FoodReceipt';
EXEC sp_help 'Review';
*/

PRINT 'Database FoodRecipeDB and tables created successfully with foreign key constraints.';
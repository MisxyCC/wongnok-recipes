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
CREATE TABLE Users (
    UserUUID NVARCHAR(255) NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Username NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME2 NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (UserUUID)
);
GO

-- Table: Difficulties
-- Stores different Difficulties levels for recipes
CREATE TABLE Difficulties (
    DifficultiesUUID NVARCHAR(255) NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Difficulties PRIMARY KEY (DifficultiesUUID)
);
GO

-- Table: TimeUseds
-- Stores categories for time taken to prepare recipes
CREATE TABLE TimeUseds (
    TimeUUID NVARCHAR(255) NOT NULL,
    TimeUseds NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TimeUseds PRIMARY KEY (TimeUUID)
);
GO

-- Table: FoodReceipts
-- Stores details about food recipes
CREATE TABLE FoodReceipts (
    FoodUUID NVARCHAR(255) NOT NULL,
    UserUUID NVARCHAR(255) NULL,         
    Name NVARCHAR(255) NOT NULL,
    ImageUrl NVARCHAR(255) NULL,          
    Ingredients NVARCHAR(MAX) NOT NULL,    
    DifficultiesID NVARCHAR(255) NOT NULL,  
    Steps NVARCHAR(MAX) NOT NULL,          
    TimeID NVARCHAR(255) NOT NULL,         
    LastUpdated DATETIME2 NOT NULL,
    CONSTRAINT PK_FoodReceipåt PRIMARY KEY (FoodUUID)
);
GO

-- Table: Reviews
-- Stores user Reviewss for food recipes
CREATE TABLE Reviews (
    ReviewsUUID NVARCHAR(255) NOT NULL,
    FoodReceiptsUUID NVARCHAR(255) NOT NULL, 
    Details NVARCHAR(MAX) NOT NULL,        
    Rating TINYINT NOT NULL,               
    LastUpdated DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,      
    CONSTRAINT PK_Reviews PRIMARY KEY (ReviewsUUID),
    CONSTRAINT CK_Rating CHECK (Rating >= 1 AND Rating <= 5)
);
GO


-- Foreign Key: FoodReceipts.UserUUID -> User.UserUUID
ALTER TABLE FoodReceipts
ADD CONSTRAINT FK_FoodReceipts_User FOREIGN KEY (UserUUID)
REFERENCES Users(UserUUID)
ON DELETE SET NULL
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipts.DifficultiesID -> Difficulties.DifficultiesUUID
ALTER TABLE FoodReceipts
ADD CONSTRAINT FK_FoodReceipts_Difficulties FOREIGN KEY (DifficultiesID)
REFERENCES Difficulties(DifficultiesUUID)
ON DELETE NO ACTION
ON UPDATE CASCADE;
GO

-- Foreign Key: FoodReceipts.TimeID -> TimeUseds.TimeUUID
ALTER TABLE FoodReceipts
ADD CONSTRAINT FK_FoodReceipts_TimeUseds FOREIGN KEY (TimeID)
REFERENCES TimeUseds(TimeUUID)
ON DELETE NO ACTION
ON UPDATE CASCADE;
GO

-- Foreign Key: Reviews.FoodReceiptsUUID -> FoodReceipts.FoodUUID (Added this FK as it's logically necessary for a Reviews)
ALTER TABLE Reviews
ADD CONSTRAINT FK_Reviews_FoodReceipts FOREIGN KEY (FoodReceiptsUUID)
REFERENCES FoodReceipts(FoodUUID)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO

-- Foreign Key: Reviews.UpdatedBy -> User.UserUUID
ALTER TABLE Reviews
ADD CONSTRAINT FK_Reviews_User FOREIGN KEY (UpdatedBy)
REFERENCES Users(UserUUID)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO

PRINT 'Database FoodRecipeDB and tables created successfully with foreign key constraints.';
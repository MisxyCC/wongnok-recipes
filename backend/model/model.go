package model

import (
	"time"

	"github.com/google/uuid"
)

// Users struct to represent the "Users" table
type Users struct {
	UserUUID     uuid.UUID     `gorm:"type:uniqueidentifier;column:UserUUID;primaryKey;default:newid()" json:"user_uuid"`
	Name         string        `gorm:"type:nvarchar(255);column:Name;not null" json:"name"`
	Username     string        `gorm:"type:nvarchar(255);column:Username;not null" json:"username"`
	Password     string        `gorm:"type:nvarchar(255);;column:Password;not null" json:"password"`
	CreatedDate  time.Time     `gorm:"type:datetime2;column:CreatedDate;not null" json:"created_date"`
	FoodReceipts []FoodReceipts `gorm:"foreignKey:UserUUID;references:UserUUID" json:"food_receipts"` // Relationship with FoodReceipt
	Reviews      []Reviews      `gorm:"foreignKey:UpdatedBy;references:UserUUID" json:"reviews"`      // Relationship with Review (as UpdatedBy)
}

// Difficulties struct to represent the "Difficulties" table
type Difficulties struct {
	DifficultyUUID uuid.UUID     `gorm:"type:uniqueidentifier;primaryKey;default:newid()" json:"difficulty_uuid"`
	Name           string        `gorm:"type:nvarchar(255);not null" json:"name"`
	FoodReceipts   []FoodReceipts `gorm:"foreignKey:DifficultyID;references:DifficultyUUID" json:"food_receipts"` // Relationship with FoodReceipt
}

// TimeUseds struct to represent the "TimeUseds" table
type TimeUseds struct {
	TimeUUID     string        `gorm:"type:nvarchar(255);primaryKey" json:"time_uuid"`
	TimeUsed     string        `gorm:"type:nvarchar(255);not null" json:"time_used"`
	FoodReceipts []FoodReceipts `gorm:"foreignKey:TimeID;references:TimeUUID" json:"food_receipts"` // Relationship with FoodReceipt
}

// FoodReceipts struct to represent the "FoodReceipts" table
type FoodReceipts struct {
	FoodUUID     uuid.UUID  `gorm:"type:uniqueidentifier;primaryKey;default:newid()" json:"food_uuid"`
	UserUUID     uuid.UUID  `gorm:"type:uniqueidentifier;not null" json:"user_uuid"`
	Name         string     `gorm:"type:nvarchar(255);not null" json:"name"`
	ImageUrl     string     `gorm:"type:nvarchar(255)" json:"image_url"`
	Ingredients  string     `gorm:"type:nvarchar(max);not null" json:"ingredients"`
	DifficultyID uuid.UUID  `gorm:"type:uniqueidentifier;not null" json:"difficulty_id"`
	Steps        string     `gorm:"type:nvarchar(max);not null" json:"steps"`
	TimeID       string     `gorm:"type:nvarchar(255);not null" json:"time_id"`
	LastUpdated  time.Time  `gorm:"type:datetime2;not null" json:"last_updated"`
	User         Users      `gorm:"foreignKey:UserUUID;references:UserUUID" json:"user"`                 // Relationship with User
	Difficulty   Difficulties `gorm:"foreignKey:DifficultyID;references:DifficultyUUID" json:"difficulty"` // Relationship with Difficulty
	TimeUsed     TimeUseds   `gorm:"foreignKey:TimeID;references:TimeUUID" json:"time_used"`              // Relationship with TimeUsed
	Reviews      []Reviews   `gorm:"foreignKey:FoodReceiptUUID;references:FoodUUID" json:"reviews"`       // Relationship with Review
}

// Reviews struct to represent the "Reviews" table
type Reviews struct {
	ReviewUUID      uuid.UUID   `gorm:"type:uniqueidentifier;primaryKey;default:newid()" json:"review_uuid"`
	FoodReceiptUUID uuid.UUID   `gorm:"type:uniqueidentifier;not null" json:"food_receipt_uuid"`
	Details         string      `gorm:"type:nvarchar(max);not null" json:"details"`
	Rating          int8        `gorm:"type:tinyint;not null;check:Rating >= 1 AND Rating <= 5" json:"rating"`
	LastUpdated     time.Time   `gorm:"type:datetime2;not null" json:"last_updated"`
	UpdatedBy       uuid.UUID   `gorm:"type:uniqueidentifier;not null" json:"updated_by"`
	FoodReceipt     FoodReceipts `gorm:"foreignKey:FoodReceiptUUID;references:FoodUUID" json:"food_receipt"` // Relationship with FoodReceipt
	User            Users       `gorm:"foreignKey:UpdatedBy;references:UserUUID" json:"user"`               // Relationship with User (as UpdatedBy)
}

type SignUpRequest struct {
	Name     string `json:"name" binding:"required"`
	Username string `json:"username" binding:"required,min=3"`
	Password string `json:"password" binding:"required,min=6"`
}

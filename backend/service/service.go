package service

import (
	"log"
	"misxy/backbone/helper"
	"misxy/backbone/model"
	"net/http"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type UserService interface {
	CreateUser(name, username, password string) (*model.Users, error)
	GetUserByUserName(username string) (*model.Users, error)
}

type userServiceImpl struct {
	db *gorm.DB
}

func NewUserService(db *gorm.DB) UserService {
	return &userServiceImpl{db: db}
}

// CreateUser handles the business logic for creating a new user.
func (s *userServiceImpl) CreateUser(name, username, password string) (*model.Users, error) {
	// Check if username already exists
	var existingUser *model.Users
	if err := s.db.Where("username = ?", username).First(&existingUser).Error; err == nil {
		return nil, &AppError{Message: "Username already exists", Code: http.StatusConflict}
	} else if err != gorm.ErrRecordNotFound {
		return nil, &AppError{Message: "Database error checking username", Code: http.StatusInternalServerError, Underlying: err}
	}

	hashedPassword, err := helper.HashPassword(password)
	if err != nil {
		log.Printf("Error hashing password: %v\n", err)
		return nil, &AppError{Message: "Failed to hash password", Code: http.StatusInternalServerError, Underlying: err}
	}
	user := model.Users{
		UserUUID: uuid.New(),
		Name:     name,
		Username: username,
		Password: hashedPassword,
		CreatedDate: time.Now().UTC(),
	}

	result := s.db.Create(&user)
	if result.Error != nil {
		log.Printf("Error creating user in DB: %v\n", result.Error)
		return nil, &AppError{Message: "Failed to create user", Code: http.StatusInternalServerError, Underlying: result.Error}
	}

	return &user, nil
}

// GetUserByUsername retrieves a user by their username.
func (s *userServiceImpl) GetUserByUserName(username string) (*model.Users, error) {
	var user model.Users
	if err := s.db.Where("username = ?", username).First(&user).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, &AppError{Message: "User not found", Code: http.StatusNotFound, Underlying: err}
		}
		return nil, &AppError{Message: "Database error", Code: http.StatusInternalServerError, Underlying: err}
	}
	return &user, nil
}

// --- Custom Error Handling ---
type AppError struct {
	Code       int
	Message    string
	Underlying error
}

func (e *AppError) Error() string {
	if e.Underlying != nil {
		return e.Message + ": " + e.Underlying.Error()
	}
	return e.Message
}

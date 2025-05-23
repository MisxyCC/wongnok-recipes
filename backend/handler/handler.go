package handler

import (
	"misxy/backbone/model"
	"misxy/backbone/service"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

type UserHandler struct {
	userService service.UserService
}
func NewUserHandler(userService service.UserService) *UserHandler {
	return &UserHandler{userService: userService}
}

func (handler *UserHandler) SignUp(c *gin.Context) {
	var req model.SignUpRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload: " + err.Error()})
		return
	}

	// Basic validation (Gin's binding:"required" already handles some)
	if req.Name == "" || req.Username == "" || req.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Name, username, and password are required"})
		return
	}

	user, err := handler.userService.CreateUser(req.Name, req.Username, req.Password)
	if err != nil {
		if appErr, ok := err.(*service.AppError); ok {
			c.JSON(appErr.Code, gin.H{"error": appErr.Message})
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "An unexpected error occurred"})
		}
		return
	}

	// Return the created user (without password)
	// Create a response struct to control what's sent back
	type SignUpResponse struct {
		UserUUID    string    `json:"user_uuid"`
		Name        string    `json:"name"`
		Username    string    `json:"username"`
		CreatedDate time.Time `json:"created_date"`
	}

	response := SignUpResponse{
		UserUUID:    user.UserUUID.String(),
		Name:        user.Name,
		Username:    user.Username,
		CreatedDate: user.CreatedDate,
	}

	c.JSON(http.StatusCreated, response)
}
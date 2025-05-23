package main

import (
	"log"
	"misxy/backbone/database"
	"misxy/backbone/handler"
	"misxy/backbone/helper"
	"misxy/backbone/service"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

var db *gorm.DB

func main() {
	db = database.ConnectDatabase()
	userService := service.NewUserService(db)
	userHandler := handler.NewUserHandler(userService)

	router := gin.Default()
	router.Use(cors.Default())
	router.GET("/healthcheck", helper.HealthCheck)
	router.POST("/signup", userHandler.SignUp)
	log.Printf("Server starting on port 8081")
	if err := router.Run("0.0.0.0:8081"); err != nil {
		log.Fatalf("Failed to run server: %v", err)
	}
}
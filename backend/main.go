package main

import (
	"misxy/backbone/helper"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
)

func main() {
	router := gin.Default()
	router.Use(cors.Default())
	router.GET("/healthcheck", helper.HealthCheck)
	router.Run("0.0.0.0:8081")
}

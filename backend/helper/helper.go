package helper

import (
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
)

func HealthCheck(ctx *gin.Context) {
	hostName, _ := os.Hostname()
	ctx.JSON(http.StatusOK, gin.H {
		"service": hostName,
		"status": "UP",
		"timestamp": time.Now(),
	})
}
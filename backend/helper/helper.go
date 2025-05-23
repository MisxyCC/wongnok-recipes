package helper

import (
	"net/http"
	"os"
	"time"
	"golang.org/x/crypto/bcrypt"
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

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14) // 14 is the cost factor
	return string(bytes), err
}

// CheckPasswordHash compares a plain password with a hashed password.
func CheckPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
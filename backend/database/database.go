package database

import (
	"fmt"
	"log"

	//"misxy/backbone/model"
	"os"
	"time"

	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func ConnectDatabase() *gorm.DB{
	var err error
    var db *gorm.DB

    newLogger := logger.New(
        log.New(os.Stdout, "\r\n", log.LstdFlags),
        logger.Config{
            SlowThreshold:             time.Second,
            LogLevel:                  logger.Info,
            Colorful:                  true,
        },
    )

    dsn := "sqlserver://SA:yourStrong(!)Password@mssql-server:1433?database=FoodRecipeDB"
    maxRetries := 15
    retryInterval := 5 * time.Second

    for i := range maxRetries {
        db, err = gorm.Open(sqlserver.Open(dsn), &gorm.Config{
            Logger: newLogger,
        })
        if err == nil {
            log.Println("Successfully connected to the database after", i+1, "attempts.")
            return db
        }
        log.Printf("Failed to connect to database (attempt %d/%d): %v. Retrying in %s...\n", i+1, maxRetries, err, retryInterval)
        time.Sleep(retryInterval)
    }
	panic(fmt.Sprintf("Failed to connect to the database after %d attempts: %v", maxRetries, err))
}
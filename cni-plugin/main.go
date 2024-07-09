package main

import (
	"fmt"
	"log"
)

// VERSION is filled out during the build process (using git describe output)
var VERSION string

func main() {
	fmt.Printf("Version: %s\n", VERSION)
	log.Fatal("xxx")
}

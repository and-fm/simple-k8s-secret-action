package main

import (
	"bufio"
	"os"
)

func main() {
	fil, err := os.Open("secrets.txt")

	if err != nil {
		panic("error reading secrets!")
	}

	fileScanner := bufio.NewScanner(fil)
	fileScanner.Split(bufio.ScanLines)

	var fileLines []string

	for fileScanner.Scan() {
		
	}
}
package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"strings"
)

// command-line flags
var inputFile = flag.String("inputFile", "input.txt", "The input file to use.")
var partTwo = flag.Bool("partTwo", false, "Solve part 2?")

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n"), nil
}

// starts program execution
func main() {
	flag.Parse()
	data, err := extractData(*inputFile)
	// TODO: add more code, I guess:-)
}

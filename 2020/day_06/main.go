package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"strings"
)

var inputFile = flag.String("inputFile", "input.txt", "The input file to use.")
var partTwo = flag.Bool("partTwo", false, "Solve part 2?")

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n\n"), nil
}

func getYesAnswers(data string) int {
	rows := strings.Split(data, "\n")
	set := map[string]bool{}
	for _, row := range rows {
		col := strings.Split(row, "")
		for i := 0; i < len(col); i++ {
			if _, ok := set[col[i]]; !ok {
				set[col[i]] = true
			}
		}
	}
	return len(set)
}

// starts programn execution
func main() {
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err)
	}
	total := 0
	for _, line := range data {
		total += getYesAnswers(line)
	}
	fmt.Printf("What is the sum of those counts? %d\n", total)
}

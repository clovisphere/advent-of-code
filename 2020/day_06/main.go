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

func getYesAnswers2(data string) int {
	var total int
	rows := strings.Split(data, "\n")
	questions := make(map[string]int)
	for _, row := range rows {
		col := strings.Split(row, "")
		for _, val := range col {
			questions[val]++
		}
	}
	// how many questions did everyone answer "yes" to
	for _, m := range questions {
		if m == len(rows) {
			total++
		}
	}
	return total
}

// starts program execution
func main() {
	flag.Parse() // NOTE: to parse command-line arguments/flags:-)
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err)
	}
	total := 0
	for _, line := range data {
		if *partTwo {
			total += getYesAnswers2(line)
		} else {
			total += getYesAnswers(line)
		}
	}
	fmt.Printf("What is the sum of those counts? %d\n", total)
}

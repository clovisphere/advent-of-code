package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n"), nil
}

// starts program execution
func main() {
	rawData, err := extractData("input.txt")
	if err != nil {
		panic(err)
	}
	grid := make([][]bool, len(rawData))
	for i, m := range rawData {
		grid[i] = make([]bool, len(m))
		squaresOrTrees := strings.Split(m, "")
		for j, n := range squaresOrTrees {
			grid[i][j] = (n == "#")
		}
	}
	numberOfTrees := 0
	for row := 0; row < len(grid); row++ {
		col := (row * 3) % len(grid[row])
		if grid[row][col] {
			numberOfTrees++
		}
	}
	fmt.Printf("How many trees have you encountered? %d\n", numberOfTrees)
}

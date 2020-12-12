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

func getNumberOfTrees(grid [][]bool, rightMove, downMove int) int {
	trees := 0
	col := 0
	for row := 0; row < len(grid); row += downMove {
		if grid[row][col%len(grid[row])] {
			trees++
		}
		col += rightMove
	}
	return trees
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
	slopes := [][]int{
		{1, 1},
		{3, 1},
		{5, 1},
		{7, 1},
		{1, 2},
	}
	total := 1
	for _, slope := range slopes {
		total *= getNumberOfTrees(grid, slope[0], slope[1])
	}
	fmt.Println("What do you get if you multiply together the ",
		"number of tree encountered on each of the listed slopes? ", total)
}

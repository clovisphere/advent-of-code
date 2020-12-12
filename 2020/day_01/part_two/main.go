// find the two entries that sum to 2020
package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func extractData(name string) ([]int, map[int]int, error) {
	b, err := ioutil.ReadFile(name)
	if err != nil {
		return nil, nil, err
	}
	s := strings.Split(strings.TrimSpace(string(b)), "\n")
	rawData := make([]int, len(s))
	set := make(map[int]int) // like a set.. or not:-)
	for k, v := range s {
		val, err := strconv.Atoi(v)
		if err != nil {
			return nil, nil, err
		}
		rawData[k] = val
		set[val] = k // NOTE: int instead of bool to fix the issue of validating against the same value:-)
	}
	return rawData, set, nil
}

// starts program execution
func main() {
	result := 2020
	rawData, set, err := extractData("input.txt")
	if err != nil {
		panic(err)
	}
outer:
	for i, m := range rawData {
		for j, n := range rawData {
			if i >= j || (m+n) >= result {
				continue
			}
			if pos, ok := set[result-m-n]; ok && pos != i && pos != j {
				fmt.Printf("The three entries that sum to %d are %d, %d and %d. Their product is %d\n",
					result, m, n, (result - m - n), m*n*(result-m-n))
				break outer
			}
		}
	}
}

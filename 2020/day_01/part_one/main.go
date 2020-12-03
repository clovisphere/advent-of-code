// find the two entries that sum to 2020
package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

// read file, and transform its content into a string slice
func extractData(name string) ([]string, error) {
	b, err := ioutil.ReadFile(name)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n"), nil
}

// starts program execution
func main() {
	if data, err := extractData("input.txt"); err == nil {
		s := make(map[int]bool) // like a set.. maybe not
		result := 2020          // the magic value
		for _, i := range data {
			val, _ := strconv.Atoi(i)
			if _, ok := s[result-val]; ok {
				fmt.Printf("The two entries that sum to 2020 are %d and %d. Their product is %d\n",
					val, (result - val), (val * (result - val)))
				break // job done:-)
			}
			s[val] = true
		}
	} else {
		fmt.Println(err)
	}
}

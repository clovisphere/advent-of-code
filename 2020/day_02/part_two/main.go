package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n"), nil
}

func applyPasswordPolicy(password string, passwordPolicy []string) bool {
	data := strings.Split(passwordPolicy[0], "-")
	min, err := strconv.Atoi(data[0])
	max, err := strconv.Atoi(data[1])
	if err != nil {
		panic(err)
	}
	letter := strings.TrimSpace(passwordPolicy[1])
	s := strings.Split(password, "")
	return (s[min-1] == letter) != (s[max-1] == letter)
}

// starts program execution
func main() {
	rawData, err := extractData("input.txt")
	var validPassword []string // list of valid password
	if err != nil {
		panic(err) //NOTE: no need to continue if there's an error
	}
	for _, row := range rawData {
		line := strings.Split(row, ":")
		password := strings.TrimSpace(line[1])
		passwordPolicy := strings.Split(strings.TrimSpace(line[0]), " ")
		if applyPasswordPolicy(password, passwordPolicy) {
			validPassword = append(validPassword, password)
		}
	}
	fmt.Printf("How many passwords are valid? %d\n", len(validPassword))
}

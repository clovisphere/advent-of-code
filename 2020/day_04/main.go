package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
)

var inputFile = flag.String("inputFile", "input.txt", "The file to use.")
var fieldValidation = flag.Bool("fieldValidation", false, "Should we validate fields?")

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n\n"), nil
}

func isValidField(key, value string) bool {
	switch key {
	case "byr", "iyr", "eyr":
		if len(value) != 4 {
			return false
		}
		year, err := strconv.Atoi(value)
		if err != nil {
			return false
		}
		if key == "byr" {
			return year >= 1902 && year <= 2002
		} else if key == "iyr" {
			return year >= 2010 && year <= 2020
		} else {
			return year >= 2020 && year <= 2030
		}
	case "hgt":
		if strings.HasSuffix(value, "cm") || strings.HasSuffix(value, "in") {
			suffix := value[len(value)-2:]
			digits, err := strconv.Atoi(value[:strings.Index(value, suffix)])
			if err != nil {
				return false
			}
			if suffix == "cm" {
				return digits >= 150 && digits <= 193
			} else {
				return digits >= 59 && digits <= 76
			}
		}
		return false
	case "hcl":
		hexColor := regexp.MustCompile("^#[0-9a-f]{6}$")
		return hexColor.MatchString(value)
	case "ecl":
		switch value {
		case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
			return true
		default:
			return false
		}
	case "pid":
		pidDigits := regexp.MustCompile("^[0-9]{9}$")
		return pidDigits.MatchString(value)
	default:
		return false
	}
}

func validate(passport string, validateField bool) bool {
	allowedFields := map[string]bool{
		"byr": true,
		"iyr": true,
		"eyr": true,
		"hgt": true,
		"hcl": true,
		"ecl": true,
		"pid": true,
		"cid": true,
	}
	validField := 0
	lines := strings.Split(passport, "\n")
outer:
	for _, line := range lines {
		pairs := strings.Split(line, " ")
		for _, pair := range pairs {
			s := strings.Split(pair, ":")
			if _, ok := allowedFields[s[0]]; ok {
				if validateField && s[0] != "cid" && !isValidField(s[0], s[1]) {
					break outer
				}
				validField++
				delete(allowedFields, s[0])
			}
		}
	}
	// 'cid' is optional
	if allowedFields["cid"] {
		validField++
	}
	return validField == 8
}

//starts program execution
func main() {
	flag.Parse()
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err) //NOTE: no need to continue if you encounter an error
	}
	total := 0
	for _, line := range data {
		if validate(line, *fieldValidation) {
			total += 1
		}
	}
	fmt.Printf("How many passports are valid? %d\n", total)
}

package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"math"
	"strconv"
	"strings"
)

var inputFile = flag.String("inputFile", "input.txt", "The input file to use.")
var partTwo = flag.Bool("partTwo", false, "Solve part 2?")
var useBitApproach = flag.Bool("useBitApproach", false, "Use bit approach?")

func extractData(filename string) ([]string, error) {
	b, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(string(b)), "\n"), nil
}

func decode(upperLimit int, pattern, lowerHalf, upperHalf string) int {
	lower := 0
	upper := upperLimit
	for _, letter := range pattern {
		mid := int(math.Floor(float64(lower+upper) / 2.0)) // trick for ninary search
		if string(letter) == lowerHalf {
			upper = mid
		} else if string(letter) == upperHalf {
			lower = mid
		}
	}
	return lower
}

func decode2(pattern string) int {
	bitMapping := map[string]string{"B": "1", "R": "1", "F": "0", "L": "0"}
	for k, v := range bitMapping {
		pattern = strings.ReplaceAll(pattern, k, v)
	}
	val, err := strconv.ParseInt(pattern, 2, 0)
	if err != nil {
		panic(err) // failed to parse:-(
	}
	return int(val)
}

func main() {
	flag.Parse()
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err) // there's nothing more to do:-)
	}
	highestSeatID := 0
	var availableSeats [1024]bool
	for _, line := range data {
		// ex: BFFFBBF RRR
		seatID := 0
		if !*useBitApproach {
			row := decode(128, line[:7], "F", "B")
			col := decode(8, line[7:], "L", "R")
			seatID = row*8 + col
		} else {
			seatID = decode2(line)
		}
		availableSeats[seatID] = true
		if seatID > highestSeatID {
			highestSeatID = seatID
		}
	}
	fmt.Printf("What is the highest seat ID on a boarding pass? %d\n", highestSeatID)

	if *partTwo {
		init := true
		for seatID, available := range availableSeats {
			if init && available {
				init = false
				continue
			}
			if !init && !available {
				fmt.Printf("What is the ID of your seat? %d\n", seatID)
				break
			}
		}
	}
}

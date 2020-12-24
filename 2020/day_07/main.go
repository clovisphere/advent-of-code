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

func parseLine(line string) (string, []string) {
	parts := strings.Split(line, " bags contain")
	destination := parts[0]
	var sources []string
	if parts[1] != "no other bags." {
		sourceSegments := strings.Split(parts[1][:len(parts[1])-1], ",")
		for _, segment := range sourceSegments {
			segment = strings.TrimSuffix(segment, "bag")
			segment = strings.TrimSuffix(segment, "bags")
			sources = append(sources, strings.SplitN(strings.TrimSpace(segment), " ", 2)[1])
		}
	}
	return destination, sources
}

// starts program execution
func main() {
	flag.Parse()
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err)
	}
	graph := make(map[string][]string)
	for _, line := range data {
		destination, sources := parseLine(line)
		for _, source := range sources {
			graph[source] = append(graph[source], destination)
		}
	}
	// how many bags that can eventually
	// contain, at least one, 'shiny gold' bag?
	var total int
	key := "shiny gold"
	knownKeys := []string{key}
	found := map[string]bool{key: true}
	for {
		nextCycle := make([]string, 0)
		for _, k := range knownKeys {
			validParents := graph[k]
			for _, p := range validParents {
				if !found[p] {
					total++
					found[p] = true
					nextCycle = append(nextCycle, p)
				}
			}
		}
		if len(nextCycle) == 0 {
			break
		}
		knownKeys = nextCycle
	}
	fmt.Printf("How many bag can eventually contain at least one shiny gold bag? %d\n", total)
}

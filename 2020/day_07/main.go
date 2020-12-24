package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"strconv"
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

func solvePartOne(key string, parents map[string][]string) {
	var total int
	knownKeys := []string{key}
	found := map[string]bool{key: true}
	for {
		nextCycle := make([]string, 0)
		for _, k := range knownKeys {
			validParents := parents[k]
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

// starts program execution
func main() {
	flag.Parse()
	data, err := extractData(*inputFile)
	if err != nil {
		panic(err)
	}
	graph := make(map[string]map[string]int)
	parents := make(map[string][]string)
	for _, line := range data {
		parts := strings.Split(line, " bags contain ")
		parentNode := parts[0]
		if parts[1] == "no other bags." {
			continue // empty children nodes
		}
		graph[parentNode] = map[string]int{}
		childrenNodes := strings.Split(parts[1][:len(parts[1])-1], ",")
		for _, node := range childrenNodes {
			node = strings.TrimSuffix(node, "bag")
			node = strings.TrimSuffix(node, "bags")
			node = strings.TrimSpace(node)
			nodePart := strings.SplitN(node, " ", 2)
			value, err := strconv.Atoi(nodePart[0])
			childNode := nodePart[1]
			if err != nil {
				fmt.Printf("Failed to parse %s\n", node)
				continue
			}
			parents[childNode] = append(parents[childNode], parentNode)
			graph[parentNode][childNode] = value
		}
	}
	//TODO: add part_two solution
	solvePartOne("shiny gold", parents)
}

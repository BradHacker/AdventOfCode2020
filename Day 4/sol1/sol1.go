package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

// Split used to check for newline and space
func Split(r rune) bool {
	return r == ' ' || r == '\n'
}

func main() {
	dat, err := ioutil.ReadFile("../input.txt")
	check(err)

	passportRaws := strings.Split(string(dat), "\n\n")

	var validPassports = 0

	for _, element := range passportRaws {
		fields := strings.FieldsFunc(element, Split)

		var validFields = 0

		for _, field := range fields {
			fieldParts := strings.Split(field, ":")
			if fieldParts[0] == "byr" || fieldParts[0] == "iyr" || fieldParts[0] == "eyr" || fieldParts[0] == "hgt" || fieldParts[0] == "hcl" || fieldParts[0] == "ecl" || fieldParts[0] == "pid" {
				validFields++
			}
		}

		if validFields == 7 {
			validPassports++
		}
	}

	fmt.Printf("# Valid Passports: %d\n", validPassports)
}

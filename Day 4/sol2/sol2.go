package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
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
			value, _ := strconv.Atoi(fieldParts[1])
			switch fieldParts[0] {
			case "byr":
				if len(fieldParts[1]) == 4 && value >= 1920 && value <= 2002 {
					validFields++
				}
			case "iyr":
				if len(fieldParts[1]) == 4 && value >= 2010 && value <= 2020 {
					validFields++
				}
			case "eyr":
				if len(fieldParts[1]) == 4 && value >= 2020 && value <= 2030 {
					validFields++
				}
			case "hgt":
				if strings.HasSuffix(fieldParts[1], "cm") {
					hgt, _ := strconv.Atoi(strings.TrimSuffix(fieldParts[1], "cm"))
					if hgt >= 150 && hgt <= 193 {
						validFields++
					}
				} else if strings.HasSuffix(fieldParts[1], "in") {
					hgt, _ := strconv.Atoi(strings.TrimSuffix(fieldParts[1], "in"))
					if hgt >= 59 && hgt <= 76 {
						validFields++
					}
				}
			case "hcl":
				if strings.HasPrefix(fieldParts[1], "#") {
					match, _ := regexp.MatchString("^#[0-9a-f]{6}$", fieldParts[1])
					if match == true {
						validFields++
					}
				}
			case "ecl":
				if fieldParts[1] == "amb" || fieldParts[1] == "blu" || fieldParts[1] == "brn" || fieldParts[1] == "gry" || fieldParts[1] == "grn" || fieldParts[1] == "hzl" || fieldParts[1] == "oth" {
					validFields++
				}
			case "pid":
				if len(fieldParts[1]) == 9 && value > 0 {
					validFields++
				}
			}
		}

		if validFields == 7 {
			validPassports++
		}
	}

	fmt.Printf("# Valid Passports: %d\n", validPassports)
}

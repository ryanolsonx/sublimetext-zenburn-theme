package days

import (
    "fmt"
    "strings"

    inputs "../inputs"
)

// Six : advent of code, day six part1 and 2
func Six() {
    input := inputs.Day6

    groups := strings.Split(input, "\n\n")

    totalUniqueYesP1 := 0
    totalUniqueYesP2 := 0

    for group := range groups {
        people := strings.Split(groups[group], "\n")

        uniqueYesInGroup := []rune{}

        groupAlphaMap := map[rune]int{
            'a': 0,
            'b': 0,
            'c': 0,
            'd': 0,
            'e': 0,
            'f': 0,
            'g': 0,
            'h': 0,
            'i': 0,
            'j': 0,
            'k': 0,
            'l': 0,
            'm': 0,
            'n': 0,
            'o': 0,
            'p': 0,
            'q': 0,
            'r': 0,
            's': 0,
            't': 0,
            'u': 0,
            'v': 0,
            'w': 0,
            'x': 0,
            'y': 0,
            'z': 0,
        }

        for person := range people {
            personToRune := []rune(people[person])

            for answer := range personToRune {
                groupAlphaMap[personToRune[answer]]++

                if !runeSliceContains(uniqueYesInGroup, personToRune[answer]) {
                    uniqueYesInGroup = append(uniqueYesInGroup, personToRune[answer])
                }
            }
        }

        allSaidYes := 0

        for k := range groupAlphaMap {
            if groupAlphaMap[k] == len(people) {
                allSaidYes++
            }
        }

        totalUniqueYesP1 = totalUniqueYesP1 + len(uniqueYesInGroup)
        totalUniqueYesP2 = totalUniqueYesP2 + allSaidYes
    }

    fmt.Println("(Part1) Sum of unique answers from each group: ")
    fmt.Println(totalUniqueYesP1)
    fmt.Println("")
    fmt.Println("(Part2) Sum of unique answers each person in group answered YES: ")
    fmt.Println(totalUniqueYesP2)
}

func runeSliceContains(s []rune, r rune) bool {
    for _, a := range s {
        if a == r {
            return true
        }
    }
    return false
}
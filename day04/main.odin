package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:slice"
import "core:strings"

main :: proc() {
	buf, _ := os.read_entire_file("input.txt")
	input := string(buf)

	splits := [?]string{"  ", " "}

	points := 0
	for line in strings.split_lines_iterator(&input) {
		cards := strings.split_n(line, ":", 2)
		sides := strings.split_n(cards[1], " | ", 2)

		winning := strings.split_multi(strings.trim_left(sides[0], " "), splits[:])
		card := strings.split_multi(strings.trim_left(sides[1], " "), splits[:])

		matches: [dynamic]string
		for n in card {
			if slice.contains(winning, n) {
				append(&matches, n)
			}
		}
		score := int(math.pow(2, f16(len(matches) - 1)))
		points = points + score
	}

	fmt.println(points)
}

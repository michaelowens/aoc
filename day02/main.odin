package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

part1 :: proc(input: ^string) -> int {
  max := map[string]int {
    "red" = 12,
    "green" = 13,
    "blue" = 14,
  }

  sum := 0
  loop_lines: for line in strings.split_lines_iterator(input) {
    line_parts := strings.split_n(line, ": ", 2)
    grab_parts := strings.split(line_parts[1], "; ")

    for grab in grab_parts {
      cube_parts := strings.split(grab, ", ")

      for cube in cube_parts {
        c := strings.split_n(cube, " ", 2)
        n, _ := strconv.parse_int(c[0])
        if max[c[1]] < n {
          continue loop_lines
        }
      }
    }

    game_parts := strings.split(line_parts[0], " ")
    game_id, _ := strconv.parse_int(game_parts[1])
    sum = sum + game_id
  }

  return sum
}

part2 :: proc(input: ^string) -> int {
  sum := 0
  loop_lines: for line in strings.split_lines_iterator(input) {
    line_parts := strings.split_n(line, ": ", 2)
    grab_parts := strings.split(line_parts[1], "; ")

    required := map[string]int {
      "red" = 0,
      "green" = 0,
      "blue" = 0,
    }

    for grab in grab_parts {
      cube_parts := strings.split(grab, ", ")

      for cube in cube_parts {
        c := strings.split_n(cube, " ", 2)
        n, _ := strconv.parse_int(c[0])
        if required[c[1]] < n {
          required[c[1]] = n
        }
      }
    }

    sum = sum + (required["red"] * required["green"] * required["blue"])
  }

  return sum
}

main :: proc() {
  buf, ok := os.read_entire_file("input.txt")
  if !ok {
    return
  }

  input := string(buf)
  
  // sum := part1(&input)
  sum := part2(&input)

  fmt.printf("%d\n", sum)
}
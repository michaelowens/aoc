package main

import "core:os"
import "core:strings"
import "core:fmt"
import "core:unicode"
import "core:strconv"

digits_strings := [?]string { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }

filter_numeric :: proc(s: string) -> bool {
  return unicode.is_digit(rune(s[0]))
}

concat_numeric :: proc(a: int, b: int) -> int {
  pow := 10
  for b >= pow {
    pow = pow * 10
  }
  return a * pow + b
}

part1 :: proc(input: ^string) -> int {
  sum := 0
  for line in strings.split_lines_iterator(input) {
    chars := strings.split(line, "")
    digits: [dynamic]int

    for i := 0; i < len(chars); i = i + 1 {
      char := chars[i]
      if !unicode.is_digit(rune(char[0])) {
        continue
      }
      
      n, ok := strconv.parse_int(char)
      if !ok {
        continue
      }
      append(&digits, n)
    }

    cn := concat_numeric(digits[0], digits[len(digits) - 1])
    sum = sum + cn
  }

  return sum
}

part2 :: proc(input: ^string) -> int {
  sum := 0
  for line in strings.split_lines_iterator(input) {
    chars := strings.split(line, "")
    digits: [dynamic]int

    for i := 0; i < len(chars); i = i + 1 {
      char := chars[i]
      if !unicode.is_digit(rune(char[0])) {
        for digit, n in digits_strings {
          end := i + len(digit)
          if end > len(chars) {
            continue
          }

          if strings.concatenate(chars[i:end]) != digit {
            continue
          }

          append(&digits, n)
        }
        continue
      }
      
      n, ok := strconv.parse_int(char)
      if !ok {
        continue
      }
      append(&digits, n)
    }

    cn := concat_numeric(digits[0], digits[len(digits) - 1])
    sum = sum + cn
  }

  return sum
}

main :: proc() {
  buf, success := os.read_entire_file("input.txt")
  if !success {
    return
  }
  defer delete(buf)

  input := string(buf)
  // sum := part1(&input)
  sum := part2(&input)

  fmt.printf("%d\n", sum)
}
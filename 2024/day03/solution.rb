# frozen_string_literal: true

# Advent of Code
# Day 3 🤭
# author: clov
# year: 2024

# Read input data
data = ARGV.empty? ? DATA.read : File.read(ARGV.first)

# Regex to capture `don't()` or `do()`
dont_do_regex = /don't\(\)|do\(\)/

# Regex for valid `mul(...)`
mul_regex = /mul\((\d+),(\d+)\)/

# Part 1: Sum all valid `mul(...)` in the data
part_one = data.scan(mul_regex).sum { |a, b| a.to_i * b.to_i }

# part 2: Handle `don't()` and `do()` logic while summing valid `mul(...)`
part_two = data.split(dont_do_regex).each_with_index.sum do |section, index|
  # Skip sections after "don't()" until "do()" is encountered
  skip = (data.scan(dont_do_regex)[index - 1] == "don't()") if index > 0
  next 0 if skip

  section.scan(mul_regex).sum { |a, b| a.to_i * b.to_i }
end

# Output results
puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

# If using the provided example 😊
__END__
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))

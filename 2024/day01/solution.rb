# frozen_string_literal: true

# Advent of Code
# Day 1 🤭
# author: clov
# year: 2024

data = if ARGV.empty?
         DATA.readlines
       else
         File.readlines(ARGV.first)
       end

# Part 1
part_one = data
           .map { _1.split.map(&:to_i) }
           .transpose
           .map(&:sort)
           .reduce(:zip)               # or: .transpose
           .sum { |a, b| (a - b).abs } # or: .map { _1.reduce(:-).abs }.sum

# Part 2
part_two = data
           .map { _1.split.map(&:to_i) }
           .transpose
           .then { |a, b| a.map { _1 * b.count(_1) } }
           .sum

puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

# If using the provided example 😊
__END__
3   4
4   3
2   5
1   3
3   9
3   3

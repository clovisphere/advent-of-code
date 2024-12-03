# frozen_string_literal: true

# Advent of Code
# Day 2 🤭
# author: clov
# year: 2024

data = if ARGV.empty?
         DATA.readlines
       else
         File.readlines(ARGV.first)
       end

def generate_subarrays(array)
  (0...array.size).map { |index| array[0...index] + array[(index + 1)..] }
end

def safe?(level)
  diffs = level.each_cons(2).map { |a, b| a - b }
  diffs.all? { |x| (1..3).include?(x) } || diffs.all? { |x| (-3..-1).include?(x) }
end

# Part 1
part_one = data
           .map { _1.split.map(&:to_i) }
           .count { |level| safe?(level) }

# Part 2
part_two = data
           .map { _1.split.map(&:to_i) }
           .count { |level| generate_subarrays(level).any? { |subarray| safe?(subarray) } }

puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

# If using the provided example 😊
__END__
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9

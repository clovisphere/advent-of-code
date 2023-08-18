# Advent of Code | Day 1 🤭
# url: https://adventofcode.com/
# author: clov
# year: 2022

def partOne(file_path)
  File.read(file_path)
    .split("\n\n")
    .map { |calories_per_elf| calories_per_elf.split("\n").map(&:to_i).sum }
    .max
end

def partTwo(file_path)
  File.read(file_path)
    .split("\n\n")
    .map { |calories_per_elf| calories_per_elf.split("\n").map(&:to_i).sum }
    .max(3)
    .sum
end

# Mmmm this sh^t should work 🤣
puts "how many total calories is that elf carrying? #{partOne('input.txt')}"
puts "how many calories are those elves carrying in total? #{partTwo('input.txt')}"

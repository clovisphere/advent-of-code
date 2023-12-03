# Advent of Code
# Day 1 🤭
# author: clov
# year: 2023

if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

# Part 1
part_one = data
    .map { |line| line.scan(/\d/) }
    .map { (_1.first + _1.last).to_i }
    .sum


# Couldn't solve this one, credit to 👇🏽
# ©️ https://www.youtube.com/watch?v=lrJfC2dF84k

# Part 2
WORD_TO_DIGIT = {
    "0"     =>  "0",
    "1"     =>  "1",
    "2"     =>  "2",
    "3"     =>  "3",
    "4"     =>  "4",
    "5"     =>  "5",
    "6"     =>  "6",
    "7"     =>  "7",
    "8"     =>  "8",
    "9"     =>  "9",
    # --- 😊 --- #
    "zero"  =>  "0",
    "one"   =>  "1",
    "two"   =>  "2",
    "three" =>  "3",
    "four"  =>  "4",
    "five"  =>  "5",
    "six"   =>  "6",
    "seven" =>  "7",
    "eight" =>  "8",
    "nine"  =>  "9",
}

words = WORD_TO_DIGIT.keys
r_words = words.map(&:reverse)

part_two = data.map do |line|
    digits = line.match(/(#{words.join("|")})/, 0)
    first = WORD_TO_DIGIT[digits[0]]

    digits  = line.reverse.match(/(#{r_words.join("|")})/, 0)
    last = WORD_TO_DIGIT[digits[0].reverse]

    (first + last).to_i
end.sum

puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"


__END__
# 1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet

# Advent of Code | Day 2 🤭
# url: https://adventofcode.com/
# author: clov
# year: 2022

=begin
# ^Rock * Paper * Scissors^
# A & X ~> Rock
# B & Y ~> Paper
# C & Z ~> Scissors
=end
SCORES = {
  "A X" => 1 + 3, # draw
  "A Y" => 2 + 6, # win
  "A Z" => 3 + 0, # loss
  "B X" => 1 + 0, # loss
  "B Y" => 2 + 3, # draw
  "B Z" => 3 + 6, # win
  "C X" => 1 + 6, # win
  "C Y" => 2 + 0, # loss
  "C Z" => 3 + 3  # draw
}.freeze

TRANSLATION = {
  "a-draw" => "A X",
  "a-win"  => "A Y",
  "a-lose" => "A Z",
  "b-draw" => "B Y",
  "b-win"  => "B Z",
  "b-lose" => "B X",
  "c-draw" => "C Z",
  "c-win"  => "C X",
  "c-lose" => "C Y"
}.freeze

def partOne(file_path)
  File.read(file_path)
    .split("\n")
    .map { |round| SCORES.fetch(round.strip, 0) }
    .sum
end

def partTwo(file_path)
  File.read(file_path)
    .split("\n")
    .map do |round|
      _start, _end = round.strip.downcase.split  # we could do better 🫣
      case _end
      when "x"
        SCORES.fetch(TRANSLATION["#{_start}-lose"], 0)
      when "y"
        SCORES.fetch(TRANSLATION["#{_start}-draw"], 0)
      else
        SCORES.fetch(TRANSLATION["#{_start}-win"], 0)
      end
    end
    .sum
end

# Mmmm this sh^t should work 🤣
puts "total score: #{partOne('input.txt')}"
puts "total score: #{partTwo('input.txt')}"

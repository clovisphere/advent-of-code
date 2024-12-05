# frozen_string_literal: true

# Advent of Code
# Day 4 🤭
# author: clov
# year: 2024

# Read input data
data = ARGV.empty? ? DATA.readlines : File.readlines(ARGV.first)

# Part 1
part_one = 0 # Yet to be implemented:-)

# Part 2
part_two = (1...data.size - 1).sum do |r|
  (1...data[0].size - 1).count do |c|
    next false unless data[r][c] == 'A'

    corners = [
      data[r - 1][c - 1],
      data[r - 1][c + 1],
      data[r + 1][c + 1],
      data[r + 1][c - 1]
    ].join

    %w[MMSS MSSM SSMM SMMS].include?(corners)
  end
end

# Output results
puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

# If using the provided example 😊
__END__
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX

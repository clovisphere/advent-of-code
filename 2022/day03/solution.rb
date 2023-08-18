# Advent of Code
# Day 3 🤭
# author: clov
# year: 2022

if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

part_one = data
  .map(&:chomp)
  .map(&:chars)
  .map { _1.each_slice(_1.length / 2).to_a }
  .map { _1 & _2 }
  .flatten
  .map { _1 =~ /[A-Z]/ ? _1.ord - 38 : _1.ord - 96 }
  .sum


part_two = data
  .map(&:chomp)
  .each_slice(3)
  .map { _1.map(&:chars) }
  .map { _1 & _2 & _3 }
  .flatten
  .map { _1 =~ /[A-Z]/ ? _1.ord - 38 : _1.ord - 96 }
  .sum

puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

__END__
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw

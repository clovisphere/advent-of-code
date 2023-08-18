# Advent of Code
# Day 4 🤭
# author: clov
# year: 2022

require 'set'

if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

part_one = data
  .map(&:chomp)
  .map { _1.split(/[,-]/) }
  .map { _1.map(&:to_i) }
  .map { _1.each_slice(2).to_a }
  .map { _1.map { |a, b| (a..b).to_set } }
  .reduce(0) { |count, (a, b)| a.subset?(b) || b.subset?(a) ? count + 1 : count }


part_two = data
  .map(&:chomp)
  .map { _1.split(/[,-]/) }
  .map { _1.map(&:to_i) }
  .map { _1.each_slice(2).to_a }
  .map { _1.map { |a, b| (a..b).to_set } }
  .reduce(0) { |count, (a, b)| a.intersect?(b) ? count + 1 : count }

puts "(part 1) answer: #{part_one}"
puts "(part 2) answer: #{part_two}"

__END__
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8

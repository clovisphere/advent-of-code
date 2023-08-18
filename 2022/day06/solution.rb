# Advent of Code
# Day 6 🤭
# author: clov
# year: 2022

require 'set'

def marker(packet, dc = 4)
  packet
    .chars
    .each_cons(dc)
    .map(&:to_set)
    .find_index { _1.size == dc } + dc
end

if ARGV.empty?
  require 'rspec/autorun'

  RSpec.describe 'Day 6' do
    it 'should work for example test cases' do
      expect(marker('bvwbjplbgvbhsrlpgdmjqwftvncz')).to eq(5)
      expect(marker('nppdvjthqldpwncqszvftbrmjlhg')).to eq(6)
      expect(marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')).to eq(10)
      expect(marker('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')).to eq(11)
    end
  end
else
  input = File
    .read(ARGV[0])
    .chomp
  answer = if ARGV[1].nil? then marker(input) else marker(input, 14) end

  puts "answer: #{answer}"
end

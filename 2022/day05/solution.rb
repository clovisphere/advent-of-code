# Advent of Code
# Day 5 🤭
# author: clov
# year: 2022

def read_towers(data)
  towers = []
  data
    .split("\n")
    .map { _1.split(/\s{4}| /) }
    .reverse
    .each_with_index do |report, i|
      next if i.zero?

      report
        .map { _1.gsub(/\[|\]/, '') } # get rid of square bracket🫣
        .each_with_index do |el, j|
        next if el == ''

        towers[j] = [] if towers[j].nil?
        towers[j] << el
      end
    end
  towers
end

def read_instructions(data)
  data
    .split("\n")
    .map { /move (?<qty>\d+) from (?<from>\d+) to (?<to>\d+)/.match(_1) }
    .map { [_1['qty'].to_i, _1['from'].to_i, _1['to'].to_i] }
end

def move(towers, qty, from, to, solving_part_2: false)
  if !solving_part_2
    qty.times { towers[to - 1] << towers[from - 1].pop }
  else
    towers[to - 1] += towers[from - 1].pop(qty)
  end
end

def move_all(towers, instructions, solving_part_2: false)
  instructions.each do |qty, from, to|
    move(towers, qty, from, to, solving_part_2)
  end
end

if ARGV.empty?
  require 'rspec/autorun'

  RSpec.describe 'Day 5' do
    before(:all) do
      @towers, @instructions = DATA.read.split("\n\n")
    end

    it 'reads the towers as expected' do
      towers = read_towers(@towers)
      expect(towers.length).to eq(3)
      expect(towers[0].length).to eq(2)
      expect(towers[0][0]).to eq('Z')
      expect(towers[0][1]).to eq('N')
    end

    it 'reads the instructions' do
      instructions = read_instructions(@instructions)
      expect(instructions.length).to eq(4)
      expect(instructions).to eq([
                                   [1, 2, 1],
                                   [3, 1, 3],
                                   [2, 2, 1],
                                   [1, 1, 2]
                                 ])
    end

    it 'moves elements' do
      towers = read_towers(@towers)
      move(towers, 1, 2, 1)
      expect(towers[0]).to eq(%w[Z N D])
      expect(towers[1]).to eq(%w[M C])
      expect(towers[2]).to eq(['P'])
    end

    it 'works for the full test case' do
      towers = read_towers(@towers)
      instructions = read_instructions(@instructions)
      move_all(towers, instructions)
      expect(towers[0]).to eq(['C'])
      expect(towers[1]).to eq(['M'])
      expect(towers[2]).to eq(%w[P D N Z])
    end
  end
else
  towers, instructions = File.read(ARGV[0]).split("\n\n")
  towers = read_towers(towers)
  instructions = read_instructions(instructions)
  move_all(towers, instructions, !ARGV[1].nil?)
  answer = towers
           .map(&:last)
           .join
  puts "what crate ends up on top of each stack? #{answer}"
end

__END__
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2

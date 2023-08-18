
if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first) 
end

cwd = []
dir_sizes = Hash.new { |h, k| h[k] = 0 }

data
  .map(&:chomp)
  .map { _1.split(" ") }
  .each do |line|
    case line
    in ["$", "cd", ".."]
      cwd.pop
    in ["$", "cd", dirname]
      cwd << dirname
    in [size, filename]
      cwd.length.times { |x| dir_sizes[cwd[0..x]] += size.to_i }
    else # unmatched pattern will be caught here 🫣
    end
  end

# part 1
part_one = dir_sizes
  .inject(0) { |sum, (_, size)| size <= 100000 ? sum + size : sum }
puts "part_one's answer: #{part_one}"

# part 2
total = 70000000
needed = 30000000
free = total - dir_sizes[['/']]
delete_at_least = needed - free

puts "\nTotal: #{total} | Free: #{free} | Needed: #{needed} | Delete at least: #{delete_at_least}"
part_two = dir_sizes.values.sort.find { |size| size > delete_at_least }
puts "part_two's answer: #{part_two}"

__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k

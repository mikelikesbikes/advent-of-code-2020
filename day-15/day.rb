def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n").first.split(",").map do |line|
    Integer(line)
  end
end

### CODE HERE ###
def nth_number(starting_nums, n)
  return starting_nums[n-1] if n < starting_nums.length
  memory = {}
  (0...starting_nums.length - 1).each_with_index { |i| memory[starting_nums[i]] = i + 1 }
  (starting_nums.length).upto(n-1).reduce(starting_nums.last) do |last_num, i|
    memory[last_num], last_num = i, memory[last_num] ? i - memory[last_num] : 0
    last_num
  end
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts nth_number(input, 2020)
puts nth_number(input, 30_000_000)

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split(",").map do |line|
    Integer(line)
  end
end

### CODE HERE ###
def nth_number(starting_nums, n)
  memory = Hash[starting_nums.zip([*1..starting_nums.length])]
  last_num = starting_nums.last
  last_new = true
  (starting_nums.length + 1).upto(n) do |i|
    num = last_new ? 0 : i - memory[last_num] - 1
    memory[last_num] = i - 1
    last_num = num
    last_new = !memory.key?(num)
  end
  last_num
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts nth_number(input, 2020)
puts nth_number(input, 30_000_000)

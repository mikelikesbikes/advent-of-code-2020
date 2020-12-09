def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n").map do |line|
    Integer(line)
  end
end


### CODE HERE ###
def find_first_invalid_xmas_code(input, len)
  len.upto(input.length - 1) do |i|
    pair = input[i-len...i].combination(2).find { |a, b| a + b == input[i] }
    return input[i] unless pair
  end
end

def find_weakness(input, len)
  target = find_first_invalid_xmas_code(input, len)
  i = 0
  while i < input.length
    k = 0
    while input[i..k].sum < target
      k += 1
    end
    if input[i..k].sum == target
      return input[i..k].minmax.sum
    end
    i += 1
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts find_first_invalid_xmas_code(input, 25)
puts find_weakness(input, 25)

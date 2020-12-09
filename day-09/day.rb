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

MAX_INT = 2 ** ([42].pack('i').size * 8) - 1
def find_weakness(input, len)
  target = find_first_invalid_xmas_code(input, len)
  i = 0
  while i < input.length
    k, sum, min, max = i, 0, MAX_INT, 0
    begin
      sum += input[k]
      min = input[k] if input[k] < min
      max = input[k] if input[k] > max
      k += 1
    end while sum < target
    return min + max if sum == target
    i += 1
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts find_first_invalid_xmas_code(input, 25)
puts find_weakness(input, 25)

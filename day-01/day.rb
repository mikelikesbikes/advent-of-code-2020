def read_lines(filename = File.expand_path("input.txt", __dir__))
  File.read(filename).split("\n").map(&:to_i)
end

def find_tuple(input, size, target_sum)
  input.permutation(size).find { |v| v.sum == target_sum }.reduce(:*)
end

return unless $PROGRAM_NAME == __FILE__

input = read_lines

puts find_tuple(input, 2, 2020)
puts find_tuple(input, 3, 2020)

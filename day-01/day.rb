require "set"

def read_lines(filename = File.expand_path("input.txt", __dir__))
  File.read(filename).split("\n").map(&:to_i)
end

def find_tuple(input, size, target_sum)
  if size == 2
    return find_pair(input, target_sum)
  end
  input.permutation(size).find { |v| v.sum == target_sum }.reduce(:*)
end

def find_pair(input, target_sum)
  nums = Set.new(input)
  input.each do |v|
    return v * (target_sum - v) if nums.include?(target_sum - v)
  end
end

return unless $PROGRAM_NAME == __FILE__

input = read_lines

puts find_tuple(input, 2, 2020)
puts find_tuple(input, 3, 2020)

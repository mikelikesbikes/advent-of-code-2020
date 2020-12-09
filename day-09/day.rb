def read_input(filename = nil)
  if !filename && !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename || "input.txt", __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n").map! do |line|
    Integer(line)
  end
end


### CODE HERE ###
def find_first_invalid_xmas_code(input, len)
  i = len
  while i < input.length
    return input[i] unless valid_xmas_code?(input, len, i)
    i += 1
  end
end

def valid_xmas_code?(input, len, i)
  j = i - len
  while j < i - 2
    k = j + 1
    while k < i
      return true if input[j] + input[k] == input[i]
      k += 1
    end
    j += 1
  end
  false
end

def find_weakness(input, target)
  i = 0
  while i < input.length - 1
    k, sum, min, max = i, input[i], input[i], input[i]
    while sum < target
      k += 1
      sum += input[k]
      min = input[k] if input[k] < min
      max = input[k] if input[k] > max
    end
    return min + max if sum == target
    i += 1
  end
end

def wobbling_sliding_window(input, target)
  i, size = 0, 2
  sum = input[i] + input[i + 1]
  while i < input.length
    # shrink size down to 2 OR sum > target
    while sum > target && size > 2
      sum -= input[i + size - 1]
      size -= 1
    end

    # expand size up until we run out of inputs OR sum < target
    while sum < target && (i + size - 1) < input.length
      sum += input[i + size]
      size += 1
    end

    # return sum of min and max in the window
    if sum == target
      return input[i, size].minmax.reduce(&:+)
    end

    # advance the window forward removing the first value
    sum -= input[i]
    size -= 1
    i += 1
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###

target = find_first_invalid_xmas_code(input, 25)
puts target
require "benchmark"
puts Benchmark.measure("find_weakness") { puts find_weakness(input, target) }
puts Benchmark.measure("wobbling_window") { puts wobbling_sliding_window(input, target) }

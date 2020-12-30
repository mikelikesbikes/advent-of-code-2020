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
def align_adapters(input)
  input.sort.tap do |j|
    j.unshift(0)
    j.push(j.last + 3)
  end
end

def differences(adapters)
  adapters.each_cons(2).each_with_object([0, 0]) do |(a, b), res|
    if b - a == 1
      res[0] += 1
    elsif b - a == 3
      res[1] += 1
    end
  end.reduce(&:*)
end

def configurations(adapters, i = 0)
  Hash
    .new { |h, i| h[i] = [i+1, i+2, i+3].sum { |j| j < adapters.length && adapters[j] - adapters[i] <= 3 ? h[j] : 0 } }
    .yield_self { |memo|
      memo[adapters.length - 1] = 1
      memo[0]
    }
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
adapters = align_adapters(input)
puts differences(adapters)
puts configurations(adapters)

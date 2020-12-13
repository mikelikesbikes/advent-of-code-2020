def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  time, buses = input.split("\n")
  [Integer(time), buses.split(",").map { |s| s.to_i }]
end


### CODE HERE ###
def earliest_bus_id(time, buses)
  buses.reject(&:zero?).map { |b| [b, b - (time % b)] }.min_by(&:last).reduce(&:*)
end

def find_subsequent_time(time, buses)
  buses = buses.each_with_index.reject { |x, _| x.zero? }.sort_by(&:first).reverse
  (increment, rem), *buses = buses
  time = (increment - rem) % increment
  buses.each do |b, rem|
    until (time + rem) % b == 0
      time += increment
    end
    increment *= b
  end
  return time
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts earliest_bus_id(*input)
puts find_subsequent_time(*input)

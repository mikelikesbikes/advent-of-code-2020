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
  [Integer(time), buses.split(",").filter_map.with_index { |s, i| [Integer(s), i] if s != "x" }]
end


### CODE HERE ###
def earliest_bus_id(time, buses)
  buses.map { |b, _| [b, b - (time % b)] }.min_by(&:last).reduce(&:*)
end

def find_subsequent_time(buses)
  buses = buses.sort_by(&:first).reverse
  (inc, rem), *buses = buses
  buses.reduce([(inc - rem) % inc, inc]) do |(time, inc), (b, rem)|
    time += inc until (time + rem) % b == 0
    [time, inc * b]
  end.first
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts earliest_bus_id(*input)
puts find_subsequent_time(input.last)

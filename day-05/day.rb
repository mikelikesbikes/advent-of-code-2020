require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

SEAT_PARTS="FLBR"
SEAT_PARTS_TO_INT="0011"
def parse_input(input)
  s = Set.new
  input.split("\n").each do |line|
    s << line.tr(SEAT_PARTS, SEAT_PARTS_TO_INT).to_i(2)
  end
  s
end


### CODE HERE ###
def max_seat_id(seats)
  seats.max
end

def find_seat(seats)
  seats.find { |s| seats.member?(s+2) && !seats.member?(s+1) } + 1
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts max_seat_id(input)
puts find_seat(input)

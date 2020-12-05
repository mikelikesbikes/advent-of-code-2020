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
    line.gsub("F", "0").gsub("B", "1").gsub("R", "1").gsub("L", "0").to_i(2)
  end
end


### CODE HERE ###
def max_seat_id(seats)
  seats.max
end

def find_seat(seats)
  seats.each_with_object(Set.new) do |seat, s|
    if s.member?(seat - 2)
      return seat - 1
    elsif s.member?(seat + 2)
      return seat + 1
    else
      s << seat
    end
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts max_seat_id(input)
puts find_seat(input)

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
    line.chars
  end
end

### CODE HERE ###
DIRECTIONS = [
  [-1, -1],
  [0, -1],
  [1, -1],
  [-1, 0],
  [1, 0],
  [-1, 1],
  [0, 1],
  [1, 1]
]
def adjacents(input, x, y)
  DIRECTIONS.count do |dx,dy|
    w, z = x + dx, y + dy
    w.between?(0, input.first.length - 1) && z.between?(0, input.length - 1) && input[z][w] == "#"
  end
end

def los_adjacent(input, x, y)
  DIRECTIONS.count do |dx, dy|
    w, z, occupied = x + dx, y + dy, nil
    while w.between?(0, input.first.length - 1) && z.between?(0, input.length - 1) && occupied != "#" && occupied != "L"
      occupied = input[z][w]
      w += dx
      z += dy
    end
    occupied == "#"
  end
end

def stabilize_seating(input)
  begin
    changed = false
    input = input.map.with_index do |row, y|
      row.map.with_index do |v, x|
        case v
        when "." then "."
        when "L" then
          if adjacents(input, x, y) == 0
            changed ||= true
            "#"
          else
            "L"
          end
        when "#" then
          if adjacents(input, x, y) >= 4
            changed ||= true
            "L"
          else
            "#"
          end
        end
      end
    end
  end while changed
  input.flatten.count("#")
end

def stabilize_seating_los(input)
  begin
    changed = false
    input = input.map.with_index do |row, y|
      row.map.with_index do |v, x|
        case v
        when "." then "."
        when "L" then
          if los_adjacent(input, x, y) == 0
            changed ||= true
            "#"
          else
            "L"
          end
        when "#" then
          if los_adjacent(input, x, y) >= 5
            changed ||= true
            "L"
          else
            "#"
          end
        end
      end
    end
  end while changed
  input.flatten.count("#")
end


return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts stabilize_seating(input)
puts stabilize_seating_los(input)

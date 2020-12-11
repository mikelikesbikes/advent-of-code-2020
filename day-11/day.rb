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
def adjacents(input, x, y)
  [
    [x-1, y-1],
    [x,   y-1],
    [x+1, y-1],
    [x-1, y],
    [x+1, y],
    [x-1, y+1],
    [x,   y+1],
    [x+1, y+1],
  ].filter { |x,y| x.between?(0, input.first.length - 1) && y.between?(0, input.length - 1) }
end

def los_adjacent(input, x, y)
  directions = [
    [-1, -1],
    [0, -1],
    [1, -1],
    [-1, 0],
    [1, 0],
    [-1, 1],
    [0, 1],
    [1, 1]
  ].map do |dx, dy|
    w, z = x + dx, y + dy
    occupied = nil
    while w.between?(0, input.first.length - 1) && z.between?(0, input.length - 1)
      occupied = input[z][w]
      break if occupied == "#" || occupied == "L"
      w += dx
      z += dy
    end
    occupied
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
          if adjacents(input, x, y).none? { |x,y| input[y][x] == "#" }
            changed ||= true
            "#"
          else
            "L"
          end
        when "#" then
          if adjacents(input, x, y).count { |x,y| input[y][x] == "#" } >= 4
            changed ||= true
            "L"
          else
            "#"
          end
        end
      end
    end
  end while changed
  input.flatten.tally["#"]
end

def stabilize_seating_los(input)
  begin
    changed = false
    input = input.map.with_index do |row, y|
      row.map.with_index do |v, x|
        case v
        when "." then "."
        when "L" then
          if los_adjacent(input, x, y).none? { |v| v == "#" }
            changed ||= true
            "#"
          else
            "L"
          end
        when "#" then
          if los_adjacent(input, x, y).count { |v| v == "#" } >= 5
            changed ||= true
            "L"
          else
            "#"
          end
        end
      end
    end
  end while changed
  input.flatten.join("").count("#")
end


return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts stabilize_seating(input)
puts stabilize_seating_los(input)

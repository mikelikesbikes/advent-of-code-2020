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
def occupied_adjacent(input, x, y)
  DIRECTIONS.count do |dx,dy|
    w, z = x + dx, y + dy
    w.between?(0, input.first.length - 1) && z.between?(0, input.length - 1) && input[z][w] == "#"
  end
end

def occupied_in_all_directions(input, x, y)
  DIRECTIONS.count do |dx, dy|
    w, z, occupied = x + dx, y + dy, nil
    while w.between?(0, input.first.length - 1) && z.between?(0, input.length - 1) && occupied != "#" && occupied != "L"
      occupied = input[z][w]
      w += dx
      z += dy end
    occupied == "#"
  end
end

PART_1_RULES = {
  "." => -> (_) { "." },
  "L" => -> (neighbors) { neighbors == 0 ? "#" : "L" },
  "#" => -> (neighbors) { neighbors >= 4 ? "L" : "#" }
}

PART_2_RULES = {
  "." => -> (_) { "." },
  "L" => -> (neighbors) { neighbors == 0 ? "#" : "L" },
  "#" => -> (neighbors) { neighbors >= 5 ? "L" : "#" }
}

def stabilize_seating(input, occupied, rules)
  begin
    changed = false
    input = input.map.with_index do |row, y|
      row.map.with_index do |v, x|
        rules[v].call(occupied.call(input, x, y)).tap do |new_v|
          changed ||= v != new_v
        end
      end
    end
  end while changed
  input.flatten.count("#")
end


return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts stabilize_seating(input, method(:occupied_adjacent), PART_1_RULES)
puts stabilize_seating(input, method(:occupied_in_all_directions), PART_2_RULES)

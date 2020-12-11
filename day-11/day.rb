def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n").each_with_object({}).with_index do |(row, h), y|
    row.chars.each_with_index do |c, x|
      h[[x, y]] = c
    end
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
  DIRECTIONS.count { |dx,dy| input[[x + dx, y + dy]] == "#" }
end

def occupied_in_all_directions(input, x, y)
  p = [nil, nil]
  DIRECTIONS.count do |dx, dy|
    p[0] = x + dx
    p[1] = y + dy
    occupied = nil
    while input.key?(p) && occupied != "#" && occupied != "L"
      occupied = input[p]
      p[0] += dx
      p[1] += dy
    end
    occupied == "#"
  end
end

PART_1_RULES = {
  "." => -> (*_) { "." },
  "L" => -> (o, i, k) { o.call(i, *k) == 0 ? "#" : "L" },
  "#" => -> (o, i, k) { o.call(i, *k) >= 4 ? "L" : "#" }
}

PART_2_RULES = {
  "." => -> (*_) { "." },
  "L" => -> (o, i, k) { o.call(i, *k) == 0 ? "#" : "L" },
  "#" => -> (o, i, k) { o.call(i, *k) >= 5 ? "L" : "#" }
}

def stabilize_seating(input, occupied, rules)
  begin
    changed = false
    input = input.each_with_object({}) do |(k, v), h|
      h[k] = rules[v].call(occupied, input, k).tap do |new_v|
        changed ||= v != new_v
      end
    end
  end while changed
  input.count { |_, v| v == "#" }
end


return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts stabilize_seating(input, method(:occupied_adjacent), PART_1_RULES)
puts stabilize_seating(input, method(:occupied_in_all_directions), PART_2_RULES)

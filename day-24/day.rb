require "set"

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
    walk_path(tokenize(line))
  end
end

def tokenize(str)
  tokens = []
  while str.length > 0
    case str[0]
    when "w", "e"
      tokens << str[0].intern
      str = str[1..-1]
    else
      tokens << str[0, 2].intern
      str = str[2..-1]
    end
  end
  tokens
end

def flip_tiles(inst)
  inst.each_with_object(Set.new) do |inst, s|
    if s.member?(inst)
      s.delete(inst)
    else
      s.add(inst)
    end
  end
end

def walk_path(tokens)
  x,y=0,0
  tokens.each do |t|
    case t
    when :w then x -= 1
    when :e then x += 1
    when :ne then y -= 1
    when :nw then x -=1 and y -= 1
    when :se then x += 1 and y += 1
    when :sw then y += 1
    end
  end
  [x,y]
end

def neighbors(x, y)
  [[-1, 0], [1, 0], [0, -1], [-1, -1], [1, 1], [0, 1]].map do |dx, dy|
    [x + dx, y + dy]
  end
end

def evolve(tiles)
  candidates = tiles.reduce(Set.new) do |c, tile|
    c.merge(neighbors(*tile))
    c << tile
  end

  n_tiles = Set.new
  candidates.each do |c|
    neighbor_count = neighbors(*c).count { |n| tiles.member?(n) }
    # if the candidate is currently black
    if tiles.member?(c)
      n_tiles << c if neighbor_count == 1 || neighbor_count == 2
    else
      n_tiles << c if neighbor_count == 2
    end
  end
  n_tiles
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

tiles = flip_tiles(input)
puts tiles.length

tiles = 100.times.reduce(tiles) { |tiles, _| evolve(tiles) }
puts tiles.length

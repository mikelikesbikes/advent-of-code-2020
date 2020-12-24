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
    Tile.build(tokenize(line))
  end
end

def tokenize(str)
  tokens = []
  while str.length > 0
    case str[0]
    when "w", "e"
      tokens << str.slice!(0).intern
    else
      tokens << str.slice!(0, 2).intern
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

Tile = Struct.new(:x, :y) do
  NEIGHBOR_OFFSETS = [[-1, 0], [1, 0], [0, -1], [-1, -1], [1, 1], [0, 1]]
  def neighbors
    NEIGHBOR_OFFSETS.each do |dx, dy|
      yield Tile.new(x + dx, y + dy)
    end
  end

  def self.build(tokens)
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
    new(x, y)
  end
end

def evolve(tiles)
  candidates = Set.new
  tiles.each do |tile|
    candidates.add(tile)
    tile.neighbors do |n|
      candidates.add(n)
    end
  end

  n_tiles = Set.new
  candidates.each do |tile|
    neighbor_count = 0
    tile.neighbors do |n|
      neighbor_count += 1 if tiles.member?(n)
    end
    if tiles.member?(tile)
      n_tiles << tile if neighbor_count.between?(1, 2)
    else
      n_tiles << tile if neighbor_count == 2
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

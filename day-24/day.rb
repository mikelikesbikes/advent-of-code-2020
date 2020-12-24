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
  tile_set = TileSet.new
  input.split("\n").each do |line|
    tile_set.toggle(Tile.build(line))
  end
  tile_set
end

Tile = Struct.new(:x, :y) do
  NEIGHBOR_OFFSETS = Hash["w", [-1, 0], "e", [1, 0], "ne", [0, -1], "nw", [-1, -1], "se", [1, 1], "sw", [0, 1]]
  def neighbors
    NEIGHBOR_OFFSETS.each do |_, (dx, dy)|
      yield Tile.new(x + dx, y + dy)
    end
  end

  def self.build(str)
    x,y=0,0
    i = 0
    while i < str.length
      tlen = str[i] == "w" || str[i] == "e" ? 1 : 2
      dx, dy = NEIGHBOR_OFFSETS[str[i, tlen]]
      x += dx
      y += dy
      i += tlen
    end
    new(x, y)
  end
end

class TileSet
  attr_accessor :tiles

  def initialize
    @tiles = Set.new
  end

  def toggle(tile)
    if tiles.member?(tile)
      tiles.delete(tile)
    else
      tiles.add(tile)
    end
  end

  def length
    tiles.length
  end

  def evolve
    candidates = Set.new
    tiles.each do |tile|
      candidates.add(tile)
      tile.neighbors do |ntile|
        candidates.add(ntile)
      end
    end

    next_tiles = Set.new
    candidates.each do |tile|
      count = 0
      tile.neighbors do |ntile|
        count += 1 if tiles.member?(ntile)
      end
      if tiles.member?(tile)
        next_tiles << tile if count.between?(1, 2)
      else
        next_tiles << tile if count == 2
      end
    end
    self.tiles = next_tiles
  end
end


return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

tile_set = parse_input(read_input)

puts tile_set.length

100.times { tile_set.evolve }
puts tile_set.length

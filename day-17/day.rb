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
  input.split("\n").each_with_index.each_with_object([]) do |(row, y), h|
    row.each_char.with_index do |c, x|
      h << [x, y] if c == "#"
    end
  end
end

NEIGHBOR_OFFSETS = [
  [-1, -1, -1],
  [0,  -1, -1],
  [1,  -1, -1],
  [-1,  0, -1],
  [0,   0, -1],
  [1,   0, -1],
  [-1,  1, -1],
  [0,   1, -1],
  [1,   1, -1],
  [-1, -1, 0],
  [0,  -1, 0],
  [1,  -1, 0],
  [-1,  0, 0],
  [1,   0, 0],
  [-1,  1, 0],
  [0,   1, 0],
  [1,   1, 0],
  [-1, -1, 1],
  [0,  -1, 1],
  [1,  -1, 1],
  [-1,  0, 1],
  [0,   0, 1],
  [1,   0, 1],
  [-1,  1, 1],
  [0,   1, 1],
  [1,   1, 1]
]
Coord = Struct.new(:x, :y, :z) do
  def initialize(*)
    super
    self.z ||= 0
  end

  def neighbors
    NEIGHBOR_OFFSETS.map do |dx, dy, dz|
      Coord.new(x + dx, y + dy, z + dz)
    end
  end
end

Coord4D = Struct.new(:x, :y, :z, :w) do
  def initialize(*)
    super
    self.z ||= 0
    self.w ||= 0
  end

  def neighbors
    neighbors = (NEIGHBOR_OFFSETS + [[0, 0, 0]]).flat_map do |dx, dy, dz|
      [
        Coord4D.new(x + dx, y + dy, z + dz, w - 1),
        Coord4D.new(x + dx, y + dy, z + dz, w),
        Coord4D.new(x + dx, y + dy, z + dz, w + 1),
      ]
    end
    neighbors.delete(self)
    neighbors
  end
end

Conway = Struct.new(:grid, :coord_class) do
  def initialize(*)
    super

    self.grid = self.grid.each_with_object(Set.new) do |(x, y), s|
      s << coord_class.new(x, y)
    end
  end

  def evolve
    candidates = Set.new
    # find all candidate cubes
    grid.each do |cube, v|
      candidates << cube
      candidates.merge(cube.neighbors)
    end

    # evolve each candidate cube
    self.grid = candidates.each_with_object(Set.new) do |cube, new_grid|
      count = cube.neighbors.count { |n| grid.member?(n) }
      if grid.member?(cube)
        new_grid << cube if count == 2 || count == 3
      else
        new_grid << cube if count == 3
      end
    end
  end

  def alive
    self.grid.size
  end
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
grid = Conway.new(input, Coord)
6.times { grid.evolve }
puts grid.alive

grid = Conway.new(input, Coord4D)
6.times { grid.evolve }
puts grid.alive


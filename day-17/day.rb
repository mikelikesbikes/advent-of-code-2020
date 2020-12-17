require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input, coord_class)
  input.split("\n").each_with_index.each_with_object(Set.new) do |(row, y), s|
    row.each_char.with_index do |c, x|
      s << coord_class.new(x, y) if c == "#"
    end
  end
end

Coord = Struct.new(:x, :y, :z) do
  def initialize(*)
    super
    self.z ||= 0
  end

  def each_neighbors(&block)
    neighbors = (-1..1).each do |dx|
      (-1..1).each do |dy|
        (-1..1).each do |dz|
          next if dx == 0 && dy == 0 && dz == 0
          self.class.new(x + dx, y + dy, z + dz).tap do |neighbor|
            block.call(neighbor) if block
          end
        end
      end
    end
  end
end

Coord4D = Struct.new(:x, :y, :z, :w) do
  def initialize(*)
    super
    self.z ||= 0
    self.w ||= 0
  end

  def each_neighbors(&block)
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        (-1..1).each do |dz|
          (-1..1).each do |dw|
            next if dx == 0 && dy == 0 && dz == 0 && dw == 0
            self.class.new(x + dx, y + dy, z + dz, w + dw).tap do |neighbor|
              block.call(neighbor) if block
            end
          end
        end
      end
    end
  end
end

Conway = Struct.new(:grid, :coord_class) do
  def evolve
    candidates = Set.new
    # find all candidate cubes
    grid.each do |cube, v|
      candidates << cube
      cube.each_neighbors do |n|
        candidates << n
      end
    end

    # evolve each candidate cube
    self.grid = candidates.each_with_object(Set.new) do |cube, new_grid|
      count = 0
      cube.each_neighbors do |n|
        next if count > 3
        count += 1 if grid.member?(n)
      end

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

### RUN STUFF HERE ###
grid = Conway.new(parse_input(read_input, Coord))
6.times { grid.evolve }
puts grid.alive

grid = Conway.new(parse_input(read_input, Coord4D))
6.times { grid.evolve }
puts grid.alive

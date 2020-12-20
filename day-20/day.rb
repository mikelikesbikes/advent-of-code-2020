def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n\n").each_with_object({}) do |str, h|
    tile = Tile.parse(str)
    h[tile.id] = tile
  end
end

Tile = Struct.new(:id, :grid, :_edges) do
  def initialize(*)
    super
    # top, right, bottom, left
    self._edges = [
      grid.first.gsub(".", "0").gsub("#", "1"),
      grid.map { |s| s[-1] }.join.gsub(".", "0").gsub("#", "1"),
      grid.last.reverse.gsub(".", "0").gsub("#", "1"),
      grid.map { |s| s[0] }.reverse.join.gsub(".", "0").gsub("#", "1")
    ]
  end

  def self.parse(str)
    meta, *rows = str.split("\n")
    id = Integer(meta[5..8])
    new(id, rows)
  end

  def trim_and_orient(flip, rotation)
    image = grid[1..-2].map { |row| row[1..-2] }
    flip_and_rotate(image, flip, rotation)
  end

  def edges(flip, rotation)
    if flip == 1
      [self._edges[2], self._edges[1], self._edges[0], self._edges[3]].map(&:reverse).rotate(-rotation)
    else
      self._edges.rotate(-rotation)
    end
  end

  # mating edges are tile1.top ^ 1023 == tile2.bottom, same for all other sides
end

# basically the recursive backtracking algorithm for sudoku...
# possibilities = tiles with edges that can align to any tile that neighbors i
# tiles can be rotate and flipped, which changes their edges
def reassemble_image(tiles, i=0, image = [])
  debug = image.length >= 2 && image[0][0] == 1951 && image[1][0] == 2311
  return image if i == tiles.length

  used_tile_ids = image.map { |t| t ? t.first : nil }
  unused_tiles = tiles.values.reject { |t| used_tile_ids.include?(t.id) }
  unused_tiles.each do |tile|
    (0..7).each do |n|
      image[i] = [tile.id, *n.divmod(2).reverse]
      if valid_at?(tiles, image, i)
        res = reassemble_image(tiles, i + 1, image)
        return res if res
      end
    end
  end
  image.delete_at(i)
  return nil
end

def flip_and_rotate(image, flip, rotation)
  if flip == 1
    image = image.reverse
  end
  rotation.times do
    image = image.map(&:chars)
    image = image.yield_self do |row, *rows|
      row.zip(*rows).map(&:reverse)
    end
    image = image.map(&:join)
  end

  image
end

def corners(image)
  len = Math.sqrt(image.length).floor

  image[0][0] * image[len-1][0] * image[-len][0] * image[-1][0]
end

def valid_at?(tiles, image, i)
  len = Math.sqrt(tiles.length).floor
  id, flip, rotation = image[i]
  edges = tiles[id].edges(flip, rotation)
  y, x = i.divmod(len)
  # match above
  debug = id == 2473 && i == 5
  if y - 1 >= 0 && n = image[(y-1)*len + x]
    n_id, n_flip, n_rotation = n
    n_edges = tiles[n_id].edges(n_flip, n_rotation)
#    require 'byebug'; debugger if debug
    return false unless edges[0].reverse == n_edges[2]
  end
  # match below
  if y + 1 < len && n = image[(y+1)*len + x]
    n_id, n_flip, n_rotation = n
    n_edges = tiles[n_id].edges(n_flip, n_rotation)
    return false unless edges[2].reverse == n_edges[0]
  end
  # match left
  if x - 1 >= 0 && n = image[y*len + x - 1]
    n_id, n_flip, n_rotation = n
    n_edges = tiles[n_id].edges(n_flip, n_rotation)
    return false unless edges[3].reverse == n_edges[1]
  end
  # match right
  if x + 1 < len && n = image[y*len + x + 1]
    n_id, n_flip, n_rotation = n
    n_edges = tiles[n_id].edges(n_flip, n_rotation)
    return false unless edges[1].reverse == n_edges[3]
  end

  return true
end

def stitch_image(tiles, image)
  stitch = image.map do |id, flip, rotation|
    tiles[id].trim_and_orient(flip, rotation)
  end

  len = Math.sqrt(tiles.length).floor
  stitch = stitch.each_slice(len).flat_map do |group|
    group.first.length.times.map do |row_index|
      group.reduce("") do |acc, grid|
        acc + grid[row_index]
      end
    end
  end
  stitch
end

SEA_MONSTER = <<~MONSTER
                  #
#    ##    ##    ###
 #  #  #  #  #  #
MONSTER
SEA_MONSTER_OVERLAY = SEA_MONSTER.split("\n").each_with_index.each_with_object([]) do |(row, y), sm|
  row.chars.each_with_index do |c, x|
    sm << [x, y] if c == "#"
  end
end
SEA_MONSTER_BOUNDS = [20,3]

def place_sea_monster(image)
  row_length = image.first.length
  (0..7).each do |n|
    flip, rotation = n.divmod(4)
    aimage = flip_and_rotate(image, flip, rotation)
    placed = false
    (0...aimage.length - 3).each do |y|
      (0...row_length - 20).each do |x|
        if SEA_MONSTER_OVERLAY.all? { |dx, dy| aimage[y+dy][x+dx] == "#" }
          placed = true
          SEA_MONSTER_OVERLAY.each do |dx, dy|
            aimage[y+dy][x+dx] = "O"
          end
        end
      end
    end
    return aimage if placed
  end
  raise "shoulda placed a monster"
end

def rough_waters(image)
  image.join("\n").count("#")
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
image = reassemble_image(input)
puts corners(image)
image = stitch_image(input, image)
image = place_sea_monster(image)
#2354 is too high
#2339 is too high
#2324 is too high
puts rough_waters(image)

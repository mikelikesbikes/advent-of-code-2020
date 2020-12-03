def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n")
end

def shred(map, sx, sy)
  x, y, tree_count = sx, sy, 0
  while y < map.length
    tree_count += 1 if map[y][x] == "#"
    x = (sx + x) % map[0].length
    y = y + sy
  end
  tree_count
end

SLOPES=[[1,1],[3,1],[5,1],[7,1],[1,2]]
def multi_shred(map, slopes = SLOPES)
  slopes.reduce(1) { |a, slope| a * shred(map, *slope) }
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

puts shred(input, 3, 1)
puts multi_shred(input)

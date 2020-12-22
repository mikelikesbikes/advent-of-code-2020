def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n\n").each_with_object(CameraArray.new) do |str, ca|
    ca.add(Camera.parse(str))
  end
end

class CameraArray
  attr_reader :cameras

  def initialize(*)
    @cameras ||= {}
  end

  def add(camera)
    cameras[camera.id] = camera
  end

  def alignment
    @alignment ||= find_alignment
  end

  def alignment_checksum
    alignment[0][0] *
      alignment[len-1][0] *
      alignment[-len][0] *
      alignment[-1][0]
  end

  def image
    return @image if @image

    images = alignment.map do |id, flip, rotation|
      camera = cameras[id]
      camera.calibrate(flip, rotation)
      camera.image
    end

    @image = images.each_slice(len).flat_map do |(image, *rest)|
      image.zip(*rest).map { |r| r.flatten.join }
    end
  end

  # basically the recursive backtracking algorithm for sudoku...  find all the
  # unused camera, try each one in each possible flip/rotation combination,
  # recurse if the camera/flip/rotation can work in the given position in the
  # camera array.
  def find_alignment(i=0, alignment = [])
    return alignment if i == cameras.length
    unused_camera_ids = cameras.keys - alignment.map(&:first)
    unused_camera_ids.each do |id|
      (0..7).each do |n|
        flip, rotation = n.divmod(4)
        alignment[i] = [id, flip, rotation]
        if valid_at?(alignment, i)
          res = find_alignment(i + 1, alignment)
          return res if res
        end
      end
    end
    alignment.delete_at(i)
    return nil
  end

  # valid_at verifies that the given alignment is valid at position i each
  # alignment entry is a tuple [camera id, flip, rotation] for the alignment
  # entry to be valid, we find the edges of the camera with the alignment
  # tuple, and ensure that the camera above, below, left, and right have
  # corresponding matching edges. For example, the camera to the left must have
  # a right edge that matches this camera's left edge.
  TOP, RIGHT, BOTTOM, LEFT = 0, 1, 2, 3
  def valid_at?(alignment, i)
    id, flip, rotation = alignment[i]
    edges = cameras[id].edges(flip, rotation)
    y, x = i.divmod(len)

    # match above
    if y - 1 >= 0 && n = alignment[(y-1)*len + x]
      n_id, n_flip, n_rotation = n
      n_edges = cameras[n_id].edges(n_flip, n_rotation)
      return false unless edges[TOP].reverse == n_edges[BOTTOM]
    end

    # match below
    if y + 1 < len && n = alignment[(y+1)*len + x]
      n_id, n_flip, n_rotation = n
      n_edges = cameras[n_id].edges(n_flip, n_rotation)
      return false unless edges[BOTTOM].reverse == n_edges[TOP]
    end

    # match left
    if x - 1 >= 0 && n = alignment[y*len + x - 1]
      n_id, n_flip, n_rotation = n
      n_edges = cameras[n_id].edges(n_flip, n_rotation)
      return false unless edges[LEFT].reverse == n_edges[RIGHT]
    end

    # match right
    if x + 1 < len && n = alignment[y*len + x + 1]
      n_id, n_flip, n_rotation = n
      n_edges = cameras[n_id].edges(n_flip, n_rotation)
      return false unless edges[RIGHT].reverse == n_edges[LEFT]
    end

    return true
  end

  def len
    Math.sqrt(cameras.length).floor
  end
end

class Camera
  attr_reader :id
  def initialize(id, image)
    @id = id
    self.image = image
  end

  def self.parse(str)
    id, *image = str.split("\n")
    new(Integer(id[5..8]), image)
  end

  # return the trimmed image
  def image
    @image[1..-2].map { |row| row[1..-2] }
  end

  def calibrate(flip, rotation)
    self.image = flip_and_rotate(@image, flip, rotation)
  end

  def edges(flip = 0, rotation = 0)
    @edges_memo[flip * 4 + rotation] ||= if flip == 1
      [self._edges[2], self._edges[1], self._edges[0], self._edges[3]].map(&:reverse).rotate(-1 * rotation % 4)
    else
      self._edges.rotate(-1 * rotation % 4)
    end
  end

  private
  attr_accessor :_edges

  def image=(image)
    @image = image

    # re-calculate edges when image is set
    self._edges = [
      @image.first.gsub(".", "0").gsub("#", "1"),
      @image.map { |s| s[-1] }.join.gsub(".", "0").gsub("#", "1"),
      @image.last.reverse.gsub(".", "0").gsub("#", "1"),
      @image.map { |s| s[0] }.reverse.join.gsub(".", "0").gsub("#", "1")
    ]
    @edges_memo = {}
  end
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

camera_array = parse_input(read_input)

### RUN STUFF HERE ###
puts camera_array.alignment_checksum
image = place_sea_monster(camera_array.image)
puts rough_waters(image)

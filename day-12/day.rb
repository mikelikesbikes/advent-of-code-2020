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
    Inst.new(line[0], Integer(line[1..-1]))
  end
end

Inst = Struct.new(:op, :units)

Coord = Struct.new(:x, :y) do
  def move(deg, n)
    case deg
    when 0   then self.y += n
    when 90  then self.x += n
    when 180 then self.y -= n
    when 270 then self.x -= n
    end
  end

  def rotate(deg)
    case deg % 360
    when 90
      self.x, self.y = self.y, -self.x
    when 180
      self.x, self.y = -self.x, -self.y
    when 270
      self.x, self.y = -self.y, self.x
    end
  end

  def distance(other = Coord.new(0,0))
    (x - other.x).abs + (y - other.y).abs
  end
end

HEADINGS = { "N" => 0, "E" => 90, "S" => 180, "W" => 270 }
class Ship
  attr_reader :coord, :facing
  def initialize
    @coord = Coord.new(0,0)
    @facing = 90
  end

  def turn(deg)
    @facing += deg
  end

  def navigate(input)
    input.each do |inst|
      case inst.op
      when "N", "S", "E", "W" then coord.move(HEADINGS[inst.op], inst.units)
      when "L" then turn(-inst.units)
      when "R" then turn(inst.units)
      when "F" then coord.move(facing % 360, inst.units)
      end
    end
    self
  end
end

class WaypointShip
  attr_reader :coord, :waypoint
  def initialize
    @coord = Coord.new(0,0)
    @waypoint = Coord.new(10, 1)
  end

  def navigate(input)
    input.each do |inst|
      case inst.op
      when "N", "S", "E", "W" then waypoint.move(HEADINGS[inst.op], inst.units)
      when "L" then waypoint.rotate(360 - inst.units)
      when "R" then waypoint.rotate(inst.units)
      when "F" then
        coord.x += waypoint.x * inst.units
        coord.y += waypoint.y * inst.units
      end
    end
  end
end
### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
ship = Ship.new
ship.navigate(input)
puts ship.coord.distance

ship = WaypointShip.new
ship.navigate(input)
puts ship.coord.distance


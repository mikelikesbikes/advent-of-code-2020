require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

# STRAP IN... We're using a Hash as a Linked List :D
class Circle < Hash
  attr_reader :max

  def initialize(*)
    super
    @last = nil
    @max = nil
  end

  def insert(node)
    if size == 0
      self[node] = node
      @max = node
    else
      insert_after(@last, node)
    end
    @last = node
  end

  def insert_after(node, v)
    @last = v if node == @last
    @max = v if v > @max
    self[v] = self[node]
    self[node] = v
  end

  def delete_after(node)
    self[node].tap do |v|
      self[node] = self[v]
      self.delete(v)
      @last = node if v == @last
    end
  end
end

class Game
  attr_reader :cups, :current_cup, :slice

  def initialize(cups, n = cups.length)
    @current_cup = cups.first
    @cups = Circle.new
    cups.each { |c| @cups.insert(c) }
    c = cups.length+1
    while c <= n
      @cups.insert(c)
      c += 1
    end
    @slice = []
    @cups.max
  end

  def self.parse(str, *args)
    new(str.strip.chars.map(&:to_i), *args)
  end

  def move
    # slice 3 cups
    3.times do
      slice << cups.delete_after(current_cup)
    end

    # find destination
    destination = current_cup - 1
    while destination > 0 && !cups[destination]
      destination -= 1
    end
    if destination == 0
      destination = cups.max
      while !cups[destination]
        destination -= 1
      end
    end

    # insert 3 cups
    until slice.empty?
      cups.insert_after(destination, slice.pop)
    end

    # set current cup index
    @current_cup = cups[current_cup]
  end

  def checksum
    n = cups[1]
    sum = ""
    while n != 1
      sum << n.to_s
      n = cups[n]
    end
    sum
  end

  def starcups
    n1 = cups[1]
    n1 * cups[n1]
  end
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

game = Game.parse(read_input)

100.times { game.move }
puts game.checksum

game = Game.parse(read_input, 1_000_000)
10_000_000.times { |i| game.move }
puts game.starcups

require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

class Game
  attr_reader :cups, :current_cup

  def initialize(cups, n = cups.length)
    @current_cup = cups.first
    # STRAP IN... We're using a Hash as a Linked List :D
    @cups = (cups + [*cups.length+1..n])
      .each_cons(2)
      .each_with_object({cups[0] => cups[0]}) do |(a, b), m|
        m[a], m[b] = b, m[a]
      end
  end

  def self.parse(str, *args)
    new(str.strip.chars.map(&:to_i), *args)
  end

  def move
    # slice 3 cups
    slice = []
    n = cups[current_cup]
    3.times do
      slice << n
      n = cups.delete(n)
      cups[current_cup] = n
    end

    # find destination
    nearest = current_cup - 1
    while nearest > 0 && !cups[nearest]
      nearest -= 1
    end
    destination = nearest > 0 ? nearest : cups.keys.max

    # insert 3 cups
    n = destination
    slice.each do |cup|
      cups[cup] = cups[n]
      n = cups[n] = cup
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

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
  attr_reader :cups

  def initialize(cups, n = cups.length)
    @current_cup_index = 0
    @cups = cups
    @cups += [*cups.length...n]
    @moves_memo = Set.new
  end

  def current_cup
    cups[@current_cup_index]
  end

  def self.parse(str, *args)
    new(str.strip.chars.map(&:to_i), *args)
  end

  def move
    current_cup = cups[@current_cup_index]
    # slice 3 cups
    slice = []
    (1..3).each do |i|
      t = @current_cup_index + 1 >= cups.length ? 0 : @current_cup_index + 1
      slice << cups.delete_at(t)
    end

    # find destination
    nearest, max = 0, 0
    (1...cups.length).each do |i|
      c = cups[i]
      if cups[nearest] >= current_cup || c < current_cup && c > cups[nearest]
        nearest = i
      end
      if c > cups[max]
        max = i
      end
    end
    destination = cups[nearest] < current_cup ? nearest : max

    # insert 3 cups
    cups.insert(destination + 1, *slice)

    # re-rotate the circle
    ci = cups.index { |c| c == current_cup }
    cups.rotate!(ci - @current_cup_index)

    # set current cup index
    @current_cup_index = (@current_cup_index + 1) % cups.length
  end

  def checksum
    index = cups.index { |c| c == 1 }
    cups.rotate(index)[1..-1].join
  end

  def starcups
    index = cups.index { |c| c == 1 }
    cups[(index + 1) % cups.length] * cups[(index + 2) % cups.length]
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

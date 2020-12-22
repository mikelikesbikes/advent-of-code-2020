require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

DEBUG = "DEBUG"
def debug?
  ENV[DEBUG]
end

def parse_input(input)
  d1, d2 = input.split("\n\n").map { |s| s.split("\n") }
  d1 = d1[1..-1].map { |s| Integer(s) }
  d2 = d2[1..-1].map { |s| Integer(s) }
  [d1, d2]
end


### CODE HERE ###
def play(deck1, deck2)
  until deck1.empty? || deck2.empty?
    c1, c2 = deck1.shift, deck2.shift
    if c1 > c2
      deck1.push(c1, c2)
    else
      deck2.push(c2, c1)
    end
  end

  deck1.empty? ? score(deck2) : score(deck1)
end

def play_recursive(deck1, deck2, game = 1)
  states = Set.new
  round = 0
  until deck1.empty? || deck2.empty?
    round += 1
    if debug?
      puts "Round #{round} Game #{game}:"
      puts "   Deck 1: #{deck1.join(", ")}"
      puts "   Deck 2: #{deck2.join(", ")}"
    end
    decks_hash = dhash(deck1, deck2)
    return score(deck1) if states.member?(decks_hash)
    states << decks_hash

    c1, c2 = deck1.shift, deck2.shift
    if c1 <= deck1.length && c2 <= deck2.length
      score = play_recursive(deck1.slice(0, c1), deck2.slice(0, c2), game + 1)
      if score > 0
        deck1.push(c1, c2)
      else
        deck2.push(c2, c1)
      end
    else
      if c1 > c2
        deck1.push(c1, c2)
      else
        deck2.push(c2, c1)
      end
    end
  end

  if deck2.empty?
    score(deck1)
  else
    -score(deck2)
  end
end

def dhash(deck1, deck2)
  deck1.hash * deck2.hash
end

def score(deck)
  i = 0
  sum = 0
  while i < deck.length
    sum += deck[i] * (deck.length - i)
    i += 1
  end
  sum
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts play(*input)

input = parse_input(read_input)
puts play_recursive(*input).abs

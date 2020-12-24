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
    xy(tokenize(line))
  end
end

def tokenize(str)
  tokens = []
  while str.length > 0
    case str[0]
    when "w", "e"
      tokens << str[0].intern
      str = str[1..-1]
    else
      tokens << str[0, 2].intern
      str = str[2..-1]
    end
  end
  tokens
end

def flip_tiles(inst)
  inst.each_with_object({}) do |inst, h|
    h[inst] = !h[inst]
  end
end

def count_black(tiles)
  tiles.values.count { |i| i }
end

def xy(tokens)
  x,y=0,0
  tokens.each do |t|
    case t
    when :w then x -= 1
    when :e then x += 1
    when :ne then y += 1
    when :nw then x -=1 and y += 1
    when :se then y -= 1
    when :sw then x -= 1 and y -= 1
    end
  end
  [x,y]
end

def reduce_tokens(tokens)
  counts = Hash[:w, 0, :e, 0, :nw, 0, :ne, 0, :se, 0, :sw, 0]
  tokens.each { |t| counts[t] += 1 }

  # cancel nw/se and ne/sw
  diff = [counts[:nw], counts[:se]].min
  counts[:nw] -= diff
  counts[:se] -= diff

  diff = [counts[:ne], counts[:sw]].min
  counts[:ne] -= diff
  counts[:sw] -= diff

  # collapse nw sw to w
  diff = [counts[:nw], counts[:sw]].min
  counts[:nw] -= diff
  counts[:sw] -= diff
  counts[:w] += diff

  # collapse ne se to e
  diff = [counts[:ne], counts[:se]].min
  counts[:ne] -= diff
  counts[:se] -= diff
  counts[:e] += diff

  # cancel w and e
  diff = [counts[:w], counts[:e]].min
  counts[:w] -= diff
  counts[:e] -= diff

  counts.flat_map { |k, v| [k]*v }.sort
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
# 382 was too low?... :(
puts count_black(p flip_tiles(input))

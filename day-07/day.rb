require "set"

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

Bag = Struct.new(:color, :rules)
BagRule = Struct.new(:color, :number)

def parse_input(input)
  input.split("\n").each_with_object({}) do |line, hash|
    color, rules = line.split(" bags contain ")
    hash[color] = Bag.new(color).tap do |bag|
      bag.rules = rules.scan(/(\d+) (\w+ \w+)/).map! do |number, color|
        BagRule.new(color, Integer(number))
      end
    end
  end
end

def bag_colors(input, target_color)
  lookup = input.values.each_with_object(Hash.new { |h, k| h[k] = [] }) do |bag, h|
    bag.rules.each do |rule|
      h[rule.color] << bag.color
    end
  end

  colors = Set.new
  candidates = lookup[target_color]
  while candidates.length > 0
    color = candidates.shift
    colors << color
    lookup[color].each do |new_candidate|
      if !colors.include?(new_candidate) && !candidates.include?(new_candidate)
        candidates << new_candidate
      end
    end
  end
  colors.length
end

def bag_count(input, target_color, memo = {})
  return memo[target_color] if memo[target_color]
  memo[target_color] = input[target_color].rules.sum(0) do |bag_rule|
    bag_rule.number * (bag_count(input, bag_rule.color, memo) + 1)
  end
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts bag_colors(input, "shiny gold")
puts bag_count(input, "shiny gold")

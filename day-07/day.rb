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
  input.split("\n").map do |line|
    color = line.match(/(\w+ \w+) bags contain (.*)/)
    Bag.new(color[1], []).tap do |bag|
      if color[2] != "no other bags"
        color[2].scan(/(\d+) (\w+ \w+)/).each do |number, color|
          bag.rules << BagRule.new(color, Integer(number))
        end
      end
    end
  end
end

def bag_colors(input, target_color)
  lookup = input.each_with_object(Hash.new { |h, k| h[k] = [] }) do |bag, h|
    bag.rules.each do |rule|
      h[rule.color] << bag.color
    end
  end

  colors = []
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

def bag_count(input, target_color)
  lookup = Hash[input.map{|b| [b.color, b]}]
  lookup[target_color].rules.sum(0) do |bag_rule|
    bag_rule.number * (bag_count(input, bag_rule.color) + 1)
  end
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts bag_colors(input, "shiny gold")
puts bag_count(input, "shiny gold")

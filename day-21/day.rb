require "set"

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
    i_str, a_str = line.match(/(.*) \(contains (.*)\)/).captures
    Food.new(i_str.split(" "), a_str.split(", "))
  end
end

def allergen_candidates(foods)
  foods.each_with_object({}) do |food, candidates|
    food.allergens.each do |allergen|
      if candidates[allergen]
        candidates[allergen] &= food.ingredients
      else
        candidates[allergen] = food.ingredients
      end
    end
  end
end

def find_non_allergens(foods)
  foods.flat_map(&:ingredients) - allergen_candidates(foods).flat_map(&:last)
end

def dangerous_ingredients(foods)
  ita = allergen_candidates(foods).each_with_object(Hash.new { |k,v| k[v] = [] }) do |(k,v),c|
    v.each do |w|
      c[w] << k
    end
  end
  itaa = []
  until ita.length == 0
    i = ita.find { |k, v| v.length == 1 }
    ita.delete(i.first)
    ita.each do |k, v|
      ita[k] -= i.last
    end
    itaa << [i.first, i.last.first]
  end
  itaa.sort_by(&:last).map(&:first).join(",")
end

Food = Struct.new(:ingredients, :allergens)


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts find_non_allergens(input).length
puts dangerous_ingredients(input)

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
  ingredient_to_allergen = allergen_candidates(foods).each_with_object(Hash.new { |k,v| k[v] = [] }) do |(allergen, ingredients), ingredient_to_allergen|
    ingredients.each do |ingredient|
      ingredient_to_allergen[ingredient] << allergen
    end
  end

  # reduce the ingredient_to_allergens mapping so each ingredient has only a single allergen
  ingredient_to_allergen = ingredient_to_allergen.length.times.each_with_object([]) do |_, reduced|
    ingredient, allergens = ingredient_to_allergen.find { |_, allergens| allergens.length == 1 }
    reduced << [ingredient, allergens.first]
    ingredient_to_allergen.delete(ingredient)
    ingredient_to_allergen.each do |ingredient, _|
      ingredient_to_allergen[ingredient] -= allergens
    end
  end

  ingredient_to_allergen.sort_by(&:last).map(&:first).join(",")
end

Food = Struct.new(:ingredients, :allergens)


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts find_non_allergens(input).length
puts dangerous_ingredients(input)

require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should how many times non-allergen ingredients are used" do
    expect(find_non_allergens(input).length).to eq 5
    expect(find_non_allergens(actual_input).length).to eq 2176
  end

  it "should find which ingredients match which allergens" do
    expect(Set.new(find_non_allergens(input))).to eq Set.new(%w[kfcds nhms sbzzf trh])
  end

  it "should find dangerous ingredients" do
    expect(dangerous_ingredients(input)).to eq "mxmxvkd,sqjhc,fvjkl"
    expect(dangerous_ingredients(actual_input)).to eq "lvv,xblchx,tr,gzvsg,jlsqx,fnntr,pmz,csqc"
  end
end

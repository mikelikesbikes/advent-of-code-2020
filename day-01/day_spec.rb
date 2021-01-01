require "rspec"
require_relative "./day"

describe "Day1" do
  let(:input) do
    parse_input(<<~INPUT)
      1721
      979
      366
      299
      675
      1456
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should find a pair that sum to 2020" do
    expect(find_tuple(input, 2, 2020)).to eq 514579
    expect(find_tuple(actual_input, 2, 2020)).to eq 806656
  end

  it "should find a triplet that sums to 2020" do
    expect(find_tuple(input, 3, 2020)).to eq 241861950
    expect(find_tuple(actual_input, 3, 2020)).to eq 230608320
  end
end

require "rspec"
require_relative "./day"

describe "Day1" do
  let(:input) do
    <<~INPUT.split("\n").map(&:to_i)
      1721
      979
      366
      299
      675
      1456
    INPUT
  end
  it "should find a pair that sum to 2020" do
    result = find_tuple(input, 2, 2020)
    expect(result).to eq 514579
  end

  it "should find a triplet that sums to 2020" do
    result = find_tuple(input, 3, 2020)
    expect(result).to eq 241861950
  end
end

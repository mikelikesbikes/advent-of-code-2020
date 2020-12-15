require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      0,3,6
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should find the 2020th number" do
    expect(nth_number(input, 2)).to eq 3
    expect(nth_number(input, 10)).to eq 0
    expect(nth_number(input, 2020)).to eq 436
    expect(nth_number(actual_input, 2020)).to eq 319
  end

  it "should find the 30,000,000th number" do
    expect(nth_number(input, 30_000_000)).to eq 175594
    expect(nth_number(actual_input, 30_000_000)).to eq 2424
  end
end

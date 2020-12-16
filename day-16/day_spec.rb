require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(scanning_error_rate(input[0], input[2])).to eq 71
    expect(scanning_error_rate(actual_input[0], actual_input[2])).to eq 23009
  end

  it "should label fields" do
    expect(label_fields(input[0], [input[1], *input[2]])).to eq %w[row class seat]
    expect(departure_fields(*input)).to eq 1
    expect(departure_fields(*actual_input)).to eq 10458887314153
  end
end

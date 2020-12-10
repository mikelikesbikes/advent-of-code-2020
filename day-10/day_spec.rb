require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should calculate differences" do
    expect(differences(align_adapters(input))).to eq 35
    expect(differences(align_adapters(actual_input))).to eq 1848
  end

  it "should calculate configurations options" do
    expect(configurations(align_adapters(input))).to eq 8
    expect(configurations(align_adapters(actual_input))).to eq 8099130339328
  end
end

require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      5764801
      17807724
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    k1, k2 = input
    expect(find_loop_size(k1)).to eq 8
    expect(find_loop_size(k2)).to eq 11

    expect(transform(k2, 8)).to eq 14897079
    expect(transform(k1, 11)).to eq 14897079
  end

  it "should work on the actual input" do
    k1, k2 = actual_input
    expect(transform(k1, find_loop_size(k2))).to eq 10548634
    expect(transform(k2, find_loop_size(k1))).to eq 10548634
  end
end

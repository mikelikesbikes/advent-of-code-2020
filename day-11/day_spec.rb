require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should calculate seating with adjacent rules" do
    expect(stabilize_seating(input, method(:occupied_adjacent), PART_1_RULES)).to eq 37
    expect(stabilize_seating(actual_input, method(:occupied_adjacent), PART_1_RULES)).to eq 2108
  end

  it "should calculate seating with line of sight rules" do
    expect(stabilize_seating(input, method(:occupied_in_all_directions), PART_2_RULES)).to eq 26
    expect(stabilize_seating(actual_input, method(:occupied_in_all_directions), PART_2_RULES)).to eq 1897
  end
end

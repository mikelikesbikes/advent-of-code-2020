require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should return the tree count for a given slope" do
    expect(shred(input, 3, 1)).to eq 7
    expect(shred(actual_input, 3, 1)).to eq 191
  end

  it "should calculate lots of slopes" do
    expect(multi_shred(input)).to eq 336
    expect(multi_shred(actual_input)).to eq 1478615040
  end
end

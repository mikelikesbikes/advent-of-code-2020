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

  it "should return the tree count for a given slope" do
    expect(shred(input, 3, 1)).to eq 7
  end

  it "should calculate lots of slopes" do
    expect(multi_shred(input)).to eq 336
  end
end

require "rspec"
require_relative "./day"

describe "day" do
  before(:all) do
    # creating these in the before all because p2 builds on expensive work in
    # p1
    @input = parse_input(<<~INPUT)
      Tile 2311:
      ..##.#..#.
      ##..#.....
      #...##..#.
      ####.#...#
      ##.##.###.
      ##...#.###
      .#.#.#..##
      ..#....#..
      ###...#.#.
      ..###..###

      Tile 1951:
      #.##...##.
      #.####...#
      .....#..##
      #...######
      .##.#....#
      .###.#####
      ###.##.##.
      .###....#.
      ..#.#..#.#
      #...##.#..

      Tile 1171:
      ####...##.
      #..##.#..#
      ##.#..#.#.
      .###.####.
      ..###.####
      .##....##.
      .#...####.
      #.##.####.
      ####..#...
      .....##...

      Tile 1427:
      ###.##.#..
      .#..#.##..
      .#.##.#..#
      #.#.#.##.#
      ....#...##
      ...##..##.
      ...#.#####
      .#.####.#.
      ..#..###.#
      ..##.#..#.

      Tile 1489:
      ##.#.#....
      ..##...#..
      .##..##...
      ..#...#...
      #####...#.
      #..#.#.#.#
      ...#.#.#..
      ##.#...##.
      ..##.##.##
      ###.##.#..

      Tile 2473:
      #....####.
      #..#.##...
      #.##..#...
      ######.#.#
      .#...#.#.#
      .#########
      .###.#..#.
      ########.#
      ##...##.#.
      ..###.#.#.

      Tile 2971:
      ..#.#....#
      #...###...
      #.#.###...
      ##.##..#..
      .#####..##
      .#..####.#
      #..#.#..#.
      ..####.###
      ..#.#.###.
      ...#.#.#.#

      Tile 2729:
      ...#.#.#.#
      ####.#....
      ..#.#.....
      ....#..#.#
      .##..##.#.
      .#.####...
      ####.#.#..
      ##.####...
      ##..#.##..
      #.##...##.

      Tile 3079:
      #.#.#####.
      .#..######
      ..#.......
      ######....
      ####.#..#.
      .#...#.##.
      #.#####.##
      ..#.###...
      ..#.......
      ..#.###...
    INPUT
    @actual_input = parse_input(File.read("input.txt"))
  end
  let(:input) { @input }
  let(:actual_input) { @actual_input }

  it "should ..." do
    expect(input.alignment_checksum).to eq 20899048083289
    expect(actual_input.alignment_checksum).to eq 17148689442341
  end

  it "should find sea monsters" do
    image = place_sea_monster(input.image)
    expect(rough_waters(image)).to eq 273

    image = place_sea_monster(actual_input.image)
    expect(rough_waters(image)).to eq 2009
  end
end

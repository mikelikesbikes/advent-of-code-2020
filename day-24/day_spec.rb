require "rspec"
require_relative "./day"

describe "day" do
  let(:tile_set) do
    parse_input(<<~INPUT)
      sesenwnenenewseeswwswswwnenewsewsw
      neeenesenwnwwswnenewnwwsewnenwseswesw
      seswneswswsenwwnwse
      nwnwneseeswswnenewneswwnewseswneseene
      swweswneswnenwsewnwneneseenw
      eesenwseswswnenwswnwnwsewwnwsene
      sewnenenenesenwsewnenwwwse
      wenwwweseeeweswwwnwwe
      wsweesenenewnwwnwsenewsenwwsesesenwne
      neeswseenwwswnwswswnw
      nenwswwsewswnenenewsenwsenwnesesenew
      enewnwewneswsewnwswenweswnenwsenwsw
      sweneswneswneneenwnewenewwneswswnese
      swwesenesewenwneswnwwneseswwne
      enesenwswwswneneswsenwnewswseenwsese
      wnwnesenesenenwwnenwsewesewsesesew
      nenewswnwewswnenesenwnesewesw
      eneswnwswnwsenenwnwnwwseeswneewsenese
      neswnwewnwnwseenwseesewsenwsweewe
      wseweeenwnesenwwwswnew
    INPUT
  end

  let(:actual_tile_set) do
    parse_input(File.read("input.txt"))
  end

  it "builds a tile set" do
    expect(tile_set.length).to eq 10
  end

  it "evolves the tile_set" do
    [15, 12, 25, 14, 23, 28, 41, 37, 49, 37].each do |expected|
      tile_set.evolve
      expect(tile_set.length).to eq expected
    end
    90.times { tile_set.evolve }
    expect(tile_set.length).to eq 2208
  end

  it "should pass part 1" do
    expect(actual_tile_set.length).to eq 500
  end

  it "should pass part 2" do
    100.times { actual_tile_set.evolve }
    expect(actual_tile_set.length).to eq 4280
  end
end

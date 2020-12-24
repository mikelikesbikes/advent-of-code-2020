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

  it "should ..." do
    expect(tile_set.length).to eq 10
    expect(actual_tile_set.length).to eq 500
  end

  it "lives!" do
    tile_set.evolve
    expect(tile_set.length).to eq 15
    tile_set.evolve
    expect(tile_set.length).to eq 12
    tile_set.evolve
    expect(tile_set.length).to eq 25
    tile_set.evolve
    expect(tile_set.length).to eq 14
    tile_set.evolve
    expect(tile_set.length).to eq 23
    tile_set.evolve
    expect(tile_set.length).to eq 28
    tile_set.evolve
    expect(tile_set.length).to eq 41
    tile_set.evolve
    expect(tile_set.length).to eq 37
    tile_set.evolve
    expect(tile_set.length).to eq 49
    tile_set.evolve
    expect(tile_set.length).to eq 37

    90.times { tile_set.evolve }
    expect(tile_set.length).to eq 2208

    100.times { actual_tile_set.evolve }
    expect(actual_tile_set.length).to eq 4280
  end
end

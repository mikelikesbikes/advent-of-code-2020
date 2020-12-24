require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
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

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(flip_tiles(input).length).to eq 10
    expect(flip_tiles(actual_input).length).to eq 500
  end

  it "tokenizes tile directions" do
    expect(tokenize("sesenwnenenewseeswwswswwnenewsewsw")).to eq %i[se se nw ne ne ne w se e sw w sw sw w ne ne w se w sw]
  end

  it "lives!" do
    tiles = flip_tiles(input)
    tiles = evolve(tiles)
    expect(tiles.length).to eq 15
    tiles = evolve(tiles)
    expect(tiles.length).to eq 12
    tiles = evolve(tiles)
    expect(tiles.length).to eq 25
    tiles = evolve(tiles)
    expect(tiles.length).to eq 14
    tiles = evolve(tiles)
    expect(tiles.length).to eq 23
    tiles = evolve(tiles)
    expect(tiles.length).to eq 28
    tiles = evolve(tiles)
    expect(tiles.length).to eq 41
    tiles = evolve(tiles)
    expect(tiles.length).to eq 37
    tiles = evolve(tiles)
    expect(tiles.length).to eq 49
    tiles = evolve(tiles)
    expect(tiles.length).to eq 37

    tiles = 90.times.reduce(tiles) { |tiles, _| evolve(tiles) }
    expect(tiles.length).to eq 2208

    tiles = flip_tiles(actual_input)
    tiles = 100.times.reduce(tiles) { |tiles, _| evolve(tiles) }
    expect(tiles.length).to eq 4280
  end
end

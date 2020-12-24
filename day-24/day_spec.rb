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
    p input
    tiles = flip_tiles(input)
    p tiles
    expect(count_black(tiles)).to eq 10
  end

  it "tokenizes tile directions" do
    expect(tokenize("sesenwnenenewseeswwswswwnenewsewsw")).to eq %i[se se nw ne ne ne w se e sw w sw sw w ne ne w se w sw]
  end

  it "builds a canonical token list" do
    expect(reduce_tokens(%i[se se nw ne ne ne w se e sw w sw sw w ne ne w se w sw])).to eq %i[se se w w w]
    expect(reduce_tokens(%i[nw w sw e e])).to eq []
    expect(reduce_tokens(%i[ne e e ne se nw nw w sw ne ne w nw w se w ne nw se sw e sw])).to eq [:ne, :ne, :nw, :w]
  end
end

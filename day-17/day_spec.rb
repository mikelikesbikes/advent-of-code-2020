require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    <<~INPUT
      .#.
      ..#
      ###
    INPUT
  end

  let(:actual_input) do
    File.read("input.txt")
  end

  it "should evolve in 3d space" do
    grid = Conway.new(parse_input(input, Coord))
    grid.evolve
    expect(grid.alive).to eq 11
    grid.evolve
    expect(grid.alive).to eq 21
    4.times { grid.evolve }
    expect(grid.alive).to eq 112

    grid = Conway.new(parse_input(actual_input, Coord))
    6.times { grid.evolve }
    expect(grid.alive).to eq 304
  end

  it "should evolve in 4d space" do
    grid = Conway.new(parse_input(input, Coord4D))
    6.times { grid.evolve }
    expect(grid.alive).to eq 848

    grid = Conway.new(parse_input(actual_input, Coord4D))
    6.times { grid.evolve }
    expect(grid.alive).to eq 1868
  end
end

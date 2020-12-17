require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      .#.
      ..#
      ###
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    grid = Conway.new(input, Coord)
    grid.evolve
    expect(grid.alive).to eq 11
    grid.evolve
    expect(grid.alive).to eq 21
    4.times { grid.evolve }
    expect(grid.alive).to eq 112
  end

  it "should ..." do
    grid = Conway.new(input, Coord4D)
    6.times { grid.evolve }
    expect(grid.alive).to eq 848
  end
end

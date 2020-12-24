require "rspec"
require_relative "./day"

describe "day" do
  let(:game) do
    Game.parse(<<~INPUT)
      389125467
    INPUT
  end

  let(:actual_game) do
    Game.parse(File.read("input.txt"))
  end

  it "should ..." do
    100.times { game.move }
    expect(game.checksum).to eq "67384529"

    100.times { actual_game.move }
    expect(actual_game.checksum).to eq "52937846"
  end

  it "should do things 10M times" do
    game = Game.parse("389125467", 1_000_000)
    10_000_000.times { game.move }
    expect(game.starcups).to eq 149245887792

    actual_game = Game.parse(File.read("input.txt"), 1_000_000)
    10_000_000.times { actual_game.move }
    expect(actual_game.starcups).to eq 8456532414
  end
end

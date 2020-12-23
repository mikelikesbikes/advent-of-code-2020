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
    game.move
    #expect(game.cups).to eq [3, 2, 8, 9, 1, 5, 4, 6, 7]
    expect(game.current_cup).to eq 2

    9.times { game.move }
    #expect(game.cups).to eq [ 5, 8, 3, 7, 4, 1, 9, 2, 6]
    90.times { game.move }
    expect(game.checksum).to eq "67384529"

    100.times { actual_game.move }
    expect(actual_game.checksum).to eq "52937846"
  end
end

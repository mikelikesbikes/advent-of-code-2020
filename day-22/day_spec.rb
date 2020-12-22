require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      Player 1:
      9
      2
      6
      3
      1

      Player 2:
      5
      8
      4
      7
      10
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should play combat" do
    expect(play(*input)).to eq 306
    expect(play(*actual_input)).to eq 32824
  end

  it "should play recursive combat" do
    expect(play_recursive(*input).abs).to eq 291
    expect(play_recursive(*actual_input).abs).to eq 36515
  end

  it "should stop play if the game repeats itself" do
    input = parse_input(<<~INPUT)
      Player 1:
      43
      19

      Player 2:
      2
      29
      14
    INPUT
    expect(play_recursive(*input)).to be > 0
  end
end

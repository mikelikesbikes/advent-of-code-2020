require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    <<~INPUT
      1 + 2 * 3 + 4 * 5 + 6
      1 + (2 * 3) + (4 * (5 + 6))
      2 * 3 + (4 * 5)
      5 + (8 * 3 + 9 + 3 * 4 * 3)
      5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
      ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(evaluate(parse_input(input, Operation))).to eq [71, 51, 26, 437, 12240, 13632]
  end

  it "does advanced math" do
    expect(evaluate(parse_input(input, Operation2))).to eq [231, 51, 46, 1445, 669060, 23340]
  end
end

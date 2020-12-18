require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
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

  it "do basic math" do
    expect(evaluate(input, P1_PRECEDENCE)).to eq [71, 51, 26, 437, 12240, 13632]
    expect(evaluate(actual_input, P1_PRECEDENCE).sum).to eq 9535936849815
  end

  it "does advanced math" do
    expect(evaluate(input, P2_PRECEDENCE)).to eq [231, 51, 46, 1445, 669060, 23340]
    expect(evaluate(actual_input, P2_PRECEDENCE).sum).to eq 472171581333710
  end
end

require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    INPUT
  end

  let(:console) { Console.new(input, 0, 0, Set.new) }
  it "should ..." do
    expect(console.break_at_loop.acc).to eq 5
  end

  it "should repair the console" do
    expect(console.repair.acc).to eq 8
  end
end

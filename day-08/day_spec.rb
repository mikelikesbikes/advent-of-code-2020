require "rspec"
require_relative "./day"

describe "day" do
  let(:console) do
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

  let(:actual_console) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(console.break_at_loop.acc).to eq 5
    expect(actual_console.break_at_loop.acc).to eq 1727
  end

  it "should repair the console" do
    expect(console.repair.acc).to eq 8
    expect(actual_console.repair.acc).to eq 552
  end
end

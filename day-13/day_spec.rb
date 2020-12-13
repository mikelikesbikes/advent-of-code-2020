require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      939
      7,13,x,x,59,x,31,19
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should find the next bus arriving after the given timestamp" do
    expect(earliest_bus_id(*input)).to eq 295
    expect(earliest_bus_id(*actual_input)).to eq 1915
  end

  it "should find the time that satisfies the contest constraints" do
    expect(find_subsequent_time(input.last)).to eq 1068781
    expect(find_subsequent_time(actual_input.last)).to eq 294354277694107
  end
end

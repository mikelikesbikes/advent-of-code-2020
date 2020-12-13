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

  it "should ..." do
    expect(earliest_bus_id(*input)).to eq 295
  end

  it "should win the context" do
    expect(find_subsequent_time(*input)).to eq 1068781
  end
end

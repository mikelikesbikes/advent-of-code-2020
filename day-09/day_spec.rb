require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    INPUT
  end
  let(:actual_input) { parse_input(File.read("input.txt")) }

  it "should find the first invalid XMAS code" do
    expect(find_first_invalid_xmas_code(input, 5)).to eq 127
    expect(find_first_invalid_xmas_code(actual_input, 25)).to eq 776203571
  end

  it "should find the encryption weakness" do
    expect(find_weakness(input, 127)).to eq 62
    expect(find_weakness(actual_input, 776203571)).to eq 104800569
    expect(wobbling_sliding_window(input, 127)).to eq 62
    expect(wobbling_sliding_window(actual_input, 776203571)).to eq 104800569
  end
end

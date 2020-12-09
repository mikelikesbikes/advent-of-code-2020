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

  it "should find the first invalid XMAS code" do
    expect(find_first_invalid_xmas_code(input, 5)).to eq 127
  end

  it "should find the encryption weakness" do
    expect(find_weakness(input, 5)).to eq 62
  end
end

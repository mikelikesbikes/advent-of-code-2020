require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    INPUT
  end
  let(:input2) do
    parse_input(<<~INPUT)
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(DecoderV1.new(input).sum_memory).to eq 165
    expect(DecoderV1.new(actual_input).sum_memory).to eq 6317049172545
  end
  it "should ..." do
    expect(DecoderV2.new(input2).sum_memory).to eq 208
    expect(DecoderV2.new(actual_input).sum_memory).to eq 3434009980379
  end
end

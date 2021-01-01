require "rspec"
require_relative "./day"

describe "Day1" do
  let(:input) do
    parse_input(<<~INPUT)
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should validate ranged passwords" do
    expect(valid_passwords(input)).to eq 2
    expect(valid_passwords(actual_input)).to eq 586
  end

  it "should validate positional passwords" do
    expect(valid_passwords_new(input)).to eq 1
    expect(valid_passwords_new(actual_input)).to eq 352
  end
end

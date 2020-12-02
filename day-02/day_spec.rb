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

  it "should validate ranged passwords" do
    expect(valid_passwords(input).length).to eq 2
  end

  it "should validate positional passwords" do
    expect(valid_passwords_new(input).length).to eq 1
  end
end

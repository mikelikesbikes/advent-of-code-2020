require "rspec"
require_relative "./day"

describe "Day1" do
  let(:input) do
    <<~INPUT.split("\n")
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    INPUT
  end

  it "should validate ranged passwords" do
    passwords = parse_input(input)
    expect(valid_passwords(passwords).length).to eq 2
  end

  it "should validate positional passwords" do
    passwords = parse_input(input)
    expect(valid_passwords_new(passwords).length).to eq 1
  end
end

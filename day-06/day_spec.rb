require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should calculate the number of unique yes questions" do
    expect(uniq_question_count(input)).to eq 11
    expect(uniq_question_count(actual_input)).to eq 6506
  end

  it "should calculate the number of questions everyone answered yes" do
    expect(all_question_count(input)).to eq 6
    expect(all_question_count(actual_input)).to eq 3243
  end
end

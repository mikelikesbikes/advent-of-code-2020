require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      FBFBBFFRLR
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
      FBFBBFFRRR
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(max_seat_id(input)).to eq 820
    expect(max_seat_id(actual_input)).to eq 894
  end

  it "should find its seat" do
    expect(find_seat(input)).to eq 358
    expect(find_seat(actual_input)).to eq 579
  end
end

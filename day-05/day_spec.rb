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

  it "should ..." do
    expect(max_seat_id(input)).to eq 820
  end

  it "should find its seat" do
    expect(find_seat(input)).to eq 358
  end
end

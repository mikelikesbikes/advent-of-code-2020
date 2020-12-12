require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      F10
      N3
      F7
      R90
      F11
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should navigate" do
    ship = Ship.new
    ship.navigate(input)
    expect(ship.coord).to eq Coord.new(17, -8)
    expect(ship.facing).to eq 180
    expect(ship.coord.distance).to eq 25

    ship = Ship.new
    ship.navigate(actual_input)
    expect(ship.coord.distance).to eq 1482
  end

  it "should navigate to waypoints" do
    ship = WaypointShip.new
    ship.navigate(input)
    expect(ship.coord).to eq Coord.new(214, -72)
    expect(ship.coord.distance).to eq 286

    ship = WaypointShip.new
    ship.navigate(actual_input)
    expect(ship.coord.distance).to eq 48739
  end
end

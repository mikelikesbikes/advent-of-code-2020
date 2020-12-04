def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n\n").map do |p|
    p.split(/\s+/).each_with_object({}) do |d, h|
      h.store(*d.split(":"))
    end
  end
end

def valid_passports(passports, strict: true)
  passports.count do |p|
    [
      p.key?("byr") && (!strict || p["byr"].to_i.between?(1920, 2002)),
      p.key?("iyr") && (!strict || p["iyr"].to_i.between?(2010, 2020)),
      p.key?("eyr") && (!strict || p["eyr"].to_i.between?(2020, 2030)),
      p.key?("hgt") && (!strict || (p["hgt"][-2..-1] == "in" ? p["hgt"].to_i.between?(59, 76) : p["hgt"].to_i.between?(150, 193))),
      p.key?("hcl") && (!strict || p["hcl"].match?(/^#[0-9a-f]{6}$/)),
      p.key?("ecl") && (!strict || %w[amb blu brn gry grn hzl oth].include?(p["ecl"])),
      p.key?("pid") && (!strict || p["pid"].match?(/^[0-9]{9}$/)),
    ].all?
  end
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_passports(input, strict: false)
puts valid_passports(input)

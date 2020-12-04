def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n\n").map do |p|
    p.split(/\s+/).each_with_object({}) do |d, h|
      key, val = d.split(":")
      h[key] = val
    end
  end
end

def valid_passports(passports)
  passports.count do |p|
    %w[byr iyr eyr hgt hcl ecl pid].all? { |field| p.key?(field) }
  end
end

def strict_valid_passports(passports)
  passports.count do |p|
    validations = [p.key?("byr") && p["byr"].to_i.between?(1920, 2002),
     p.key?("iyr") && p["iyr"].to_i.between?(2010, 2020),
     p.key?("eyr") && p["eyr"].to_i.between?(2020, 2030),
     p.key?("hgt") && p["hgt"][-2..-1] == "in" ? p["hgt"].to_i.between?(59, 76) : p["hgt"].to_i.between?(150, 193),
     p.key?("hcl") && p["hcl"].match?(/^#[0-9a-f]{6}$/),
     p.key?("ecl") && %w[amb blu brn gry grn hzl oth].include?(p["ecl"]),
     p.key?("pid") && p["pid"].match?(/^[0-9]{9}$/),
    ]
    p(p)
    p validations
    validations.all?
  end
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_passports(input)
puts strict_valid_passports(input)

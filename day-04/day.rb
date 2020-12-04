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
      p.key?("byr") && (!strict || Integer(p["byr"]).between?(1920, 2002)),
      p.key?("iyr") && (!strict || Integer(p["iyr"]).between?(2010, 2020)),
      p.key?("eyr") && (!strict || Integer(p["eyr"]).between?(2020, 2030)),
      p.key?("hgt") && (!strict || (case p["hgt"][-2..-1]
                                    when "in" then Integer(p["hgt"][0..-3]).between?(59, 76)
                                    when "cm" then Integer(p["hgt"][0..-3]).between?(150, 193)
                                    else false
                                    end)),
      p.key?("hcl") && (!strict || p["hcl"].match?(/^#[0-9a-f]{6}$/)),
      p.key?("ecl") && (!strict || p["ecl"].match?(/^(amb|blu|brn|gry|grn|hzl|oth)$/)),
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

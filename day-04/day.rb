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

VALIDATORS = {
  "byr" => -> (value) { Integer(value).between?(1920, 2002) },
  "iyr" => -> (value) { Integer(value).between?(2010, 2020) },
  "eyr" => -> (value) { Integer(value).between?(2020, 2030) },
  "hgt" => -> (value) {
    case value[-2..-1]
    when "in" then Integer(value[0..-3]).between?(59, 76)
    when "cm" then Integer(value[0..-3]).between?(150, 193)
    else false
    end
  },
  "hcl" => -> (value) { value.match?(/^#[0-9a-f]{6}$/) },
  "ecl" => -> (value) { value.match?(/^(amb|blu|brn|gry|grn|hzl|oth)$/) },
  "pid" => -> (value) { value.match?(/^[0-9]{9}$/) },
}
VALIDATORS.default = -> (_) { false }
def valid_passports(passports, strict: true)
  passports.count do |p|
    VALIDATORS.all? do |field, validator|
      p.key?(field) && (!strict || validator.call(p[field]))
    end
  end
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_passports(input, strict: false)
puts valid_passports(input)

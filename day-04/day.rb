def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n\n").map do |p|
    Hash[p.scan(/(\w+):(\S+)/)]
  end
end

def validate(&block)
  -> (value, validate_value) { value && (!validate_value || block.call(value)) }
end
VALIDATORS = {
  "byr" => validate { |v| Integer(v).between?(1920, 2002) },
  "iyr" => validate { |v| Integer(v).between?(2010, 2020) },
  "eyr" => validate { |v| Integer(v).between?(2020, 2030) },
  "hgt" => validate { |v|
    case v[-2..-1]
    when "in" then Integer(v[0..-3]).between?(59, 76)
    when "cm" then Integer(v[0..-3]).between?(150, 193)
    else false
    end
  },
  "hcl" => validate { |v| v.match?(/^#[0-9a-f]{6}$/) },
  "ecl" => validate { |v| v.match?(/^(amb|blu|brn|gry|grn|hzl|oth)$/) },
  "pid" => validate { |v| v.match?(/^[0-9]{9}$/) },
}
VALIDATORS.default = -> (_) { false }
def valid_passports(passports, strict: true)
  passports.count do |p|
    VALIDATORS.all? { |field, validator| validator.call(p[field], strict) }
  end
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_passports(input, strict: false)
puts valid_passports(input)

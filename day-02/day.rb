def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n").map do |line|
    policy, password = line.split(": ")
    range, c = policy.split(" ")
    b, e = range.split("-")
    [b.to_i, e.to_i, c, password]
  end
end

def valid_passwords(passwords)
  passwords.count do |b, e, c, password|
    password.count(c).between?(b, e)
  end
end

def valid_passwords_new(passwords)
  passwords.count do |b, e, c, password|
    (password[b-1] == c) ^ (password[e-1] == c)
  end
end

return unless $PROGRAM_NAME == __FILE__

passwords = parse_input(read_input)

puts valid_passwords(passwords)
puts valid_passwords_new(passwords)

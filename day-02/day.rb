def read_lines(filename = File.expand_path("input.txt", __dir__))
  File.read(filename).split("\n")
end

def parse_input(input)
  input.map do |s|
    policy, password = s.split(": ")
    range, c = policy.split(" ")
    b, e = range.split("-")
    [b.to_i, e.to_i, c, password]
  end
end

def valid_passwords(passwords)
  passwords.filter do |b, e, c, password|
    count = password.chars.count { |l| l == c }
    count >= b && count <= e
  end
end

def valid_passwords_new(passwords)
  passwords.filter do |b, e, c, password|
    c1, c2 = password[b-1], password[e-1]
    (c1 == c || c2 == c) && c1 != c2
  end
end

return unless $PROGRAM_NAME == __FILE__

passwords = parse_input(read_lines)

puts valid_passwords(passwords).length
puts valid_passwords_new(passwords).length

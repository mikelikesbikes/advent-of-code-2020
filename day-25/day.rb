def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n").map do |line|
    Integer(line)
  end
end

def find_loop_size(public_key)
  subject_number = 7
  value = 1
  i = 0
  while value != public_key
    value = value * subject_number % 20201227
    i += 1
  end
  i
end

def transform(public_key, loop_size)
  subject_number = public_key
  value = 1
  loop_size.times do
    value = value * subject_number
    value = value % 20201227
  end
  value
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

k1, k2 = parse_input(read_input)
puts transform(k1, find_loop_size(k2))
# don't really need this second one... just wanted to see it generate the same
# number twice :)
puts transform(k2, find_loop_size(k1))

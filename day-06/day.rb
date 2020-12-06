def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  input.split("\n\n").map { |line| line.split("\n").map(&:chars) }
end

def uniq_question_count(input)
  input.sum do |group|
    group.reduce(&:|).length
  end
end

def all_question_count(input)
  input.sum do |group|
    group.reduce(&:&).length
  end
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts uniq_question_count(input)
puts all_question_count(input)

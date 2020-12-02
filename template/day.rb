def read_input(filename = File.expand_path("input.txt", __dir__))
  File.read(filename)
end

def parse_input(input)
  input.split("\n").map do |line|
    Integer(line)
  end
end


### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = read_lines

### RUN STUFF HERE ###

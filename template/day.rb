def read_lines(filename = File.expand_path("input.txt", __dir__))
  File.read(filename).split("\n").map(&:to_i)
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__

input = read_lines

### RUN STUFF HERE ###

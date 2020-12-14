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
    case line
    when /^mask = ([01X]{36})$/
      ["mask", $1]
    when /^mem\[(\d{1,6})\] = (\d+)$/
      ["mem", Integer($1), Integer($2)]
    end
  end
end


### CODE HERE ###
class DecoderV1
  attr_reader :memory
  def initialize(lines)
    @memory = Hash.new(0)
    mask = "X"*36
    lines.each do |op, *args|
      case op
      when "mask"
        mask = args.first
      when "mem"
        memory[args[0]] = mask_value(mask, args[1])
      end
    end
  end

  def mask_value(mask, val)
    one_mask = mask.gsub(/[X0]/, "0").to_i(2)
    zero_mask = mask.gsub(/X/, "1").to_i(2)
    (val | one_mask) & zero_mask
  end
end

class DecoderV2
  attr_reader :memory
  def initialize(lines)
    @memory = Hash.new(0)
    mask = "X"*36
    lines.each do |op, *args|
      case op
      when "mask"
        mask = args[0]
      when "mem"
        set_memory(mask_address(mask, args[0]), args[1])
      end
    end
  end

  def mask_address(mask, addr)
    masked_address = addr.to_s(2).rjust(mask.length, "0").chars.zip(mask.chars).map do |(a, m)|
      case m
      when "0" then a
      when "1" then "1"
      when "X" then "X"
      end
    end.join
  end

  def set_memory(addr, val)
    index = addr.index("X")
    return @memory[addr.to_i(2)] = val unless index

    set_memory(addr.dup.tap {|a| a[index] = "0" }, val)
    set_memory(addr.dup.tap {|a| a[index] = "1" }, val)
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts DecoderV1.new(input).memory.values.sum
puts DecoderV2.new(input).memory.values.sum

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
      [MASK, $1]
    when /^mem\[(\d{1,6})\] = (\d+)$/
      [MEM, Integer($1), Integer($2)]
    end
  end
end

ZERO = ?0
ONE = ?1
X = ?X
MASK = "mask"
MEM = "mem"

### CODE HERE ###
class DecoderBase
  attr_reader :memory, :mask
  def initialize(lines)
    @memory = Hash.new(0)
    lines.each do |op, *args|
      case op
      when MASK
        set_mask(args[0])
      when MEM
        set_memory(args[0], args[1])
      end
    end
  end

  def set_mask(mask)
    @mask = mask
  end

  def sum_memory
    sum = 0
    memory.each_value { |v| sum += v }
    sum
  end

  def bit_at(n, i)
    # 0b000000000000000000000000000000001011, 32 -> 1
    # 0b000000000000000000000000000000001011, 33 -> 0
    (((0XFFFFFFFFF >> i) & n) >> 35 - i)
  end
end

class DecoderV1 < DecoderBase
  def set_memory(addr, val)
    memory[addr] = mask_value(val)
  end

  def mask_value(val)
    s = String.new
    (0...mask.length).each do |i|
      s << case mask[i]
      when ZERO  then ZERO
      when ONE   then ONE
      when X     then bit_at(val, i).zero? ? ZERO : ONE
      end
    end
    s.to_i(2)
  end
end

class DecoderV2 < DecoderBase
  def set_memory(addr, val)
    addr = mask_addr(addr)
    xs = (0...addr.length).each_with_object([]) { |i, a| a << i if addr[i] == X }
    0.upto((2**xs.length)-1).each do |n|
      xs.each_with_index do |xpos, i|
        addr[xpos] = bit_at(n, 36 - xs.length + i).zero? ? ZERO : ONE
      end
      memory[addr.to_i(2)] = val
    end
    val
  end

  def mask_addr(addr)
    s = String.new
    mask.each_char.with_index do |m, i|
      s << case mask[i]
      when ZERO then bit_at(addr, i).zero? ? ZERO : ONE
      when ONE  then ONE
      when X    then X
      end
    end
    s
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)

### RUN STUFF HERE ###
puts DecoderV1.new(input).sum_memory
puts DecoderV2.new(input).sum_memory

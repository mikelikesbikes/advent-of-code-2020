require "set"

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
    Instruction.new(line[0..2], Integer(line[4..-1]))
  end
end

Instruction = Struct.new(:op, :arg)
Console = Struct.new(:instructions, :acc, :ip, :visited) do
  def step(&block)
    throw :done if ip >= self.instructions.length
    block.call(self) if block
    instruction = instructions[ip]
    case instruction.op
    when "nop"
      self.ip += 1
    when "acc"
      self.acc += instruction.arg
      self.ip += 1
    when "jmp"
      self.ip += instruction.arg
    else
      raise "unsupported op #{instruction}"
    end
  end

  def break_at_loop(&block)
    until visited.member?(self.ip)
      visited << self.ip
      self.step(&block)
    end
    self
  end

  def repair
    catch :done do
      instructions.each_with_index do |inst, i|
        case inst.op
        when "nop"
          instructions[i] = Instruction.new("jmp", inst.arg)
        when "jmp"
          instructions[i] = Instruction.new("nop", inst.arg)
        else
          next
        end

        break_at_loop
        instructions[i] = inst
        reset
      end
    end
    self
  end

  def reset
    self.acc = 0
    self.ip = 0
    self.visited = Set.new
  end
end

return unless $PROGRAM_NAME == __FILE__

input = parse_input(read_input)
console = Console.new(input, 0, 0, Set.new)

puts console.break_at_loop.acc
puts console.repair.acc
### RUN STUFF HERE ###

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input, op_class)
  input.split("\n").map do |line|
    op_class.new(line.gsub(/\s+/, "").chars.map { |c| c.match?(/\d/) ? Integer(c) : c })
  end
end

Operation = Struct.new(:tokens) do
  def evaluate
    i = 0
    nums = []
    ops = []
    tokens.each do |token|
      case token
      when 0..9 then nums.push(token)
      when "+", "*"
        if ops.empty?
          ops.push(token)
        else
          if ops.last == "+" || ops.last == "*"
            process(nums, ops) while !ops.empty? && ops.last != "("
            ops.push(token)
          else
            ops.push(token)
          end
        end
      when "(" then ops.push(token)
      when ")"
        process(nums, ops) while !ops.empty? && ops.last != "("
        op = ops.pop
        raise unless op == "("
      end
    end
    process(nums, ops) while !ops.empty?
    nums.pop
  end

  def process(nums, ops)
    a, b = nums.pop(2)
    op = ops.pop
    case op
    when "+" then nums.push(a + b)
    when "*" then nums.push(a * b)
    end
  end
end

Operation2 = Struct.new(:tokens) do
  def evaluate
    i = 0
    nums = []
    ops = []
    tokens.each do |token|
      case token
      when 0..9 then nums.push(token)
      when "+", "*"
        if ops.empty?
          ops.push(token)
        else
          if ops.last == "+" || ops.last == "*"
            process(nums, ops) while !ops.empty? && ops.last != "(" && token < ops.last
            ops.push(token)
          else
            ops.push(token)
          end
        end
      when "(" then ops.push(token)
      when ")"
        process(nums, ops) while !ops.empty? && ops.last != "(" && token < ops.last
        op = ops.pop
        raise unless op == "("
      end
    end
    process(nums, ops) while !ops.empty?
    nums.pop
  end

  def process(nums, ops)
    a, b = nums.pop(2)
    op = ops.pop
    case op
    when "+" then nums.push(a + b)
    when "*" then nums.push(a * b)
    end
  end
end

def evaluate(input)
  input.map(&:evaluate)
end

### CODE HERE ###

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input, Operation)
input2 = parse_input(read_input, Operation2)

### RUN STUFF HERE ###
puts evaluate(input).sum
puts evaluate(input2).sum

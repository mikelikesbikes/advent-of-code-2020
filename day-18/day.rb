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
    Expression.new(line.gsub(/\s+/, "").chars.map { |c| c.match?(/\d/) ? Integer(c) : c })
  end
end

### CODE HERE ###

Expression = Struct.new(:tokens) do
  def evaluate(p)
    i = 0
    nums = []
    ops = []
    tokens.each do |token|
      case token
      when 0..9 then nums.push(token)
      when "+", "*"
        process(nums, ops) while !ops.empty? && p[token] <= p[ops.last]
        ops.push(token)
      when "(" then ops.push(token)
      when ")"
        process(nums, ops) while ops.last != "("
        op = ops.pop
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

def evaluate(input, p)
  input.map { |exp| exp.evaluate(p) }
end

P1_PRECEDENCE = { "+" => 1, "*" => 1, "(" => -1 }
P2_PRECEDENCE = { "+" => 2, "*" => 1, "(" => -1 }

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts evaluate(input, P1_PRECEDENCE).sum
puts evaluate(input, P2_PRECEDENCE).sum

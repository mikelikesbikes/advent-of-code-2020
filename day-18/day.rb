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
    Expression.parse(line)
  end
end

### CODE HERE ###

Expression = Struct.new(:tokens) do
  def self.parse(str)
    new(str.gsub(/\s+/, "").chars.map { |c| c.match?(/\d/) ? Integer(c) : c })
  end

  PRECEDENCE=Hash.new(1).tap { |h| h["("] = 0 }
  def evaluate(p=PRECEDENCE)
    nums, ops = [], []
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
    nums.push(a.send(op, b))
  end
end

def evaluate(input, *p)
  input.map { |exp| exp.evaluate(*p) }
end

P2_PRECEDENCE = PRECEDENCE.merge({"+" => 2, "*" => 1})

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

input = parse_input(read_input)

### RUN STUFF HERE ###
puts evaluate(input).sum
puts evaluate(input, P2_PRECEDENCE).sum

def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

def parse_input(input)
  rules, messages = input.split("\n\n").map { |s| s.split("\n") }
  rules = rules.each_with_object({}) do |rule, h|
    n, parts = rule.split(": ")
    parts = if parts.start_with?('"')
      [parts[1]]
    else
      parts.split("|").map! do |part|
        part.split(" ").map! do |c|
          Integer(c)
        end
      end
    end
    h[Integer(n)] = Rule.new(parts)
  end
  [Rules.new(rules), messages]
end

### CODE HERE ###
Rules = Struct.new(:rules) do
  def match_at?(str, n, i)
    nodes = [Array[i]]
    # 0
    # 4 1 5
    # 4 2 3 5 | 4 3 2 5
    # 4 3 2 5 | 4 4 4 3 5 | 4 5 5 3 5
    # 4 4 4 3 5 | 4 5 5 3 5 | 4 4 5 2 5 | 4 5 4 2 5
    # 4 5 5 3 5 | 4 4 5 2 5 | 4 5 4 2 5 | 4 4 4 4 5 5 | 4 4 4 5 4 5
    # 4 4 5 2 5 | 4 5 4 2 5 | 4 4 4 4 5 5 | 4 4 4 5 4 5 | 4 5 5 4 5 5 | 4 5 5 5 4 5
    # 4 5 4 2 5 | 4 4 4 4 5 5 | 4 4 4 5 4 5 | 4 5 5 4 5 5 | 4 5 5 5 4 5 | 4 4 5 4 4 5 | 4 4 5 5 5 5
    # 4 4 4 4 5 5 | 4 4 4 5 4 5 | 4 5 5 4 5 5 | 4 5 5 5 4 5 | 4 4 5 4 4 5 | 4 4 5 5 5 5

    while !nodes.empty?
      #p nodes
      node = nodes.shift
      # expand each part pushing back into nodes
      # expand index
      i = node.index { |n| Integer === n }
      #p ["node", node, i]
      if i
        prefix, suffix = node[0...i], node[i+1..-1]
        if str.start_with?(prefix.join)
          Array(rules[node[i]].parts).each do |part|
            #p ["parts: ", prefix, part, suffix ]
            #p prefix+Array(part)+suffix
            nodes.push(prefix + Array(part) + suffix)
          end
        end
      else
        return true if node.join == str
      end
    end
  end
end

Rule = Struct.new(:parts) do
end

def valid_messages(rules, messages)
  messages.count do |message|
    rules.match_at?(message, 0, 0)
  end
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

rules, messages = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_messages(rules, messages)

rules.rules[8] = Rule.new([[42], [42, 8]])
rules.rules[11] = Rule.new([[42, 31], [42, 11, 31]])
puts valid_messages(rules, messages)

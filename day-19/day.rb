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
      parts[1]
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
  def match_at(str, n, i)
    #p [str, n, i, rules[i]]
    res = rules[i].match_at(str, n, self)
    p [str, n, i, rules[i], res] if i == 8 || i == 11
    res
  end
end

Rule = Struct.new(:parts) do
  def match_at(str, n, rules)
    if terminal?
      str[n] == parts ? 1 : -1
    else
      parts.each do |part|
        match_len = part.reduce(0) do |o, sub_rule_index|
          res = rules.match_at(str, n + o, sub_rule_index)
          break -1 unless res > 0
          o + res
        end
        return match_len if match_len > 0
      end
      0
    end
  end

  def terminal?
    String === parts
  end
end

def valid_messages(rules, messages)
  messages.count do |message|
    rules.match_at(message, 0, 0) == message.length
  end
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

rules, messages = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_messages(rules, messages)

rules.rules[8] = Rule.new([[42], [42, 8]])
rules.rules[11] = Rule.new([[42, 31], [42, 11, 31]])
puts valid_messages(rules, messages)

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
  rule_set = rules.each_with_object(RuleSet.new) do |str, rule_set|
    rule_set.add(Rule.parse(str))
  end
  [rule_set, messages]
end

### CODE HERE ###
Rule = Struct.new(:id, :parts) do
  def self.parse(str)
    n, str = str.split(": ")

    parts = if str.start_with?('"')
      [str[1]]
    else
      str.split("|").map! do |part|
        part.split(" ").map! do |c|
          Integer(c)
        end
      end
    end
    Rule.new(Integer(n), parts)
  end
end

RuleSet = Struct.new(:rules) do
  def initialize(*)
    super
    self.rules ||= {}
  end

  def add(rule)
    self.rules[rule.id] = rule
  end

  def match_rule?(str, i)
    nodes = [Array[i]]

    while !nodes.empty?
      node = nodes.shift
      i = node.index { |n| Integer === n }
      if i
        prefix, suffix = node[0...i], node[i+1..-1]
        prefix = prefix.join
        # skip expanding patterns that don't start with the prefix
        if str.start_with?(prefix)
          Array(rules[node[i]].parts).each do |part|
            # skip adding patterns that are longer than the target string
            if prefix.length + part.length + suffix.length <= str.length
              nodes.push(Array(prefix) + Array(part) + suffix)
            end
          end
        end
      else
        return true if node.join == str
      end
    end
  end
end


def valid_messages(rules, messages)
  messages.count do |message|
    rules.match_rule?(message, 0)
  end
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

rules, messages = parse_input(read_input)

### RUN STUFF HERE ###
puts valid_messages(rules, messages)

rules.add(Rule.parse("8: 42 | 42 8"))
rules.add(Rule.parse("11: 42 31 | 42 11 31"))
puts valid_messages(rules, messages)

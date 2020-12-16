def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

Rule = Struct.new(:name, :ranges) do
  def self.parse(str)
    name, r1, r2, r3, r4 = str.scan(/^(.*): (\d+)-(\d+) or (\d+)-(\d+)$/).first
    new(name, [Integer(r1)..Integer(r2), Integer(r3)..Integer(r4)])
  end
end

Ticket = Struct.new(:fields) do
  def self.parse(str)
    new(str.split(",").map { |s| Integer(s) })
  end

  def invalid_fields(rules)
    ranges = rules.flat_map { |r| r.ranges }
    fields.select do |v|
      ranges.none? { |r| r.include?(v) }
    end
  end

  def valid?(rules)
    invalid_fields(rules).empty?
  end

  def fields_for(rule)
    fields.length.times.select do |i|
      rule.ranges[0].include?(fields[i]) ||
        rule.ranges[1].include?(fields[i])
    end
  end
end

def parse_input(input)
  rules, ticket, nearby_tickets = input.split("\n\n")
  rules = rules.split("\n").map { |str| Rule.parse(str) }
  ticket = Ticket.parse(ticket.split("\n").last)
  nearby_tickets = nearby_tickets.split("\n")[1..-1].map { |t| Ticket.parse(t) }
  [rules, ticket, nearby_tickets]
end

### CODE HERE ###
def scanning_error_rate(rules, tickets)
  tickets.sum { |t| t.invalid_fields(rules).sum }
end

def label_fields(rules, tickets)
  labels = rules.each_with_object({}) do |rule, h|
    h[rule] = [*0...rules.length]
  end
  tickets.each do |t|
    next unless t.valid?(rules)
    rules.each do |rule|
      fields_for = t.fields_for(rule)
      labels[rule] = labels[rule] & fields_for
    end
  end
  labels = labels.to_a
  final_labels = {}
  until final_labels.length == rules.length
    index = labels.index { |k, v| v.length == 1 }
    label = labels.delete_at(index)
    final_labels[label[0].name] = label[1][0]
    labels.each do |k, v|
      v.delete(label[1][0])
    end
  end
  final_labels.sort_by { |k, v| v }.map { |k, v| k }
end

def departure_fields(rules, ticket, nearby_tickets)
  product = 1
  label_fields(rules, [ticket, *nearby_tickets]).map.with_index do |n, i|
    product *= ticket.fields[i] if n.start_with?("departure")
  end
  product
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

rules, ticket, nearby_tickets = parse_input(read_input)

### RUN STUFF HERE ###
puts scanning_error_rate(rules, nearby_tickets)
puts departure_fields(rules, ticket, nearby_tickets)


def read_input(filename = "input.txt")
  if !STDIN.tty?
    ARGF.read
  else
    filename = File.expand_path(ARGV[0] || filename, __dir__)
    File.read(filename)
  end
end

### CODE HERE ###
Rule = Struct.new(:name, :ranges) do
  def self.parse(str)
    name, r1, r2, r3, r4 = str.scan(/^(.*): (\d+)-(\d+) or (\d+)-(\d+)$/).first
    new(name, [Integer(r1)..Integer(r2), Integer(r3)..Integer(r4)])
  end

  def valid?(val)
    ranges.any? { |r| r.include?(val) }
  end
end

Ticket = Struct.new(:fields) do
  def self.parse(str)
    new(str.split(",").map { |s| Integer(s) })
  end

  def invalid_fields(rules)
    fields.select do |v|
      rules.none? { |r| r.valid?(v) }
    end
  end

  def valid?(rules)
    invalid_fields(rules).empty?
  end

  def fields_for(rule)
    fields.length.times.select do |i|
      rule.valid?(fields[i])
    end
  end
end

def parse_input(input)
  rules, ticket, nearby_tickets = input.split("\n\n")
  rules = rules.split("\n").map { |str| Rule.parse(str) }
  ticket = Ticket.parse(ticket.split("\n")[1])
  nearby_tickets = nearby_tickets.split("\n")[1..-1].map { |t| Ticket.parse(t) }
  [rules, ticket, nearby_tickets]
end

def scanning_error_rate(rules, tickets)
  tickets.sum { |t| t.invalid_fields(rules).sum }
end

def label_fields(rules, tickets)
  # build a hash with each rule name to an array of candidate column indexes
  labels = rules.each_with_object({}) do |rule, h|
    h[rule.name] = [*0...rules.length]
  end

  # for every valid ticket, check find the rules that are valid for each field,
  # and update the candidates list using the intersection of current candidates
  tickets.each do |t|
    next unless t.valid?(rules)
    rules.each do |rule|
      candidates = labels[rule.name]

      # skip any rules where we've already narrowed candidates down to 1
      next if candidates.length == 1

      # update the candidates for the given rule
      rule_fields = t.fields_for(rule)
      candidates.delete_if { |c| !rule_fields.include?(c) }

      # prune the candidate from all candidate lists if there's only 1
      # candidate for a rule
      if candidates.length == 1
        labels.each do |k, v|
          next if k == rule.name
          v.delete(candidates.first)
        end
      end
    end
  end

  # consolidate the field labels by finding labels that have only a single
  # candidate removing those from the candidate labels and adding them to the
  # proper column in final labels and removing that column from all other
  # labels candidate columns
  final_labels = Array.new(labels.length)
  until labels.empty?
    label, cols = labels.each.find { |k, v| v.length == 1 }
    labels.delete(label)
    final_labels[cols.first] = label
    labels.each do |k, v|
      v.delete(cols.first)
    end
  end
  final_labels
end

def departure_fields(rules, ticket, nearby_tickets)
  label_fields(rules, [ticket, *nearby_tickets]).each_with_index.reduce(1) do |product, (n, i)|
    n.start_with?("departure") ? product * ticket.fields[i] : product
  end
end

return unless $PROGRAM_NAME == __FILE__ || $PROGRAM_NAME.end_with?("ruby-memory-profiler")

rules, ticket, nearby_tickets = parse_input(read_input)

### RUN STUFF HERE ###
puts scanning_error_rate(rules, nearby_tickets)
puts departure_fields(rules, ticket, nearby_tickets)


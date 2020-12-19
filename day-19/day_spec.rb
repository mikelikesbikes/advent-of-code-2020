require "rspec"
require_relative "./day"

describe "day" do
  let(:input) do
    parse_input(<<~INPUT)
      0: 4 1 5
      1: 2 3 | 3 2
      2: 4 4 | 5 5
      3: 4 5 | 5 4
      4: "a"
      5: "b"

      ababbb
      bababa
      abbbab
      aaabbb
      aaaabbb
    INPUT
  end
  let(:input2) do
    parse_input(<<~INPUT)
      42: 9 14 | 10 1
      9: 14 27 | 1 26
      10: 23 14 | 28 1
      1: "a"
      11: 42 31
      5: 1 14 | 15 1
      19: 14 1 | 14 14
      12: 24 14 | 19 1
      16: 15 1 | 14 14
      31: 14 17 | 1 13
      6: 14 14 | 1 14
      2: 1 24 | 14 4
      0: 8 11
      13: 14 3 | 1 12
      15: 1 | 14
      17: 14 2 | 1 7
      23: 25 1 | 22 14
      28: 16 1
      4: 1 1
      20: 14 14 | 1 15
      3: 5 14 | 16 1
      27: 1 6 | 14 18
      14: "b"
      21: 14 1 | 1 14
      25: 1 1 | 1 14
      22: 14 14
      8: 42
      26: 14 22 | 1 20
      18: 15 15
      7: 14 5 | 1 21
      24: 14 1

      abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
      bbabbbbaabaabba
      babbbbaabbbbbabbbbbbaabaaabaaa
      aaabbbbbbaaaabaababaabababbabaaabbababababaaa
      bbbbbbbaaaabbbbaaabbabaaa
      bbbababbbbaaaaaaaabbababaaababaabab
      ababaaaaaabaaab
      ababaaaaabbbaba
      baabbaaaabbaaaababbaababb
      abbbbabbbbaaaababbbbbbaaaababb
      aaaaabbaabaaaaababaa
      aaaabbaaaabbaaa
      aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
      babaaabbbaaabaababbaabababaaab
      aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
    INPUT
  end

  let(:actual_input) do
    parse_input(File.read("input.txt"))
  end

  it "should ..." do
    expect(valid_messages(*input)).to eq 2
    expect(valid_messages(*input2)).to eq 3
    expect(valid_messages(*actual_input)).to eq 165
  end

  it "should find valid messages with modified rules" do
    rules, messages = input2
    rules.add(Rule.parse("8: 42 | 42 8"))
    rules.add(Rule.parse("11: 42 31 | 42 11 31"))
    expect(valid_messages(*input2)).to eq 12

    rules, messages = actual_input
    rules.add(Rule.parse("8: 42 | 42 8"))
    rules.add(Rule.parse("11: 42 31 | 42 11 31"))
    expect(valid_messages(*actual_input)).to eq 274
  end
end

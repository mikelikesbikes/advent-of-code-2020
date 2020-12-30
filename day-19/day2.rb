# This was an experiment, and is still WIP, to see if i could effectively use
# parslet to solve the problem... i got it working for part 1, but for
# whatever reason i couldn't modify the rules to get it working for part 2...
require "parslet"

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
#  parser = rules.each_with_object(P.new) do |str, parser|
#    parser.class.add_rule(str)
#  end
  messages
end

class P < Parslet::Parser
  def self.add_rule(str)
    n, str = str.split(": ")
    rule = if str[0] == "\""
      "match(#{str})"
    else
      str.split(" | ").map { |s| "r"+s.gsub(" ", " >> r") }.join(" | ")
    end

    puts(<<~RUBY)
      rule(:r#{n}) { #{rule} }
    RUBY
  end

  root(:r0)

  def set_root(i)
    self.class.module_eval "root(:r#{i})"
  end
end

#parser, messages = parse_input(read_input)
#puts messages.count { |m| parser.parse(m) rescue nil }
#
#P.rule(:r8) { r42 >> r8.repeat }
#P.rule(:r11) { r42 >> r11.repeat >> r31 }
#
#parser = P.new
#puts messages.count { |m| parser.parse(m) rescue nil }

#class P < Parslet::Parser
#  rule(:r0) { r4 >> r1 >> r5 }
#  rule(:r1) { r2 >> r3 | r3 >> r2 }
#  rule(:r2) { r4 >> r4 | r5 >> r5 }
#  rule(:r3) { r4 >> r5 | r5 >> r4 }
#  rule(:r4) { match("a") }
#  rule(:r5) { match("b") }
#  root(:r0)
#end

class P1 < Parslet::Parser
  rule(:r66) { r69 >> r116 | r9 >> r115 }
  rule(:r91) { r95 >> r9 | r109 >> r69 }
  rule(:r14) { r110 >> r69 | r15 >> r9 }
  rule(:r4) { r119 >> r9 | r61 >> r69 }
  rule(:r17) { r9 >> r23 | r69 >> r93 }
  rule(:r37) { r118 >> r69 | r94 >> r9 }
  rule(:r68) { r9 >> r80 | r69 >> r19 }
  rule(:r117) { r37 >> r9 | r45 >> r69 }
  rule(:r132) { r9 >> r109 }
  rule(:r74) { r9 >> r25 | r69 >> r126 }
  rule(:r102) { r122 >> r9 | r6 >> r69 }
  rule(:r98) { r89 >> r9 | r99 >> r69 }
  rule(:r113) { r83 >> r9 | r7 >> r69 }
  rule(:r92) { r9 >> r16 | r69 >> r50 }
  rule(:r33) { r9 >> r39 | r69 >> r133 }
  rule(:r134) { r95 >> r69 | r7 >> r9 }
  rule(:r57) { r9 >> r7 | r69 >> r110 }
  rule(:r31) { r9 >> r66 | r69 >> r51 }
  rule(:r47) { r9 >> r3 | r69 >> r83 }
  rule(:r21) { r69 >> r123 | r9 >> r129 }
  rule(:r104) { r9 >> r86 | r69 >> r7 }
  rule(:r40) { r69 >> r24 | r9 >> r34 }
  rule(:r32) { r9 >> r44 | r69 >> r88 }
  rule(:r45) { r49 >> r69 | r48 >> r9 }
  rule(:r2) { r69 >> r88 | r9 >> r23 }
  rule(:r5) { r3 >> r9 | r110 >> r69 }
  rule(:r108) { r20 >> r86 }
  rule(:r76) { r97 >> r9 | r113 >> r69 }
  rule(:r56) { r9 >> r121 | r69 >> r58 }
  rule(:r29) { r69 >> r13 | r9 >> r82 }
  rule(:r123) { r86 >> r20 }
  rule(:r46) { r23 >> r69 | r95 >> r9 }
  rule(:r19) { r7 >> r69 | r109 >> r9 }
  rule(:r12) { r93 >> r9 | r95 >> r69 }
  rule(:r75) { r85 >> r9 | r128 >> r69 }
  rule(:r127) { r93 >> r69 | r83 >> r9 }
  rule(:r61) { r9 >> r7 | r69 >> r23 }
  rule(:r78) { r9 >> r132 | r69 >> r107 }
  rule(:r121) { r88 >> r69 | r23 >> r9 }
  rule(:r60) { r33 >> r69 | r76 >> r9 }
  rule(:r73) { r26 >> r69 | r100 >> r9 }
  rule(:r116) { r9 >> r60 | r69 >> r75 }
  rule(:r93) { r69 >> r9 }
  rule(:r38) { r9 >> r106 | r69 >> r110 }
  rule(:r107) { r9 >> r7 | r69 >> r86 }
  rule(:r82) { r5 >> r69 | r64 >> r9 }
  rule(:r58) { r44 >> r69 | r23 >> r9 }
  rule(:r34) { r69 >> r57 | r9 >> r104 }
  rule(:r124) { r69 >> r106 | r9 >> r44 }
  rule(:r109) { r69 >> r9 | r9 >> r9 }
  rule(:r48) { r69 >> r44 | r9 >> r83 }
  rule(:r28) { r9 >> r83 | r69 >> r7 }
  rule(:r64) { r9 >> r93 | r69 >> r7 }
  rule(:r54) { r9 >> r102 | r69 >> r40 }
  rule(:r94) { r83 >> r69 | r7 >> r9 }
  rule(:r80) { r9 >> r86 | r69 >> r3 }
  rule(:r62) { r86 >> r69 | r83 >> r9 }
  rule(:r42) { r125 >> r69 | r70 >> r9 }
  rule(:r71) { r69 >> r112 | r9 >> r114 }
  rule(:r8) { r42 }
  rule(:r131) { r69 >> r44 | r9 >> r7 }
  rule(:r88) { r69 >> r9 | r9 >> r69 }
  rule(:r87) { r15 >> r69 | r7 >> r9 }
  rule(:r3) { r9 >> r9 | r69 >> r69 }
  rule(:r9) { match("b") }
  rule(:r41) { r21 >> r69 | r78 >> r9 }
  rule(:r65) { r9 >> r69 | r69 >> r20 }
  rule(:r128) { r134 >> r69 | r101 >> r9 }
  rule(:r44) { r9 >> r69 | r69 >> r69 }
  rule(:r51) { r9 >> r18 | r69 >> r54 }
  rule(:r55) { r69 >> r79 | r9 >> r5 }
  rule(:r95) { r69 >> r69 | r69 >> r9 }
  rule(:r110) { r9 >> r69 }
  rule(:r22) { r92 >> r69 | r10 >> r9 }
  rule(:r67) { r9 >> r44 | r69 >> r23 }
  rule(:r7) { r9 >> r20 | r69 >> r69 }
  rule(:r90) { r69 >> r96 | r9 >> r68 }
  rule(:r53) { r111 >> r9 | r27 >> r69 }
  rule(:r125) { r69 >> r72 | r9 >> r22 }
  rule(:r11) { r42 >> r31 }
  rule(:r23) { r9 >> r69 | r9 >> r9 }
  rule(:r114) { r69 >> r105 | r9 >> r131 }
  rule(:r81) { r53 >> r69 | r29 >> r9 }
  rule(:r69) { match("a") }
  rule(:r1) { r86 >> r9 | r95 >> r69 }
  rule(:r18) { r9 >> r73 | r69 >> r90 }
  rule(:r83) { r20 >> r20 }
  rule(:r130) { r89 >> r69 | r47 >> r9 }
  rule(:r89) { r44 >> r9 | r93 >> r69 }
  rule(:r15) { r9 >> r9 }
  rule(:r0) { r8 >> r11 }
  rule(:r105) { r69 >> r110 }
  rule(:r13) { r135 >> r9 | r14 >> r69 }
  rule(:r6) { r69 >> r105 | r9 >> r132 }
  rule(:r103) { r120 >> r69 | r71 >> r9 }
  rule(:r85) { r1 >> r69 | r2 >> r9 }
  rule(:r96) { r89 >> r9 | r12 >> r69 }
  rule(:r101) { r69 >> r95 | r9 >> r23 }
  rule(:r39) { r69 >> r15 | r9 >> r109 }
  rule(:r133) { r88 >> r69 | r65 >> r9 }
  rule(:r86) { r69 >> r20 | r9 >> r9 }
  rule(:r122) { r127 >> r9 | r43 >> r69 }
  rule(:r20) { r69 | r9 }
  rule(:r52) { r69 >> r109 | r9 >> r3 }
  rule(:r119) { r15 >> r69 | r88 >> r9 }
  rule(:r77) { r9 >> r7 | r69 >> r93 }
  rule(:r50) { r87 >> r9 | r61 >> r69 }
  rule(:r129) { r9 >> r65 | r69 >> r110 }
  rule(:r97) { r69 >> r95 | r9 >> r93 }
  rule(:r111) { r59 >> r69 | r35 >> r9 }
  rule(:r115) { r69 >> r84 | r9 >> r41 }
  rule(:r84) { r36 >> r69 | r4 >> r9 }
  rule(:r72) { r117 >> r9 | r74 >> r69 }
  rule(:r135) { r110 >> r69 }
  rule(:r112) { r62 >> r69 | r124 >> r9 }
  rule(:r43) { r69 >> r3 | r9 >> r15 }
  rule(:r118) { r109 >> r9 | r93 >> r69 }
  rule(:r49) { r69 >> r23 | r9 >> r83 }
  rule(:r26) { r69 >> r67 }
  rule(:r63) { r106 >> r9 | r44 >> r69 }
  rule(:r70) { r103 >> r69 | r81 >> r9 }
  rule(:r25) { r17 >> r9 | r77 >> r69 }
  rule(:r36) { r91 >> r9 | r32 >> r69 }
  rule(:r10) { r69 >> r98 | r9 >> r56 }
  rule(:r30) { r9 >> r109 | r69 >> r3 }
  rule(:r126) { r9 >> r28 | r69 >> r63 }
  rule(:r16) { r9 >> r38 | r69 >> r30 }
  rule(:r99) { r106 >> r9 | r109 >> r69 }
  rule(:r59) { r23 >> r9 | r3 >> r69 }
  rule(:r120) { r130 >> r9 | r55 >> r69 }
  rule(:r27) { r69 >> r91 | r9 >> r108 }
  rule(:r24) { r46 >> r69 | r52 >> r9 }
  rule(:r35) { r9 >> r93 | r69 >> r109 }
  rule(:r100) { r9 >> r101 | r69 >> r80 }
  rule(:r106) { r69 >> r69 }
  rule(:r79) { r44 >> r69 | r65 >> r9 }
  root(:r0)
end

class P2 < Parslet::Parser
  rule(:r66) { r69 >> r116 | r9 >> r115 }
  rule(:r91) { r95 >> r9 | r109 >> r69 }
  rule(:r14) { r110 >> r69 | r15 >> r9 }
  rule(:r4) { r119 >> r9 | r61 >> r69 }
  rule(:r17) { r9 >> r23 | r69 >> r93 }
  rule(:r37) { r118 >> r69 | r94 >> r9 }
  rule(:r68) { r9 >> r80 | r69 >> r19 }
  rule(:r117) { r37 >> r9 | r45 >> r69 }
  rule(:r132) { r9 >> r109 }
  rule(:r74) { r9 >> r25 | r69 >> r126 }
  rule(:r102) { r122 >> r9 | r6 >> r69 }
  rule(:r98) { r89 >> r9 | r99 >> r69 }
  rule(:r113) { r83 >> r9 | r7 >> r69 }
  rule(:r92) { r9 >> r16 | r69 >> r50 }
  rule(:r33) { r9 >> r39 | r69 >> r133 }
  rule(:r134) { r95 >> r69 | r7 >> r9 }
  rule(:r57) { r9 >> r7 | r69 >> r110 }
  rule(:r31) { r9 >> r66 | r69 >> r51 }
  rule(:r47) { r9 >> r3 | r69 >> r83 }
  rule(:r21) { r69 >> r123 | r9 >> r129 }
  rule(:r104) { r9 >> r86 | r69 >> r7 }
  rule(:r40) { r69 >> r24 | r9 >> r34 }
  rule(:r32) { r9 >> r44 | r69 >> r88 }
  rule(:r45) { r49 >> r69 | r48 >> r9 }
  rule(:r2) { r69 >> r88 | r9 >> r23 }
  rule(:r5) { r3 >> r9 | r110 >> r69 }
  rule(:r108) { r20 >> r86 }
  rule(:r76) { r97 >> r9 | r113 >> r69 }
  rule(:r56) { r9 >> r121 | r69 >> r58 }
  rule(:r29) { r69 >> r13 | r9 >> r82 }
  rule(:r123) { r86 >> r20 }
  rule(:r46) { r23 >> r69 | r95 >> r9 }
  rule(:r19) { r7 >> r69 | r109 >> r9 }
  rule(:r12) { r93 >> r9 | r95 >> r69 }
  rule(:r75) { r85 >> r9 | r128 >> r69 }
  rule(:r127) { r93 >> r69 | r83 >> r9 }
  rule(:r61) { r9 >> r7 | r69 >> r23 }
  rule(:r78) { r9 >> r132 | r69 >> r107 }
  rule(:r121) { r88 >> r69 | r23 >> r9 }
  rule(:r60) { r33 >> r69 | r76 >> r9 }
  rule(:r73) { r26 >> r69 | r100 >> r9 }
  rule(:r116) { r9 >> r60 | r69 >> r75 }
  rule(:r93) { r69 >> r9 }
  rule(:r38) { r9 >> r106 | r69 >> r110 }
  rule(:r107) { r9 >> r7 | r69 >> r86 }
  rule(:r82) { r5 >> r69 | r64 >> r9 }
  rule(:r58) { r44 >> r69 | r23 >> r9 }
  rule(:r34) { r69 >> r57 | r9 >> r104 }
  rule(:r124) { r69 >> r106 | r9 >> r44 }
  rule(:r109) { r69 >> r9 | r9 >> r9 }
  rule(:r48) { r69 >> r44 | r9 >> r83 }
  rule(:r28) { r9 >> r83 | r69 >> r7 }
  rule(:r64) { r9 >> r93 | r69 >> r7 }
  rule(:r54) { r9 >> r102 | r69 >> r40 }
  rule(:r94) { r83 >> r69 | r7 >> r9 }
  rule(:r80) { r9 >> r86 | r69 >> r3 }
  rule(:r62) { r86 >> r69 | r83 >> r9 }
  rule(:r42) { r125 >> r69 | r70 >> r9 }
  rule(:r71) { r69 >> r112 | r9 >> r114 }
  rule(:r8) { (r42).repeat(1) }
  rule(:r131) { r69 >> r44 | r9 >> r7 }
  rule(:r88) { r69 >> r9 | r9 >> r69 }
  rule(:r87) { r15 >> r69 | r7 >> r9 }
  rule(:r3) { r9 >> r9 | r69 >> r69 }
  rule(:r9) { match("b") }
  rule(:r41) { r21 >> r69 | r78 >> r9 }
  rule(:r65) { r9 >> r69 | r69 >> r20 }
  rule(:r128) { r134 >> r69 | r101 >> r9 }
  rule(:r44) { r9 >> r69 | r69 >> r69 }
  rule(:r51) { r9 >> r18 | r69 >> r54 }
  rule(:r55) { r69 >> r79 | r9 >> r5 }
  rule(:r95) { r69 >> r69 | r69 >> r9 }
  rule(:r110) { r9 >> r69 }
  rule(:r22) { r92 >> r69 | r10 >> r9 }
  rule(:r67) { r9 >> r44 | r69 >> r23 }
  rule(:r7) { r9 >> r20 | r69 >> r69 }
  rule(:r90) { r69 >> r96 | r9 >> r68 }
  rule(:r53) { r111 >> r9 | r27 >> r69 }
  rule(:r125) { r69 >> r72 | r9 >> r22 }
  rule(:r11) { r42 >> (r11).repeat(0) >> r31 }
  rule(:r23) { r9 >> r69 | r9 >> r9 }
  rule(:r114) { r69 >> r105 | r9 >> r131 }
  rule(:r81) { r53 >> r69 | r29 >> r9 }
  rule(:r69) { match("a") }
  rule(:r1) { r86 >> r9 | r95 >> r69 }
  rule(:r18) { r9 >> r73 | r69 >> r90 }
  rule(:r83) { r20 >> r20 }
  rule(:r130) { r89 >> r69 | r47 >> r9 }
  rule(:r89) { r44 >> r9 | r93 >> r69 }
  rule(:r15) { r9 >> r9 }
  rule(:r0) { r8 >> r11 }
  rule(:r105) { r69 >> r110 }
  rule(:r13) { r135 >> r9 | r14 >> r69 }
  rule(:r6) { r69 >> r105 | r9 >> r132 }
  rule(:r103) { r120 >> r69 | r71 >> r9 }
  rule(:r85) { r1 >> r69 | r2 >> r9 }
  rule(:r96) { r89 >> r9 | r12 >> r69 }
  rule(:r101) { r69 >> r95 | r9 >> r23 }
  rule(:r39) { r69 >> r15 | r9 >> r109 }
  rule(:r133) { r88 >> r69 | r65 >> r9 }
  rule(:r86) { r69 >> r20 | r9 >> r9 }
  rule(:r122) { r127 >> r9 | r43 >> r69 }
  rule(:r20) { r69 | r9 }
  rule(:r52) { r69 >> r109 | r9 >> r3 }
  rule(:r119) { r15 >> r69 | r88 >> r9 }
  rule(:r77) { r9 >> r7 | r69 >> r93 }
  rule(:r50) { r87 >> r9 | r61 >> r69 }
  rule(:r129) { r9 >> r65 | r69 >> r110 }
  rule(:r97) { r69 >> r95 | r9 >> r93 }
  rule(:r111) { r59 >> r69 | r35 >> r9 }
  rule(:r115) { r69 >> r84 | r9 >> r41 }
  rule(:r84) { r36 >> r69 | r4 >> r9 }
  rule(:r72) { r117 >> r9 | r74 >> r69 }
  rule(:r135) { r110 >> r69 }
  rule(:r112) { r62 >> r69 | r124 >> r9 }
  rule(:r43) { r69 >> r3 | r9 >> r15 }
  rule(:r118) { r109 >> r9 | r93 >> r69 }
  rule(:r49) { r69 >> r23 | r9 >> r83 }
  rule(:r26) { r69 >> r67 }
  rule(:r63) { r106 >> r9 | r44 >> r69 }
  rule(:r70) { r103 >> r69 | r81 >> r9 }
  rule(:r25) { r17 >> r9 | r77 >> r69 }
  rule(:r36) { r91 >> r9 | r32 >> r69 }
  rule(:r10) { r69 >> r98 | r9 >> r56 }
  rule(:r30) { r9 >> r109 | r69 >> r3 }
  rule(:r126) { r9 >> r28 | r69 >> r63 }
  rule(:r16) { r9 >> r38 | r69 >> r30 }
  rule(:r99) { r106 >> r9 | r109 >> r69 }
  rule(:r59) { r23 >> r9 | r3 >> r69 }
  rule(:r120) { r130 >> r9 | r55 >> r69 }
  rule(:r27) { r69 >> r91 | r9 >> r108 }
  rule(:r24) { r46 >> r69 | r52 >> r9 }
  rule(:r35) { r9 >> r93 | r69 >> r109 }
  rule(:r100) { r9 >> r101 | r69 >> r80 }
  rule(:r106) { r69 >> r69 }
  rule(:r79) { r44 >> r69 | r65 >> r9 }
  root(:r0)
end

messages = parse_input(read_input)

#puts messages.count { |m| P1.new.parse(m) rescue nil }
puts messages.count { |m| P2.new.parse(m) rescue nil }

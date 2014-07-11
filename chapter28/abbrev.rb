# Abbrev: Generate sets of unique abbreviations
#
# Given a set of strings, calculate the set of unambiguous abbreviations
# for those strings and return a hash where the keys are all possible
# abbreviations and the values are the full strings.
#
# Also adds a Array#abbrev method.

require 'abbrev'

Abbrev::abbrev(%w{ruby rune})

# => {"ruby"=>"ruby", "rub"=>"ruby", "rune"=>"rune", "run"=>"rune"}

# A trivial command loop using abbreviations:

COMMANDS = %w{ sample send start status stop hello world }.abbrev.tap do |abbrev|
  puts abbrev
end

while line = gets
  line = line.chomp

  case COMMANDS[line]
  when "sample" then puts "word found!"
  when "send" then #...
  else
    STDERR.puts "Unknown command: #{line}"
  end
end

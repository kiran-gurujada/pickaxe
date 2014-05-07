class VowelFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  # Enumerable module requires definition of an iterator
  def each
    @string.scan(/[aeiou]/) do |vowel|
      yield vowel
    end
  end
end

vf = VowelFinder.new("the quick brown fox jumped")
p vf.inject(:+) # => "euiooue"

# We can call inject on VowelFinder because it mixes in Enumerable
# the :+ method adds numbers, or concatenates a string
# we can use a module to encapsulate this functionality too

module Summable
  def sum
    inject(:+)
  end
end

class Array
  include Summable
end

class Range
  include Summable
end

require_relative "vowel_finder"

class VowelFinder
  include Summable
end

p [ 1, 2, 3, 4, 5 ].sum # => 15
p ('a'..'m').sum # => "abcdefghijklm"
p vf.sum # => "euiooue"

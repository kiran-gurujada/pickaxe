# a = a + 2 can be written as a *= 2
# This transfers to similar methods written for your own classes

class Bowlderize
  def initialize(string)
    @value = string.gsub(/[aeiou]/, '*')
  end

  def +(other)
    Bowlderize.new(self.to_s + other.to_s)
  end

  def to_s
    @value
  end
end

puts a = Bowlderize.new("damn ")
puts a += "shame"

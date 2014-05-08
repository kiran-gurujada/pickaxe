# methods can be associated with blocks
# normally the block is called using yield from within the method

def double(p1)
  yield(p1*2)
end

p double(3) {|val| "I got #{val}" } # => "I got 6"
p double("tom") {|val| "Then I got #{val}"} # => "Then I got tomtom"

# however if the last argument in a method definition is prefixed
# with an ampersand, any associated block is converted to a Proc
# and assigned to that argument.
# This allows you to store a block for later use

class TaxCalculator
  def initialize(name, &block)
    @name, @block = name, block
  end

  def get_tax(amount)
    "#@name on #{amount} = #{ @block.call(amount) }"
  end
end

tc = TaxCalculator.new("Sales tax") {|amt| amt * 0.075 }

p tc.get_tax(100) # => "Sales tax on 100 = 7.5"
p tc.get_tax(250) # => "Sales tax on 250 = 18.75"

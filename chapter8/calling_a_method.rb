# call a method by optionally specifying a receiver, giving the name
# of the method and optionally passing some parameters and/or a block
# If you omit the receiver, it defaults to self

class InvoiceWriter
  def initialize(order)
    @order = order
  end

  def write_on(output)
    write_header_on(output) # called on current object
    write_body_on(output) # self is not changed, as there is no receiver
    write_totals_on(output)
  end

  private

  def write_header_on(output)
    # ...
  end

  def write_body_on(output)
    # ...
  end

  def write_totals_on(output)
    # ...
  end
end

# private methods may NOT be called with a receiver, so they must be
# methods available on self

# every method call returns a value (although you don't have to use it)
# the value of a method is the value of the last statement executed by
# the method

# ruby has a return statement, which can be used to exit a method early

def meth_three
  100.times do |num|
    square = num * num
    return num, square if square > 1000 # multiple parameters are returned as an array
  end
end

p meth_three # => [32, 1024]

# you can convert any collection or enumerable object into it's constituent
# elements adn pass those as parameters using the splat

def five(a, b, c, d, e)
  "I was passed #{a} #{b} #{c} #{d} #{e}"
end

p five(1, 2, 3, 4, 5)
p five(1, 2, 3, *['a', 'b'])
p five(*['a', 'b'], 1, 2, 3)
p five(*(10..14))
p five(*[1, 2], 3, *(4..5))

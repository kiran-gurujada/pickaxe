# A module that allows us to tract the execution of methods in a class that
# mixes the module in.

require_relative 'trace_calls'
class Example
  def one(arg)
    puts "One called with #{arg}"
  end
end

ex1 = Example.new
ex1.one("Hello") # no tracing from this call

class Example
  include TraceCalls
  def two(arg1, arg2)
    arg1 + arg2
  end
end

ex1.one("Goodbye") # both of these show traces
puts ex1.two(4, 5)


# There is a sublety here. When we mix in the TraceCalls module to a class,
# it has to add tracing to any existing instance methods in the class.
#
# It also has to arrange to add tracing to any methods we subsequently add.

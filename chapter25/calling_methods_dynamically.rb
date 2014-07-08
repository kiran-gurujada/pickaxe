# The Object#send method lets you tell any object to invoke a method by
# name.

"John Coltrane".send(:length) # => 13
"Miles Davies".send("sub", /iles/, '.') # => "M. Davies"

# Another way of invoking methods dynamically is to use Method objects.
#
# A Method objects is like a Proc: it represents a chunk of code and a
# context in which it executes. In this case, the code is the body of the
# method and the context is the object that created it.
#
# Once we have our Method object, we can execute it sometime later by
# sending it the message +call+.

trane = "John Coltrane".method(:length)
miles = "Miles Davis".method("sub")

trane.call # => 13
miles.call(/iles/, '.') # => "M. Davis"

# You can pass around the Method object like any other, and when Method#call
# is invoked, the method is run just as if you had invoked it on the original
# object.
#
# Apparently this is also how C-style function pointers work.
#
# You can use Method objects in place of procs. e.g.:

def double(a)
  2 * a
end

method_object = method(:double)

[1, 3, 5, 7].map(&method_object) # => [2, 6, 10, 14]

# Method objects are bound to one particular object.
#
# You can create _unbound_ methods (class UnboundMethod) and then subsequently
# bind them to one or more objects. The binding creates a new Method object.
# As with aliases, unbound methods are references to the definition of the
# method at the time they are created:

unbound_length = String.instance_method(:length)
class String
  def length
    99
  end
end

str = "cat"
str.length # => 99
bound_length = unbound_length.bind(str)
bound_length.call # => 3

# The eval method (and its variations such as class_eval, instance_eval and
# module_eval) will parse and execute an abitrary string of Ruby source.

trane = %q{"John Coltrane".length}
miles = '"Miles Davis".sub(/iles/, \'.\')'

eval trane # => 13
eval miles # => "M. Davis"

# When using +eval+, it can be helpful to explicitly state the context in
# which the expression should be evaluated rather than using the current
# context.
#
# You can obtain a context using Object#binding at the desired point:

def get_a_binding
  val = 123
  binding
end

val = "cat"

the_binding = get_a_binding
eval("val", the_binding) # => 123
eval("val") # => "cat"

# The first +eval+ evaluates +val+ in the context of the binding as it was
# inside the method get_a_binding. In this binding, val == 123.
#
# The second +eval+ evaluates +val+ in the top-level binding, where it has
# the value "cat".


# Perforamnce considerations
#
# Ruby offers several ways to invoke an abitrary method of some object:
# Object#send, Method#call and the various flavours of +eval+
#
# Bear in mind that +eval+ is significantly slower than the other methods.

require "benchmark"
include Benchmark

test = "Stormy Weather"
m = test.method(:length)
n = 100000

bm(12) do |x|
  x.report("call") { n.times {m.call} }
  x.report("send") { n.times {test.send(:length) } }
  x.report("eval") { n.times {eval "test.length"} }
end

# Everything in Ruby is an object. However, the top level environment
# would seem to contradict this. We can write, for example:

puts "Hello World!"

# No objects in sight. This could be Fortran or Basic.
#
# Let's dig deeper.
#
# The literal "Hello World!" generates a Ruby +String+ so that's one.
# The bare method +puts+ is effectively the same as +self.puts+ so that's two.
#
# But what is self?

self.class # => Object

# At the top level, code is executed in the context of Object. So any defined
# methods are defined in the context of the Object class.
#
# We can call Kernel.puts from the top-level because Kernel is included
# as a module in Object.

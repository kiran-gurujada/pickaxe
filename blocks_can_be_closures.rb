# what is a closure?
# A closure is a function wrapped up with it's own referencing environment
# It allows a function to access non-local variables
# In this case the closure comes in the form of a lambda constructed by
# the n_times function
# the lambda carries the function argument with it and it becomes part of
# the function object itself.
#
## HINT: it's called a closure because the variable is coupled CLOSELY
## with the function

def n_times(thing)
  lambda {|n| thing * n}
end

# construct Proc object (lambda does this) using argument '23'
p1 = n_times(23)

# this argument is now referenced by calling the Proc, even though it is now
# out of scope, it remains accessible.
p p1.call(3) # => 69
p p1.call(4) # => 92

p2 = n_times("Hello ")
p p2.call(3) # => "Hello Hello Hello"

## A second example

def power_proc_generator
  value = 1
  lambda {value += value}
end

power_proc = power_proc_generator

puts power_proc.call
puts power_proc.call
puts power_proc.call

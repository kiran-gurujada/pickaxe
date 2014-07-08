# ObjectSpace.each_object allows you to traverse all objects in a Ruby program.
# e.g.:

a = Complex(1, 2)
b = Complex(99, -100)
ObjectSpace.each_object(Complex) {|x| puts x}

# Produces:
# 0+1i
# 99-100i
# 1+2i

# Where did the extra 0+1i come from?
#
# It is defined by the Complex class as a constant in Constant::I the square
# root of -1.

a = 102
b = 95
ObjectSpace.each_object(Fixnum) {|x| p x}

# Produces no output.
#
# Neither of the Fixnum objects we created showed up because ObjectSpace
# doesn't know about objects with immediate values:
# Fixnum, Symbol, true, false, nil and most Floats (on 64bit platforms).
#
# Because Ruby allows for abitrary types of objects, you cannot tell what
# it can do without looking inside it.
#
# We can get a list of all the methods that an object responds to:

r = 1..10
list = r.methods
list.length # => 111
list[0..3] # => [:==, :===, :eql?, :hash]

# We can check whether an object responds to a particular method

r = 1..10
r.respond_to?("frozen") # => true
r.respond_to?(:has_key?) # => false
"me".respond_to?("==") # => true

# We can ask for an object's class and unique object ID and test its relationship
# to other classes:

num = 1
num.object_id # => 3
num.class # => Fixnum
num.kind_of?(Fixnum) # => true
num.kind_of?(Numeric) # => true
num.instance_of?(Fixnum) # => true
num.instance_of?(Numeric) # => false


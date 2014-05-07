# Inheritance allows you to create a class that is a refinement or specialization
# of another class.
# This class is called the SUBCLASS of the original, and the original is the SUPERCLASS
# of this class.
#
# The child inherits all of the capabilities of the parent class - all of the parent's
# instance methods are available in instances of the child.

class Parent
  def say_hello
    puts "Hello from #{self}"
  end
end

p = Parent.new
p.say_hello

# subclass the parent...
class Child < Parent
end

# inherits all of parent's methods
c = Child.new
c.say_hello

p Child.superclass # => Parent
p Parent.superclass # => Object
p Object.superclass # => BasicObject

# BasicObject is used sometimes in metaprogramming, acting as a blank canvas
# All objects have BasicObject as the ultimate parent in their class heirarchy
p BasicObject.superclass # => nil

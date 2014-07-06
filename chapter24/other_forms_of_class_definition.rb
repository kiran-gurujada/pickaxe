# There are two additional ways to define a class in Ruby
#
# Subclassing expressions
#
# This form is a generalization of the regular class definition syntax.

class Parent
  #...
end

class Child < Parent
  #...
end

# The object to the right of the < does not necessarily need to be a class
# name - it can be any expression that returns a class object.
#
# Ruby comes with a class called +Struct+ which allows you to define classes
# that contain only data attributes. E.g.:

Person = Struct.new(:name, :address, :likes)

dave = Person.new("Dave", "TX")
dave.likes = "Programming"
puts dave

# The return value from Struct.new is a class object. By assigning it to the
# constant Person, we can thereafter use Person as if it were any other
# class.
#
# But say we wanted to change the to_s method of out Struct.
#
# We could do it by opening up the class e.g.:

Person2 = Struct.new(:name, :address, :likes)

class Person2
  def to_s
    "#{self.name} lives in #{self.address} and likes #{self.likes}"
  end
end

dave = Person2.new("Dave", "Texas")
dave.likes = "Programming"
puts dave

# However, a more elegant solution is this:

class Person3 < Struct.new(:name, :address, :likes)
  def to_s
    "#{self.name} lives in #{self.address} and likes #{self.likes}"
  end
end

dave = Person3.new("Dave", "Texas")
dave.likes = "Programming languages"
puts dave

# The other method is to create singleton classes

class Example
end

ex = Example.new

# When we call Example.new, we invoke the +new+ method on the class object
# +Example+. This is a standard method call - Ruby looks for the new method
# in the class of the object (and the class of Example is Class) and
# invokes it. So we can also invoke Class#new directly:

some_class = Class.new
puts some_class.class

# Pass Class.new a block, and that block is used as the body of the class:

some_class = Class.new do
  def self.class_method
    puts "In class method"
  end
  def instance_method
    puts "Instance method"
  end
end

some_class.class_method
obj = some_class.new
obj.instance_method

# By default these classes will be direct descendents of Object, You can
# give them a different parent by passing the parent's class as a parameter:

some_class = Class.new(String) do
  def vowel_movement
    tr 'aeiou', '*'
  end
end

obj = some_class.new("now is the time")
puts obj.vowel_movement

# How Classes Get Their Names
#
# Classes created using Class.new are nameless.
#
# However, if you assign a nameless class object to a constant, Ruby will
# automatically name the class after the constant:

some_class = Class.new
obj = some_class.new
puts "Initial name is #{some_class.name}"
SomeClass = some_class
puts "Now the name is #{some_class.new}"
puts "also works via the object: #{obj.class.name}"

# We can use these dynamically constructed classes to extend Ruby in
# interesting ways. For example, here's a simple reimplementation of
# the Ruby +Struct+ class:

def MyStruct(*keys)
  Class.new do
    attr_accessor *keys
    def initialize(hash)
      hash.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end

Person = MyStruct :name, :address, :likes
dave = Person.new(name: "dave", address: "TX", likes: "Stilton")
chad = Person.new(name: "chad", likes: "Jazz")
chad.address = "CO"

puts "Dave's name is #{dave.name}"
puts "Chad lives in #{chad.address}"

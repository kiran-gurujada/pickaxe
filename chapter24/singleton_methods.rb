# Ruby lets you define methods that are specific to a particular object.
# These are called singleton methods.

animal = "cat"
puts animal.upcase # => CAT

# Now define a singleton method on the string referenced by animal

def animal.speak
  puts "The #{self} says miaow"
end

animal.speak
puts animal.upcase

# Produces:
#
# The cat says miaow
# CAT

# When we define a method on one instance of a class, Ruby creates a new
# anonymous class (called a _singleton class_ or _eigenclass_) for that object
# and puts the method in that class.
#
# This eigenclass then becomes the the class of the "cat" object and makes
# String (the original class) a superclass of the eigenclass.

# Ruby sets self to the class inside class definitions, so the following are
# equivalent:

class Dave
  def self.class_method_one
    puts "Class method one" # self is set to Dave here
  end
  def Dave.class_method_two
    puts "Class method two"
  end
end

# But there isn't such a thing as class methods in Ruby, so the methods defined
# on the Dave class object are actually held in Dave's eigenclass.
#
# You can also define methods on an object's eigenclass using this notation:

animal = "dog"

class << animal
  # self is now animal's eigenclass
  def speak
    puts "The #{self} says Woof!"
  end
end

animal.speak # => The dog says Woof!

# Class definitions return the value of the last statement evaluated in the class
# body. This can be used to get the eigenclass object.

singleton = class << animal
  def lie
    puts "The #{self} lies down"
  end
  def instance_self
    self
  end
  self  # << return eigenclass object
end

animal.speak
animal.lie
puts "Singleton class object is #{singleton}"
puts "Instance of singleton class for animal calls itself #{animal.instance_self}"
puts "It defines methods #{singleton.instance_methods - 'cat'.methods}"

# Ruby does not allow you to instantiate eigenclasses out of context of their
# original object.

singleton = class << "cat"; self; end
singleton.new # => TypeError can't create instance of singleton class

# You can define attribute getter/setters on a Class using its eigenclass

class Test
  @var = 99 # defined on Class, NOT on instances of this class
  class << self
    attr_accessor :var # set accessor methods on Test class itself
  end
end

puts "Original value = #{Test.var}"
Test.var = "cat"
puts "New value = #{Test.var}"

# Produces:
#
# Original value = 99
# New value = cat

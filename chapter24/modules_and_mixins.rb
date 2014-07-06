# When including a module into a Ruby class, the instance methods of the
# module become available as instance methods of the class.

module Logger
  def log(msg)
    STDERR.puts Time.now.strftime("%H:%M:%S: ") + "#{self} (#{msg})"
  end
end

class Song
  include Logger
end

s = Song.new
s.log("created")

# Ruby implements include very simply: the module you include is inserted
# as a superclass of the class being defined.
#
# Because the module is injected into the chain of superclasses, it must
# hold a link to the original parent class. If it didn't, there would be
# no way of traversing the superclass chain to look up methods.
#
# Modules can be included into many different classes, so using one Module
# object wouldn't work.
#
# To get around this, when you include a module in class Example, Ruby constructs
# a new class object, and inserts it between Example and it's original
# superclass. It then references the module's methods from this new
# class object.
#
# If you change a module after including it in a class, those changes
# are reflected in the class (and the class's objects). Classes are updated
# with new methods as soon as they change in the module.

module Mod
  def greeting
    "Hello"
  end
end

class Example
  include Mod
end

ex = Example.new
puts "Before change, greeting is #{ex.greeting}"

Mod.class_eval do
  def greeting
    "Hi"
  end
end

puts "After change, greeting is #{ex.greeting}"

# If a module includes other modules, a chain of proxy classes will be added
# to any class that includes that module - one proxy for every module directly
# or indirectly included.
#
# Ruby will include a module only once in an inheritance chain - including
# a module that is already included by one of your superclasses has no
# additional effect.

# +prepend+
#
# prepend is a method in Ruby 2.0 that behaves logically like include, but
# methods in the prepended module override those in the host class (rather
# than the other way around).
#
# This is implemented using a dummy class underneath the host class and inserting
# the module between the two.
#
# If a method inside a prepended module has the same name as one in the original
# class, it will be invoked instead of the original.

module VanityPuts
  def puts(*args)
    args.each do |arg|
      super("Dave says: #{arg}")
    end
  end
end

class Object
  prepend VanityPuts
end

puts "Hello and", "goodbye"

# There's a problem with the above: the change we just made to class Object
# is global.

# +extend+
#
# The include method adds a module as a superclas of self. It is used inside
# a class definition to make the instance methods in the module available to
# instances of the class.
#
# Sometimes it can be useful to add instance methods to a particular object
# rather than a class. This is where extend comes in:

module Humour
  def tickle
    "#{self} says hee, hee!"
  end
end

obj = "Grouchy"
obj.extend Humour
p obj.tickle

# Using extend, this module is implemented as a dummy eigenclass on the
# object that includes the module.
#
# You can use extend within a class definition to make the module's methods
# become class methods.
#
# This is because calling extend is the same as calling self.extend. E.g.:

module Humour
  def tickle
    "#{self} says hee, hee!"
  end
end

class Grouchy
  extend Humour
end

p Grouchy.tickle

# In class_methods_and_modules.rb we defined a method called included
# in our GeneralLogger module.
#
# When this module was included in a class, it triggered the included()
# method and allowed our module to dynamically add class method to the
# host class.
#
# +included+ is an example of a _hook method_ (AKA callback).
#
# A hook method is a method you write that is triggered by the Ruby
# interpreter when some particular event occurs.
#
# The interpreter looks for these methods by name - if you define a method
# in the appropriate place with an appropriate name, Ruby will call
# it automatically when it's corresponding event fires.
#
# Methods that can be invoked from within the interpreter are:

# Method-related hooks
#
# method_added, method_missing, method_removed, method_undefined,
# singleton_method_added, singleton_method_removed, singleton_method_undefined

# Class and module-related hooks
#
# append_features, const_missing, extend_object, extended, included,
# inherited, initialize, initialize_clone, initialize_copy, initialize_dup

# Object marshaling hooks
#
# marshal_dump, marshal_load

# Coercion hooks
#
# coerce, induced_from, to_xxx



# The inherited Hook
#
# If a class defines a method called inherited, Ruby will call it whenever
# that class is subclassed.
#
# This hook is often used in situations where a base class must keep track
# of its children.
#
# E.g. an online store might offer a variety of shipping options. Each
# would be represented by a different class, and each of these classes
# could be a subclass of a single Shipping class. This parent class
# could keep track of all the various shipping options by recording the
# every class that subclasses it.
#
# When it comes time to display the shipping options to the user, the
# application could call the base class, asking it for a list of its children.

class Shipping # Base class
  @children = []  # this variable is in the CLASS, not the instances

  def self.inherited(child)
    @children << child
  end

  def self.shipping_options(weight, international)
    @children.select {|child| child.can_ship(weight, international)}
  end
end

class MediaMail < Shipping
  def self.can_ship(weight, international)
    !international
  end
end

class FlatRatePriority < Shipping
  def self.can_ship(weight, international)
    weight < 64 && !international
  end
end

class InternationalFlatRateBox < Shipping
  def self.can_ship(weight, international)
    weight < 9*16 && international
  end
end

puts "Shipping 16oz domestic"
puts Shipping.shipping_options(16, false)

puts "\nShipping 90oz domestic"
puts Shipping.shipping_options(90, false)

puts "\nShipping 16oz international"
puts Shipping.shipping_options(16, true)

# Command interpreters often use this pattern: the base class keeps track
# of available commands, each of which is implemented in a subclass.

# The method_missing hook
#
# When Ruby is unable to find a method in a class heirarchy, Ruby tries
# to invoke the hook method +method_missing+ on the original object.
#
# Again, Ruby bubbles up through the class heirarchy looking for the method.
#
# Ruby defines its own version of method_missing in BasicObject, so typically
# the search stops there. The built in method_missing raises an exception.
#
# method_missing is simply a Ruby method so it can be overridden in our own
# classes to handle calls to undefined methods in an application-specific
# way.

def method_missing(name, *args, &block)
  #...
end

# The name argument argument receives the name of the method that couldn't
# be found. It is passed as a symbol.
#
# The args argument is an array of the arguments passed in the original
# call.
#
# The block argument will receive any block passed to the original method.

def method_missing(name, *args, &block)
  puts "Called #{name} with #{args.inspect} and #{block}"
end

wibbleblargle
wobble 1, 2
blurgle(3, 4) {stuff}

# A word on etiquette: there are two main ways that people use method_missing
# 1) Intercept every use of an undefined method and handle it.
# 2) Intercept all calls but handle only some of them (i.e. pass through
# to super)

class MyClass < OtherClass
  def method_missing(name, *args, &block)
    if <some_condition>
      # handle call
    else
      super
    end
  end
end

# If you fail to pass on calls that you don't handle, your application will
# silently ignore calls to unknown methods in your class.

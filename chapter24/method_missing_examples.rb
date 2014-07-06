# method_missing to simulate accessors
#
# OpenStruct is a class distributed with Ruby. It allows you to write objects
# with attributes that are created dynamically by assignment. e.g.

require 'ostruct'
obj = OpenStruct.new(name: 'Dave')
obj.address = "Texas"
obj.likes = "Programming"

puts "#{obj.name} lives in #{obj.address} and likes #{obj.likes}"

# We can use method_missing to write our own version of OpenStruct

class MyOpenStruct < BasicObject
  def initialize(initial_values = [])
    @values = initial_values
  end
  def _singleton_class
    class << self
      self
    end
  end
  def method_missing(name, *args, &block)
    if name[-1] == "="
      base_name = name[0..-2].intern
      _singleton_class.instance_exec(name) do |name|
        define_method(name) do
          @values[base_name] = value
        end
      end
      @values[base_name] = args[0]
    else
      _singleton_class.instance_exec(name) do |name|
        define_method(name) do
          @values[name]
        end
      end
      @values[name]
    end
  end
end

obj = MyOpenStruct.new(name: 'Sam')
obj.address = "Chile"
obj.likes = "Ruby"
puts "#{obj.name} lives in #{obj.address} and likes #{obj.likes}"

# BasicObject is the root of Ruby's object heirarchy and contains a minimal
# number of methods (like a Blank Slate)
#
# This is useful in our case because it means that our MyOpenStruct class
# can have attributes like +display+ or +class+ (which are defined as methods
# on a normal Object.
#
# A common pattern inside method_missing - the first time we reference or
# assign to an attribute of our object, we access or update the @values
# hash appropriately. But we also define the method that the caller was
# trying to access.
#
# This means that the next time the attribute is used, the method is
# already defined and will not invoke method_missing.
#
# Also notice how we had to jump through some hoops to define the method.
# We want to define the method ONLY for the current object. This means
# the method definition has to live in the object's singleton class.
#
# We can do that using instance_exec and define_method. But the class << self
# trick is required to get the object's singleton class.
#
# FYI define_method will always define an instance method, whether it is
# executed via instance_exec or class_exec.

class SamsOpenStruct < BasicObject
  def initialize(initial_values)
    @values = initial_values
  end
  def _eigenclass
    class << self
      self
    end
  end
  def method_missing(name, *args, &block)
    if name[-1] == "="
      base_name = name[0..-2].intern # MUST be a symbol
      _eigenclass.instance_exec(name) do |name|
        # tunnel through to object's eigenclass scope
        define_method(name) do |value|
          @values[base_name] = value
        end
      end
      @values[base_name] = args[0]
    else
      _eigenclass.instance_exec(name) do |name|
        # define getter on eigenclass of object
        define_method(name) do
          @values[name]
        end
      end
      @values[name]
    end
  end
end

gp = SamsOpenStruct.new(name: 'Malcolm')
gp.likes = "Archaeology"
gp.address = "Hurst Green"
puts "#{gp.name} lives in #{gp.address} and likes #{gp.likes}"

# The problem with using method_missing and BasicObject:

obj = SamsOpenStruct.new(name: 'Sam')
obj.address = 'Chile'
o1 = obj.dup
o1.name = "Mike"
o1.address = "Colorado"

# => method_missing_examples.rb:115:in `<main>': undefined method `name=' for nil:NilClass (NoMethodError)
#
# The dup method is not defined by BasicObject, so method_missing picks it
# up and returns nil (because we haven't defined a dup attribute yet).
#
# We could fix this so it at least reports an error

def method_missing(name, *args, &block)
  if name[-1] == "="
    # as before
  else
    super unless @values.has_key? name
  end
end

# The class now reports an error if we try to dup or clone it.
#
# Although BasicObject may seem like a natural fit for method_missing, it can
# be more trouble than it's worth.

## method_missing as a filter
#
# method_missing is better used to recognise certain patterns of call, passing
# on those it doesn't recognize to its parent class to handle.
#
# One example is the dynamic finder in ActiveRecord. You can find rows that
# match the criteria of having given values in certain columns.
#
# Say we have an ActiveRecord class called Book that maps to the books table
# with columns title and author, you could write:

pickaxe = Book.find_by_title("Programming Ruby")
daves_books = Book.find_all_by_author("Dave Thomas")

# ActiveRecord implements these finder methods using method_missing. It looks
# for calls to undefined methods that match the pattern /^find_(all_)?by_(.*)/
#
# If the method being invoked does not match this pattern, ActiveRecord calls
# super so that a genuine method_missing report can be generated.

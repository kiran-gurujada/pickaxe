# Knowing about objects is one part of reflection, but to get the whole
# picture, you also need to be able to look at classes the methods and
# constants they contain.
#
# Look at a class heirarchy using Class#superclass, or Module#ancestors.

def pretty_print_heirarchy(klass)
  begin
    print klass
    klass = klass.superclass
    print " < " if klass
  end while klass
end

klass = Fixnum
pretty_print_heirarchy(klass)
puts
p Fixnum.ancestors

# If you want to build a complete class heirarchy, run that code for every
# class in the system. We can use ObjectSpace to iterate over all Class
# objects:

ObjectSpace.each_object(Class) do |klass|
  pretty_print_heirarchy(klass)
  puts
end


# Peeking inside class objects
#
# We can find out more about the methods and constants in a particular object.
# We can ask for methods by access level, and we can ask for just singleton
# methods.
#
# We can also look at the object's constants, local and instance variables.

class Demo
  @@var = 99
  CONST = 1.23
private
  def private_method
  end
protected
  def protected_method
  end
public
  def public_method
    @inst = 1
    i = 1
    j = 2
    local_variables # call local_variables on self
  end
  def Demo.class_method
  end
end

Demo.private_instance_methods(false) # => [:private_method]
Demo.protected_instance_methods(false) # => [:protected_method]
Demo.public_instance_methods(false) # => [:public_method]
Demo.singleton_methods(false) # => [:class_method]
Demo.class_variables # => [:@@var]
Demo.constants(false) # => [:CONST]

demo = Demo.new
demo.instance_variables
# Get 'public_method' to return its local variables and set an instance
# variable.
demo.public_method # => [:i, :j]
demo.instance_variables # => [:@inst]


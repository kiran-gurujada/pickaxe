# The methods Object#instance_eval, Module#class_eval and Module#module_eval
# allow you to set +self+ to be some abitrary object, evaluate a block
# in that context, then reset self.

"cat".instance_eval do
  puts "Upper case = #{upcase}"
  puts "Length is #{self.length}"
end

# Both forms also take a string rather than a block but this is considered
# dangerous.
#
# First, it is slow. Calling eval effectively compiles the code in the string
# before executing it.
#
# But worse, eval can be dangerous. There can be a chance that outside data
# can wind up inside the string parameter to eval, leading to a security
# hole. We don't want to execute abitrary code from the outside.
#
# E.g.:

"cat".instance_eval 'puts "Upper=#{upcase}, length=#{self.length}"'

# class_eval and instance_eval both set up self for the duration of the
# block. However, they differ in the way they set up the environment for
# method definition.
#
# class_eval sets things up as if you were in the body of a class definition
# so method definitions will define instance methods:

class MyClass
end

MyClass.class_eval do
  def instance_method
    puts "In an instance method"
  end
end

obj = MyClass.new
obj.instance_method

# In contrast, calling instance_eval on a class acts as if you were working
# inside the eigenclass of the class. Therefore any methods you define will
# become class methods.

MyClass.instance_eval do
  def class_method
    puts "In a class method"
  end
end
MyClass.class_method

# Ironically, when defining methods, class_eval and instance_eval have
# precisely the wrong names:
#
# class_eval defines instance methods
# instance_eval defines class methods

# Ruby has variants of these methods - Object#instance_exec, Module#class_exec
# and Module#module_exec that behave identically to their _eval counterparts
# except they only take a block (not a string).
#
# Any arguments given to the methods are passed in as block parameters.
#
# This is important because previously it was impossible to pass an instance
# variable into a block given to one of the _eval methods - because self
# is changed by the call, these variables go out of scope.
#
# With the _exec form, you can now pass them in:

@animal = "cat"
"dog".instance_exec(@animal) do |other|
  puts "#{other} and #{self}"
end

# Class-level methods that generate code behind the scenes are also known
# as macros. Some examples:

#class Song
#  attr_accessor :duration
#end

# or in Rails...

#class Album < ActiveRecord::Base
#  has_many :tracks
#end

class Example
  def self.add_logging
    def log(msg)
      STDERR.puts Time.now.strftime("%H:%M:%S: " + "#{self} (#{msg})")
    end
  end

  add_logging
end

ex = Example.new
ex.log("hello")

# This is a fairly useless example, but notice a few things.
# add_logging is defined on Example's eigenclass.
# This means we can call it later using the implicit self receiver.
#
# Also notice that add_logging contains a nested method defition.
# This inner definition only gets executred when we call the add_logging
# method.
# The result is that log will be defined as an instance method of class
# Example.
#
# We can define the add_logging method in one class and then use it in a
# subclass.
#
# This works because the singleton class heirarchy parallels the regular
# class heirarchy.
#
# As a result, class methods in a parent class are also available in the child
# class, as the following example shows:

class Logger
  def self.add_logging
    def log(msg)
      STDERR.puts Time.now.strftime("%H:%M:%S: ") + "#{self} (#{msg})"
    end
  end
end

class Example2 < Logger
  add_logging
end

ex = Example2.new
ex.log("hello")

# Looking back at the previous examples, attr_accessor is an instance method
# defined in class Module and so is available to all module and class
# definitions.
#
# has_many is a class method defined in the Base class in Rails' ActiveRecord
# module and so is available to all classes that subclass ActiveRecord::Base

# This kind of metaprograming becomes useful if, for example, we want to
# construct a different version of the log method for each class that uses
# it:

class Logger2
  def self.add_logging(id_string)
    define_method(:log) do |msg|
      now = Time.now.strftime("%H:%M:%S")
      STDERR.puts "#{now}-#{id_string}: #{self} (#{msg})"
    end
  end
end

class Song < Logger2
  add_logging "Tune"
end

class Album < Logger2
  add_logging "CD"
end

song = Song.new
song.log("rock on")

# An important subtlety here is where now and id_string are declared on the
# same line, even though id_string is defiend outside of the define_method block.
#
# This works because block definitions create closures, allowing the context
# in which the block is defined to be carried forward and used when the block
# is used.
#
# i.e. a wormhole through to the block's binding
#
# In this case we are taking a class-level method and using it in a dynamically
# defined instance method. This is a common pattern when creating these
# kinds of class-level macros.

# We can also use parameters in the class-level method to determine the
# name of the method(s) to create. e.g. this modification of attr_accessor

class AttrLogger
  def self.attr_logger(name)
    attr_reader name
    define_method("#{name}=") do |val|
      puts "Assigning #{val.inspect} to #{name}"
      instance_variable_set("@#{name}", val)
    end
  end
end

class Example3 < AttrLogger
  attr_logger :value
end

ex = Example3.new
ex.value = 123
puts "Value is #{ex.value}"
ex.value = "cat"
puts "Value is now #{ex.value}"

# You can define class methods in one class and then use them in sub-classes
# of that class.
#
# But it is often inappropriate to use subclassing, either because we
# already have to subclass some other class or because it makes no sense
# to do Song < Logger.
#
# In this case you can use a module to hold your metaprogramming implementation.
#
# As we've seen, using +extend+ inside a class definition will add the
# methods in a module as class methods to the class being defined, e.g.:

module AttrLogger
  def attr_logger(name)
    attr_reader name
    define_method("#{name}=") do |val|
      puts "Assigning #{val.inspect} to #{name}"
      instance_variable_set("@#{name}", val)
    end
  end
end

class Example
  extend AttrLogger
  attr_logger :value
end

ex = Example.new
ex.value = 123
puts "Value is #{ex.value}"
ex.value = "cat"
puts "Value is now #{ex.value}"

# It gets a little trickier when adding both class methods and instance
# methods into the class being defined.
#
# One technique used extensively in Rails uses a Ruby hook method +included+.
# included is called automatically by Ruby when you include a module into a
# class. It is passed the class object of the class being defined.

module GeneralLogger
  # Instance method to be added to any class that includes this
  def log(msg)
    puts Time.now.strftime("%H:%M:%S: ") + msg
  end

  # module containing class methods to be added.
  module ClassMethods
    def attr_logger(name)
      attr_reader name
      define_method("#{name}=") do |val|
        log "Assigning #{val.inspect} to #{name}"
        instance_variable_set("@#{name}", val)
      end
    end
  end

  # extend host class with class methods upon inclusion of this module
  def self.included(host_class)
    host_class.extend(ClassMethods)
  end
end

class Example2
  include GeneralLogger

  attr_logger :value
end

ex = Example2.new
ex.log("New example created")
ex.value = 123
puts "Value is #{ex.value}"
ex.value = "cat"
puts "Value is now #{ex.value}"

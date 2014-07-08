# A _hook_ is a technique that lets you trap some Ruby event, like object
# creation.
#
# Here are some common Ruby hooking techniques:
#
# Hooking method calls
#
# The simplest hook technique in Ruby is to intercept calls to methods in
# system classes e.g. to log all operating system commands your program
# might execute.
#
# Simply rename the method Kernel.system and substitute one of your own
# that both logs the command and calls the original Kernel method.

class AliasLogObject < Object
  alias_method :old_system, :system
  def system(*args)
    old_system(*args).tap do |result|
      puts "system(#{args.join(', ')}) returned #{result.inspect}"
    end
  end
end

AliasLogObject.new.instance_eval do
  system("date")
  system("kangaroo", "-hop 10", "skippy")
end

puts

# Produces:
#
# Mon  7 Jul 2014 12:27:30 BST
# system(date) returned true
# system(kangaroo, -hop 10, skippy) returned nil

# The problem with this technique is relying on a method called :old_system
# not being previously defined.
#
# We can get around this by using method objects, which are effectively
# anonymous

class AnonMethodObject < Object
  old_system_method = instance_method(:system)
  define_method(:system) do |*args|
    old_system_method.bind(self).call(*args).tap do |result|
      puts "system(#{args.join(', ')}) returned #{result.inspect}"
    end
  end
end

AnonMethodObject.new.instance_eval do
  system("date")
  system("kangaroo", "-hop 10", "skippy")
end

puts

# Ruby 2.0 offers a new way of doing this. Modules can be used to include
# new instance methods in some other module or class.
#
# Until now these methods did not override existing class or module methods,
# but using the +prepend+ keyword we can flip the priorities around.
#
# Within the module's methods, calling +super+ calls the hosts method of
# the same name. So we get:

module SystemHook
  private
  def system(*args)
    super.tap do |result|
      puts "system(#{args.join(', ')}) returned #{result.inspect}"
    end
  end
end

class PrependModuleObject < Object
  prepend SystemHook
end

PrependModuleObject.new.instance_eval do
  system("date")
  system("kangaroo", "-hop 10", "skippy")
end

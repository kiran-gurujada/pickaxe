# Ruby lets you get involved when objects are created. This allows you
# to wrap them, add or remove methods or add them to containers to implement
# persistence.
#
# HINT: Hijacking Ruby objects at creation time
#
# In this example we add a +timestamp+ attribute to every object in the system.

class Object
  attr_accessor :timestamp
end

# Now we hook object creation to add this timestamp. One way to do this is
# to rename Class#new. This will work for most objects (except some such as literal
# strings which are constructed without a call to new)

module HijackNew
  def new(*args, &block)
    super(*args, &block).tap do |obj|
      obj.timestamp = Time.now
    end
  end
end

class Class
  prepend HijackNew
end

# Now we can run a test. We'll create a couple of objects a few milliseconds
# apart and check their timestamps.

class Test
end

obj1 = Test.new
sleep(0.002)
obj2 = Test.new
p obj1.timestamp.to_f # => 1404735861.761322
p obj2.timestamp.to_f # => 1404735861.763534

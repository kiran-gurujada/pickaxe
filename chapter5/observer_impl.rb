# Any module you mix into a class may create instance variables in the client object
# They can also use attr_reader and friends to define accessors for these instance variables
# E.g. the Observable module here adds an instance variable @observer_list to any class
# that includes it

module Observable
  def observers
    @observer_list ||= []
  end

  def add_observer(obj)
    observers << obj
  end

  def notify_observers
    obervers.each {|o| o.update}
  end
end

# However this is risky.
# A mixin's isntance variables can clash with those of the host class or with those of other
# mixins.
#
# The example that follows shows a class that uses our Observer module but that unluckily also
# uses an instance variable called @observer_list.
# At runtime, this program will go wrong in some hard-to-diagnose ways

# BUGGY!
class TelescopeScheduler

  # other classes can register to get notifications
  # when the schedule changes
  include Observable

  def initialize
    @observer_list = [] #folks with telescope time
  end

  def add_viewer(viewer)
    @observer_list << viewer
  end
  # . . .
end

# For this reason, most mixin modules don't use instance variables directly - they use accessors
# instead.
# If you must use instance variables in a module, name it in a unique way e.g.
# - use module name as part of the variable name, or
# - use a module-level hash indexed by current object id to store instance-specific data

module Test
  State = {}
  def state=(value)
    State[object_id] = value
  end

  def state
    State[object_id]
  end
end

class Client
  include Test
end

c1 = Client.new
c2 = Client.new
c1.state = 'cat'
c2.state = 'dog'
p c1.state # => 'cat'
p c2.state # => 'dog'

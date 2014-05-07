# modules are useful for two reasons
# 1) they provide a namespace and prevent name clashes
# 2) they support the mixin facility
#
# For example, we have two methods called sin, that work with totally different concepts
# one is in module Trig and the other in module Moral

module Trig
  PI = 3.141592654
  def Trig.sin(x)
    # . . .
  end

  def Trig.cos(x)
    # . . .
  end
end

module Moral
  VERY_BAD = 0
  BAD = 1
  def Moral.sin(badness)
    # . . .
  end
end

# module constants are named just like class constants, with an initial uppercase letter
# (by convention we use ALL UPPERCASE to describe them)
# module methods are defined exactly like class methods

# to reference the name sin unambiguously, we can qualify the name using the name of the module
# as a namespace for that method

y = Trig.sin(Trig::PI/4)
wrongdoing = Moral.sin(Moral::VERY_BAD)

# modules can be used to eliminate the need for inheritance, providing a facility called a
# mixin
# instance methods in a module become available as instance methods on a class when the module
# is mixed in.
# they essentially behave as a superclass

module Debug
  def who_am_i?
    "#{self.class.name} (id: #{self.object_id}): #{self.name}"
  end
end

class Phonograph
  include Debug
  attr_reader :name
  def initialize(name)
    @name = name
  end
  # . . .
end

class EightTrack
  include Debug
  attr_reader :name
  def initialize(name)
    @name = name
  end
  # . . .
end

ph = Phonograph.new("West End Blues")
et = EightTrack.new("Surrealistic Pillow")

p ph.who_am_i? # => "Phonograph (id: 2156932020): West End Blues"
p et.who_am_i? # => "EightTrack (id: 2156931980): Surrealistic Pillow"

# the include keyword does not copy the instance methods - it instead adds a reference
# to the included module from the class.
# So if the module is changed, all classes instantly inherit the changed behaviour

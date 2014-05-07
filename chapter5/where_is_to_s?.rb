# Why is to_s available everywhere?
#
# Because to_s is defined in class Object (Object.instance_methods.grep(/to_s/) # => [:to_s] )
# so every class that inherits from Object (i.e. everything except BasicObject) inherits this
# instance method for free.

class Person
  def initialize(name)
    @name
  end
end

p = Person.new("Michael")
puts p

# but we can also override the to_s method for this class
class Person
  def initialize(name)
    @name = name
  end

  def to_s
    "Person named #{@name}"
  end
end

p = Person.new("Michael")
puts p

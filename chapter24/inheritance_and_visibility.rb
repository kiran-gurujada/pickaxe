# There's a gotcha when it comes to method definition and class
# inheritance.
#
# Within a class definition, you can change the visibility of a method
# in an ancestor class. For example, you can do something like this:

class Base
  def a_method
    puts "Got here!"
  end
  private :a_method
end

class Derived1 < Base
  public :a_method
end

class Derived2 < Base
end

# In this example, you can invoke a_method in instances of class Derived1
# but not in class Derived2.
#
# This is the least astonishing behaviour.
#
# Ruby manages this by including a hidden proxy method in the subclass
# that invokes the original method using super. So the following code:

class Derived1 < Base
  public :a_method
end

# Is the effectively effectively equivalent to this:

class Derived1 < Base
  def a_method(*)
    super
  end
  public :a_method
end

# The call to super can access the parent's method regardless of its
# visibility.
#
# Thus, a derivative class can make previously private methods public (or
# vice versa).

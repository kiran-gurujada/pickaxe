# Apparently instance_eval is useful for writing certain DSLs.
#
# In this example we are writing a simple DSL for turtle graphics.
# Let's draw a set of three 5x5 squares:

3.times do
  forward(8)
  pen_down
  4.times do
    forward(4)
    left
  end
  pen_up
end

# We could implement forward, pen_down, left and pen_up as Ruby methods,
# but to call them with no receiver like this, either we have to be within
# a class that defines them (or a child of such a class) or we have to make
# the methods global.
#
# instance_eval to the rescue!!! (flies in with flapping cape)
#
# We can define a class Turtle that defines the various methods we need
# as instance methods. We'll also define a walk method, which will execute
# out turtle DSL, and a draw method to draw the resulting picture:

Class Turtle
  def left; end
  def right; end
  def forward(n); end
  def pen_up; end
  def pen_down; end
  def walk(...); end
  def draw; end
end

# If we implement walk correctly, then we can write this:

turtle = Turtle.new
turtle.walk do
  3.times do
    forward(8)
    pen_down
    4.times do
      forward(4)
      left
    end
    pen_up
  end
end

turtle.draw

# So what is the correct implementation of walk?
#
# We must use instance_eval because the DSL commands in the block have to
# call the methods in the turtle object.
#
# We also have to arrange to pass the block given to the walk method to be
# evaluated by that instance_eval call.
#
# Our implementation looks like this:

def walk(&block)
  instance_eval(&block)
end

# We used the block passed to the walk method as a wormhole to the binding
# inside class Turtle.
#
# This method avoids having to make the receiver explicit - without it
# we would need to write something like:

turtle.walk do
  turtle.forward(4)
  turtle.left
end

# The drawback is that inside the block, you are wormholed into the Turtle
# class's scope. So the following would NOT work:

@size = 4
turtle.walk do
  4.times do
    turtle.forward(@size)
    turtle.left
  end
end

# Instance variables are locked up inside self, and the self in the block
# is set to Turtle, not to the surrounding scope.
#
# Due to this problem, the instance_eval'd block of this type is becoming less
# popular.

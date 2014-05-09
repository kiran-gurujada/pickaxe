# an assignment statement sets the variable on the left side (lvalue)
# to refer to the value on the right side (rvalue)
# It then returns that rvalue as the result of the assignment expression
# This means you can chain assignments in abitrary combinations

a = b = 1 + 2 + 3
p a # => 6
p b # => 6

a = (b = 1 + 2) + 3
p a # => 6
p b # => 3

# File.open(name = gets.chomp)

# Ruby has two basic forms of assignment
# 1) assign object reference to a variable or constant
# ## instrument = "piano"
# ## MIDDLE_A = 440
#
# 2) have an attribute or element reference on the left side.
# This form is special because it is implemented by calling a method
# on the lvalue (so you can override them)

class ProjectList
  def initialize
    @projects = []
  end

  def projects=(list)
    @projects = list.map(&:upcase) # store list of names in uppercase
  end

  def [](offset)
    @projects[offset]
  end
end

list = ProjectList.new
list.projects = %w{ strip sand prime sand paint sand paint rub paint }
p list[3] # => "SAND"
p list[4] # => "PAINT"

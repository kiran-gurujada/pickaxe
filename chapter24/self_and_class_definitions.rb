# Code executed within the context of a class definition has self set
# to that of the enclosing class:

class Test
  puts "In the definition of class Test"
  puts "self = #{self}"
  puts "Class of self = #{self.class}"
end

# Produces:
#
# In the definition of class Test
# self = Test
# Class of self = Class

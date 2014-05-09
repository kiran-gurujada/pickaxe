# Ruby objects support comparison using the methods
# ==, ===, <=>, =~, eql? and equal?
#
# All but <=> are defined in class Object but may be overridden by
# descendants. E.g. Array redefines == so that arrays are equal if
# number and corresponding elements are the same.

# ==
# Test for equal value

# ===
# ?

# <=>
# Compares two objects. Returns -1, 0 or 1 depending on whether receiver
# is less than, equal to or greater than argument respectively.

# <, <=, >, >=
# Comparison operators.

# =~
# Regexp match pattern

# eql?
# True if receiver has same type and value as argument
# HINT: exactly the same as?

1.0.eql?(1.0) # => true
1.eql?(1.0) # => false

#equal?
# True if receiver and argument have the same object id
# HINT: is the same object as?

# Ruby looks for a negative operator for != and !~
# If it does not find one, it negates the result of == or =~

class T
  def ==(other)
    puts "Comparing self == #{other}"
    other == "value"
  end
end

t = T.new
p(t == "value")
p(t != "value") # Ruby calls the == method, then inverts the answer


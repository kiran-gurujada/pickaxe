# in Ruby, many operators are implemented as method calls

a, b, c = 1, 2, 3
a * b + c == (a.*(b)).+(c) # => true

# this lets you do crazy things like redefining basic arithmetic if
# it tickles your fancy

class Fixnum
  alias old_plus +

  def +(other) # redefine addition of Fixnums. DON'T DO THIS!!!
    old_plus(other).succ
  end
end

p 1 + 2 # => 4
p a = 3
p a += 4 # => 8
p a + a + a # => 26

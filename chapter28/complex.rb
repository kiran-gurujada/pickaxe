# Patches Math library to be applied to complex numbers.

point = Complex(2, 3)
Math::sin(point)

# => Produces error

require 'complex'
point = Complex(2, 3)
Math::sin(point) # => (9.15449914691143-4.168906959966565i)

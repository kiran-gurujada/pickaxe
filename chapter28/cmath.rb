# Complex numbers are built into Ruby >1.9. Cmath offers math functions
# such as tan, sin, log10 etc that work with complex numbers.

require 'cmath'
point = Complex(2, 3)
CMath::sin(point) # => 9.15449914691143-4.168906959966565i)

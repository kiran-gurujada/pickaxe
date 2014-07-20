# Ruby's standard Bignum class supports large integers.
#
# The BigDecimal class supports decimal numbers with a lot of digits after
# the decimal point.
#
# - Calculate the area of a circle using BigDecimals

require 'bigdecimal'
require 'bigdecimal/math'
include BigMath

pi = BigMath::PI(20) # 20 is the number of decimal digits
radius = BigDecimal("2.14156987652974674392")
area = pi * radius ** 2
puts area.to_s

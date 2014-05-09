# blocks such as loop and each have specific scoping rules
# Normally, locals created in the block are not accessable outside the
# block.

[1, 2, 3].each do |x|
  y = x + 1
end
[x, y]

# => NameError (undefined local variable or method 'x')

# However, if a local already exists with the same name, the existing
# variable will be passed into the block

x = "initial value"
y = "another value"

[1, 2, 3].each do |x|
  y = x + 1
end
[x, y] # => ["initial value", 4]

# the variable never actually has to be used - just displayed outside
# of the block to the Ruby interpreter

a = "never used" if false
[99].each do |i|
  a = i
end
a # => 99

# you can list block-local variables in the block's parameter list,
# preceded by a semi-colon

# NO block-locals:

square = "yes"
total = 0

[1, 2, 3].each do |val|
  square = val * val
  total += square
end

puts "Total = #{total}, square = #{square}"

# Produces:
# Total = 14, square = 9

# USES block-local variable to shadow variable in outer scope

square = "yes"
total = 0

[1, 2, 3].each do |val; square|
  square = val * val # block-local square shadows outer-scope square
  total += square
end

puts "Total = #{total}, square = #{square}"

# Produces:
# Total = 14, square = yes

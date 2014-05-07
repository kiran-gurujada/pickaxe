# Blocks written using the old syntax take parameter lists between vertical bars.
#
# Blocks written using the -> syntax take a separate parameter list before the block body.
#
# In both cases, the parameter list looks like the list you might give to a method. It can
# take default values, splat args (*args), keyword args and a block parameter (&last_arg).

proc1 = lambda do |a, *b, &block|
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc1.call(1, 2, 3, 4) { puts "in block1" }

# and here's one that uses the new -> notation

proc2 = -> a, *b, &block do
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc2.call(1, 2, 3, 4) { puts "in block2" }

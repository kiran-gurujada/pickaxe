# The optional block argument must be last in the list.
#
# When a method is called, Ruby checks for an associated block, and
# if present, converts it into an object of class Proc and assigns
# it to the block argument.
#
# If no block is supplied, the block argument is set to nil.

def example(&block)
  puts block.inspect
end

p example # => nil
p example { "a block" } # => #<Proc:0x0000010123f850@block_arguments.rb:14>

# A block is a closure - it remembers the context in which it
# was defined and uses that context wherever it is called. The
# context includes the value of self, constants, class variables,
# local variables and any captured block.
#
# e.g.

class BlockExample
  CONST = 0
  @@a = 3
  def return_closure
    a = 1
    @a = 2
    lambda { [ CONST, a, @a, @@a, yield ] }
  end
  def change_values
    @a += 1
    @@a += 1
  end
end

eg = BlockExample.new
block = eg.return_closure { "original" }

block.call # => [0, 1, 2, 3, "original"]
block.freeze # doesn't prevent block from returning different values as these are dynamically dependent on it's binding
eg.change_values
block.call # => [0, 1, 3, 4, "original"]

# The return_closure method returns a lambda that encapsulates a access to variables
# in the defining scope (block carries the binding with it).
#
# Even though the block is called outside of the scope of these variables,
# they are still available through the closure.
#
# HINT: Closures are like wormholes to other bindings within the code.

# Within raw procs and lambdas, executing +next+ causes the block to exit
# back to the caller of the block. The return value is the value(s) passed
# to +next+, or nil if no values are passed.
# HINT: +next+ is like a return for procs and lambdas

def ten_times
  10.times do |i|
    if yield(i)
      puts "Caller likes #{i}"
    end
  end
end

ten_times do |number|
  next(true) if number == 7
end

# Caller likes 7
# => 10

# Within a raw proc, +break+ terminates the method that invoked the block. The
# return value is any parameters passed to the break

# Return and Blocks
# A +return+ from inside a _raw_ block that's still in scope acts as a return from that scope.
# A +return+ from a block whose original context is no longer in scope raises an exception.
# HINT: _raw_ blocks return from the scope in which they are defined
# (non-intuitive behaviour)
# e.g.

def meth1
  (1..10).each do |val|
    return val
  end
end

meth1 # => 1

def meth2(&b)
  b
end

res = meth2 {return}
res.call # => LocalJumpError

# A lambda behaves more like a method. A +return+ returns from the block to the caller
# of the block.
# HINT: Lambdas are like better behaved blocks.

def meth3
  p = lambda { return 99 }
  res = p.call
  "The block returned #{res}"
end

meth3 # => "The block returned 99"


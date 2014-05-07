# -> was chosen due to limitations in Ruby's available character set.
# HINT: chosen because  ->  supposedly looks like a λ
# (but actually doesn't look anything like it at all)

proc1 = ->arg { puts "In proc1 with #{arg}" }
proc2 = ->arg1, arg2 { puts "In proc2 with #{arg1} and #{arg2}" }
proc3 = ->(arg1, arg2) { puts "In proc3 with #{arg1} and #{arg2}" }

proc1.call "ant"
proc2.call "bee", "cat"
proc3.call "dog", "elk"

# the -> form is more compact than using lambda and helps when you want to pass
# one or more Proc objects to a method

def my_if(condition, then_clause, else_clause)
  if condition
    then_clause.call
  else
    else_clause.call
  end
end

5.times do |val|
  my_if val < 2,
    -> { puts "#{val} is small" },
    -> { puts "#{val} is big" }
end

# one good reason to pass blocks as methods is that you can reevaluate the code in
# those blocks at any time.
# Let's reimplement a while loop using a method
# - because the condition is passed as a block, we can evaluate it each time around the loop

def my_while(cond, &body)
  while cond.call
    body.call
  end
end

a = 0

my_while ->{ a < 3 } do
  puts a
  a += 1
end

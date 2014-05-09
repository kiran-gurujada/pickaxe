# most Ruby looping is implemented using iterators

3.times do
  print "ho! "
end

# => "ho! ho! ho!"

# ranges and steps can also be used

0.upto(9) do |x|
  print x, " "
end

# 0 1 2 3 4 5 6 7 8 9

0.step(12, 3) {|x| print x, " "}

# 0 3 6 9 12

# similarly, you can iterate over arrays and other containers

[1, 1, 2, 3, 5].each {|val| print val, " "}

# 1 1 2 3 5

# once a class supports each, additional methods from enumerable become
# available

File.open("ordinal").grep(/d$/) do |line|
  puts line # only iterate over lines that end with a d
end

# Produces:
# second
# third

# Ruby also has a basic iterator called loop. This is hardly ever used.

loop do
  # execute block forever until we break out
end

###
# break, redo and next let you alter the normal flow through a loop or
# iterator

# break terminates the immediately enclosing loop, control resumes at the
# next statement after the block.
#
# redo repeats the current iteration of the loop from the start but without
# re-evaluating the condition or fetching the next iterator element
#
# next skips to the end of the loop, effectively jumping to the next
# iteration

while line = gets
  next if line =~ /^\s*#/ # skip comments
  break if line =~ /^END/ # break out of loop when we reach end of file

  # substitute stuff in backticks and try again
  redo if line.gsub!(/`(.*?)`/) {eval($1) }

  # process line...
end

# break and next may be passed a value

result = while line = gets
           break(line) if line =~ /answer/
         end
process_answer(result) if result

# while, until and for loops are built into the language and do not introduce
# new scope.
# Previously existing local variables can be referenced and modified in the
# loop

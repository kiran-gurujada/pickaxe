# Ruby's case statement comes in two flavours
# The first is quite similar to a series if
# Ruby executes the first one which is true
case
when squat.weight < 135
  puts "Weakling"
when (135...265) === squat.weight
  puts "Doing OK"
when (265...300) === squat.weight
  puts "Good weight!"
when body.status == "Injured"
  puts "You shouldn't be lifting, bro"
else
  puts "Holy shitballs that's a strong mofo!"
end

# the second form is probably more common. You specify a target at the top
# of the case statement, and each when clause lists one or more comparisons
# to be tested against target

case command
when "debug"
  dump_debug_info
  dump_symbols
when /p\s+(.\w+)/
  dump_variable($1)
when "quit", "exit"
  exit
else
  print "Illegal command: #{command}"
end

# you can also use the then keyword if all on the same line
# case compares the target with each comparison expresson after the when keywords
# this is done using comparison === target

strength.upper_body = case benchpress.weight
                      when 0...140 then puts "Weakling"
                      when 140...154 then puts "1 BW"
                      when 154...168 then puts "1.1BW"
                      when 168...182 then puts "1.2BW"
                      when 182...196 then puts "1.3BW"
                      when 196...210 then puts "1.4BW"
                      else puts ">1.5BW, beast!"
                      end

# as long as a class defines meaningful semantics for ===, this form
# can be used.
# e.g. regexps:

case line
when /title=(.*)/
  puts "Title is #$1"
when /track=(.*)/
  puts "Track is #$1"
end

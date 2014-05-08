# Example: we are teaching maths skills.
# Student can ask for a n-plus or n-times table.

print "(t)imes or (p)lus: "
operator = gets
print "number: "
number = Integer(gets)

if operator =~ /^t/
  puts((1..10).collect {|n| n*number }.join(", "))
else
  puts((1..10).collect {|n| n+number }.join(", "))
end

# this has duplicated code. can we factor out the block that does the
# calculation?

puts "VERSION 2..."
print "(t)imes or (p)lus: "
operator = gets
print "number: "
number = Integer(gets)

if operator =~ /^t/
  calc = lambda {|n| n*number}
else
  calc = lambda {|n| n+number}
end

puts((1..10).collect(&calc).join(", ")) # Ruby assumes the &parameter is a proc and auto-converts to a block

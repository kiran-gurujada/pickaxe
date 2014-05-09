# Ruby has some (primitive) support for looping

while line = gets
  # read lines until input is exhausted (gets returns false/nil)
end

# the until loop does the opposite

until bodyfat < 0.06
  keep_focus_on(lifting, diet)
end

# can be tacked on to the end of a statement just like if

a = 1
a *= 2 while a < 100
p a # => 128
a -= 10 until a < 100
p a # => 98

# a range can be used as a kind of flipflop, turning on at the low end
# and off at the high end

file = File.open("ordinal")
while line = file.gets
  puts(line) if line =~ /third/ .. line =~ /fifth/
end

# =>
# third
# fourth
# fifth

# watch out for fencepost problems when using while and until as statement
# modifiers in a begin...end block

print "Hello\n" while false
begin
  print "Goodbye\n"
end while false

# => Goodbye

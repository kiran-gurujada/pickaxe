# Variable/Method ambiguity
#
# When ruby sees a name such as +a+ in an expression, it must determine
# whether it is a local variable reference or a call to a method with
# no parameters.
#
# Ruby tracks symbols assigned to it as it parses a source file. It
# assumes these symbols are variables.
# If it subsequently encounters this name, it checks to see if a prior
# assignment to that symbol has been seen. If so, it treats it as a
# variables, otherwise a method.
#
# Contrived example:

def a
  puts "Function 'a' called"
  99
end

for i in 1..2
  if i == 2
    puts "i==2, a=#{a}"
  else
    a = 1
    puts "i==1, a=#{a}"
  end
end

# Note that assignment does not have to be executed - Ruby just
# has to have seen it. The following code does not raise an error:

b = 1 if false; p b  # => nil

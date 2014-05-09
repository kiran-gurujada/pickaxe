# enclosing a string in backticks or using %x{} will exectute as a command
# on that system.
# HINT: %x stands for eXecute
# The value of the expression is the STDOUT of that command

p `date`
p `ls`.split[1]
p %x{echo "hello there"}

# expression expansion and usual escape sequences apply

(0..3).each do |i|
  listing = `ls #{'../' * i}`
  puts listing
  #...
end

# exit status is available in global variable $?

puts
p "Exit status: #{$?}"

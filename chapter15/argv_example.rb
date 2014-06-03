puts "Program name stored in $0 (aliased to $PROGRAM_NAME): " + $0.to_s

print "Arguments provided were: "

puts ARGV.join(', ')

puts "ARGV length is: " + ARGV.length.to_s

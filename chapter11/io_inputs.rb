# use IO#gets to read lines

puts "Echo contents of a file..."

File.open("testfile") do |file|
  while line = file.gets
    puts line
  end
end

# use IO#each_byte to read byte-by-byte from the IO object
# the Integer#chr method converts an integer to the corresponding ASCII character

puts
puts "And in bytes..."

File.open("testfile") do |file|
  file.each_byte.with_index do |ch, index|
    print "#{ch.chr}:#{ch} "
    break if index > 10
  end
end
puts

# IO#each_line calls the block with each line from the file

puts
puts "And for each line..."

File.open("testfile") do |file|
  file.each_line {|line| puts "Got #{line.dump}"}
end

# each_line can use any abitrary sequence of characters as a line separator

puts
puts "Using 'e' as a line separator..."

File.open("testfile") do |file|
  file.each_line("e") {|line| puts "Got #{line.dump}"}
end

# Combine the idea of an iterator with the autoclosing block feature an you get
# IO.foreach
#
# This method:
#   1) takes the name of an IO source
#   2) opens it for reaching
#   3) calls the iterator once for every line in the file
#   4) closes the file automatically

puts
puts "Using IO.foreach..."

IO.foreach("testfile") {|line| puts line }

# Or you can read an entire file into a string, or an array of lines

# read into string
str = IO.read("testfile")
str.length  # => 66
str[0..10]  # => "This is lin"

# or, read into array
arr = IO.readlines("testfile")
arr.length
arr[0]  # => "This is line one\n"

# if you want to read/write raw binary data, you have three options:

# 1) use a literal
str = "\001\002\003" # => "\u0001\u0002\u0003"

# 2) poke it in byte-by-byte
str2 = ""
str2 << 1 << 2 << 3 # => "\u0001\u0002\u0003"

# 3) use Array#pack
[1, 2, 3].pack("c*") # => "\x01\x02\x03"

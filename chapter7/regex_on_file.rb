# the following code prints lines in testfile that have the string  on  in them

puts "matching /on/..."

File.foreach("testfile").with_index do |line, index|
  puts "#{index}: #{line}" if line =~ /on/
end

# you can test whether a pattern does NOT match a string using !~

puts
puts "NOT matching /y/..."

File.foreach("testfile").with_index do |line, index|
  puts "#{index}: #{line}" if line !~ /y/
end

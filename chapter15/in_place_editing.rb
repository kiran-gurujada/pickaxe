if ARGV.length == 0
  puts "Invoke me with:\n$ruby -i.bak in_place_editing.rb testfile otherfile"
end

while line = gets
  puts line.chomp.reverse
end

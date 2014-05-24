words = File.read("/usr/share/dict/words")
count = words.scan(/^............\n/).size

puts "#{count} twelve character words"

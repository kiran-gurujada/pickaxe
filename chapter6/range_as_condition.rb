# Ranges can also be used as conditional expressions
# They act as a kind of toggle switch - turn on when the condition in the first part becomes true,
# turn off when the condition in the second part comes true.
while line = gets
  puts line if line =~ /start/ .. line =~ /end/
end

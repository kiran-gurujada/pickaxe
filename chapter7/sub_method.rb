# the sub method takes a pattern and some replacement text
# if it finds a match for teh apttern in the string, its replaces the matched substring
# with the specified replacement text

str = "Dog and Cat"
new_str = str.sub(/Cat/, "Gerbil")
puts "Lets go to the #{new_str} for a pint."

# the sub method changes only the first match it finds.
# To replace all matches, use gsub (g is for global) - just like in Vim

str = "Dog and Cat"
new_str1 = str.sub(/a/, "*")
new_str2 = str.gsub(/a/, "*")
puts "Using sub: #{new_str1}"
puts "Using gsub: #{new_str2}"

# if you want to modify the string in place, use the destructive forms
# sub! and gsub!

str = "now is the time right now"
str.sub!(/now/, Time.new.strftime("%H:%M"))
str.gsub!(/t/, "T")
puts str

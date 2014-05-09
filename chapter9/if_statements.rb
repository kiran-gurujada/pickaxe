# if statements have optional then keywords

if language == "Python" then
  opinion = "OK"
elsif language == "Visual Basic" then
  opinion = "sucks balls"
else
  opinion = "I'll have to try it out first"
end

# for multiple line ifs, 'then' can be neglected

if language == "Java"
  opinion = "Nothing good was ever designed by committee"
elsif language == "C"
  opinion = "Hard"
else
  opinion = "What language?"
end

# however, if you want to lay out code more tightly, you can separate the
# boolean expression from the statements with 'then'

if language == "Lisp" then opinion = "Intimidating but intriguing"
elsif language == "C++" then opinion = "Get the hell away from me"
else opinion = "Unknown"
end

# you can even use the return value from the if statement

opinion = if language == "English"
            "I'm a wizard with words mofo"
          elsif language == "Spanish"
            "I speak it fluently"
          else
            "Don't speak it, bro"
          end

# Ruby also has a negated form of the if statement

unless language == "Ruby"
  "Wrong language, use Ruby instead"
end

# Ruby also supports the compact conditional form

opinion = language == "Ruby" ? "Awesome" : "Not so awesome"

# if modifiers can also be tacked on to the end of a statement

month, day, year = $1, $2, $3 if date =~ /(\d\d)-(\d\d)-(\d\d)/
puts "a = #{a}" if $DEBUG
print total unless total.zero?

# you can do the same with unless, to have the opposite effect

File.foreach("/etc/passwd") do |line|
  next if line =~ /^#/  # skip comments
  parse(line) unless line =~ /^$/  # don't parse empty lines
end

# raise and rescue works great for abandoning execution when things go wrong
# Sometimes though, we might want to jump out of some deeply nested construct
# during normal processing.
#
# We use throw and catch for this
# HINT: it's like throwing and then catching a ball (duh)

# read word list to array, print in reverse order when done
# if any of the lines in the file is not a valid word, abandon the whole process
file_name = ARGV[0]

word_list = File.open(file_name)
word_in_error = catch(:done) do # define block (:done). block is executed until a corresponding throw is encountered, in which case the entire block is termianted
  result = []
  while line = word_list.gets
    word = line.chomp
    throw(:done, word) unless word =~ /^\w+$/  # uh oh, we encountered a throw. Ruby, climb the call stack and look for a catch with a matching symbol immediately!
    result << word
  end
  puts result.reverse
end
if word_in_error
  puts "Failed: '#{word_in_error}' found, but a word was expected"
end

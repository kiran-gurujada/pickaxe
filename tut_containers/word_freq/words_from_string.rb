# write program to calculate the number of times a word appears in
# a sentence
# For example, in this sentence, the word 'the' occurs two times.
#
# 1) Given some text as a string, return a list of words
# 2) Build a count for each distinct word

# sam's implementation:
def words_from_string(string)
  string.downcase.scan(/[\w']+/)
end

# takes an array of words and returns a has of words and
# their frequencies
def word_frequency(words)
  frequencies = Hash.new(0)
  words.each do |word|
    frequencies[word] += 1
  end
  frequencies
end

raw_text = %{The problem breaks down into two parts. First, given some text as a string, return a list of words. That sounds like an array. Then, build a count for each distinct word. That sounds like a use for a hash---we can index it with the word and use the corresponding entry to keep a count.}

words_list = words_from_string(raw_text)
counts = word_frequency(words_list)
sorted = counts.sort_by {|word, count| count}.reverse
top_five = sorted.first(5)

puts top_five.map {|word, count| "#{word}: #{count}"}

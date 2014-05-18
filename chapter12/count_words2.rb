# analyse a text file, counting occurences of each word
# split into two parts, a method that reads the file and yields
# successive words, and a block that does the counting

def yield_words(file_name)
  File.foreach(file_name) do |line|
    line.scan(/\w+/) do |word|
      yield(word)
    end
  end
end

counts = Hash.new(0)

yield_words("testfile") {|word| counts[word] += 1}

counts.keys.sort.each {|k| print "#{k}:#{counts[k]} "}



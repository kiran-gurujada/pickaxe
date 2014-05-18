# analyse a text file, counting the occurences of each word,
# then print frequency sorted alphabetically by key

counts = Hash.new(0)

File.foreach("testfile") do |line|
  line.scan(/\w+/) do |word|
    word = word.downcase
    counts[word] += 1
  end
end

counts.keys.sort.each {|k| print "#{k}:#{counts[k]} "}

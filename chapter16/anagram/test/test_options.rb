require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/anagram/options'

class TestOptions < Minitest::Spec
  describe Anagram::Options do
    it "should return default when specifying no dictionary" do
      opts = Anagram::Options.new(["someword"])
      Anagram::Options::DEFAULT_DICTIONARY.must_equal opts.dictionary
    end

    it "should return the dictionary when specifying a dictionary" do
      opts = Anagram::Options.new(["-d", "mydict", "someword"])
      "mydict".must_equal opts.dictionary
    end

    it " should return the words when specifying words and no dictionary" do
      opts = Anagram::Options.new(["word1", "word2"])
      ["word1", "word2"].must_equal opts.words_to_find
    end

    it "should return the words when specifying words and a dictionary" do
      opts = Anagram::Options.new(["-d", "mydict", "word1", "word2"])
      ["word1", "word2"].must_equal opts.words_to_find
    end
  end
end

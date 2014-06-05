require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/anagram/finder'

class TestFinder < MiniTest::Spec
  describe Anagram::Finder do
    describe "signature" do
      {"cat" => "act", "act" => "act", "wombat" => "abmotw"}.each do |word, sig|
        it "should be #{sig} for #{word}" do
          Anagram::Finder.signature_of(word).must_equal sig
        end
      end
    end

    describe "lookup" do
      before do
        @finder = Anagram::Finder.new(["cat", "wombat"])
      end

      it "should return word if word given" do
        @finder.lookup("cat").must_equal ["cat"]
      end

      it "should return word if anagram given" do
        @finder.lookup("act").must_equal ["cat"]
        @finder.lookup("cta").must_equal ["cat"]
      end

      it "should return nil if no word matches anagram" do
        @finder.lookup("wibble").must_equal nil
      end
    end
  end
end

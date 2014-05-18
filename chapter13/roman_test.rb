#require_relative 'roman_bug'
require_relative 'roman_fixed'

r = Roman.new(1)
fail "'i' expected" unless r.to_s == 'i'

r = Roman.new(9)
fail "'ix' expected" unless r.to_s == 'ix'

# this method works but is cumbersome and has been replaced by
# dedicated frameworks.
# The default in Ruby >1.9 is MiniTest.
# MiniTest::Unit is a partial drop-in replacement for it's heavier-
# weight cousin, Test::Unit

require 'test/unit'

class TestRoman < Test::Unit::TestCase
  def test_simple
    assert_equal("i", Roman.new(1).to_s)
    assert_equal("ii", Roman.new(2).to_s)
    assert_equal("iii", Roman.new(3).to_s)
    assert_equal("iv", Roman.new(4).to_s)
    assert_equal("ix", Roman.new(9).to_s)
  end
end


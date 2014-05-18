# you can add your own messages to Test::Unit tests

require 'test/unit'

# imagine it's an ActiveRecord model...
class User
  def self.find(arg)
    nil
  end
end

class ATestThatFails < Test::Unit::TestCase
  def test_user_created
    user = User.find(1)
    refute_nil(user, "User with ID=1 should exist")
  end
end

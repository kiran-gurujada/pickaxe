# We have written a class that handles the tennis scoring system.
# Let's use RSpec specifications to drive the process
require 'rspec'

describe "TennisScorer", "basic scoring" do
  it "should start with a score of 0-0"
  it "should be 15-0 if the server wins a point"
  it "should be 0-15 if the receiver wins a point"
  it "should be 15-15 after they both win a point"
  #...
end

# we can run this spec using the <tt>rspec</tt> command:
# $rspec rspec_example.rb
#
# This will actually tell you if the specification has been implemented or
# not.

# RSpecc gives us an alternate way to set up conditions
# for our tests.
#
# The <tt>let</tt> method creates what looks like a
# variable (actually a dynamically defined method) whose
# value is given by evaluating a block.
#
# let is lazy-evaluated, once before each method that
# requires it's defined variable
#
# (see let_spec.rb for details)

require_relative "tennis_scorer"

describe TennisScorer, "basic scoring" do

  let(:ts) { TennisScorer.new }

  it "should start with a score of 0-0" do
    ts.score.should == '0-0'
  end

  it "should be 15-0 if the receiver wins a point" do
    ts.give_point_to(:server)
    ts.score.should == '15-0'
  end

  it "should be 0-15 if the receiver wins a point" do
    ts.give_point_to(:receiver)
    ts.score.should == '0-15'
  end

  it "should be 15-15 after they both win a point" do
    ts.give_point_to(:receiver)
    ts.give_point_to(:server)
    ts.score.should == '15-15'
  end
end

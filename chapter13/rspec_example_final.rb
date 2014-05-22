# full spec for tennis_scorer
# When I run $rspec rspec_example_final.rb
# Then the examples should all pass.

require_relative "tennis_scorer"

describe TennisScorer, "basic scoring" do

  let(:ts) { TennisScorer.new }

  it "should start with a score of 0-0" do
    ts.score.should == '0-0'
  end

  it "should be 15-0 if the server wins a point" do
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

  it "should be 40-0 after the server wins 3 points" do
    3.times do
      ts.give_point_to(:server)
    end
    ts.score.should == '40-0'
  end

  it "should be W-L after the server wins 4 points" do
    4.times do
      ts.give_point_to(:server)
    end
    ts.score.should == 'W-L'
  end

  it "should be L-W after the receiver wins 4 points" do
    4.times do
      ts.give_point_to(:receiver)
    end
    ts.score.should == 'L-W'
  end

  it "should be Deuce after each wins 3 points" do
    3.times do
      ts.give_point_to(:receiver)
      ts.give_point_to(:server)
    end
    ts.score.should == 'Deuce'
  end

  it "should be A-server after each wins 3 points and the server gets one more" do
    3.times do
      ts.give_point_to(:server)
      ts.give_point_to(:receiver)
    end
    ts.give_point_to(:server)
    ts.score.should == 'A-server'
  end
end

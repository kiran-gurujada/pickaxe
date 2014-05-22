# use let to define a memoized helper method. The
# value will be cached across multiple calls within one
# example, but not across examples
#
# Note that let is lazy-evaluated - it is not evaluated
# until the first time the method it defines is invoked

require 'rspec'

$count = 0
describe "let" do
  let(:count) { $count += 1 }

  it "memoizes the value" do
    count.should == 1
    count.should == 1
  end

  it "is not cached across examples" do
    count.should == 2
  end
end

# you can use let! to explicitly force the method's invocation
# before each example

$count_two = 0

describe "let!" do
  invocation_order = []

  let!(:count) do
    invocation_order << :let!
    $count_two += 1
  end

  it "calls the helper method in a before hook" do
    invocation_order << :example
    invocation_order.should == [:let!, :example]
    count_two.should == 1
  end


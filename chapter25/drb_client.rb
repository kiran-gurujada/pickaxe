# A simple drb client creates a local drb object and associates it with
# the object on the remote server - the local object is a proxy.

require 'drb'

DRb.start_service
obj = DRbObject.new(nil, 'druby://localhost:9000')

# Now use obj
puts "Sum is: #{obj.add(1, 2, 3)}"

# Distributed Ruby
#
# Since we can serialize any object into a form suitable for storage, we can
# also transmit objects between processes.
#
# You can use distributed Ruby with the drb library. Using drb, a Ruby process
# may act as a server, a client or both.
#
# A drb server acts as a source of objects, while a client is a user of the
# objects. To the client it appears as though the objects are local but in
# reality the code is being executed remotely.
#
# A server starts a service by associating an object with a given port. Threads
# are created internally to handle incoming requests on that port, so you
# must join the drb thread before exiting.

require 'drb'

class TestServer
  def add(*args)
    args.inject { |n, v| n + v }
  end
end

server = TestServer.new
DRb.start_service('druby://localhost:9000', server)
DRb.thread.join # Don't exit yet!


# Ruby comes with a library called GServer that implements basic TCP server functionality
# You can add your own behaviour by subclassing the GServer class
#
# Let's use it to write some code that waits for a client to connect on a socket and
# then returns the last few lines of the system log file.
# (actually this is quite useful for long-running applications)
#
# The GServer class handles all the mechanics of interfacing to TCP sockets.
# You create a GServer object and tell it the port to listen on (you can do a lot more but
# let's keep it simple here)
# Then when a client connects, the GServer object calls its serve method to handle that connection.
#
# The serve method in the GServer class is very simple - 
# def serve(io)
# end
#
# so we must extend it to add our own functionality
require 'gserver'
require 'pry'

class LogServer < GServer # LogServer is a special kind of GServer
  def initialize
    super(12345) # call initialize on parent
  end

  # serve method is invoked for each connected client
  def serve(client)
    client.puts get_end_of_log_file
  end

  private

  def get_end_of_log_file
    File.open("/var/log/system.log") do |log|
      log.seek(-500, IO::SEEK_END) # back up 500 characters from end
      log.gets # ignore partial line
      log.read # and return the rest
    end
  end
end

server = LogServer.new
server.start.join

# The stub serve method in GServer is expected to be subclassed and implemented by children.
# It effectively allows subclasses to implement hook methods to add application-level functionality.
# Just because this idiom is common doesn't make it good design.

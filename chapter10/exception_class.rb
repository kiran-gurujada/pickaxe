# Information about an exception is packed into an object of class
# Exception.
#
# Ruby defines a standard heirarchy of exceptions.
#
# When raising an exception, you can use one of the built in Exception
# classes, or create your own.
#
# Make your own exceptions subclasses of StandardError or one of its
# children (otherwise they will not be caught by default)

### Handling exceptions

require 'open-uri'

web_page = open("http://pragprog.com/podcasts")
output = File.open("podcasts.html", "w")
while line = web_page.gets
  output.puts line
end
output.close

# in the above case, a connection problem could cause an incomplete
# page to be stored. Let's make sure that doesn't happen

page = "podcasts"
file_name = "#{page}.html"
web_page = open("http://pragprog.com/#{page}")
output = File.open(file_name, "w")
begin
  while line = web_page.gets
    output.puts line
  end
  output.close
rescue Exception
  STDERR.puts "Failed to download #{page}: #{$!}"
  output.close
  File.delete(file_name)
  raise
end

# when an exception is raised, independent of any subsequent exception
# Ruby puts exception object into $!
# HINT: the ! indicates indignation that any of our code could possibly
# cause an error - errors?! me?!
#
# after closing and deleting the file, we call raise with no parameters
# which resumes escalation of the exception in $!

# You can have mutliple rescue clauses in a begin block to catch different
# types of exception, and assign it to a local variable (more readable that
# using $!)

begin
  eval string
rescue SyntaxError, NameError => boom
  print "String doesn't compile" + boom
rescue StandardError => bang
  print "Error running script" + bang
end

# Ruby executes the body following the first matching exception
# match is made using parameter===$! (will match if name exception is the
# same type or a superclass of the exception that happened)
#
# A rescue clause with no parameter defaults to StandardError

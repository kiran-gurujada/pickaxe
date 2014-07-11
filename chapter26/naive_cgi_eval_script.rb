require 'cgi'

cgi = CGI.new('html4')

expr = cgi["expression"].to_s # Fetch the value of the form field "expression"

begin
  result = eval(expr)
rescue Exception => detail
  # handle bad expressions
end

# display result back to user...
#
# THIS IS NAIIVE AND HORRIBLY INSECURE
#
# All external data is DANGEROUS. Don't let it close to interfaces that can
# modify your system.
#
# In this case, the form field submitted to this script is the external data,
# and the call to eval is a security breach allowing abitrary code to be
# executed on the server.
#
# Ruby provides some built-in support for reducing this risk. Information
# from the outside world should be marked as _tainted_. When running in a
# safe mode, potentially dangerous methods will raise a SecurityError if
# passed a tainted object.

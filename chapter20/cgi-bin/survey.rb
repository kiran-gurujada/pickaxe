#!/usr/bin/env ruby
require 'cgi'

cgi = CGI.new("html4")
cgi['name']    # => "Sam Philip"
cgi['reason']  # => "flexible"

# However, the above doesn't work well because we only see one of the three
# 'reason' values
name = cgi.params['name']  # => ["Dave Thomas"]
reasons = cgi.params['reason'] # => ["flexible", "transparent", "fun"]


print "Content-type: text/html\r\n\r\n"
puts <<-EOM
<html>
<head>
<meta charset="UTF-8">
<title>Results</title>
</head>
<body>
Thanks for your input, #{name[0]}.
You like ruby because it's:
<ol>
  <li>#{reasons[0]}</li>
  <li>#{reasons[1]}</li>
  <li>#{reasons[2]}</li>
</ol
</body>
</html>
EOM

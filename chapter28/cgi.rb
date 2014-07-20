# The CGI class provides support for programs used as Common Gateway
# Interface (CGI) scripts in a web server.
#
# CGI objects are initialized with data from the environment and from the
# HTTP request and provide convenient accessors to form data and cookies.
#
# They can also manage sessions using a variety of storage mechanisms.
#
# Class CGI also provides basic facilities for HTML generation and class methods
# to (un)escape requests and HTML.
#
# - Cgi::Session
#
# Escapes and unescapes special characters in URLs and HTML. Numeric entities
# less than 256 will be encoded based on the encoding of the input string.
# Other numeric entries left unchanged.

require 'cgi'

p CGI.escape('c:/My Files')
p CGI.unescape("c%3A%2FMy+Files")
p CGI.escapeHTML('"a"<b&c∂é')
p CGI.unescapeHTML('&quot;a&quot;&lt;b&amp;c∂é')

# - Access information from the incoming request

c = CGI.new
p c.auth_type
p c.user_agent

# - Access form fields from an incoming request.
# Example request: http://mydomain.com/test.cgi?fred=10&barney=cat

c = CGI.new
c['fred'] # => "10"
c.keys # => ["fred", "barney"]
c.params # => ["fred"=>["10"], "barney"=>["cat"]]

# - Multiple values in submitted forms accessed like an array with params.
# [] only accesses the first value.
# Example request has three fields called "name":

c = CGI.new
c['name'] # => "fred"
c.params['name'] # => ["fred", "wilma", "barney"]
c.keys # => "name"
c.params # => {"name"=>["fred", "wilma", "barney"]}

# - Sends a response to the browser. This is low level, better to use HTML
# templating libraries instead.

cgi = CGI.new("html5")
cgi.http_header("type" => "text/html", "expires" => Time.now + 30)
cgi.out do
  cgi.html do
    cgi.head{ cgi.title{"Hello World!"} } +
      cgi.body do
        cgi.pre do
          CGI::escapeHTML(
            "params: " +
            cgi.params.inspect + "\n" +
            "cookies: " +
            cgi.cookies.inspect + "\n")
        end
    end
  end
end

# - Stores a cookie in the client browser:

cgi = CGI.new("html5")
cookie = CGI::Cookie.new('name' => 'mycookie',
                         'value' => 'chocolate chip',
                         'expires' => Time.now + 3600)
cgi.out('cookie' => cookie) do
  cgi.head + cgi.body { "Cookie stored" }
end

# - Retrieves a previously stored cookie:

cgi = CGI.new('html5')
cookie = cgi.cookies['mycookie']

cgi.out('cookie' => cookie) do
  cgi.head + cgi.body { "Flavor: " + cookie[0] }
end

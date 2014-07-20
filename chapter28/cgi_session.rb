# A CGI::Session maintains a persistent state for web users in a CGI
# environment.
#
# Sessions may be held in memory or stored on disk (or in the case of Rails,
# stored in the cookie).
#
# Sessions imitate a hash, providing key-value storage and retrieval.
#
# - Store the timestamp of last access, along with the access count using
# a session object.

require 'cgi'
require 'cgi/session'

cgi = CGI.new('html3')
sess = CGI::Session.new(cgi,
                        "session_key" => "rubyweb",
                        "prefix" => "web-session.")
if sess['lastaccess']
  msg = "<p>You were last here #{sess['lastaccess']}.</p>"
else
  msg = "<p>Looks like you haven't been here for a while.</p>"
end

count = (sess['accesscount'] || 0).to_i
count += 1

msg << "<p>Number of visits: #{count}</p>"

sess["accesscount"] = count
sess["lastaccess"] = Time.now.to_s
sess.close

cgi.out {
  cgi.html {
    cgi.body {
      msg
    }
  }
}

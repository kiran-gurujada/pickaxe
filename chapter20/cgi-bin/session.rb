#!/usr/bin/env ruby
require 'cgi'
require 'cgi/session'

cgi = CGI.new("html4")
sess = CGI::Session.new(cgi, "session_key" => "rubyweb", "prefix" => "web-session.")

if sess['lastaccess']
  msg = "<p>You were last here #{sess['lastaccess']}.</p>"
else
  msg = "<p>Looks like you haven't been here for a while</p>"
end

count = (sess["accesscount"] || 0).to_i
count += 1

msg << "<p>Number of visits: #{count}</p>"
msg << "<p>DEBUG: Your tmpdir is: #{Dir.tmpdir}.</p>"

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

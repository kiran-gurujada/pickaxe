#!/usr/bin/env ruby
# WEBrick by default serves files from the html/ directory
require 'webrick'
include WEBrick

s = HTTPServer.new(Port: 2000, DocumentRoot: File.join(Dir.pwd, "/html"))

trap("INT") {s.shutdown}
s.start

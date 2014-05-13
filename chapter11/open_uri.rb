require 'open-uri'

open('http://pragprog.com') do |f|
  puts f.read.scan(/<img alt=".*?" src="(.*?)"/m).uniq[0, 3]
end

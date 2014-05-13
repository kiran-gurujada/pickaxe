require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://pragprog.com/"))

puts "Page title is " + doc.xpath("//title").inner_html

# Output the first paragraph in the div with an id="copyright"
# (nokogiri apparently supports both xpath and css-like selectors)
puts doc.css('div#copyright p')

# Output the second hyperlink in the site-links div using xpath
# and css
puts "\nSecond hyperlink is"
puts "[Xpath method]: " + doc.xpath('id("site-links")//a[2]').to_s
puts "[CSS method]: " + doc.css('#site-links a:nth-of-type(2)').to_s

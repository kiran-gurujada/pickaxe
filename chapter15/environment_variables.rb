# You can access OS environment variables using ENV
# It responds to the same method as Hash.

puts ENV['SHELL']
puts ENV['HOME']
puts ENV['USER']
puts ENV.keys.size
puts ENV.keys[0, 4]

puts "Listing ENV..."
ENV.each_pair do |k, v|
  v = "''" if v == ''
  puts k + ' => ' + v
end

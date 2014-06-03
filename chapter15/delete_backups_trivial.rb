require 'fileutils'

puts "CAUTION: This file causes destructive changes to files in your home \
folder. Continue? y(es)/n(o)/d(ummy run)"

response = gets.downcase

if response == 'y'
  files = Dir['*~']
  FileUtils::rm files, verbose: true
elsif response == 'd'
  files = Dir['*~']
  p FileUtils::ls files
else
  exit
end

# The coverage module counts the number of times each line of Ruby code
# is executed in one or more source files and provides a summary as a
# hash.
#
# The keys of the hash are the names of the files that were analyzed and the
# values are each an array containing counts (on a per line basis).
#
# (See reference support/fizzbuzz.rb)

require 'coverage'
Coverage.start
STDOUT.reopen("/dev/null")
require_relative 'support/fizzbuzz.rb'

Coverage.result.each do |file_name, counts|
  File.readlines(file_name).each_with_index do |code_line, line_number|
    count = counts[line_number] || "--"
    STDERR.printf "%3s: %s", count, code_line
  end
end

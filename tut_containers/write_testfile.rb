# Write a test file with numbered lines, that looks like this:
# This is line one
# This is line two
# This is line three
# ...etc...
require 'humanize'

def write_numbered_lines(filename, n_lines)
  f = File.open(filename, "w")
  (1..n_lines).each do |n|
    f << "This is line #{n.humanize}\n"
  end
  f.close
end

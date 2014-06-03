# Using the special object ARGF or reading from standard input
# will assume arguments to be filenames and open them for reading
# accordingly.
#
# If your program takes a mixture of filenames and flag options,
# you must empty the flag options before reading from the files
# e.g. using gets
#
# ARGV will return an EOF when all files have been fully read, so
# ruby won't dump you at a prompt waiting for STDIN from the user,
# instead it will exit
if ARGV.length == 0
  puts "No arguments provided.\nTry running $ruby argf_example.rb testfile otherfile"
  exit
end

while line = gets
  printf "%d: %10s[%d] %s", ARGF.lineno, ARGF.filename, ARGF.file.lineno, line
end

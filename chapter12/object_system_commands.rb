# the Object#system method executes the given command in a subprocess
# returns true if command executes properly
# returns false if command fails - error dumped into $? global variable
#
# STDOUT from system(command) is printed directly to STDOUT
# to capture STDOUT, use the backtick version:
# string = `command`
#
# We can use IO.popen to communicate more extensively with shell commands
# via STDIN and STDOUT
# pass '-' as an argument to fork a new ruby interpreter

pipe = IO.popen("-", "w+")
if pipe # something in pipe
  pipe.puts "Get a job!"
  STDERR.puts "Child says '#{pipe.gets.chomp}'"
else # ????
  STDERR.puts "Dad says '#{gets.chomp}'"
  puts "OK"
end

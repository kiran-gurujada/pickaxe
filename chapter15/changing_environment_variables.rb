# The ENV hash can be modified, and this changes the values of the
# corresponding system environment variables.
#
# However, this change is local to the process that makes it and any
# children it might spawn.
#
# In the code below, a subprocess changes an environment variables and this
# change is inherited by a process that it then starts.
# However, this change is not visible to the original parent.
# HINT: parents never really know what their children are doing

puts "In parent, term = #{ENV['TERM']}"  # xterm-256color

fork do
  puts "Start of child 1, term = #{ENV['TERM']}"  # xterm-256color
  ENV['TERM'] = 'ansi'
  fork do
    puts "Start of child 2, term = #{ENV['TERM']}"  # ansi
  end
  Process.wait
  puts "End of child 1, term = #{ENV['TERM']}"  # ansi
end
Process.wait
puts "Back in parent, term = #{ENV['TERM']}"  # xterm-256color

# Setting an ENV value to nil removes the variable from the environment

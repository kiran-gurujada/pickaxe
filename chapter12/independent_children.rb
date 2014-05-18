# we can give the subprocess its assignment and later check to
# see whether it has finished

# e.g. a long-running external sort

exec("sort textfile > output.txt") if fork.nil?
# sort is now running in a child process
# carry on processing in the main program
#
#...
#
# then wait for sort to finish
Process.wait


# for more information on controlling external processes, look
# at the documentation for Object#open and IO.popen as well
# as the Process module

# IO.popen can take a block

IO.popen("date") {|f| puts "Date is #{f.gets}"}

# the IO object will be closed automatically when called with a
# block, just like File.open

# if you associate a block with fork, the code in the block will
# be run in a Ruby subprocess and the parent will continue to
# run after the block

puts "Parent pid = #$$"
fork do
  puts "In child, pid = #$$"
  exit 99
end
pid = Process.wait
puts "Child terminated, pid was #{pid}, exit status was #{$?.exitstatus}"

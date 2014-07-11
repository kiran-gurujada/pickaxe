# The variable $SAFE determines Ruby's level of paranoia.
#
# 0 - No checking for use of externally supplied (tainted)
# data is performed. Ruby's default mode.
#
# >= 1 - Ruby disallows the use of tainted data by potentially
# dangerous operations.
#
# >= 2 - Ruby prohibits the loading of program files from
# globally writable locations.
#
# >= 3 - All newly created objects are considered tainted and
# untrusted.
#
# >= 4 - Ruby effectively partitions the running program in
# two. Nontrusted objects may not be modified.
#
#
# The default value of $SAFE is usually set to 0. If a Ruby script is to be
# run setuid or setgid, or under mod_ruby its safe level is set to 1.
#
# It can also be set using the -T command line option, or by assigning a value
# to the variable within a running program. $SAFE is a ratchet - it cannot
# be lowered during execution.
#
# $SAFE can be partitioned into threads:

File.open(filename, "w") do |f|
  f.print ... # write untrusted program into file
end
Thread.start do
  $SAFE = 4
  load(filename, true)
end

SCRIPT_LINES__ = {}
require 'pry'

# You can inspect the source file of a Ruby program.
#
# The special variable __FILE__ constains the name of the current source
# file. This leads to a fairly short (if cheating) Quine - a program that
# outputs its own source:

print File.read(__FILE__)

# The method Object#caller returns the call stack as a list. Each entry in
# this list starts off with a filename, a colon and a line number in that
# file.
#
# You can parse this information to display source. In the following example
# we have a main program that calls a method in a separate file.
#
# This in turn invokes a block, where we traverse the call stack and write
# out the source lines involved. Notice the use of a hash of file contents,
# indexed by filename.
#
# See: stack_dumper.rb, sub.rb and main.rb in /stack_dumper/
#
# File            Line  Source Line
# ---------------+----+------------
# main.rb        :  5 - dump_call_stack
# sub.rb         :  2 - main_method(v1 * 3, v2 * 6)
# main.rb        :  8 - sub_method(123, 'cat')
#
#
# The SCRIPT_LINES__ constant is closely related to this technique. If a program
# initializes a constant called SCRIPT_LINES__ with a hash, that hash will receive
# a new entry for every file subsequently loaded using +require+ or +load+.
#
# The key is the name of the file, and the value is the source of the file as an array
# of strings.

puts SCRIPT_LINES__.keys

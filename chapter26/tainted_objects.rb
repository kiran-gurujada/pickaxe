# Any Ruby object derived from some external source (e.g. a string read
# from a file or an environment variable) is automatically marked as being
# tainted.
#
# If your program uses a tainted object to derive a new object, then that
# new object will inherit the taint.
#
# Any object with external data somewhere in its past will be tainted.
#
# You can test for a taint using Object#tainted?
# E.g.:

# internal data

x1 = "a string"
x1.tainted? # => false

x2 = x1[2, 4]
x2.tainted? # => false

x1 =~ /([a-z])/
$1.tainted? # => false

# external data

y1 = ENV['HOME']
y1.tainted? # => true

y2 = y1[2, 4]
y2.tainted? # => true

y1 =~ /([a-z])/
$1.tainted? # => true

# HINT: taint is contagious

# You can taint any object by invoking its +taint+ method.
#
# For $SAFE <= 3 you can remove the taint using +untaint+.
#
# This is not something to do lightly.

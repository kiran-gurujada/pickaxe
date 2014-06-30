# Ruby is line-oriented.
# Expressions are assumed to terminate at the end of a line unless the parser
# can determine that the statement is incomplete, e.g. if the last token is
# an operator or comma.
#
# Use a semicolon +;+ to separate multiple expressions on one line.
#
# A backslash +\+ can be used for multi-line expressions.
#
# Comments start with +#+ and run to the end of the line.

a = 1
b = 2; c = 3
d = 4 + 5 +
  6 + 7     # no '\' needed
e = 8 + 9 \
  + 10      # '\' needed

=begin
lines starting +=begin+ and ending +=end+ are
ignored by Ruby
=end

# if Ruby encounters a line anywhere containing just __END__
# it treats that line as the end of the program

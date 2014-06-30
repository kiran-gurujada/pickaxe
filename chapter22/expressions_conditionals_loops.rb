# Single terms in an expression may be any of the following
#
# - Literal
# e.g. numbers, strings, arrays, hashes, ranges, symbols or regex
#
# - Shell command
# `enclosed in backticks` or %x{delimited '%x'}
# stdout is returned as the value of the expression
# $? is set with the command's exit status
#
# - Variable or Constant reference
# e.g. barney, APP_NAME, Math::PI
#
# - Method invocation

# Operator expressions
#
# Expressions may be combined using operators.

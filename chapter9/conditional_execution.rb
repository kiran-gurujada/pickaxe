# Boolean expressions
# In Ruby, any value that is not nil or false evaluates to true
# and, && both return the first argument if false, otherwise they
# return the second

nil && 99 # => nil
false && 99 # => false
"cat" && 99 # => 99

# similarly, both or and || return their first argument unless it is false,
# in which case they evaluate and return the second argument
# (Ruby tries to return a true value)

nil || 99 # => 99
false || 99 # => 99
"cat" || 99 # => "cat"

# you can use ||= to assign a value to a variable if not already set
# i.e. equals-if-not-already-assigned

var ||= "default value"

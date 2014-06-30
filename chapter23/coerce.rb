# Consider this method

1 + 2

# This is equivalent to:

1.+(2)

# Cool. We passed an instance of Integer as an argument to another instance
# of class Integer.
# But what if we do this:

1.+(2.3)

# How does Ruby know to return a Float in this example?
#
# +Coerce+
# Guarantees that two objects will have the same class (and thus can be added,
# multiplied, compared etc)

p 1.coerce(2) # => [2, 1]
p 1.coerce(2.3) # => [2.3, 1.0]
p (4.5).coerce(2.3) # => [2.3, 4.5]
p (4.5).coerce(2) # => [2.0, 4.5]

# Raise an Exception with Object#raise

# raise # => raises whatever is in $!, or a generic runtime error if nil
# raise "message" # => raise RuntimeError with message
# raise thing, string, stack trace

# Handling exceptions
# 1) Within begin/end block

begin
  6 / 3
rescue
  "Ruby fails at basic math."
else
  "Math worked! All is normal..."
ensure
  p "If you can see this, the universe still exists. Phew..."
end

# "If you can see this, the universe still exists. Phew..."
# => "Math worked! All is normal..."

begin
  1 / 0
rescue
  "oops, tried to divide by zero!"
else
  "rules of math suspended. Entering singularity..."
ensure
  p "If you can see this, the universe still exists. Phew..."
end

# "If you can see this, the universe still exists. Phew..."
# => "oops, tried to divide by zero!"

1 / 0 rescue "Careful, almost destroyed the universe there!"

# A block or method may have multiple +rescue+ clauses. Each rescue may
# specify zero or more exception parameters.
#
# A +rescue+ clause with no parameter is treated as if it had a parameter
# of StandardError.

begin
  1 / 0
rescue Exception => e
  e
end

# => #<ZeroDivisionError: divided by 0>

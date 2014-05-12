# You can raise exceptions in your code using Object#raise
# its synonym Object#fail does the same thing, just more vindictively
class InterfaceException < Exception
end

raise  # raise current exception (or RuntimeError if no current exception)
raise 'bad mp3 encoding'  # create new RuntimeError with message as string
raise InterfaceException, 'PEBKAC error', caller # set exception type, message and include stack trace

# here are some examples of raise in action

raise

raise "Missing name" if name.nil?

if i >= names.size
  raise IndexError, "#{i} >= size (#{names.size})"
end

raise ArgumentError, "Name too big", caller

# the previous example removes the current routine from the stack backtrace
# We can take this further and pass only a subset of the call stack

raise ArgumentError, "Name too big", caller[1..-1]

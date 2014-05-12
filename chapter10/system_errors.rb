# System errors are raised when a call to the OS returns an error code
# Ruby takes these errors and wraps each in an exception object
# Each is a subclass of SystemCallError, and defined in a module called
# Errno. e.g.

Errno::EAGAIN::Errno  # => 35
Errno::EPERM::Errno  # => 1
Errno::EWOULDBLOCK::Errno  # => 35

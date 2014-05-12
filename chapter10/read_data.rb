require 'retry_exception'

begin
  stuff = read_data(socket)
  #... process stuff
rescue RetryException => detail
  retry if detail.ok_to_retry
  raise
end

def read_data(socket)
  data = socket.read(512)
  if data.nil?
    raise RetryException.new(true), "transient read error"
  end
  # ... normal processing
end

# example of how to use cases to handle responses in the net/http library

require 'net/http'

def fetch(uri_str, limit = 10)
  raise ArgumentError, 'too many http redirects' if limit == 0

  response = Net::HTTP.get_response(URI(uri_str))

  case response
  when Net::HTTPSuccess then
    response
  when Net::HTTPRedirection then
    location = response ['location']
    warn "redirected to #{location}"
    fetch(location, limit - 1)
  else
    response.value
  end
end

print fetch("http://www.ruby-lang.org")

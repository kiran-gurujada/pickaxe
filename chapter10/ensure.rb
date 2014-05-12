# ensure is uses to guarantee processing at the end of a block, even
# if an exception is raised

f = File.open("testfile")
begin
  # .. process
rescue
  # .. handle error
ensure
  f.close  # always executed
end

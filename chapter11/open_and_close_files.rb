# use File.new to create a new file object

file = File.new("testfile", "r")
# ... process the file
file.close

# can also use block form to ensure file gets closed

File.open("testfile", "r") do |file|
  # ... process the file
end # <- file automatically closed here, even if an exception is raised

# can imagine that the open method looks like this:

class File
  def File.open(*args)
    result = f = File.new(*args)
    if block_given?
      begin
        result = yield f
      ensure
        f.close
      end
    end
    result
  end
end

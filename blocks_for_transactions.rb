# example of how to transactionally open a file
# using a block

class File
  def self.open_and_process(*args)
    f = File.open(*args)
    yield f
    f.close()
  end
end

File.open_and_process("testfile", "r") do |file|
  while line = file.gets
    puts line
  end
end

# another implementation
class File
  def self.my_open(*args)
    result = file = File.new(*args)
    if block_given?
      result = yield file
      file.close
    end
    result
  end
end

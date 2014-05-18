# Threads can normally access any variables that are in scope when the
# thread is created.
# Variables local to the block containing the thread code are local to the thread
# only and not shared.
# You can create per-thread variables that are accessable by other threads (watch out
# for race conditions)

count = 0 # accessable in all threads

threads = (0...10).map do |i|
  Thread.new do
    sleep(rand)
    # treat thread object like a hash to store thread-local variables with
    # abitrary names

    # race condition exists here. The following should be atomic

    ###
    Thread.current[:mycount] = count # set thread-local variable
    count += 1
    ###

  end
end

threads.each {|thread| thread.join; print thread[:mycount], ", "}
puts "count = #{count}"

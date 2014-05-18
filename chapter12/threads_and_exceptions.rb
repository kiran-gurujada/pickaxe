# exceptions in threads cause different behaviour depending on
# 1) the setting of the abort_on_exception flag on Thread
# --- When set to true, all threads will abort if an exception is raised
# 2) the setting of the interpreter's $DEBUG flag
# --- May be set using ruby -d
#
# By default, abort_on_exception is set false and $DEBUG == false
#
# In the default case, an unhandled exception simply kills the current
# thread - the rest continue to run.
# In fact, you don't even hear about the exception until you issue a join
# on the thread that raised it.
# HINT: threads suffer in silence unless questioned directly

puts "thread 1 fails silently..."

def spawn_threads
  threads = (0...4).map do |number|
    Thread.new(number) do |i|
      raise "BOOM!" if i == 1
      print "#{i}\n"
    end
  end
end

spawn_threads
puts "Waiting..."
sleep 0.1
puts "Done"

puts "raise exception forcibly by joining threads..."

threads = spawn_threads
puts "Waiting..."
threads.each do |t|
  begin
    t.join
  rescue RuntimeError => e
    puts "Failed: #{e.message}"
  end
end

puts "Done"

# however, you can set abort_on_exception to true or use -d to enable DEBUG
# and any unhandled exception will kill the main thread.

puts "Enable abort_on_exception..."
Thread.abort_on_exception = true
threads = spawn_threads

puts "Waiting..."
threads.each {|t| t.join}
puts "Done"

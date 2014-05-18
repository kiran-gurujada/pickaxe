# the only safe low-level thread scheduling operations are
# Thread#join and Thread#value
#
# Ruby does, however, support higher-level thread synchronization

# RACE CONDITION example:

sum = 0
threads = 10.times.map do
  Thread.new do
    100_000.times do
      new_value = sum + 1
      print "#{new_value}  " if new_value % 250_000 == 0
      # new thread likely to be scheduled here
      sum = new_value # after control is returned to this thread, sum is
      # clobbered with a new (old) value - we lost data!
    end
  end
end

threads.each(&:join)
puts "\nsum = #{sum}" # 'should' add up to 1_000_000, but doesn't due to race condition

# use Mutexes to control access to resource.
# mutex stands for MUTual EXclusion
# HINT: a mutex is like a bathroom pass - only one thread can go at a time
puts
puts "And now with mutexes..."

sum = 0
mutex = Mutex.new
threads = 10.times.map do
  Thread.new do
    100_000.times do
      mutex.lock             #### one at a time!
      new_value = sum + 1       #
      print "#{new_value} " if new_value % 250_000 == 0
      sum = new_value           #
      mutex.unlock           ####
    end
  end
end

threads.each(&:join)
puts "\nsum = #{sum}"

# this code pattern is so common that Ruby provide Mutex#synchronize
# which locks the mutex, runs the code in a block and then unlocks the mutex
# This ensures the mutex gets unlocked even if an exception is thrown during
# the locked state

puts
puts "Using Mutex#synchronize..."

sum = 0
mutex = Mutex.new
threads = 10.times.map do
  Thread.new do
    100_000.times do
      mutex.synchronize do      ####
        new_value = sum + 1     #
        print "#{new_value}  " if new_value % 250_000 == 0
        sum = new_value         #
      end                       ####
    end
  end
end

threads.each(&:join)
puts "\nsum = #{sum}"

# sometimes you might want to claim a lock if the mutex is currently unlocked,
# but you don't want to suspend execution of the current thread in case it
# isn't.
# You can use Mutex#try_lock to take the lock if possible, and return false if
# not.
#
# The following code illustrates ahypothetical currency converter.
# The ExchangeRates class caches rates from an online feed and a background thread
# updates the cache once per hour.
# This update takes ~ 1 minute
# In the main thread, we interact with our user, using try_lock to print
# a status message if the update is in process

rate_mutex = Mutex.new
exchange_rates = ExchangeRates.new
exchange_rates.update_from_online_feed

Thread.new do
  loop do
    sleep 3600
    rate_mutex.sychronize do
      exchange_rates.update_from_online_feed
    end
  end
end

loop do
  print "Enter currency code and amount: "
  line = gets
  if rate_mutex.try_lock
    begin
      puts(exchange_rates.convert(line))
    ensure
      rate_mutex.unlock
    end
  else
    puts "Sorry, rates are being updated. Try again in a minute"
  end
end


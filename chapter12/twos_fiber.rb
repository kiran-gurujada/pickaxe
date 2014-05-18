# a fiber that yields successive even numbers NOT divisible by three

twos = Fiber.new do
  num = 2
  loop do
    Fiber.yield(num) unless num % 3 == 0
    num += 2
  end
end

# for fun, run this for one second and see how high we get
require 'timeout'

begin
  Timeout.timeout(1) do
    loop do
      puts twos.resume
    end
  end
ensure
  puts
end

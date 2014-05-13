# StringIO objects behave like any other I/O object but they read and write
# strings, not files.

require 'stringio'

ip = StringIO.new("be relentlessly resourceful\nmake something people want\n= $$$ and fulfilment")
op = StringIO.new("", "w")

ip.each_line do |line|
  op.puts line.capitalize
end

print op.string

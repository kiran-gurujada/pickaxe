require 'socket'

client = TCPSocket.open('127.0.0.1', 3000)
client.send("OPTIONS /~dave/ HTTP/1.0\r\n\r\n", 0)  # 0 means standard packet
puts client.readlines
client.close

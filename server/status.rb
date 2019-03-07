require 'socket'        
require 'json'
require 'pry'
puts "Running server at port 58109..."
server = TCPServer.new 58109

class Status
  attr_accessor :space
  def initialize
    @space = %x( df -h )
  end

  def to_json
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
    return hash.to_json
  end
end

while session = server.accept
  request = session.gets
  puts request
  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: application/vnd.api+json; charset=utf-8\r\n" # 2
  session.print "\r\n" # 3
  obj = Status.new
  session.print obj.to_json
  session.print "\r\n" # 3
  session.close
end

require 'socket'
require 'net/http'
require 'json'

hostname = 'localhost'
port = 58109
uri = URI('http://localhost:58109')

response = Net::HTTP.get_response(uri)

puts JSON.parse(response.body)["space"]


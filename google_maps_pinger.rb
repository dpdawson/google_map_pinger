require 'json'
require 'uri'
require 'net/http'

times_to_ping = ARGV[0].to_i
time_to_wait_between_pings = ARGV[1].to_f

(1..times_to_ping).each do |i|
  url = "http://maps.googleapis.com/maps/api/geocode/json?language=en&address=a#{i}&sensor=false"
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  p "Address #{i}"
  p JSON.parse(response.body)["status"]
  sleep(time_to_wait_between_pings)
end
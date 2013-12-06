require 'json'
require 'uri'
require 'net/http'

times_to_ping = ARGV[0].to_i
time_to_wait_between_pings = ARGV[1].to_f
count = 0
timer = Time.now

(1..times_to_ping).each do |i|
  url = "http://maps.googleapis.com/maps/api/geocode/json?language=en&address=a#{i}&sensor=false"
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  count += 1
  if count == 5 && (Time.now - timer) < 0.8
    p i, 'calls done, sleeping ...'
    sleep(time_to_wait_between_pings)
    count = 0
    timer = Time.now
  elsif count == 5
    count = 0
    timer = Time.now
  end
  if JSON.parse(response.body)["status"] == "OVER_QUERY_LIMIT"
    p count, (Time.now - timer)
    timer = Time.now
    count = 0
    p "Address #{i}"
    p JSON.parse(response.body)["status"]
  end

end
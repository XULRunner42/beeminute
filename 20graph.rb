#!/usr/bin/env ruby
# 20graph.rb
# Read the state of GET /users/u/goals/g/datapoints.json

require 'json'
#require 'net/http'
#require 'net/https'
require 'ap'
require './beedata'
#require 'sequel'

def graph
    u = 'yebyenw'
    g = '20-minutes'

=begin
def news_search(query, results=10, start=1)
    base_url = "http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=YahooDemo&output=json"
    url = "#{base_url}&query=#{URI.encode(query)}&results=#{results}&start=#{start}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    result = JSON.parse(data)

    # if the hash has 'Error' as a key, we raise an error
    if result.has_key? 'Error'
        raise "web service error" 
    end return result 
end
=end

    url = "https://www.beeminder.com/api/v1/users/#{u}/goals/#{g}/datapoints.json"

=begin
p url
https = Net::HTTP.new(url, Net::HTTP.https_default_port)

https.use_ssl = true
https.ssl_timeout = 2
https.verify_mode = OpenSSL::SSL::VERIFY_PEER
https.ca_file = '/usr/share/curl/curl-ca-bundle.crt'
https.verify_depth = 2
#https.enable_post_connection_check = true

#Net::HTTP.use_ssl = true
#resp = Net::HTTP.get_response(URI.parse(url))
#data = resp.body

data = ""
https.start do |http|
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    data = response.body
    #resp = https.get_response(URI.parse(url))
end
result = JSON.parse(data)
=end

    data = IO.read('./20-minutes.json')
    result = JSON.parse(data)

    beedata([result[0],result[1],result[2]])

    # ap result
end

graph

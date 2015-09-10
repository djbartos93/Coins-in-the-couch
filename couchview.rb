require 'net/http'
require 'uri'
require 'yaml'
require 'json'


def title_list
  puts "getting movies"

  uri = URI.parse('http://172.16.0.15:5050/api/0c7afb2c910d49b2aa98b5f762e62b98/movie.list')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  output['movies'].each do |movie|
    print movie['info']['original_title'].to_yaml
  end

  #print response.body
  #output = File.open('./db/temp_db.yml', 'w')
  #output.puts YAML.dump(JSON.parse response.body)
  #debug = JSON.parse response.body
  #print debug['movies'][0]['title']
end

def omdb
  puts "getting movie info"
    request_uri = 'http://www.omdbapi.com/?'
    request_query = "i=#{list}&plot=short&r=json"
    full_request = "#{request_uri}#{request_query}"
    print full_request
    uri = URI.parse(full_request)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    output = JSON.parse response.body
    print output

end


list

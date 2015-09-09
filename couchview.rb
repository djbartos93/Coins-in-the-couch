require 'net/http'
require 'uri'
require 'yaml'
require 'json'

def list
  puts "getting movies"

  uri = URI.parse('http://172.16.0.15:5050/api/0c7afb2c910d49b2aa98b5f762e62b98/movie.list')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  imdbnum = output['movies'][1]['info']['imdb']
  #print response.body
  #output = File.open('./db/temp_db.yml', 'w')
  #output.puts YAML.dump(JSON.parse response.body)
  #debug = JSON.parse response.body
  #print debug['movies'][0]['title']
end

def omdb
  puts "getting movie info"
    uri = URI.parse('http://www.omdbapi.com/?')

    http = Net::HTTP.new(uri.host, uri.port)

    JSON.parse(Net::HTTP.post_form(uri, {
    'i' => '=tt0289043&',
    'plot' => '=short&',
    'r' => '=json'
    }).body)
end

def api_test
  uri = URI.parse('http://www.omdbapi.com/?i=tt0289043&plot=short&r=json')
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  print output
end

api_test

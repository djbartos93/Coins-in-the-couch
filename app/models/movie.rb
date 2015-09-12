class Movie < ActiveRecord::Base
end
def sync
  print "movie sync in progress"
  uri = URI.parse('http://172.16.0.15:5050/api/0c7afb2c910d49b2aa98b5f762e62b98/movie.list')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  imdbnum = output['movies'].each do |movie|
    titles = movie['info']['original_title']
    @Movies.new(:title => titles).save
  end
end

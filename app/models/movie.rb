class Movie < ActiveRecord::Base
end
def sync
  print "movie sync in progress"
  uri = URI.parse('http://172.16.0.15:5050/api/0c7afb2c910d49b2aa98b5f762e62b98/movie.list')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  output['movies'].each do |titles|
    @Movie.create(:title => movie_info['info']['original_title'], :director => movie_info['info']['directors'], :genre => movie_info['info']['genres'], :year => movie_info['info']['year'], :quality => 'N/A')
    print movie['info']['original_title'].to_yaml
  end
end

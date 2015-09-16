module MoviesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direciton}" : nil
    direction = column == sort_column && sort_direciton == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class =>css_class}
  end
end

def get_plot
  url = "http://www.omdbapi.com/?i=#{@movie.imdb_id}&plot=full&r=json"
  print url
  print "getting plot"
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  output = JSON.parse response.body
  print output['Plot'].to_yaml
  @plot = output['Plot'].to_yaml
  print @plot
end

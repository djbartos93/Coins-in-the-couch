class Movie < ActiveRecord::Base
  serialize :genre
  serialize :director
  searchkick
end

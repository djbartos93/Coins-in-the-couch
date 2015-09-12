class Movie < ActiveRecord::Base
  serialize :genre
  searchkick
end

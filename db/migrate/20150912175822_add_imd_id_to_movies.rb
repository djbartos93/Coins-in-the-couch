class AddImdIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_id, :string
  end
end

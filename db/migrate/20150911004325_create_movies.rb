class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :genre
      t.integer :year
      t.string :quality

      t.timestamps null: false
    end
  end
end

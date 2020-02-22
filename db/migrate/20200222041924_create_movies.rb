class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title, default: ""
      t.string :overview, default: ""
      t.integer :vote_count, default: 0
      t.string :poster_path, default: ""
      t.date :release_date
      t.integer :tmdb_id

      t.timestamps
    end
  end
end
